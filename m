Return-Path: <stable+bounces-7647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC60817583
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4B71F2361A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A7D5D747;
	Mon, 18 Dec 2023 15:36:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A945D732
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28ad7a26f4aso2894115a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913777; x=1703518577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D13MnaLmjhY/E+ZTLFs+4oJ/DoyYuR5PT1L280NX5SU=;
        b=pHxzUymgRyV9FVrVZUQShBZt/bpxrkhJBmO+a2Nwa900skz65GYKBrpzrdYg653QzN
         x6uZdI/DVdqWRq9TGzKB/CiFULuCH/cICOp5dbeiSByhid2Am9uHZDXiKm9vh9OoglLt
         3pSGTLlyRRaeWvteUAfyVefByo+8yuNrOCTJpjOJveC8DETcKnJ3ulgsQhkPoDXIeL8c
         FLCui3F4WQERH904VZcoK4uq4Tr811mKvTbw4C7SOZ0KD/eOkwhxcq2Tgoavdd8xJcpo
         QnxH7dp+qyvqzqD0w3EzVXW2ZZxA5oIOflv8K6WvfKjNpedWPb/vfJR4x/GKh5wEzhAA
         vO9w==
X-Gm-Message-State: AOJu0YzoOMdXwEym8s+hzZfYwcbjB8Bu8BdmTbP7CqD+px9TiD+qMEig
	5BEy3grmKGGk/67JF9C4NVs=
X-Google-Smtp-Source: AGHT+IEM+l7srU859HE2zDEW2IV+foID5077YLUeEzy85CBEVurGMyJkUza+KBe3nrA8AJwyWrSVhQ==
X-Received: by 2002:a17:90b:1017:b0:28b:a895:7cb with SMTP id gm23-20020a17090b101700b0028ba89507cbmr387955pjb.5.1702913776763;
        Mon, 18 Dec 2023 07:36:16 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:16 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 018/154] ksmbd: smbd: call rdma_accept() under CM handler
Date: Tue, 19 Dec 2023 00:32:38 +0900
Message-Id: <20231218153454.8090-19-linkinjeon@kernel.org>
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

[ Upstream commit 99b7650ac51847e81b4d5139824e321e6cb76130 ]

if CONFIG_LOCKDEP is enabled, the following
kernel warning message is generated because
rdma_accept() checks whehter the handler_mutex
is held by lockdep_assert_held. CM(Connection
Manager) holds the mutex before CM handler
callback is called.

[   63.211405 ] WARNING: CPU: 1 PID: 345 at drivers/infiniband/core/cma.c:4405 rdma_accept+0x17a/0x350
[   63.212080 ] RIP: 0010:rdma_accept+0x17a/0x350
...
[   63.214036 ] Call Trace:
[   63.214098 ]  <TASK>
[   63.214185 ]  smb_direct_accept_client+0xb4/0x170 [ksmbd]
[   63.214412 ]  smb_direct_prepare+0x322/0x8c0 [ksmbd]
[   63.214555 ]  ? rcu_read_lock_sched_held+0x3a/0x70
[   63.214700 ]  ksmbd_conn_handler_loop+0x63/0x270 [ksmbd]
[   63.214826 ]  ? ksmbd_conn_alive+0x80/0x80 [ksmbd]
[   63.214952 ]  kthread+0x171/0x1a0
[   63.215039 ]  ? set_kthread_struct+0x40/0x40
[   63.215128 ]  ret_from_fork+0x22/0x30

To avoid this, move creating a queue pair and accepting
a client from transport_ops->prepare() to
smb_direct_handle_connect_request().

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 102 ++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 43 deletions(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 9d12ef4024e2..ba2d3d286017 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -574,6 +574,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		}
 		t->negotiation_requested = true;
 		t->full_packet_received = true;
+		enqueue_reassembly(t, recvmsg, 0);
 		wake_up_interruptible(&t->wait_status);
 		break;
 	case SMB_DIRECT_MSG_DATA_TRANSFER: {
@@ -1600,19 +1601,13 @@ static int smb_direct_accept_client(struct smb_direct_transport *t)
 		pr_err("error at rdma_accept: %d\n", ret);
 		return ret;
 	}
-
-	wait_event_interruptible(t->wait_status,
-				 t->status != SMB_DIRECT_CS_NEW);
-	if (t->status != SMB_DIRECT_CS_CONNECTED)
-		return -ENOTCONN;
 	return 0;
 }
 
-static int smb_direct_negotiate(struct smb_direct_transport *t)
+static int smb_direct_prepare_negotiation(struct smb_direct_transport *t)
 {
 	int ret;
 	struct smb_direct_recvmsg *recvmsg;
-	struct smb_direct_negotiate_req *req;
 
 	recvmsg = get_free_recvmsg(t);
 	if (!recvmsg)
@@ -1622,44 +1617,20 @@ static int smb_direct_negotiate(struct smb_direct_transport *t)
 	ret = smb_direct_post_recv(t, recvmsg);
 	if (ret) {
 		pr_err("Can't post recv: %d\n", ret);
-		goto out;
+		goto out_err;
 	}
 
 	t->negotiation_requested = false;
 	ret = smb_direct_accept_client(t);
 	if (ret) {
 		pr_err("Can't accept client\n");
-		goto out;
+		goto out_err;
 	}
 
 	smb_direct_post_recv_credits(&t->post_recv_credits_work.work);
-
-	ksmbd_debug(RDMA, "Waiting for SMB_DIRECT negotiate request\n");
-	ret = wait_event_interruptible_timeout(t->wait_status,
-					       t->negotiation_requested ||
-						t->status == SMB_DIRECT_CS_DISCONNECTED,
-					       SMB_DIRECT_NEGOTIATE_TIMEOUT * HZ);
-	if (ret <= 0 || t->status == SMB_DIRECT_CS_DISCONNECTED) {
-		ret = ret < 0 ? ret : -ETIMEDOUT;
-		goto out;
-	}
-
-	ret = smb_direct_check_recvmsg(recvmsg);
-	if (ret == -ECONNABORTED)
-		goto out;
-
-	req = (struct smb_direct_negotiate_req *)recvmsg->packet;
-	t->max_recv_size = min_t(int, t->max_recv_size,
-				 le32_to_cpu(req->preferred_send_size));
-	t->max_send_size = min_t(int, t->max_send_size,
-				 le32_to_cpu(req->max_receive_size));
-	t->max_fragmented_send_size =
-			le32_to_cpu(req->max_fragmented_size);
-
-	ret = smb_direct_send_negotiate_response(t, ret);
-out:
-	if (recvmsg)
-		put_recvmsg(t, recvmsg);
+	return 0;
+out_err:
+	put_recvmsg(t, recvmsg);
 	return ret;
 }
 
@@ -1896,6 +1867,47 @@ static int smb_direct_create_qpair(struct smb_direct_transport *t,
 static int smb_direct_prepare(struct ksmbd_transport *t)
 {
 	struct smb_direct_transport *st = smb_trans_direct_transfort(t);
+	struct smb_direct_recvmsg *recvmsg;
+	struct smb_direct_negotiate_req *req;
+	int ret;
+
+	ksmbd_debug(RDMA, "Waiting for SMB_DIRECT negotiate request\n");
+	ret = wait_event_interruptible_timeout(st->wait_status,
+					       st->negotiation_requested ||
+					       st->status == SMB_DIRECT_CS_DISCONNECTED,
+					       SMB_DIRECT_NEGOTIATE_TIMEOUT * HZ);
+	if (ret <= 0 || st->status == SMB_DIRECT_CS_DISCONNECTED)
+		return ret < 0 ? ret : -ETIMEDOUT;
+
+	recvmsg = get_first_reassembly(st);
+	if (!recvmsg)
+		return -ECONNABORTED;
+
+	ret = smb_direct_check_recvmsg(recvmsg);
+	if (ret == -ECONNABORTED)
+		goto out;
+
+	req = (struct smb_direct_negotiate_req *)recvmsg->packet;
+	st->max_recv_size = min_t(int, st->max_recv_size,
+				  le32_to_cpu(req->preferred_send_size));
+	st->max_send_size = min_t(int, st->max_send_size,
+				  le32_to_cpu(req->max_receive_size));
+	st->max_fragmented_send_size =
+			le32_to_cpu(req->max_fragmented_size);
+
+	ret = smb_direct_send_negotiate_response(st, ret);
+out:
+	spin_lock_irq(&st->reassembly_queue_lock);
+	st->reassembly_queue_length--;
+	list_del(&recvmsg->list);
+	spin_unlock_irq(&st->reassembly_queue_lock);
+	put_recvmsg(st, recvmsg);
+
+	return ret;
+}
+
+static int smb_direct_connect(struct smb_direct_transport *st)
+{
 	int ret;
 	struct ib_qp_cap qp_cap;
 
@@ -1917,13 +1929,11 @@ static int smb_direct_prepare(struct ksmbd_transport *t)
 		return ret;
 	}
 
-	ret = smb_direct_negotiate(st);
+	ret = smb_direct_prepare_negotiation(st);
 	if (ret) {
 		pr_err("Can't negotiate: %d\n", ret);
 		return ret;
 	}
-
-	st->status = SMB_DIRECT_CS_CONNECTED;
 	return 0;
 }
 
@@ -1939,6 +1949,7 @@ static bool rdma_frwr_is_supported(struct ib_device_attr *attrs)
 static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 {
 	struct smb_direct_transport *t;
+	int ret;
 
 	if (!rdma_frwr_is_supported(&new_cm_id->device->attrs)) {
 		ksmbd_debug(RDMA,
@@ -1951,18 +1962,23 @@ static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 	if (!t)
 		return -ENOMEM;
 
+	ret = smb_direct_connect(t);
+	if (ret)
+		goto out_err;
+
 	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
 					      KSMBD_TRANS(t)->conn, "ksmbd:r%u",
 					      smb_direct_port);
 	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
-		int ret = PTR_ERR(KSMBD_TRANS(t)->handler);
-
+		ret = PTR_ERR(KSMBD_TRANS(t)->handler);
 		pr_err("Can't start thread\n");
-		free_transport(t);
-		return ret;
+		goto out_err;
 	}
 
 	return 0;
+out_err:
+	free_transport(t);
+	return ret;
 }
 
 static int smb_direct_listen_handler(struct rdma_cm_id *cm_id,
-- 
2.25.1


