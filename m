Return-Path: <stable+bounces-72980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E36696B5F9
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151E128431F
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 09:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621DF1CC169;
	Wed,  4 Sep 2024 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qr6Ybpzl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458B19AD56
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440765; cv=none; b=Qq2gB1S85G8WPruQMTYDujXmd7Fc8UEiRJa2I7eZDGmdQP7t78h45UA8loGc7tI9trUjD6DbqQ/gsB0nDISeJK72yEmwo20ILG3M6XcAD8xDy0yOcvhQV8jqI293jj4+4Md+IFBDbmHvWhWpFJ5KXQ8U2oMoFzaa/JboeLQYE/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440765; c=relaxed/simple;
	bh=jDBq4Ng87U5vWLCtGk/fTMd743FQxW3hZo2L1hthBoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QEgG1m3O2Z2AdKjRPf3Lcfm8AnFK/k6+jRX74u7uIfDTLWAxRkC6L+/VrNMRo6jf+5mmU+rimrnVC11FKORxZotg/2jdwmtKCWCGgVye/JZ4eWIXq1cWQ7cUV2oVKMpmT4Rm7+jcY2ebMHv65Gi+e3Ut9SPc+WKGyNkdzN5w56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Qr6Ybpzl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20688fbaeafso19579465ad.0
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725440762; x=1726045562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s2WW0Uh5MFwXmQymV6WF9+7CjegjBeXRtTOVI/P2KHw=;
        b=Qr6YbpzlxeEIyLeLCA+SVeoRtFEYXxM0RirkVD9YcGfPck5FEvduwNo3Tj5OXKsQLH
         ymXqY+DG1JiAGEHJPj9W/ZJldBlDvIYJConhm8pZ5i0xcFKJ4ebDGTgSb1S6BqC8vdv5
         ii7/vrFRWaLy6VX7nLz3h+phRCPRt462aNnCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725440762; x=1726045562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s2WW0Uh5MFwXmQymV6WF9+7CjegjBeXRtTOVI/P2KHw=;
        b=A9kDVxUSixlXeopUDcQEJu8lFh3YKEiwllcMXU0GAgfOOb/c5IDtiizA7f5P3Ncb8V
         VLCQzRQwwJrNciODSoiA9taE1kDPKNVl06Ssn0uZEUhRD8R0FZS113ku/4Mcl+36+3Jw
         DfwOWO6Zo/9miovX3LMEt4m60RC995dK4RznnYaMTNS6qPCn8cC+CUbQOWsq8g3Jz7Gy
         LuCZ3cKupZvzrOjRZzkKXr3xvwf6/aMoS7O6yh47IRg7wWHnNTlWdhwN/b8TQvVtzcfc
         L6MoQORf+Tv5t9W2YF43m/Mn+xzQVjh0b+9xkpdm0Ct2fouyBfbpz46KJ0Koj9zsawSy
         7N/Q==
X-Gm-Message-State: AOJu0YxxTFwNCiKXaL505zEcZEU9w8RTGaxkRBZ+FzFEShm8y6gyNiGm
	x/b3UI17nkckxR35iYLl9gKiwyrrVEbCLLsMxa461xDtcQRmBm9W6UdyF9YVmk4R/pX9g/ALoKg
	00wd8AlgZYgAl6Y2yFgogb08VE6FtR0zH+bSORZMi46kjRql4WUFrFWbeIYVfVQcgShsZPg9GY+
	XDWR9u8MJlQ/acB3LNJdXaqlZ8lRGmF9XXkw6ZXIZMfPN+Qj+rqw==
X-Google-Smtp-Source: AGHT+IEBsx5mNF1aMY3Pulj+ByK6nJUa4wjeFTWqbIBmNujyGWU5qrkO+va3WqSnQ1IWgwTrsH7VXw==
X-Received: by 2002:a17:902:ce10:b0:205:8456:df0c with SMTP id d9443c01a7336-2058456df32mr82458875ad.26.1725440761785;
        Wed, 04 Sep 2024 02:06:01 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea52a8asm9670135ad.182.2024.09.04.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:06:01 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Breno Leitao <leitao@debian.org>,
	Heng Qi <hengqi@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.15] virtio_net: Fix napi_skb_cache_put warning
Date: Wed,  4 Sep 2024 02:05:53 -0700
Message-Id: <20240904090553.15076-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit f8321fa75102246d7415a6af441872f6637c93ab ]

After the commit bdacf3e34945 ("net: Use nested-BH locking for
napi_alloc_cache.") was merged, the following warning began to appear:

	 WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0

	  __warn+0x12f/0x340
	  napi_skb_cache_put+0x82/0x4b0
	  napi_skb_cache_put+0x82/0x4b0
	  report_bug+0x165/0x370
	  handle_bug+0x3d/0x80
	  exc_invalid_op+0x1a/0x50
	  asm_exc_invalid_op+0x1a/0x20
	  __free_old_xmit+0x1c8/0x510
	  napi_skb_cache_put+0x82/0x4b0
	  __free_old_xmit+0x1c8/0x510
	  __free_old_xmit+0x1c8/0x510
	  __pfx___free_old_xmit+0x10/0x10

The issue arises because virtio is assuming it's running in NAPI context
even when it's not, such as in the netpoll case.

To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
is available. Same for virtnet_poll_cleantx(), which always assumed that
it was in a NAPI context.

Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
Link: https://patch.msgid.link/20240712115325.54175-1-leitao@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on v5.15.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index bd0cb3a03b7b..d8138ad4f865 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1548,7 +1548,7 @@ static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
 		return false;
 }
 
-static void virtnet_poll_cleantx(struct receive_queue *rq)
+static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int index = vq2rxq(rq->vq);
@@ -1561,7 +1561,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 	if (__netif_tx_trylock(txq)) {
 		do {
 			virtqueue_disable_cb(sq->vq);
-			free_old_xmit_skbs(sq, true);
+			free_old_xmit_skbs(sq, !!budget);
 		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
@@ -1580,7 +1580,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
 
-	virtnet_poll_cleantx(rq);
+	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
 
@@ -1683,7 +1683,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, true);
+	free_old_xmit_skbs(sq, !!budget);
 
 	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
 		netif_tx_wake_queue(txq);
-- 
2.39.4


