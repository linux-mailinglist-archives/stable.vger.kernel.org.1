Return-Path: <stable+bounces-98898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBB09E6318
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 02:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B69167933
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5183D146A93;
	Fri,  6 Dec 2024 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="pS47XYtL"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3B80054
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447520; cv=none; b=uMhRXeMdgz+zoSW97LKgWmnKfZOKpzeJIECFNoPfiFJXhQ3SSfVHQ1//YHO8++a3fInSzsLsz9F60VE/WPrtfWocGvkbCwM80jxW/9blUV7OsDTcGP2Y6RJ3VRsSflM2xO8pH214Fk0wG9xJ7a7LZSW6WmU9aG8oppg3Kqxsc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447520; c=relaxed/simple;
	bh=RqlqljCEL65bX/4/99BjDeGnmkrxramPpNz4DWizEy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XunyEWSmWqmZpY6Yy1DuFri5VromFmS8VohDGWU5KP0dyVP9Y5ooZIaRq607z83onJqmBjbGWVxb4Geg86EeZ25g1RO511HoPMcCvCYvFfLoXcD3kqJHbD2OPn8wsJK0ImXukoX09mNU0OXTNxuSuDqznV4798fyrktSKQBWUII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=pS47XYtL; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E4E4240CEB
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 01:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733447516;
	bh=0DkRrRdtwcxltiw3a2XZYsY1oAxq6KLTi5TBwA0X+38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=pS47XYtL+oAcOL1+shxEHUTnGs6ELQ1P/SUqrrl6TA7BFzQ9nel40X45fzVwRV/47
	 PlE5ngf+cglyM7PofZJSA3YKAB2rs2nkzqJy0/hIiVp4imyIYSLGGRUXCGQYUauiYE
	 Fd7x9pYQCejksjO+Q0wL8kDenFFP+XX/OlpTiTYTIfMmSGrHypxFHU7PsWCqu2akxh
	 Qo/Tw/seb7v0dTqvSRUWpeHr+pEkv3bI9K1mgzTIURcqzfctEahMJJccSchhJGlibq
	 f7mWbSX+SphkhS9xt/2kJoL0iZdqub7xZsnI3GwpaE51aLWAkV5CPWnR90OR5qYJqx
	 6BPZRiOEPtQrQ==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-725a30c9a35so927826b3a.2
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 17:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447515; x=1734052315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DkRrRdtwcxltiw3a2XZYsY1oAxq6KLTi5TBwA0X+38=;
        b=fvoWSe2LyWcea0483h/JT+RYLAZW/iu57QbII3gDy72XcIOz/Og/qNVo0qvcKd5FQw
         tusyyTaSdeAfNxcx7DoIA2/gmai7LasWbGOJYYdW53tAGAXh6RU7e+uojh4sgifn9u0m
         PxB0I2zOJkcy9ffjH1j6tfxD6VoBDyl4lawpToI29PiXyS81/EXLkhLO8/zvQr8nNK0N
         Uk1U3/YTN2s9CBwrxUzGk7wXvrTN1P4xLDrrURwgfUqtiKwxTBR3KKUluj0TniN944wC
         s/PWRUdh1cBCct7PlMrYUKRq7gE+/lBRuHG+YtlJNBQEynGKDRStpv1VkPhf3fgRIxdQ
         wNdA==
X-Forwarded-Encrypted: i=1; AJvYcCUXECGL0dNTe5Jhsi5wSsZJLBgPor8HBLru5zYG4lMtgVHaaVFvyU4vG5OlsdsfglJTXDK5UJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+cCeebVP8CMooPvaFEvf9PKmFoO5eoqxt2/zgd1m76U/0+VW+
	64cxlw6hMnIinNkepjlithon2sznRw7sVi0bMp3HHpdzyDV8tztiSlpS9tOcf/T0kALy6KoZeQa
	f2o2YVoO/uenSHwvbNPjqstI2WkwCH4ty9OR+NADWyC9+nW/6lx5QxeiziQrLfHoxOxaj2g==
X-Gm-Gg: ASbGncu+Hn+jzxKxC3hb6oOQ80+MxNIzNqFGjdw8Hlv3ZXPL8okxsROl3OPOZtbOio3
	xh9HMlmE3VjD4JpAxTAM9Q8kpbGlfeYGoSqrN7aXnIarX+7+zd452jK+FbLKEJ2jbeqOwYaeqMr
	BpA3geScLasKPRq3PxO9UgwMltz3MkJgw93RL1OdtdjRNvXIsY8l80GDhLEFN8WhbUlu7NrPJtz
	IGza3k92CNFsPJb8uScEJ4EqdhpAyu5Bzreqwz5AOBwgYTYRcM=
X-Received: by 2002:a17:903:24e:b0:215:9d29:9724 with SMTP id d9443c01a7336-21614dc51d0mr16338775ad.38.1733447514872;
        Thu, 05 Dec 2024 17:11:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiAxk12TLEAZVlXN3AMx9CBNnCG3b9Crg3EPVg0Vc1+/w62vhDV/vWjq+VCbS4eYtWIXUo4Q==
X-Received: by 2002:a17:903:24e:b0:215:9d29:9724 with SMTP id d9443c01a7336-21614dc51d0mr16338465ad.38.1733447514451;
        Thu, 05 Dec 2024 17:11:54 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:9740:f048:7177:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa18esm17979355ad.123.2024.12.05.17.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:11:54 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 3/6] virtio_ring: add a func argument 'recycle_done' to virtqueue_resize()
Date: Fri,  6 Dec 2024 10:10:44 +0900
Message-ID: <20241206011047.923923-4-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206011047.923923-1-koichiro.den@canonical.com>
References: <20241206011047.923923-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When virtqueue_resize() has actually recycled all unused buffers,
additional work may be required in some cases. Relying solely on its
return status is fragile, so introduce a new function argument
'recycle_done', which is invoked when the recycle really occurs.

Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c     | 4 ++--
 drivers/virtio/virtio_ring.c | 6 +++++-
 include/linux/virtio.h       | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fc89c5e1a207..e10bc9e6b072 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3331,7 +3331,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 
 	virtnet_rx_pause(vi, rq);
 
-	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
+	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf, NULL);
 	if (err)
 		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
 
@@ -3394,7 +3394,7 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, NULL);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 82a7d2cbc704..6af8cf6a619e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2772,6 +2772,7 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
  * @_vq: the struct virtqueue we're talking about.
  * @num: new ring num
  * @recycle: callback to recycle unused buffers
+ * @recycle_done: callback to be invoked when recycle for all unused buffers done
  *
  * When it is really necessary to create a new vring, it will set the current vq
  * into the reset state. Then call the passed callback to recycle the buffer
@@ -2792,7 +2793,8 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
  *
  */
 int virtqueue_resize(struct virtqueue *_vq, u32 num,
-		     void (*recycle)(struct virtqueue *vq, void *buf))
+		     void (*recycle)(struct virtqueue *vq, void *buf),
+		     void (*recycle_done)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
@@ -2809,6 +2811,8 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 	err = virtqueue_disable_and_recycle(_vq, recycle);
 	if (err)
 		return err;
+	if (recycle_done)
+		recycle_done(_vq);
 
 	if (vq->packed_ring)
 		err = virtqueue_resize_packed(_vq, num);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 57cc4b07fd17..0aa7df4ed5ca 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -109,7 +109,8 @@ dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
 dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
 
 int virtqueue_resize(struct virtqueue *vq, u32 num,
-		     void (*recycle)(struct virtqueue *vq, void *buf));
+		     void (*recycle)(struct virtqueue *vq, void *buf),
+		     void (*recycle_done)(struct virtqueue *vq));
 int virtqueue_reset(struct virtqueue *vq,
 		    void (*recycle)(struct virtqueue *vq, void *buf));
 
-- 
2.43.0


