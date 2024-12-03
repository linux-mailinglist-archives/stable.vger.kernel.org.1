Return-Path: <stable+bounces-96195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4604E9E1435
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 08:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83EB8B23E4F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 07:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A151B1D61;
	Tue,  3 Dec 2024 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QoSkUbSG"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF1A1ABECF
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211065; cv=none; b=FDMN6Rxl6WV6nnLlS+uAkDRnXwqlnG9QBCYIgwLSP8FfaouQLSDRX2TNSOoscsq5Qxhlam0nEm1fLnAfqS752JUeWUv1GxJ6rCuR4Yr1BkjYEcW9IwWOI7SB2ujHOUmjblmOtXZynCXgW5Fhh3cQEF3hz+kY/ZWcrlHO99wwNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211065; c=relaxed/simple;
	bh=w5AGnCRzxvkv5uIQocaLa71YmtI6LxwVdo9vgigsjyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9R7UK3WOfKE5THzMzk30tQRJ8EfNvcda7WJ9VYfoitqQMeUzquvviPv4BypCBU+P+jbia020I8KqokiAl5ibBtc/6uXFX/GYvM6erh067S6cgMoGWAy6E5JdmmWWxPsArWGjHL6qWyfqRJbLaQV+EcvnCAz+MfyTuX96mMLPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=QoSkUbSG; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7F59C40624
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 07:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733211061;
	bh=fW9S3ivOx/vCR/Vpb6zGlhQWyPtyKwj/7WKI3Nel5z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=QoSkUbSG4sn0AdiFfXD0l9vSJzLdEnz5weCkV+IhLUyhySqlIuzFD9x6EXuCkjbot
	 iHMhpGpaAPjBwZaHOWgjclclDBJwNRzPUCwpgpBXc4Asgx5EtSIB0LiRQDKVHCnBMz
	 CQVvJSizHFDNLR2ZTZYm91IsB3qnXgctPZj2Um3lMYtX8LfMb8G8TANLPcSULUArfs
	 j9j04/CLmUniB3i2jwufIFiVszieQjX6E0TMa4XN5PKcV2sehraAS4H01/OmYV024c
	 ExB14VxSSb+dl8lIsF5yhwMmckM7foLzaxAN+1hI3ns7X37VwmGJXmrFnjpCLygK5c
	 8oxitsmza5UwA==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-215576aca41so23173565ad.0
        for <stable@vger.kernel.org>; Mon, 02 Dec 2024 23:31:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211060; x=1733815860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fW9S3ivOx/vCR/Vpb6zGlhQWyPtyKwj/7WKI3Nel5z4=;
        b=Y8QLaNC8ffjZQMye8y57Xg1BhDv33BxHwte+IllAc89HUOk8Bg1YitRKy5bmCVrUjZ
         GnUhljp6KH08PCOgiayZXt196LiL1EbKGCmPeAXynPpWs45FTQ+VbUjT8gwZ+MxLciUC
         VyNFTlMIAlvChJK271yBBGxCEKKD9+wU/Hsl0XSFBRZBfpWU7lFMhKengmmIGwqUO6DZ
         O+hAwRko+ORBmLqwWcHVe7Jhrn3pjpZkKmEXTce87OP94z9YoewToXbI+ezCR3JIvDGp
         xsgaYHEY/SEXPWaADk8f+/LyAWodPNnuyJanVgFlm4/vx2nPEkJ7SoP79VzUHxLpIPV/
         vbyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Ap9RlARfLxxpMoGXmt70SlA/+DKSfW2dCTGHKgx+Ko2JTgyzKmFT32qOaHVyA1Ya8tF0xh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6JTwsrWwTT6B4n6057j1TttDkPsUZWIf43LwQjRxzyhs3IIL
	b5PS61OmHt817obU5wlRprwwvLh4Tmd0kVZhwTqQv8MSmtwieet1qKxDeG+ssBvDFuOnv5n+SSp
	igv1b+HG9+zQtAc6FU3PTdOv3lMm3hWpqf6mOHUDtqLv75hVe98eaoq3ZdBEvtG3kBfNUMg==
X-Gm-Gg: ASbGnct+mY/NNTx0H/YzQZbglbMTt3UUhPIeKFS28lV8Gy+W/p0kxdVN6iK3G5N4Ckw
	3hqlv7h4r5Hfo6z1L1Z03bGeuDuyG/uZRPxXq4bO/ZfPcomcGqxCUKBWFYhdZjVkYBkfdQFwF6T
	OL83ywe3qF/w+nkRpv/j5zVegrbM6rXaTtEBglVqnw8yIewu78dKezfPesMRxxENNHHpcYhhwGA
	QhO4Ic9r8dOrA4zcB6CH3kfOJfAQK3oNxI99hJ31r0e7nBw4hQAwjrBNwG7Sn/m9xo5
X-Received: by 2002:a17:902:cec7:b0:215:a3e4:d26b with SMTP id d9443c01a7336-215a3e4dc89mr79434785ad.0.1733211060067;
        Mon, 02 Dec 2024 23:31:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwtFDsd1WSbUlFVtINv5gpljD9oqMcZ9HvNspEp3AWCkY/mGPNDUp8oHCemJTryvY2p/FvlA==
X-Received: by 2002:a17:902:cec7:b0:215:a3e4:d26b with SMTP id d9443c01a7336-215a3e4dc89mr79434565ad.0.1733211059765;
        Mon, 02 Dec 2024 23:30:59 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586d40afasm35735165ad.270.2024.12.02.23.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:30:59 -0800 (PST)
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
Subject: [PATCH net-next v2 2/5] virtio_ring: add 'flushed' as an argument to virtqueue_resize()
Date: Tue,  3 Dec 2024 16:30:22 +0900
Message-ID: <20241203073025.67065-3-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203073025.67065-1-koichiro.den@canonical.com>
References: <20241203073025.67065-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When virtqueue_resize() has actually recycled all unused buffers,
additional work may be required in some cases. Relying solely on its
return status is fragile, so introduce a new argument 'flushed' to
explicitly indicate whether it has really occurred.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c     | 6 ++++--
 drivers/virtio/virtio_ring.c | 7 ++++++-
 include/linux/virtio.h       | 3 ++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 48ce8b3881b6..df9bfe31aa6d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3326,12 +3326,13 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 			     struct receive_queue *rq, u32 ring_num)
 {
 	int err, qindex;
+	bool flushed;
 
 	qindex = rq - vi->rq;
 
 	virtnet_rx_pause(vi, rq);
 
-	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
+	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf, &flushed);
 	if (err)
 		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
 
@@ -3389,12 +3390,13 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 			     u32 ring_num)
 {
 	int qindex, err;
+	bool flushed;
 
 	qindex = sq - vi->sq;
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, &flushed);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 82a7d2cbc704..34a068d401ec 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2772,6 +2772,7 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
  * @_vq: the struct virtqueue we're talking about.
  * @num: new ring num
  * @recycle: callback to recycle unused buffers
+ * @flushed: whether or not unused buffers are all flushed
  *
  * When it is really necessary to create a new vring, it will set the current vq
  * into the reset state. Then call the passed callback to recycle the buffer
@@ -2792,11 +2793,14 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
  *
  */
 int virtqueue_resize(struct virtqueue *_vq, u32 num,
-		     void (*recycle)(struct virtqueue *vq, void *buf))
+		     void (*recycle)(struct virtqueue *vq, void *buf),
+		     bool *flushed)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
 
+	*flushed = false;
+
 	if (num > vq->vq.num_max)
 		return -E2BIG;
 
@@ -2809,6 +2813,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 	err = virtqueue_disable_and_recycle(_vq, recycle);
 	if (err)
 		return err;
+	*flushed = true;
 
 	if (vq->packed_ring)
 		err = virtqueue_resize_packed(_vq, num);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 57cc4b07fd17..878feda08af9 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -109,7 +109,8 @@ dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
 dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
 
 int virtqueue_resize(struct virtqueue *vq, u32 num,
-		     void (*recycle)(struct virtqueue *vq, void *buf));
+		     void (*recycle)(struct virtqueue *vq, void *buf),
+		     bool *flushed);
 int virtqueue_reset(struct virtqueue *vq,
 		    void (*recycle)(struct virtqueue *vq, void *buf));
 
-- 
2.43.0


