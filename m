Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C777352D7
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjFSKil (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjFSKii (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:38:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70906E68
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:38:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E281160B67
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B82C433CB;
        Mon, 19 Jun 2023 10:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171116;
        bh=YvryWc8nKIvE5uaiKgvBv5SSrQnt8snbod6tU5iB1Ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=burAO9eVxv9+KuNEPEbV8+UqN69b5Y0KTn9NlUmtv8FNJHvP4iUQmzZb0zzmOsht6
         7m5yG0D69YcST9XZEWburOsl6qdE7d6pDYAujOt+jxc9CBixH463l8/PvU0FwGH835
         KsUc1wPx9x9oCMobWkhXYzFaUdteLlanO9ZI2veY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Phong Hoang <phong.hoang.wz@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 128/187] net: renesas: rswitch: Fix timestamp feature after all descriptors are used
Date:   Mon, 19 Jun 2023 12:29:06 +0200
Message-ID: <20230619102203.783651800@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 0ad4982c520ed87ea7ebfc9381ea1f617ed75364 ]

The timestamp descriptors were intended to act cyclically. Descriptors
from index 0 through gq->ring_size - 1 contain actual information, and
the last index (gq->ring_size) should have LINKFIX to indicate
the first index 0 descriptor. However, the LINKFIX value is missing,
causing the timestamp feature to stop after all descriptors are used.
To resolve this issue, set the LINKFIX to the timestamp descritors.

Reported-by: Phong Hoang <phong.hoang.wz@renesas.com>
Fixes: 33f5d733b589 ("net: renesas: rswitch: Improve TX timestamp accuracy")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/rswitch.c | 36 ++++++++++++++++----------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 7855d9ef81eb1..66bce799471c1 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -347,17 +347,6 @@ static int rswitch_gwca_queue_alloc(struct net_device *ndev,
 	return -ENOMEM;
 }
 
-static int rswitch_gwca_ts_queue_alloc(struct rswitch_private *priv)
-{
-	struct rswitch_gwca_queue *gq = &priv->gwca.ts_queue;
-
-	gq->ring_size = TS_RING_SIZE;
-	gq->ts_ring = dma_alloc_coherent(&priv->pdev->dev,
-					 sizeof(struct rswitch_ts_desc) *
-					 (gq->ring_size + 1), &gq->ring_dma, GFP_KERNEL);
-	return !gq->ts_ring ? -ENOMEM : 0;
-}
-
 static void rswitch_desc_set_dptr(struct rswitch_desc *desc, dma_addr_t addr)
 {
 	desc->dptrl = cpu_to_le32(lower_32_bits(addr));
@@ -533,6 +522,28 @@ static void rswitch_gwca_linkfix_free(struct rswitch_private *priv)
 	gwca->linkfix_table = NULL;
 }
 
+static int rswitch_gwca_ts_queue_alloc(struct rswitch_private *priv)
+{
+	struct rswitch_gwca_queue *gq = &priv->gwca.ts_queue;
+	struct rswitch_ts_desc *desc;
+
+	gq->ring_size = TS_RING_SIZE;
+	gq->ts_ring = dma_alloc_coherent(&priv->pdev->dev,
+					 sizeof(struct rswitch_ts_desc) *
+					 (gq->ring_size + 1), &gq->ring_dma, GFP_KERNEL);
+
+	if (!gq->ts_ring)
+		return -ENOMEM;
+
+	rswitch_gwca_ts_queue_fill(priv, 0, TS_RING_SIZE);
+	desc = &gq->ts_ring[gq->ring_size];
+	desc->desc.die_dt = DT_LINKFIX;
+	rswitch_desc_set_dptr(&desc->desc, gq->ring_dma);
+	INIT_LIST_HEAD(&priv->gwca.ts_info_list);
+
+	return 0;
+}
+
 static struct rswitch_gwca_queue *rswitch_gwca_get(struct rswitch_private *priv)
 {
 	struct rswitch_gwca_queue *gq;
@@ -1782,9 +1793,6 @@ static int rswitch_init(struct rswitch_private *priv)
 	if (err < 0)
 		goto err_ts_queue_alloc;
 
-	rswitch_gwca_ts_queue_fill(priv, 0, TS_RING_SIZE);
-	INIT_LIST_HEAD(&priv->gwca.ts_info_list);
-
 	for (i = 0; i < RSWITCH_NUM_PORTS; i++) {
 		err = rswitch_device_alloc(priv, i);
 		if (err < 0) {
-- 
2.39.2



