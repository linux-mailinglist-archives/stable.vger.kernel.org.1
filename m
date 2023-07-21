Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBAF75CD98
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjGUQNP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjGUQMz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:12:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9473AB1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F0761D3B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62D3C433C8;
        Fri, 21 Jul 2023 16:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955940;
        bh=HkSKAFI+ObhILjpjEHW/1SJ+XEGcO3jrcUeprU80YPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qe8wdHfYu8unB7uEXe+sSxn41V7meHxodxhaQGGJUniqWhb3GNTb8EaVazLUWbC3p
         V6sKe4S/T56a4DyEFunrGscvNadzWpIJWO50vG0I+vKVe477yepFuxjC+AbkwA1am0
         cXWvPLWJRZ1RitFx41rfp61adHYKR+J6Gz3g6fko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Fang <wei.fang@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 084/292] net: fec: increase the size of tx ring and update tx_wake_threshold
Date:   Fri, 21 Jul 2023 18:03:13 +0200
Message-ID: <20230721160532.414102750@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit 56b3c6ba53d0e9649ea5e4089b39cadde13aaef8 ]

When the XDP feature is enabled and with heavy XDP frames to be
transmitted, there is a considerable probability that available
tx BDs are insufficient. This will lead to some XDP frames to be
discarded and the "NOT enough BD for SG!" error log will appear
in the console (as shown below).

[  160.013112] fec 30be0000.ethernet eth0: NOT enough BD for SG!
[  160.023116] fec 30be0000.ethernet eth0: NOT enough BD for SG!
[  160.028926] fec 30be0000.ethernet eth0: NOT enough BD for SG!
[  160.038946] fec 30be0000.ethernet eth0: NOT enough BD for SG!
[  160.044758] fec 30be0000.ethernet eth0: NOT enough BD for SG!

In the case of heavy XDP traffic, sometimes the speed of recycling
tx BDs may be slower than the speed of sending XDP frames. There
may be several specific reasons, such as the interrupt is not
responsed in time, the efficiency of the NAPI callback function is
too low due to all the queues (tx queues and rx queues) share the
same NAPI, and so on.

After trying various methods, I think that increase the size of tx
BD ring is simple and effective. Maybe the best resolution is that
allocate NAPI for each queue to improve the efficiency of the NAPI
callback, but this change is a bit big and I didn't try this method.
Perheps this method will be implemented in a future patch.

This patch also updates the tx_wake_threshold of tx ring which is
related to the size of tx ring in the previous logic. Otherwise,
the tx_wake_threshold will be too high (403 BDs), which is more
likely to impact the slow path in the case of heavy XDP traffic,
because XDP path and slow path share the tx BD rings. According
to Jakub's suggestion, the tx_wake_threshold is at least equal to
tx_stop_threshold + 2 * MAX_SKB_FRAGS, if a queue of hundreds of
entries is overflowing, we should be able to apply a hysteresis
of a few tens of entries.

Fixes: 6d6b39f180b8 ("net: fec: add initial XDP support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec.h      | 2 +-
 drivers/net/ethernet/freescale/fec_main.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 8c0226d061fec..63a053dea819d 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -355,7 +355,7 @@ struct bufdesc_ex {
 #define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
 #define FEC_ENET_TX_FRSIZE	2048
 #define FEC_ENET_TX_FRPPG	(PAGE_SIZE / FEC_ENET_TX_FRSIZE)
-#define TX_RING_SIZE		512	/* Must be power of two */
+#define TX_RING_SIZE		1024	/* Must be power of two */
 #define TX_RING_MOD_MASK	511	/*   for this to work */
 
 #define BD_ENET_RX_INT		0x00800000
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e6ed36e5daefa..7659888a96917 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3347,8 +3347,7 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
 		fep->total_tx_ring_size += fep->tx_queue[i]->bd.ring_size;
 
 		txq->tx_stop_threshold = FEC_MAX_SKB_DESCS;
-		txq->tx_wake_threshold =
-			(txq->bd.ring_size - txq->tx_stop_threshold) / 2;
+		txq->tx_wake_threshold = FEC_MAX_SKB_DESCS + 2 * MAX_SKB_FRAGS;
 
 		txq->tso_hdrs = dma_alloc_coherent(&fep->pdev->dev,
 					txq->bd.ring_size * TSO_HEADER_SIZE,
-- 
2.39.2



