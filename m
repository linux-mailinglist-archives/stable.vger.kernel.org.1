Return-Path: <stable+bounces-98899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB669E631F
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 02:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB002167818
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58F4154C12;
	Fri,  6 Dec 2024 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tbca2gfv"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1799F153812
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447525; cv=none; b=Xc8FXE1II0wrdsrHN9vHFAxfMM9/1BuBcyLSU8QFPYi5sNPJHHh5KwxxrLc9jbGcXKsezefFQWGxfK1jsO/StKg+uKWvz8GYEox4HlVmaeUi2eNBOgSupg9jZYrGLE0BUqJtiWdUxUQyyWh+mgjaBJwMSAnAYAqYrI07KpyREAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447525; c=relaxed/simple;
	bh=HSdpSrosBpFjoXoHgEPxOFMdxecD/sTFHyHuYcmRo44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCgH9eSyltu+JDypk+CGztGJ2q52z/UQzvXFHaoJpMTcDzJaeNyjtrbRccya/CEntHEs0uBl0OO86h7qJk+3+nhuIFTAR4y9vaFJlZDLuBgcur7Ko4kVWqfZ9Vzf6w9LwS+Sl+nlMoku/MSoGOsna/shPaEFk1Lk6K9JIYWnJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tbca2gfv; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3ED3140CEC
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 01:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733447522;
	bh=3okZ7Dk5bsE+ZlwnvoQtqX4jE3/LzcC69p28rg/sS/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=tbca2gfv2PwPq0DU19SM1pmigc1fn0BZaJvbxBrAJMD3swtG4VWCOvQPozh5UA1AS
	 M31/yHYVuq0VqFg1BH+mUEu4o15cnyyVILDUj4WUOIK3xslNK8mraF0RBJXCIIMUC5
	 QgDe9sMs/mFs+Yf/LRbHO6tqFuzr8WgxUuBUzJgYiJFCshgOFnzhIblluovSwPVZuD
	 ahyd4pPdc6i4PQa5pYeTugFmA9nomhNUsDSaZkT0WJUYHkYh2HKNIrbKMMFVQeZi9J
	 wMErPd1BLaiEHFQWOV6mepi9M5fzE38e5mVAQFGLfSvGYrSdQsgawkOIqjVT2V+IQ4
	 U4SOx1Tt8mb8Q==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2158c589cd0so15529595ad.1
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 17:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447519; x=1734052319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3okZ7Dk5bsE+ZlwnvoQtqX4jE3/LzcC69p28rg/sS/E=;
        b=hyuIGgWl5p2fNdluqQzyLrBaPj9Ec4s30Pc8jkYf6kMZax8I5aZ+ruFGrC6DzWkP5F
         ++w/S67oz40ocLCADKlr7u/ukRVfvj7MHpJsxy/BhakXuLywd6MjPgssLQpovdlOsPsg
         ciJLrDGgzdFcULY553dU0oAcP+w9X0uKCZL0LyLHgyO7Eif2Jpy5JJ+YWnCLKQYDKrUb
         vM5h2+Kf60RfNwU5x9sETxNdN6wmfORRM3QBqcY0QQF3sVquHmSmYYsUlxBYiGgMrbj/
         TEvw5qJJb13yFM+7uy9cBRLGNmPD5NScMyAPE9Y14yYWccMXmOVQ8Jr8sNWR85a+eG1x
         X75g==
X-Forwarded-Encrypted: i=1; AJvYcCX1+a7AA/RZ4Pd5gBFFWUATv1UUQJVsctCneYcXwUNiVz+5wIlZNPN1QQ2SuIWW4M2ePilbEY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsbZxTYKPr44Bi6o9gH4SJO4JrpiT0KFquZhgL8VvAsKo9nhFf
	DvK++GlaX20JTgB+kEpimy0ZwJOWda1Q8TX32qaeII9DAbnWRVZQ/o7YGachMNVupJMWs7Tw1WO
	SBlgW5R5JazyhHVAmfpZ8TEjixkhcsSGKfcThAuN5uV71WymAuHX1m5PdhSTekiooVP7Ywg==
X-Gm-Gg: ASbGncs0ol0uQSatoHf4qUd1Nqcq/urAxwKbdS5vy0TrBXFnbNAS+7SePtwmq1e63z7
	ms1XBAY2kKxxVFujPKHbyW1gBMerJm2StcyNadBIOPVCkxbS4nBIQFq/BAvAOJDgiYQzLQ0v7Ku
	yV6opPWGw//zMEB+9sKzglr4iFx/XDyWNsaFpplR01MTMvNaugd023ZwqKs/KeZaoyxzu7n9cAZ
	s0ij2LUJkv2NKUbh53N+zC5i/lhuanQ/yn/zyWbNMr+x11pTqc=
X-Received: by 2002:a17:902:f601:b0:215:b13e:9b14 with SMTP id d9443c01a7336-21614d75a53mr12429315ad.25.1733447519047;
        Thu, 05 Dec 2024 17:11:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQJN3aYvWonWOaVQbbwag0krwaPJYzGL0PhqRtYyRPCKfavtSDhMd7s04xv5fglvYMegTrDg==
X-Received: by 2002:a17:902:f601:b0:215:b13e:9b14 with SMTP id d9443c01a7336-21614d75a53mr12428985ad.25.1733447518781;
        Thu, 05 Dec 2024 17:11:58 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:9740:f048:7177:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa18esm17979355ad.123.2024.12.05.17.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:11:58 -0800 (PST)
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
Subject: [PATCH net v4 4/6] virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
Date: Fri,  6 Dec 2024 10:10:45 +0900
Message-ID: <20241206011047.923923-5-koichiro.den@canonical.com>
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

virtnet_tx_resize() flushes remaining tx skbs, requiring DQL counters to
be reset when flushing has actually occurred. Add
virtnet_sq_free_unused_buf_done() as a callback for virtqueue_reset() to
handle this.

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e10bc9e6b072..3a0341cc6085 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -503,6 +503,7 @@ struct virtio_net_common_hdr {
 static struct virtio_net_common_hdr xsk_hdr;
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
+static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq);
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct net_device *dev,
 			       unsigned int *xdp_xmit,
@@ -3394,7 +3395,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, NULL);
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf,
+			       virtnet_sq_free_unused_buf_done);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
 
@@ -6233,6 +6235,14 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 	}
 }
 
+static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+	int i = vq2txq(vq);
+
+	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
+}
+
 static void free_unused_bufs(struct virtnet_info *vi)
 {
 	void *buf;
-- 
2.43.0


