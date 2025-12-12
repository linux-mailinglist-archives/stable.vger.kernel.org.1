Return-Path: <stable+bounces-200920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C0CCB91F5
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 16:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC4013014C64
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 15:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1370A3176F4;
	Fri, 12 Dec 2025 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoOXaMoQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D6730E0E4
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553279; cv=none; b=BtE3IcA3uqpqwD4kRJOEBvieKjabNr2XxMTYs2LSov5ALfon3O7Pf6un8G8IlrYe/ltVoiC7lu3AmIWlZ8WMJzTxCWEb/Uslz8/D7U16wBJDEALFmmfU1Lo0VaKWY/XWgkZLdKquHjZzZJJ59qBrUJxlkhPH6ajZq3mJvdgvPss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553279; c=relaxed/simple;
	bh=i+qr47P2eCDHTXJAVkjOdS7xg57iGJ43qDshBEK6miY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGfM7hbHiOrXtpG9mxei/U/mzAXxTAQSmt3Jd+USobRhOG7xyxwH7vXnYgS8pqwO6xmCHtiVUnovbuKweLDUeZzevPWemtYRTNpPbBSxv/6vdhY5sAU1uSos5ovUSpqhmuEKU+mWvmDUoV7m6EIJDpDrHNL7Ka1c/N08ttpS5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoOXaMoQ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34b75f7a134so319629a91.0
        for <stable@vger.kernel.org>; Fri, 12 Dec 2025 07:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765553277; x=1766158077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzENitL8AUZ68RERyt6xp7p+jtCblr0NyYweq7WA0Os=;
        b=eoOXaMoQMgVMdNzz88yV8SuElgbM5NJDiq50Dw5EON2DksG0/gN/2zEa+0K7l+sHOQ
         xZfhP6miNtyaLWBbDErCy5ygXBmp34U7aa8DfgeVifkOWjuQGpMkZzCLlyCZw1RVVf+U
         5xHMjRPTqj40hU+Sd1ruoHaKLiG1Qz/YY6S6+nj+c99ebjbIN32yk03UFby0vNS4hsak
         XYKgok0TfoKpLfTgy9dE9eKuRujiYWNeWrC86U71RWS/HfGA+FZ3WzYqRHO4ElJL7p88
         9qDZlh/m9QHdPjsbYext/O66FGo63fyMErF7n21elANS5+aPUoO2sfBHtEfWlYikU5So
         49qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553277; x=1766158077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzENitL8AUZ68RERyt6xp7p+jtCblr0NyYweq7WA0Os=;
        b=AHW0uODRSZosETU0K+0ATCJuqsjF7rsPjT3HdiAlKk3Z/3gaf4s6D9Me+DErKDyMBn
         RosHlZCHRQLNuAOChaSaR4+rm1Hu+Cl3Df+PmQuvmwbQB4m3i90ES/weF5IFN62Q5w3B
         rUJuYTJvgJirUEB+moYYXQVMcG9P561+27AZLJz+CV9GfdgBCoHEAirzWmlq9Yhbh4Dv
         iH/UW6bDDMQO0P7hQDUdD1k9qEin0uRIZti21A3+TI3GdMzoOEdojX6X+TRIrpwQfR7E
         Txo/QqXiVwExflWmn7zmNpljnGI86Rp6SlE76o+3G5vKG9tu2tK1dy2ZNu1NRdrlXs6d
         gkyw==
X-Forwarded-Encrypted: i=1; AJvYcCUd1wMA1jZkSEA8TXvHg7nTmSu5SD45gnI665kkvADgzTu1mHx9qqYYmVNSmfnxt/lVSY8780c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/U/Z+5mpdIW00Cjy4lx7kC2Sv6zhx/JVnX6ve5q/3/QEDd7S
	b2BSANdraCkncqDFKy9gnGqR+eJExRht4fmFOvzEUUJ1TXnjd9TZorQG
X-Gm-Gg: AY/fxX4rSJEciPqmwvCigHgi+TP1AU9OfsJyAymngcnaX514ki3Vuso+ZzEVRBZ7UN/
	b+bUa3PbTZrrLMtjgdMDViz3FIr3KnMykeXeS3cw8j39bH2HtWu2eO8tlcF3DHZ7xnJBK+fUQRX
	hftqzsXKTRXcEwX4KTW+zwm7xiyWMNunHIKdwW9s7DXmGECO8IKLhUypzBAxeBsvLtSIl6LaVQd
	4x5SNGfdJk2v9CIW0QB0zkBiUrfM1NmGrzjPt3EByCyhGHDlSlB256LaHVLdVhs68pjGabU1huU
	K7ZI8ywVlLU2hh/h/0FYANyqgOCUr8tZSI4FGHp8btTviM2fmycUZLTPiBxemblZj/J1oHGjdk+
	PjbnvPexXJkcAtimiqqig1RqCgdD3B3JrWByRK1QBzcpNHfUF5o0wvHe2toZRm6mFSZ+CbL7kap
	/grKwMDNRI4S+Ado8e2N/4EZUL
X-Google-Smtp-Source: AGHT+IGJkdJ9hixisUeeYL/0HntI53jNSy5a6YB1w0C5X5lbrmy3dicEMz346CEDNpxcNlRXqX/xeA==
X-Received: by 2002:a17:90b:35c9:b0:33f:f22c:8602 with SMTP id 98e67ed59e1d1-34abd858b3cmr2097689a91.26.1765553277401;
        Fri, 12 Dec 2025 07:27:57 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:5402:1cf7:eb53:9399])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-34abe3dea94sm2288511a91.11.2025.12.12.07.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:27:56 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] virtio-net: enable all napis before scheduling refill work
Date: Fri, 12 Dec 2025 22:27:41 +0700
Message-ID: <20251212152741.11656-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling napi_disable() on an already disabled napi can cause the
deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
when pausing rx"), to avoid the deadlock, when pausing the RX in
virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
However, in the virtnet_rx_resume_all(), we enable the delayed refill
work too early before enabling all the receive queue napis.

The deadlock can be reproduced by running
selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
device and inserting a cond_resched() inside the for loop in
virtnet_rx_resume_all() to increase the success rate. Because the worker
processing the delayed refilled work runs on the same CPU as
virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
In real scenario, the contention on netdev_lock can cause the
reschedule.

This fixes the deadlock by ensuring all receive queue's napis are
enabled before we enable the delayed refill work in
virtnet_rx_resume_all() and virtnet_open().

Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
Cc: stable@vger.kernel.org
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
Changes in v2:
- Move try_fill_recv() before rx napi_enable()
- Link to v1: https://lore.kernel.org/netdev/20251208153419.18196-1-minhquangbui99@gmail.com/
---
 drivers/net/virtio_net.c | 71 +++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 8e04adb57f52..4e08880a9467 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3214,21 +3214,31 @@ static void virtnet_update_settings(struct virtnet_info *vi)
 static int virtnet_open(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	bool schedule_refill = false;
 	int i, err;
 
-	enable_delayed_refill(vi);
-
+	/* - We must call try_fill_recv before enabling napi of the same receive
+	 * queue so that it doesn't race with the call in virtnet_receive.
+	 * - We must enable and schedule delayed refill work only when we have
+	 * enabled all the receive queue's napi. Otherwise, in refill_work, we
+	 * have a deadlock when calling napi_disable on an already disabled
+	 * napi.
+	 */
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			/* Make sure we have some buffers: if oom use wq. */
 			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
+				schedule_refill = true;
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
 			goto err_enable_qp;
 	}
 
+	enable_delayed_refill(vi);
+	if (schedule_refill)
+		schedule_delayed_work(&vi->refill, 0);
+
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
 		if (vi->status & VIRTIO_NET_S_LINK_UP)
 			netif_carrier_on(vi->dev);
@@ -3463,39 +3473,48 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
 	__virtnet_rx_pause(vi, rq);
 }
 
-static void __virtnet_rx_resume(struct virtnet_info *vi,
-				struct receive_queue *rq,
-				bool refill)
+static void virtnet_rx_resume_all(struct virtnet_info *vi)
 {
-	bool running = netif_running(vi->dev);
 	bool schedule_refill = false;
+	int i;
 
-	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
-		schedule_refill = true;
-	if (running)
-		virtnet_napi_enable(rq);
-
-	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
-}
+	if (netif_running(vi->dev)) {
+		/* See the comment in virtnet_open for the ordering rule
+		 * of try_fill_recv, receive queue napi_enable and delayed
+		 * refill enable/schedule.
+		 */
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			if (i < vi->curr_queue_pairs)
+				if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
+					schedule_refill = true;
 
-static void virtnet_rx_resume_all(struct virtnet_info *vi)
-{
-	int i;
+			virtnet_napi_enable(&vi->rq[i]);
+		}
 
-	enable_delayed_refill(vi);
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (i < vi->curr_queue_pairs)
-			__virtnet_rx_resume(vi, &vi->rq[i], true);
-		else
-			__virtnet_rx_resume(vi, &vi->rq[i], false);
+		enable_delayed_refill(vi);
+		if (schedule_refill)
+			schedule_delayed_work(&vi->refill, 0);
 	}
 }
 
 static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
 {
-	enable_delayed_refill(vi);
-	__virtnet_rx_resume(vi, rq, true);
+	bool schedule_refill = false;
+
+	if (netif_running(vi->dev)) {
+		/* See the comment in virtnet_open for the ordering rule
+		 * of try_fill_recv, receive queue napi_enable and delayed
+		 * refill enable/schedule.
+		 */
+		if (!try_fill_recv(vi, rq, GFP_KERNEL))
+			schedule_refill = true;
+
+		virtnet_napi_enable(rq);
+
+		enable_delayed_refill(vi);
+		if (schedule_refill)
+			schedule_delayed_work(&vi->refill, 0);
+	}
 }
 
 static int virtnet_rx_resize(struct virtnet_info *vi,
-- 
2.43.0


