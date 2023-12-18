Return-Path: <stable+bounces-7650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 752EA817589
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D9728396C
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F69971450;
	Mon, 18 Dec 2023 15:36:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAFE71463
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28ade227850so2537125a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913788; x=1703518588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUVp5s8cMaRg7cbsJUhKVU/D3CSW9A7F+tQMtb2zp2o=;
        b=XTIJ75OFjNxjZTGRufpHe4Kc8nuSa0ozF33H2XJqxUXnkVWazsGm6Ucpco6pBadgSw
         Ul+EswBzLI7Zxq8A6GpKfIXBDF/a+oCLvkifMtqrr0PfE3UGS0jGri+IcwW9V76X9k5w
         gwn1Wt23TctRsAL9qUfX8hT7PapajzwFv2ZUg6rM+xwOOfxR1qy/mZ2Sgm4BZqBwdQA8
         nTVaIG8uj4Dlvze/2I4L3CUCduxJny/M4XIKNYiOyxbbpOFycXfx1Oz5kgZNJcHc+NPX
         EwDYxlrbHGP0JkGB1dHuFdI1iQHAWKeUy3Xolp9RlPbWetO24cHseESc/BqQhyV8Eka6
         kr4g==
X-Gm-Message-State: AOJu0YzGIFRtmEOWaHUQ7RCmISpTVbVX4Isa7NMclmPZiiTOGgZG24IK
	0xaBBrkb4BKgb3qapQzg3segwSPINU4=
X-Google-Smtp-Source: AGHT+IF3WL5izf2SRLTYNKPRXUsJKswbGr5sNPuffIOj1vtvAt2L3uSm9aqG39K9Db55Vu7W6gg/6A==
X-Received: by 2002:a17:90a:d24b:b0:28b:7e09:1ca3 with SMTP id o11-20020a17090ad24b00b0028b7e091ca3mr1058180pjw.22.1702913788025;
        Mon, 18 Dec 2023 07:36:28 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:27 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Yufan Chen <wiz.chen@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 021/154] ksmbd: add smb-direct shutdown
Date: Tue, 19 Dec 2023 00:32:41 +0900
Message-Id: <20231218153454.8090-22-linkinjeon@kernel.org>
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

[ Upstream commit 136dff3a6b71dc16c30b35cc390feb0bfc32ed50 ]

When killing ksmbd server after connecting rdma, ksmbd threads does not
terminate properly because the rdma connection is still alive.
This patch add shutdown operation to disconnect rdma connection while
ksmbd threads terminate.

Signed-off-by: Yufan Chen <wiz.chen@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.c     |  9 ++++++++-
 fs/ksmbd/connection.h     |  1 +
 fs/ksmbd/transport_rdma.c | 10 ++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index ddf447e9b8bf..6e3416d9c65e 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -399,17 +399,24 @@ int ksmbd_conn_transport_init(void)
 static void stop_sessions(void)
 {
 	struct ksmbd_conn *conn;
+	struct ksmbd_transport *t;
 
 again:
 	read_lock(&conn_list_lock);
 	list_for_each_entry(conn, &conn_list, conns_list) {
 		struct task_struct *task;
 
-		task = conn->transport->handler;
+		t = conn->transport;
+		task = t->handler;
 		if (task)
 			ksmbd_debug(CONN, "Stop session handler %s/%d\n",
 				    task->comm, task_pid_nr(task));
 		conn->status = KSMBD_SESS_EXITING;
+		if (t->ops->shutdown) {
+			read_unlock(&conn_list_lock);
+			t->ops->shutdown(t);
+			read_lock(&conn_list_lock);
+		}
 	}
 	read_unlock(&conn_list_lock);
 
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index 89eb41bbd160..fd243cdddb22 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -110,6 +110,7 @@ struct ksmbd_conn_ops {
 struct ksmbd_transport_ops {
 	int (*prepare)(struct ksmbd_transport *t);
 	void (*disconnect)(struct ksmbd_transport *t);
+	void (*shutdown)(struct ksmbd_transport *t);
 	int (*read)(struct ksmbd_transport *t, char *buf,
 		    unsigned int size, int max_retries);
 	int (*writev)(struct ksmbd_transport *t, struct kvec *iovs, int niov,
diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 7e85c2767cd0..c723e0552d77 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -1459,6 +1459,15 @@ static void smb_direct_disconnect(struct ksmbd_transport *t)
 	free_transport(st);
 }
 
+static void smb_direct_shutdown(struct ksmbd_transport *t)
+{
+	struct smb_direct_transport *st = smb_trans_direct_transfort(t);
+
+	ksmbd_debug(RDMA, "smb-direct shutdown cm_id=%p\n", st->cm_id);
+
+	smb_direct_disconnect_rdma_work(&st->disconnect_work);
+}
+
 static int smb_direct_cm_handler(struct rdma_cm_id *cm_id,
 				 struct rdma_cm_event *event)
 {
@@ -2207,6 +2216,7 @@ bool ksmbd_rdma_capable_netdev(struct net_device *netdev)
 static struct ksmbd_transport_ops ksmbd_smb_direct_transport_ops = {
 	.prepare	= smb_direct_prepare,
 	.disconnect	= smb_direct_disconnect,
+	.shutdown	= smb_direct_shutdown,
 	.writev		= smb_direct_writev,
 	.read		= smb_direct_read,
 	.rdma_read	= smb_direct_rdma_read,
-- 
2.25.1


