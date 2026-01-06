Return-Path: <stable+bounces-205100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BEBCF8FA6
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50969306F8E7
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45472337B89;
	Tue,  6 Jan 2026 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InUmX2Tc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95174336ED7
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711905; cv=none; b=LCp3T+hzl2U1zI2tHGS55wGQrYW1TkLkvizsdm4bzUTMJMnZCC38uU3cF55DdxBILWfQfxi9qayHs43ChdSkFlmpvw7F4/yHbwc3izh2pBS8z4MDjL6qXLXGbYS0Xl94Fwdh/12A+i5yz/Q1CjriBwdn9H5Rxxeo81u+MbCZtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711905; c=relaxed/simple;
	bh=xszaQ3qzOot1odzGyBA0Zkfa9b0Ivks3e8yQFqhs2jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Osx2tXnDrEEqvsdg1ZrVEz66qpco1w+4b9qiYVkdrtR+WFtEEZZX0pBxqUCS15As8bvqubtE52IzTJmYGSDMOdbG6pvvhH8PFZQTbJRQEnarjx0zdA6fZ4mBhbkO6+rnSxM7sAfKsKKDWPcyf0AN7EbPrjOqMoSxjmfGFFc9HVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InUmX2Tc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so914828b3a.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 07:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711901; x=1768316701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCgDdsFcTcXxf+qbWNQRt/nwxivkvn3dRLkqvh820N0=;
        b=InUmX2Tc85X+x4r1XsBfynIkmazzuKxkR4u+dpkAHvul0xSw+BeGD/9SAhp9Bq77Go
         XGqgUM5aZJeylku7TEDr4kYRwbnH8Uln41jW3De/Yc0G0BfCc7GD+Qz2L0XxQdqyfyHK
         ugpnj9OtaUgXdhfIozd3XfVq9K0QX8Qf+V4dx+3oEhuMpDxPds7pjibwrJ30yUGnj23O
         sXCQxNFAKbkAFPnM1noZzT39K2I/x2VvHINveqRBwpIp7CV/YrSzQpip9HhkurwGBSAQ
         wCV8t06fGv28Id8n65INMNw2+8ahemFmK76qQvt5qfxCi7axA6Wa1OFnbfsmZG00G99A
         AwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711901; x=1768316701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCgDdsFcTcXxf+qbWNQRt/nwxivkvn3dRLkqvh820N0=;
        b=HLia2vwEYTgdnuLlJV4atN+b55/hjBHhrPVwZXBnSj/8WKkmgPqRRhsagebk35/oX6
         v46mQY6zGhWzUO2x94HyFix20o7EoO1lxa9SE0TzAdSN8UmGtpmFeKBZfIxVipPbrjyn
         zO0Xk3dHJbscfNfNzdEqN8C47ryZgElpWCE4tVRK6gr+kNULfq+kV3rx8M9esWUtBCGE
         /pqDq/Q9j01YuXHBxeJ4d3OofIOe+F07LquMz9ARdtLugcQgpCU4514TlbOMbG466lBM
         ZiXb7Tt4Toh171KwEknUHvsEcxogPKhKL8wAgVHBOduyotLIhlGTXLVg2EknHPee/pF6
         El+w==
X-Forwarded-Encrypted: i=1; AJvYcCU8aXytNRlFffbVk4uUjQu1Nm6LXz2iD4M/U12GWVp21/zzD+Re1rZPd04MFqdtTmQArMqO5T4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydj9cZyX7ezPSegvsgKFq3EEEB2NQ0JqfYlU1w/FFjcTbTRBg0
	e0vDMD7RQaY4ZSj9FFUi1jztMrk/Vq9PeYo3v62qLwLb83cjjGC7g0G4
X-Gm-Gg: AY/fxX45h4JPqk1uVjf+UdZzxEt8fmYjEUX4HeMDYi/Ezxg7F1AbjYIkmCWHja5m3U5
	I0ODeT7uog/Gl0+FzTPqy6aJoW7rTezyxUlc0WYyIrqEQA5r8TwHVLHe3Jxcj7fT3Muu7fxGCQe
	lz72zlj7y/QL0OQQfOdK0hKPlY1Fz8wuNpZZZO7AbWohvvn7KuwIyGoZ30Dfrypx4HgcdVtZjvW
	X0meV97qiMQq5/GCIQSq/gXVwnUWGvttElklFpxOmnjkR6xLqfDJ3B+OBIYaEj1i4BLpiLs0XOb
	I2gJ4Auj0lZSr837nk2WHl9YrmSnhT7cKoyhrbyt8lsePwnIr6UpGNYhubGJzJ3zLf/GK+KRs1A
	q2QPzjy+v57gBcGCirE1TUZBugYIKMOWkFMEy34broQ2zQw9/LjS8tql0DeewQmIQ5+p93xNqw1
	b37KwHzercSXX1P9tWGXo=
X-Google-Smtp-Source: AGHT+IHDogIdZKcYrYsV8f80P4yM3C43vbE23Xgd+qTKk7rTQsoMMRcLT36sPlF6l2euTU7zw8ZVRA==
X-Received: by 2002:a05:6a20:244a:b0:34f:2070:89d5 with SMTP id adf61e73a8af0-389822449d3mr2785149637.11.1767711901107;
        Tue, 06 Jan 2026 07:05:01 -0800 (PST)
Received: from minh.. ([14.187.47.150])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c4cbfc2f481sm2674231a12.10.2026.01.06.07.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:05:00 -0800 (PST)
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
Subject: [PATCH net v3 1/3] virtio-net: don't schedule delayed refill worker
Date: Tue,  6 Jan 2026 22:04:36 +0700
Message-ID: <20260106150438.7425-2-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106150438.7425-1-minhquangbui99@gmail.com>
References: <20260106150438.7425-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we fail to refill the receive buffers, we schedule a delayed worker
to retry later. However, this worker creates some concurrency issues.
For example, when the worker runs concurrently with virtnet_xdp_set,
both need to temporarily disable queue's NAPI before enabling again.
Without proper synchronization, a deadlock can happen when
napi_disable() is called on an already disabled NAPI. That
napi_disable() call will be stuck and so will the subsequent
napi_enable() call.

To simplify the logic and avoid further problems, we will instead retry
refilling in the next NAPI poll.

Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
Cc: stable@vger.kernel.org
Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 48 +++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1bb3aeca66c6..f986abf0c236 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3046,16 +3046,16 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	else
 		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
 
+	u64_stats_set(&stats.packets, packets);
 	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
-		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
-			spin_lock(&vi->refill_lock);
-			if (vi->refill_enabled)
-				schedule_delayed_work(&vi->refill, 0);
-			spin_unlock(&vi->refill_lock);
-		}
+		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
+			/* We need to retry refilling in the next NAPI poll so
+			 * we must return budget to make sure the NAPI is
+			 * repolled.
+			 */
+			packets = budget;
 	}
 
-	u64_stats_set(&stats.packets, packets);
 	u64_stats_update_begin(&rq->stats.syncp);
 	for (i = 0; i < ARRAY_SIZE(virtnet_rq_stats_desc); i++) {
 		size_t offset = virtnet_rq_stats_desc[i].offset;
@@ -3230,9 +3230,10 @@ static int virtnet_open(struct net_device *dev)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
-			/* Make sure we have some buffers: if oom use wq. */
-			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
-				schedule_delayed_work(&vi->refill, 0);
+			/* Pre-fill rq agressively, to make sure we are ready to
+			 * get packets immediately.
+			 */
+			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
 
 		err = virtnet_enable_queue_pair(vi, i);
 		if (err < 0)
@@ -3472,16 +3473,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
 				struct receive_queue *rq,
 				bool refill)
 {
-	bool running = netif_running(vi->dev);
-	bool schedule_refill = false;
+	if (netif_running(vi->dev)) {
+		/* Pre-fill rq agressively, to make sure we are ready to get
+		 * packets immediately.
+		 */
+		if (refill)
+			try_fill_recv(vi, rq, GFP_KERNEL);
 
-	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
-		schedule_refill = true;
-	if (running)
 		virtnet_napi_enable(rq);
-
-	if (schedule_refill)
-		schedule_delayed_work(&vi->refill, 0);
+	}
 }
 
 static void virtnet_rx_resume_all(struct virtnet_info *vi)
@@ -3829,11 +3829,13 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
 	}
 succ:
 	vi->curr_queue_pairs = queue_pairs;
-	/* virtnet_open() will refill when device is going to up. */
-	spin_lock_bh(&vi->refill_lock);
-	if (dev->flags & IFF_UP && vi->refill_enabled)
-		schedule_delayed_work(&vi->refill, 0);
-	spin_unlock_bh(&vi->refill_lock);
+	if (dev->flags & IFF_UP) {
+		local_bh_disable();
+		for (int i = 0; i < vi->curr_queue_pairs; ++i)
+			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
+
+		local_bh_enable();
+	}
 
 	return 0;
 }
-- 
2.43.0


