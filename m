Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0637A3BCE
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbjIQUW6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240898AbjIQUWl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:22:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4C2187
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:22:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5B2C433CC;
        Sun, 17 Sep 2023 20:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982126;
        bh=4uFJBeY5p09L9yGuvcYDT9jfsAMQnEz7AuKVoQbdCAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kq29eax0pWmqafmeox1j/8y53ORyiqSIsXhi96LXjUgCDcmqa3TrScaol3OpePxMF
         GO/IUdXR5gbMcxdQZSfMBXJL5echJnmz/VoOYCt33ExGA/OriSD8IhjRp5FD1Gpa2C
         UnIp5S4d5OgBJs6M0U734C7xcu2MAMqX4YmQV3Xc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 190/219] net: stmmac: fix handling of zero coalescing tx-usecs
Date:   Sun, 17 Sep 2023 21:15:17 +0200
Message-ID: <20230917191047.807462927@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

[ Upstream commit fa60b8163816f194786f3ee334c9a458da7699c6 ]

Setting ethtool -C eth0 tx-usecs 0 is supposed to disable the use of the
coalescing timer but currently it gets programmed with zero delay
instead.

Disable the use of the coalescing timer if tx-usecs is zero by
preventing it from being restarted.  Note that to keep things simple we
don't start/stop the timer when the coalescing settings are changed, but
just let that happen on the next transmit or timer expiry.

Fixes: 8fce33317023 ("net: stmmac: Rework coalesce timer and fix multi-queue races")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a07bcb2f5d2e2..1559a4dafd413 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2692,9 +2692,7 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue)
 
 	/* We still have pending packets, let's call for a new scheduling */
 	if (tx_q->dirty_tx != tx_q->cur_tx)
-		hrtimer_start(&tx_q->txtimer,
-			      STMMAC_COAL_TIMER(priv->tx_coal_timer[queue]),
-			      HRTIMER_MODE_REL);
+		stmmac_tx_timer_arm(priv, queue);
 
 	__netif_tx_unlock_bh(netdev_get_tx_queue(priv->dev, queue));
 
@@ -2975,9 +2973,13 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
+	u32 tx_coal_timer = priv->tx_coal_timer[queue];
+
+	if (!tx_coal_timer)
+		return;
 
 	hrtimer_start(&tx_q->txtimer,
-		      STMMAC_COAL_TIMER(priv->tx_coal_timer[queue]),
+		      STMMAC_COAL_TIMER(tx_coal_timer),
 		      HRTIMER_MODE_REL);
 }
 
-- 
2.40.1



