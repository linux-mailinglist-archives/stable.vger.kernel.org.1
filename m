Return-Path: <stable+bounces-12335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202E6835618
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 15:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78CC9B22348
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D089374C9;
	Sun, 21 Jan 2024 14:31:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98DF374C2
	for <stable@vger.kernel.org>; Sun, 21 Jan 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847498; cv=none; b=eEylvHijelzZDJRs/OAnU8iOB0zrMdCBHVz9W24LJskPEl/AwH+obrGAHoEjnAWwVs3ZP3g9opR0rjKwkGL752xeyXMHew3/k+htMVhtsRdQuKBz0lM8LZY7OVxckIURs4e7gpbHpmT+3Am9outgaEQ9EWb4ZkN/7nFhDAm7X2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847498; c=relaxed/simple;
	bh=cGFeJLKDRX2IMF3CcpH7JxtWGJa+1XQAuC6M4ItX8UY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G5S2J9pxQ2OzolS0srooAs51ksr9gL7dTY+gnIiZyJgmy6BC+2xOuXZfvrxUq0NnJ59bsttTWmu1/pOuHDtnGBuaK4Un0IpKoAskZ3H5IQp+0q1D+YB7A2vXprarmT59Tr8k6CrIOAHhJo/u76+IvjQLKUk81aXB9YNWV0NJhlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29026523507so1808454a91.0
        for <stable@vger.kernel.org>; Sun, 21 Jan 2024 06:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705847496; x=1706452296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFOAmVaVUjoeayEc52i2BSCgIN9Ho02A0gnRSa7ryQQ=;
        b=qAxC3ypi9KvlO4Z4w0mNCOpf6nCrGpDBfbTCSGVvQ7hFghxRBOcc58YZ0EuN1I4o4/
         0pNhJPyw/P3vQGG2EJ6Q1WNMgvAYWLJEe13kCG1OYLAsx23UxYeLX7/IcFOtSf6rVeve
         SGaUYQPnSuoaqHMn13kAFLFlABCyUcrm060rO2yzqjqrbCESRVtu9SZKE5Vxw5tKwoKk
         4HgxBwo2OC/xHfKOS+bH/zyt7Ke5aoYCbZVmEkR9Zm2s4oeSKJ/0rm4CPBKO7HKat+su
         kmOMBgzyoNT7ClcGDlCayoGlJ83uWm4DjWw7GAZXXsxu6keHLT5JnoxKCfHGw6dH+wPm
         oOYg==
X-Gm-Message-State: AOJu0Yx0lYN+8vfBP4yVbhi0Px6r2m2hZxVMNqglUSMRs52xUh+d3fsQ
	V0/zk3L7ewI5qZxMbyvd0g9OexUB6rqWcWeD3ortuZuDnnalhGpe
X-Google-Smtp-Source: AGHT+IFuO2QA+QimrVpL/+gWGjeX9SjkPOd+IIPrxvUmbwfUSk4yvIpopdKbSgAQiyjhlI6w/0hXaA==
X-Received: by 2002:a17:90b:3547:b0:28c:4c8d:5574 with SMTP id lt7-20020a17090b354700b0028c4c8d5574mr1031921pjb.49.1705847496187;
        Sun, 21 Jan 2024 06:31:36 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d5dd98bf12sm5831027plc.49.2024.01.21.06.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 06:31:35 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 10/11] ksmbd: fix UAF issue in ksmbd_tcp_new_connection()
Date: Sun, 21 Jan 2024 23:30:37 +0900
Message-Id: <20240121143038.10589-11-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121143038.10589-1-linkinjeon@kernel.org>
References: <20240121143038.10589-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 38d20c62903d669693a1869aa68c4dd5674e2544 ]

The race is between the handling of a new TCP connection and
its disconnection. It leads to UAF on  in
ksmbd_tcp_new_connection() function.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-22991
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/connection.c     |  6 ------
 fs/ksmbd/connection.h     |  1 -
 fs/ksmbd/transport_rdma.c | 11 ++++++-----
 fs/ksmbd/transport_tcp.c  | 13 +++++++------
 4 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index f9fbde916a09..63815c4df133 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -416,13 +416,7 @@ static void stop_sessions(void)
 again:
 	down_read(&conn_list_lock);
 	list_for_each_entry(conn, &conn_list, conns_list) {
-		struct task_struct *task;
-
 		t = conn->transport;
-		task = t->handler;
-		if (task)
-			ksmbd_debug(CONN, "Stop session handler %s/%d\n",
-				    task->comm, task_pid_nr(task));
 		ksmbd_conn_set_exiting(conn);
 		if (t->ops->shutdown) {
 			up_read(&conn_list_lock);
diff --git a/fs/ksmbd/connection.h b/fs/ksmbd/connection.h
index 342f935f5770..0e04cf8b1d89 100644
--- a/fs/ksmbd/connection.h
+++ b/fs/ksmbd/connection.h
@@ -135,7 +135,6 @@ struct ksmbd_transport_ops {
 struct ksmbd_transport {
 	struct ksmbd_conn		*conn;
 	struct ksmbd_transport_ops	*ops;
-	struct task_struct		*handler;
 };
 
 #define KSMBD_TCP_RECV_TIMEOUT	(7 * HZ)
diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 252a1e7afcc0..355673f2830b 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -2039,6 +2039,7 @@ static bool rdma_frwr_is_supported(struct ib_device_attr *attrs)
 static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 {
 	struct smb_direct_transport *t;
+	struct task_struct *handler;
 	int ret;
 
 	if (!rdma_frwr_is_supported(&new_cm_id->device->attrs)) {
@@ -2056,11 +2057,11 @@ static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 	if (ret)
 		goto out_err;
 
-	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
-					      KSMBD_TRANS(t)->conn, "ksmbd:r%u",
-					      smb_direct_port);
-	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
-		ret = PTR_ERR(KSMBD_TRANS(t)->handler);
+	handler = kthread_run(ksmbd_conn_handler_loop,
+			      KSMBD_TRANS(t)->conn, "ksmbd:r%u",
+			      smb_direct_port);
+	if (IS_ERR(handler)) {
+		ret = PTR_ERR(handler);
 		pr_err("Can't start thread\n");
 		goto out_err;
 	}
diff --git a/fs/ksmbd/transport_tcp.c b/fs/ksmbd/transport_tcp.c
index eff7a1d793f0..9d4222154dcc 100644
--- a/fs/ksmbd/transport_tcp.c
+++ b/fs/ksmbd/transport_tcp.c
@@ -185,6 +185,7 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 	struct sockaddr *csin;
 	int rc = 0;
 	struct tcp_transport *t;
+	struct task_struct *handler;
 
 	t = alloc_transport(client_sk);
 	if (!t) {
@@ -199,13 +200,13 @@ static int ksmbd_tcp_new_connection(struct socket *client_sk)
 		goto out_error;
 	}
 
-	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
-					      KSMBD_TRANS(t)->conn,
-					      "ksmbd:%u",
-					      ksmbd_tcp_get_port(csin));
-	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
+	handler = kthread_run(ksmbd_conn_handler_loop,
+			      KSMBD_TRANS(t)->conn,
+			      "ksmbd:%u",
+			      ksmbd_tcp_get_port(csin));
+	if (IS_ERR(handler)) {
 		pr_err("cannot start conn thread\n");
-		rc = PTR_ERR(KSMBD_TRANS(t)->handler);
+		rc = PTR_ERR(handler);
 		free_transport(t);
 	}
 	return rc;
-- 
2.25.1


