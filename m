Return-Path: <stable+bounces-98897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351C9E6314
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 02:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF60167B84
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F931411EE;
	Fri,  6 Dec 2024 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NXnVseF2"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048113C9A6
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447516; cv=none; b=gyrS+Kmk+6o9CNnbOtSUQ3jcDGxAEtMAUYZSZmmTw29X2c2nVCZlhXFI4sFM469CEK/Gyx97PZ/JV+nOed/j6YH4c3j9fbjSvpKPLCYRXI8vbh8nUSU+HL3XPVozyAYDgD4E5in9lMRbohoV5xWO3lORFnxQ6ymBeodNZO5v6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447516; c=relaxed/simple;
	bh=96Kfacf61eXHoKwnotb++f8dB1xgmK90ltAc50Mdduk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2onaTghhbzLoCZRtB9LuDz+zeU1T2dtZd32tIxvYv51aOeGh2Q+QZl1cHphJ/f5iXwu3MdYoChc6Rvj3rL/E3J5ZV5JXGgqqvXy83dDZlzRq3rFZ2S/A/w+zv+zE8fM79akqMxiDPLt1H9QP8wrSOcV+vDyv0XSM4glo2QyXYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NXnVseF2; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7F44440CEA
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 01:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733447512;
	bh=nSlPIIC6AcIBGV2PkIN03d/6vzcJU5ZO51l3In2QAJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=NXnVseF2BK/+kneXib7M5ueeP5D+lW5hYcUJ4fvjP5UF5++OIBHv+ZaFumjy7kQyS
	 2QgofyOIDDIg27/JQvhHpK2UJqc0d1J2is++Gwt3nuEf04g+S9fUT+sbu7ZBB/rp8t
	 /t5emsbl31b+lBfaIFbNA/146ebdih4wiKJq3ImiFgcaSAME+/NWiIh9MfQn/8dfOY
	 HAs5tlbbSVKjjmcj44a3GeCqjXrIT02KtsOmtWZvEAY0n2nyQkQbJfOgMLxUDj6bWK
	 BoWmvc6oBgxm+p8ebHnKBz6pZ9pk59IZ6dqQfl+4D4NiX4OiRvv/zxrc4moxoYtF7W
	 UruH7XwkHer5w==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2153e070e62so17228065ad.0
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 17:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447511; x=1734052311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSlPIIC6AcIBGV2PkIN03d/6vzcJU5ZO51l3In2QAJw=;
        b=bt6b53aXB5tZUQMHdbl5EU54on+loU4dt6FMk1qKgahgPkPV7ZmoaxV988kfG6A4eo
         GRuL04ZiTY9gLmKai/EDf5V6T4vgGolwLKnnShxl5U9FVNF/hxD7+a4ZfRrax2NYmGkV
         xhZkUybaz4MUt4vNcO0791yiL9V4WwAG9ty784LSI3c4sZUq/iip8QrU9LMxFL9K6fUI
         GxU/3w2cFKp+wJyrBxc6FqsXlDCG9455AMiyXTDHxb1MIMnS9BXn6+3r1FL44qvrkfNw
         pzYgvfJK6dgQzr+A7Iq8/EB2ACFFyfRrzJy25NZrWHhmS6JoktqmKE140PGn2QwiUiYz
         5N6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqamxCZWRWiSxw8JdLc+O8rn810qnMlzY5s8o8hBqLlfTAo2MwJV0GHYSkShidTbewe1pwYY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCico7H002os2fD90Sr9rmDJrH79x4ylhFB2Ril50ITpq5N1I9
	Kgu7m1uA7jn74jsFNnPEBFXm3Q4J70M0RcYScIzrqx0cHLEi02po6N6BP+xYBJ/1VXADkxSJBHH
	IsFGWGfl0v/sGLEp18pHbyvys+g8uSNMKR7ymwt2I9kI/pfuCsPU2so1oQDgRdSDJ24iWJQ==
X-Gm-Gg: ASbGncvCwgc8q2fLrnBoNjV0HIT1toFVT+qk8xbMLnMgTNpaxKUKKu67cyxJZ85ZIva
	aO29Ul9LR72N/oA/2B3HETvxzpxnydWQAad1yp7HuNNw0UucEdiMhGPjD+FaJpYUoxg/Hd5jig2
	Unw9rGlmjuCe3U1xyrQN3/fXhUjC52jrkKyUDxWbN795WZalLDeSZWhpPtHiYQNYAvj2DtRP36X
	6eqmolBPPJq0/1SQaVsrmXVrEKKGjpC/q/Lq458VB5MFNYWM10=
X-Received: by 2002:a17:902:f542:b0:215:e76d:debe with SMTP id d9443c01a7336-21614d1f258mr13747005ad.10.1733447510923;
        Thu, 05 Dec 2024 17:11:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKbHax0jjSvtZYTNxWpYl5lGbpKdIWP0A58s2CxR3vPhspLqJQTgD+Jp4LCBdjfkXKt7Ymdg==
X-Received: by 2002:a17:902:f542:b0:215:e76d:debe with SMTP id d9443c01a7336-21614d1f258mr13746705ad.10.1733447510661;
        Thu, 05 Dec 2024 17:11:50 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:9740:f048:7177:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa18esm17979355ad.123.2024.12.05.17.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:11:50 -0800 (PST)
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
Subject: [PATCH net v4 2/6] virtio_net: replace vq2rxq with vq2txq where appropriate
Date: Fri,  6 Dec 2024 10:10:43 +0900
Message-ID: <20241206011047.923923-3-koichiro.den@canonical.com>
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

While not harmful, using vq2rxq where it's always sq appears odd.
Replace it with the more appropriate vq2txq for clarity and correctness.

Fixes: 89f86675cb03 ("virtio_net: xsk: tx: support xmit xsk buffer")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6e0925f7f182..fc89c5e1a207 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6213,7 +6213,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
 	struct send_queue *sq;
-	int i = vq2rxq(vq);
+	int i = vq2txq(vq);
 
 	sq = &vi->sq[i];
 
-- 
2.43.0


