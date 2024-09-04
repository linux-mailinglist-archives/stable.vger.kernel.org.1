Return-Path: <stable+bounces-72982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7AB96B60D
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AF028850C
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 09:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5C91CC89B;
	Wed,  4 Sep 2024 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QyoyVeJZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E047919E978
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440945; cv=none; b=DcWn0Eju8m14Guc/yyAPQNcAcjLX6KdoZaU1Bvm/hPF2TCEJxwQnWatzRBwrX7UmqZcvYifnGkR7D/H3a1SWFKtJ32yeNEtuvTrUUnwov+t3gmByMvnpVvuPhD/DwpIHK/O9T/NUZtgLEs9KYnk/7g8DeQh2JE4FpCnE8b9OwdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440945; c=relaxed/simple;
	bh=PlJdXfCl7z5GITdFrA3sDKLcDG9iFjX/X4c3rw7NHVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MhNbPNLVWHgOxo21e6GXR4ZuevhCoHLSbeDq8mxkR8uElAddkfaDSW11Q1sD1OSb/vyTwJmlnzy23StHR0c2nGNw9HOUZ1O6DQxvEiNeEomLxC4pnudwjgup1rJz1OVeGbxXKU+xA8zyEfLdz3cwgmSY1vZKLW6ZI+okRBRpo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QyoyVeJZ; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-277e6002b7dso1555788fac.1
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 02:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725440942; x=1726045742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7eCTU1AOHaUUwMtmGS3dOCXqi4sZOm3TtWxsQHb+32g=;
        b=QyoyVeJZFgvY+jHHdyS35CNBePkg/4Sn2h3v65Oo2k3SCDhqK4UKyQQcUTwWHGUVTj
         684MojfaEAZwIIly91Y30o9lnn5Mtyy80fHAG7rDysEJ5I/2NjbumxBfix3E0A7vRlIy
         Et9jHNlBqldprvj8ZGJ4hO0VCrRLkxtgyyKJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725440942; x=1726045742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eCTU1AOHaUUwMtmGS3dOCXqi4sZOm3TtWxsQHb+32g=;
        b=PLI8qG1vsYG616X96aOnA0/E1l7058AsEhD0JpBoJgdekiCHJ+t+EyF3iumuieW6do
         Cr/PeZCr9ZMde1enUMhBDPn+VVa7LFFmDUWl9AMdSfV+mjMydlYdQn5H0+i37zLLp0nV
         jGk7Y8hjTu42/qwk6nE4YrrVx5PFxGP9GCmESQ6FjlwTZcmR9Gq+o8n/gyPG13Snd7MK
         RQBP5swivLKmzfRSAkEU8IUMF+lHhLya2Qah1t2+dUfVps+ojyX/6mysypB0JnDJN71g
         VH9x5PTifFWcPiVuvMeU+VsnJyNnprErBJOHuWJ95PhNMTX+YPgdI4iCbffxlKAi2Hpj
         wMyA==
X-Gm-Message-State: AOJu0YyMlbExks1bFN9PiWIBm4f74fmt6K/Nmy7h2geL2I98YnXRyIJK
	AuWa4afXgxFR5VQRoRVqGeoEVpvgDHDuVXTGm+3ujJTCzcjYJTs1sF2cEFnwyc9CezfVE1uI2kJ
	jz9BRLrAQqVcMVK+IlLQ4L102p9DMTE2sy5buLSLbmT7JKOXQh+j476G0gzcJ5jq5UIhoRvZAc1
	BRtjX7S6YRgwQ4TUH2h2H5UfOdxLIZysxM3LO0c9oxMO9e+rt6oA==
X-Google-Smtp-Source: AGHT+IEuKwdsL6Brf++PqlqKCm8Wb2D1A/dk6x7le3ZX0A36iHJ+V6NVDFzn0XXFrxLbntFKkyBZKQ==
X-Received: by 2002:a05:6870:390a:b0:25d:e3d:b441 with SMTP id 586e51a60fabf-277c81ed3a6mr14723563fac.40.1725440941752;
        Wed, 04 Sep 2024 02:09:01 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177859aa50sm1206994b3a.175.2024.09.04.02.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:09:01 -0700 (PDT)
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
Subject: [PATCH v4.19-v5.10] virtio_net: Fix napi_skb_cache_put warning
Date: Wed,  4 Sep 2024 02:08:53 -0700
Message-Id: <20240904090853.15187-1-shivani.agarwal@broadcom.com>
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
[Shivani: Modified to apply on v4.19.y-v5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f7ed99561..99dea89b2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1497,7 +1497,7 @@ static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
 		return false;
 }
 
-static void virtnet_poll_cleantx(struct receive_queue *rq)
+static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	unsigned int index = vq2rxq(rq->vq);
@@ -1508,7 +1508,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 		return;
 
 	if (__netif_tx_trylock(txq)) {
-		free_old_xmit_skbs(sq, true);
+		free_old_xmit_skbs(sq, !!budget);
 		__netif_tx_unlock(txq);
 	}
 
@@ -1525,7 +1525,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	unsigned int received;
 	unsigned int xdp_xmit = 0;
 
-	virtnet_poll_cleantx(rq);
+	virtnet_poll_cleantx(rq, budget);
 
 	received = virtnet_receive(rq, budget, &xdp_xmit);
 
@@ -1598,7 +1598,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
-	free_old_xmit_skbs(sq, true);
+	free_old_xmit_skbs(sq, !!budget);
 
 	opaque = virtqueue_enable_cb_prepare(sq->vq);
 
-- 
2.39.4


