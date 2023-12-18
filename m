Return-Path: <stable+bounces-7664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BC98175AC
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4301C24D6F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FEA49F72;
	Mon, 18 Dec 2023 15:37:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9C3D564
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c6839373f8so2123927a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913835; x=1703518635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZSP2TVSEZ+JdZNnrODmD0dvRIkgNQZN2IvmVa9pA0A=;
        b=M0Gbj/m4Qf6EJsgQB9gmd22wezepUSngbw30Bcua/qKZ5UdOUAZ7qTVSKaJ8SL6m3p
         kEgJg1vhf6mZr5bAwuoLwcaFpc3IFC5605ZVsT+wNeDVOUTw8NZonkPAc+LwNuTItKgo
         bFzVfhwATkPeUhf4uyH7Y8Aa8ZcPewFToYpqBxyDv4vfEeOTDtnbxeHwXR1qLp0BgaaB
         ihvn0PEDWY/p/C+wcj9IpLLvF/hE/2bVdug7gScuStka43fCdRj++Hxkk7jfuEQ3zfr3
         6h1MiY804lP/8XRb7NWUilJ973mJ+sT+iB00dssytojX8ifF7egsO82OufaS3xxMQu17
         Q0MQ==
X-Gm-Message-State: AOJu0Yy1z7nkEe3L34S3xYVehZvKj1Uc04mXgD8hu1QowF/GvvI6SzJA
	XgvB7nMB+H623ojvgChnIr4=
X-Google-Smtp-Source: AGHT+IEIYIibYHmAWePbZsHK4KQ15kprzPDDcRiCyIWAxX+s/MC3KEZBkEHWBkMNMAm+f3oBDokKOQ==
X-Received: by 2002:a17:90a:1305:b0:28b:2f14:5bc1 with SMTP id h5-20020a17090a130500b0028b2f145bc1mr7008505pja.7.1702913834817;
        Mon, 18 Dec 2023 07:37:14 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:14 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 035/154] ksmbd: smbd: simplify tracking pending packets
Date: Tue, 19 Dec 2023 00:32:55 +0900
Message-Id: <20231218153454.8090-36-linkinjeon@kernel.org>
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

[ Upstream commit 11659a8ddbd9c4c1ab6f3b8f52837178ef121b20 ]

Because we don't have to tracking pending packets
by dividing these into packets with payload and
packets without payload, merge the tracking code.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 411ea62712f1..02271ebf418a 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -157,8 +157,6 @@ struct smb_direct_transport {
 	mempool_t		*recvmsg_mempool;
 	struct kmem_cache	*recvmsg_cache;
 
-	wait_queue_head_t	wait_send_payload_pending;
-	atomic_t		send_payload_pending;
 	wait_queue_head_t	wait_send_pending;
 	atomic_t		send_pending;
 
@@ -392,8 +390,6 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 	spin_lock_init(&t->empty_recvmsg_queue_lock);
 	INIT_LIST_HEAD(&t->empty_recvmsg_queue);
 
-	init_waitqueue_head(&t->wait_send_payload_pending);
-	atomic_set(&t->send_payload_pending, 0);
 	init_waitqueue_head(&t->wait_send_pending);
 	atomic_set(&t->send_pending, 0);
 
@@ -423,8 +419,6 @@ static void free_transport(struct smb_direct_transport *t)
 	wake_up_interruptible(&t->wait_send_credits);
 
 	ksmbd_debug(RDMA, "wait for all send posted to IB to finish\n");
-	wait_event(t->wait_send_payload_pending,
-		   atomic_read(&t->send_payload_pending) == 0);
 	wait_event(t->wait_send_pending,
 		   atomic_read(&t->send_pending) == 0);
 
@@ -879,13 +873,8 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 		smb_direct_disconnect_rdma_connection(t);
 	}
 
-	if (sendmsg->num_sge > 1) {
-		if (atomic_dec_and_test(&t->send_payload_pending))
-			wake_up(&t->wait_send_payload_pending);
-	} else {
-		if (atomic_dec_and_test(&t->send_pending))
-			wake_up(&t->wait_send_pending);
-	}
+	if (atomic_dec_and_test(&t->send_pending))
+		wake_up(&t->wait_send_pending);
 
 	/* iterate and free the list of messages in reverse. the list's head
 	 * is invalid.
@@ -917,21 +906,12 @@ static int smb_direct_post_send(struct smb_direct_transport *t,
 {
 	int ret;
 
-	if (wr->num_sge > 1)
-		atomic_inc(&t->send_payload_pending);
-	else
-		atomic_inc(&t->send_pending);
-
+	atomic_inc(&t->send_pending);
 	ret = ib_post_send(t->qp, wr, NULL);
 	if (ret) {
 		pr_err("failed to post send: %d\n", ret);
-		if (wr->num_sge > 1) {
-			if (atomic_dec_and_test(&t->send_payload_pending))
-				wake_up(&t->wait_send_payload_pending);
-		} else {
-			if (atomic_dec_and_test(&t->send_pending))
-				wake_up(&t->wait_send_pending);
-		}
+		if (atomic_dec_and_test(&t->send_pending))
+			wake_up(&t->wait_send_pending);
 		smb_direct_disconnect_rdma_connection(t);
 	}
 	return ret;
@@ -1332,8 +1312,8 @@ static int smb_direct_writev(struct ksmbd_transport *t,
 	 * that means all the I/Os have been out and we are good to return
 	 */
 
-	wait_event(st->wait_send_payload_pending,
-		   atomic_read(&st->send_payload_pending) == 0);
+	wait_event(st->wait_send_pending,
+		   atomic_read(&st->send_pending) == 0);
 	return ret;
 }
 
-- 
2.25.1


