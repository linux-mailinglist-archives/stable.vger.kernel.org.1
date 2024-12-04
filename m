Return-Path: <stable+bounces-98233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644939E32F0
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 06:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285EE284F3B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 05:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444EF18F2D4;
	Wed,  4 Dec 2024 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jhYLJqj8"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8192118F2FD
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288903; cv=none; b=DwQyUU8+9xlK3B5oaDcfxJ0BKsT4GZNVkqhpc3kpPUinldnZiSlyEDX+VxfV/y/NaEosGAq2C5WJiPH9okwyEVC0750a+3v46VUdJ9vGNQn7U7p5GLnNtAuLpSy20rxRGbP0S+BkUh9gZbQK36tbIlNB91TXtSbOAC1zD78eAsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288903; c=relaxed/simple;
	bh=/hxsPKXVZNwPj0FSFmTo2DxSrpBL+nEcvnadMx1VMr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/24ISbgyd+xQFXSr4VP3lZnZxmnjhLoaQxghpPVwOT+vdBJsaO9w94iyoS8NJzH0guQUftWHKQTzh29K3MEEAf5WR1kx5On/XwcfmUHpfA/IsurlNMl2Eu+7Uh/av3Jwvj1HlF55XQp8QoAm3OV+RkUTuAG5oSkhR9zVsv9+xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jhYLJqj8; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0557C3FDB1
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 05:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733288900;
	bh=cMQ1mn6QkKh++9sVefHm/YQARbeGOPYVwGZmbPvclzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=jhYLJqj8RGOxgIfMoQZBrMXIVgbpvQk8DzSxvkYyalpHN6s5l0GFe5UeNBKTsZcFM
	 KX8QdH2ZlGiNM8kq8V/GyBOP6RFDm5wUNhvx2S/5pttskEqBtm5ggFi49kTys2SfIe
	 ksosjFbaFc2pE6ILfn2XohK5Fyb1/H3+sgIVWOWXVPkbaYGlfsOzWFyBpy/eMHPJwk
	 B7ZZYf6Hy/97mMSGiP7b2OYCW6xGIUdS1h//g/Toa2o9ffki7Wsjs/jep/2MLxamsM
	 a+kvuowLHjTlwvGv4glvbksq7PH3QLvR6qtl5b1ykHTDYvlq+BSzKSWsov8jyWhCy1
	 qRdsoLd/4PIVQ==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-724fc3f60c1so7893281b3a.2
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 21:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733288898; x=1733893698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMQ1mn6QkKh++9sVefHm/YQARbeGOPYVwGZmbPvclzE=;
        b=gOd8zLek/OuoRqhDsWpEVAlSmdSXqvWVNdl/CMAGyrTq0rNhjQDZdlB/ZqnWfpxJQe
         znh0/Dvjd0PO2ILFSoE0UREgeGuSXjyz73dHdHNOSn+/XqiNMm/MEEjcN0nB0AW1Sawg
         GwwHJn+5TtPstxgEIxKVmDGGyJ6yAVxeXrijJghj9/TrZhgOxxa6p8K9tQcFrI8aFYBz
         /bGuwGnFCxyHMxu0VrcA2Rf7YEfVCeBrKZYM/NzKunI3ZN6YFo/4gopGQljLX9l1URmV
         2s3jvn9k2iwtJrHfVVYKxCUe/Ws+uTT8w4bEOoFfvNQSb9afRxtcKsuK2XblaWSKnnNZ
         yoVg==
X-Forwarded-Encrypted: i=1; AJvYcCWeP224eEZAbusXDnK1fhU3U7DgQBQ8v1+fgoe+iIqm3iyB2THlK+ZcEWJvLNwjrYn8aUrEehQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB437yggtmlnnxwnQxUb5+VsK2IAbX0+V4eXXOp9iTZW7uFwWL
	YlGj1WOcVGacYeliybOZjAnzRCpq3yIEI1LcNzh3eYCxqWRN9FkSvqn/8iBlWihnsTlUupEOL1o
	k6Sdtoz1zcRtS66IocFJpaz8T+2Mu6e1GyLU7BFqGi5j8EeVo49WSrW2whO1W7an3dXPr1Q==
X-Gm-Gg: ASbGncvtViaWz2a753CJWF+6WfGswEE+xKmaCiIo6ljpPe3YRRp7/5aUQi4xvQqDKSS
	TegZoPiGGys4rK5ZX/GnczE/iHIYPjA7O60XSlEbt7/EoJW6hZnXPJBLVlpBBjAhlE/m8H29Xz+
	w0UY4PnEd/rg5N0xia2Nq4A5CCUTfHF9PH7EdkN2BInw6C9RrHqZQOOWEiykQTzy9E9RVeutxEb
	trZIhfzd21oqN7Y4VxqxBeUgngLVwbroDz581YIA8y2tJ42RTIVGOIVt/4B6akGJd1Z
X-Received: by 2002:a05:6a00:3c8a:b0:71e:5fa1:d3e4 with SMTP id d2e1a72fcca58-7257fa45248mr6730702b3a.2.1733288898385;
        Tue, 03 Dec 2024 21:08:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzK4BK1oktH3ckDZBRjHOokufY6SEBLhJ5DJ7e1vYZicOqoakq+cqHgepP7ZCNIOpN0Nx7ew==
X-Received: by 2002:a05:6a00:3c8a:b0:71e:5fa1:d3e4 with SMTP id d2e1a72fcca58-7257fa45248mr6730677b3a.2.1733288898066;
        Tue, 03 Dec 2024 21:08:18 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:9c88:3d14:cbea:e537])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd0a0682d6sm145466a12.10.2024.12.03.21.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:08:17 -0800 (PST)
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
Subject: [PATCH net-next v3 6/7] virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()
Date: Wed,  4 Dec 2024 14:07:23 +0900
Message-ID: <20241204050724.307544-7-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204050724.307544-1-koichiro.den@canonical.com>
References: <20241204050724.307544-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When virtqueue_reset() has actually recycled all unused buffers,
additional work may be required in some cases. Relying solely on its
return status is fragile, so introduce a new function argument
'recycle_done', which is invoked when it really occurs.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c     | 4 ++--
 drivers/virtio/virtio_ring.c | 6 +++++-
 include/linux/virtio.h       | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d0cf29fd8255..5eaa7a2884d5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5711,7 +5711,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
 
 	virtnet_rx_pause(vi, rq);
 
-	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf);
+	err = virtqueue_reset(rq->vq, virtnet_rq_unmap_free_buf, NULL);
 	if (err) {
 		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
 
@@ -5740,7 +5740,7 @@ static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf, NULL);
 	if (err) {
 		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
 		pool = NULL;
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6af8cf6a619e..fdd2d2b07b5a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2827,6 +2827,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * virtqueue_reset - detach and recycle all unused buffers
  * @_vq: the struct virtqueue we're talking about.
  * @recycle: callback to recycle unused buffers
+ * @recycle_done: callback to be invoked when recycle for all unused buffers done
  *
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
@@ -2838,7 +2839,8 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * -EPERM: Operation not permitted
  */
 int virtqueue_reset(struct virtqueue *_vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf))
+		    void (*recycle)(struct virtqueue *vq, void *buf),
+		    void (*recycle_done)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
@@ -2846,6 +2848,8 @@ int virtqueue_reset(struct virtqueue *_vq,
 	err = virtqueue_disable_and_recycle(_vq, recycle);
 	if (err)
 		return err;
+	if (recycle_done)
+		recycle_done(_vq);
 
 	if (vq->packed_ring)
 		virtqueue_reinit_packed(vq);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 0aa7df4ed5ca..dd88682e27e3 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -112,7 +112,8 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
 		     void (*recycle)(struct virtqueue *vq, void *buf),
 		     void (*recycle_done)(struct virtqueue *vq));
 int virtqueue_reset(struct virtqueue *vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf));
+		    void (*recycle)(struct virtqueue *vq, void *buf),
+		    void (*recycle_done)(struct virtqueue *vq));
 
 struct virtio_admin_cmd {
 	__le16 opcode;
-- 
2.43.0


