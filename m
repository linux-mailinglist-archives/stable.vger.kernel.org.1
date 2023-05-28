Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC53713F44
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjE1Tnl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjE1Tnk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:43:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD49E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FBC161F1C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEEDC433EF;
        Sun, 28 May 2023 19:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303018;
        bh=ue84VWn1JiGKIYJfQd6jviRx6bF2sXBYN8dq0fzynZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GkzhhXlbubsU100Fl4sp48kBTKl6tzMgzjUpR/5l3epBjPV2efIxdTqaPKc03BIw/
         txlWoMC2iWytqwua4HNorDSfLIX8rHjSLbOC1pqZqXp9CXP10F4QKzRjpUZLz95G1O
         gTDCoFLQBgg88ctxQ/0SU/sg6PlWC/8kHKCD5DBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 113/211] net: bcmgenet: Remove phy_stop() from bcmgenet_netif_stop()
Date:   Sun, 28 May 2023 20:10:34 +0100
Message-Id: <20230528190846.375854528@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 93e0401e0fc0c54b0ac05b687cd135c2ac38187c ]

The call to phy_stop() races with the later call to phy_disconnect(),
resulting in concurrent phy_suspend() calls being run from different
CPUs. The final call to phy_disconnect() ensures that the PHY is
stopped and suspended, too.

Fixes: c96e731c93ff ("net: bcmgenet: connect and disconnect from the PHY state machine")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 7667cbb5adfd6..20b161620fee9 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3412,7 +3412,6 @@ static void bcmgenet_netif_stop(struct net_device *dev)
 	/* Disable MAC transmit. TX DMA disabled must be done before this */
 	umac_enable_set(priv, CMD_TX_EN, false);
 
-	phy_stop(dev->phydev);
 	bcmgenet_disable_rx_napi(priv);
 	bcmgenet_intr_disable(priv);
 
-- 
2.39.2



