Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C504783307
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjHUUGJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjHUUGI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79CCA8
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:06:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8567364942
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6549AC433C7;
        Mon, 21 Aug 2023 20:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648365;
        bh=L3orHMSze/2KMZ7XZXgQ/fHae78bN7YFxfdscclpYK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUOjfzI6a8pqe6iFM+9a8mauusS9SNzifmd9Oc3w2ZGNU7RHVnFEcaMg8EDsiz1wq
         AVnlPQKc359lZyXAx+z36wM0Y9R/Kd7XjOcCD8IDr6YdY3r46PurPRGQ9X+ynXZ7ai
         EJxQMy0rhGrjrbqsRbkCRMRmZ3bheJRQ9vz7AOx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 149/234] net: macb: In ZynqMP resume always configure PS GTR for non-wakeup source
Date:   Mon, 21 Aug 2023 21:41:52 +0200
Message-ID: <20230821194135.430621803@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

[ Upstream commit 6c461e394d11a981c662cc16cebfb05b602e23ba ]

On Zynq UltraScale+ MPSoC ubuntu platform when systemctl issues suspend,
network manager bring down the interface and goes into suspend. When it
wakes up it again enables the interface.

This leads to xilinx-psgtr "PLL lock timeout" on interface bringup, as
the power management controller power down the entire FPD (including
SERDES) if none of the FPD devices are in use and serdes is not
initialized on resume.

$ sudo rtcwake -m no -s 120 -v
$ sudo systemctl suspend  <this does ifconfig eth1 down>
$ ifconfig eth1 up
xilinx-psgtr fd400000.phy: lane 0 (type 10, protocol 5): PLL lock timeout
phy phy-fd400000.phy.0: phy poweron failed --> -110

macb driver is called in this way:
1. macb_close: Stop network interface. In this function, it
   reset MACB IP and disables PHY and network interface.

2. macb_suspend: It is called in kernel suspend flow. But because
   network interface has been disabled(netif_running(ndev) is
   false), it does nothing and returns directly;

3. System goes into suspend state. Some time later, system is
   waken up by RTC wakeup device;

4. macb_resume: It does nothing because network interface has
   been disabled;

5. macb_open: It is called to enable network interface again. ethernet
   interface is initialized in this API but serdes which is power-off
   by PMUFW during FPD-off suspend is not initialized again and so
   we hit GT PLL lock issue on open.

To resolve this PLL timeout issue always do PS GTR initialization
when ethernet device is configured as non-wakeup source.

Fixes: f22bd29ba19a ("net: macb: Fix ZynqMP SGMII non-wakeup source resume failure")
Fixes: 8b73fa3ae02b ("net: macb: Added ZynqMP-specific initialization")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Link: https://lore.kernel.org/r/1691414091-2260697-1-git-send-email-radhey.shyam.pandey@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 29a1199dad146..3fbe15b3ac627 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5159,6 +5159,9 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	unsigned int q;
 	int err;
 
+	if (!device_may_wakeup(&bp->dev->dev))
+		phy_exit(bp->sgmii_phy);
+
 	if (!netif_running(netdev))
 		return 0;
 
@@ -5219,7 +5222,6 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	if (!(bp->wol & MACB_WOL_ENABLED)) {
 		rtnl_lock();
 		phylink_stop(bp->phylink);
-		phy_exit(bp->sgmii_phy);
 		rtnl_unlock();
 		spin_lock_irqsave(&bp->lock, flags);
 		macb_reset_hw(bp);
@@ -5249,6 +5251,9 @@ static int __maybe_unused macb_resume(struct device *dev)
 	unsigned int q;
 	int err;
 
+	if (!device_may_wakeup(&bp->dev->dev))
+		phy_init(bp->sgmii_phy);
+
 	if (!netif_running(netdev))
 		return 0;
 
@@ -5309,8 +5314,6 @@ static int __maybe_unused macb_resume(struct device *dev)
 	macb_set_rx_mode(netdev);
 	macb_restore_features(bp);
 	rtnl_lock();
-	if (!device_may_wakeup(&bp->dev->dev))
-		phy_init(bp->sgmii_phy);
 
 	phylink_start(bp->phylink);
 	rtnl_unlock();
-- 
2.40.1



