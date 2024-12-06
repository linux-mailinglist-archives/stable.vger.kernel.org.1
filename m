Return-Path: <stable+bounces-98900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D8B9E6322
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 02:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED38283593
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D4C176242;
	Fri,  6 Dec 2024 01:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XR7jBx98"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E813BAD7
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447529; cv=none; b=eI9cFtWzVRHgfr5TmFxp+ExFmDIb/Ue2tnvvmbopMObK4PdVsvOF/BANzCTb2HoeildV5PErcARhtU/7N70geVpnd9E4t0A/ENBDufh1Wb4QJdGd/aqmMu2z/zbacn3Adq/eU6+SUZpnv4vN/OrpmQIAE768Lcg6DITqvYkKL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447529; c=relaxed/simple;
	bh=PA8/nHkFzKyb0DBtcvKTmZDujViTonA6IYtFxIJd3EM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4YoOaPIszHL1ZBPgUg6hrsINC6Y87xlZ+VaOM9Lk8WB9cfr5sUJ8TN/8X3rSLyvfNSOXgvtFUN+0yQXibLHoLTDL/qpU4LmWBcQWPcQz9q8nVX1560PHwwXp6rkk4QUPyYr5ODitepaHPttwt8LmLe+G5wp4y+4uLQJhsBFtEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XR7jBx98; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8196C40D9A
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 01:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733447524;
	bh=EaIKOfv6bk/O45LzQBb832X2umTA/PIxnCqcZGBeU+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=XR7jBx98txklshiqfsevz5ZWa16wTrmt92/8IpqgN7AAU8hLgNxRwFNr+LYbqEaWr
	 UUoujra0egQdqL/UOOC1guknawWo3dxB3QqEYLCnLZKZQy+hrBij/RyjgoQTWguGpv
	 SXWBIL0FSB+y/HYr/sAc9gQoSA4QmkiRUvIEeKJ393AJVwq8lsLlHzK8on8fNhVfPg
	 Mw803lVS13/4KiB0n9nmoxrC9Rj0QIut8h7zM1hvwjGDdD1KkUb+OEKxyt805P3du9
	 FtcdCke83US3UAbZ1gqIC25fY/rWvJk/GVha+X/v97vqdihWYI+MYnOyGDzDLnv9Ds
	 dCENIoX3p8RGQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-215576aca41so20874675ad.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 17:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447523; x=1734052323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaIKOfv6bk/O45LzQBb832X2umTA/PIxnCqcZGBeU+M=;
        b=wxwu4kkN4g9Nw8zFYdyG/VqEXhYZw8vLgWjC253eP4/VY7KKRkXHWVc0GJ8Dscsp//
         FCkCbk/ZUTQqCCQZcmfzEFfJQDrQN+W8FOoEbA8dl1Z9sKzTBeTSZrdyrV/n8lc3fIoM
         8USVK2DX5Y/StkuCtpwyDdI4eJZVd25+3084bhYvsW01dFFYw1dD3Gw6KJXKgZM1YY4e
         vqgVPcrGZLFZjIM+i3d4aL+Ch++Xt57G3iv/2gDy4deJ2KdkoQULK3THe4YyiOJsCjob
         3IP4CyO+NyEMUNbkgdOT0TCMw+tNfzq8/hu7pxlH2nThxyCc1h7Uw7CcVgPBYyluUI/e
         Rwqw==
X-Forwarded-Encrypted: i=1; AJvYcCVWZTADt7J5JFMkduh3ZvM3v+qWAo+/MMjubamsJHZZEvbx2+zEWtyjfILHEDFxxHVYyAGqj94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlY7S3SR+njKCS1ESl8zfuIuK3Ys8kCkPj7TDhh2geL1Oh4pOc
	1WI72jiH4rpmHxXO/lJk15D61RPxaoqWR6oWaNp8IFAi5LJCOupBh51R9fXCqb2F/hCMHkaEmtj
	TsFDr+Q2AriLP80ZEERmuAtYU/dgXoaBD0/Vq9wEvwJgN2REATW+rmAcl/xStQmKt5I2V2g==
X-Gm-Gg: ASbGncsDoYuORQYiGZjD+q82Id/bLrH7CgbEa+4fWmKot1BsD9856/dfAoYOOJPrx/B
	bSrG1fTN/fgsS4hwbkNsmKlbzFp2pv5Dvf9pXeyf+H1Y8wFJYmpA7XrfCBJkDMSuPQ5i4TfozhK
	8Rdw4P+TdX22Wmvk88T/m6TgrbeysVXdcT7JXy6nihiisRzjSCzdaG9XdC3cxv/Wa6ujc+lAGoD
	Txdlv+y64Sgi/AT6qI8+gur+cdOdZxTy3pyBZcCMTeP+GohCaE=
X-Received: by 2002:a17:902:d2c3:b0:215:5a82:3f8c with SMTP id d9443c01a7336-215f3ce4fa4mr81930375ad.20.1733447523065;
        Thu, 05 Dec 2024 17:12:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXqJiZIYbDQc+sRm11CP5WOXPhB8Q1WFXfqgl8yxVSWKPwnlYc7wDaqcK9TVVx9Gd1p79dsg==
X-Received: by 2002:a17:902:d2c3:b0:215:5a82:3f8c with SMTP id d9443c01a7336-215f3ce4fa4mr81929985ad.20.1733447522743;
        Thu, 05 Dec 2024 17:12:02 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:9740:f048:7177:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa18esm17979355ad.123.2024.12.05.17.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:12:02 -0800 (PST)
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
Subject: [PATCH net v4 5/6] virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()
Date: Fri,  6 Dec 2024 10:10:46 +0900
Message-ID: <20241206011047.923923-6-koichiro.den@canonical.com>
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
index 3a0341cc6085..5cf4b2b20431 100644
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


