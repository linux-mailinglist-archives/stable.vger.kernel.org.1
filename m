Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42CF7CAC1A
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjJPOt2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjJPOt1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:49:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AFBB4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:49:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8764C433C7;
        Mon, 16 Oct 2023 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467765;
        bh=ihgZXAE+594DZFNUJHEUjY2CJ3tVrqSjM46qNrP9R/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvN+O1P8iY3MQtA//d/UxO47szbJS0qwPm1NgFM0bHtZcYGkkRrO2xAnGF7kNRDK0
         vAwozwlITCx4Frsk3Qx6HpqIjLwhtkNbcoagCBgNmP53dFxVNTMCYtAWm5FxKXDlyS
         9sPRKtBRdTkcAiYfKM0YURPDpupwElv56zg7Sv38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 061/191] ravb: Fix use-after-free issue in ravb_tx_timeout_work()
Date:   Mon, 16 Oct 2023 10:40:46 +0200
Message-ID: <20231016084016.825207415@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 3971442870713de527684398416970cf025b4f89 ]

The ravb_stop() should call cancel_work_sync(). Otherwise,
ravb_tx_timeout_work() is possible to use the freed priv after
ravb_remove() was called like below:

CPU0			CPU1
			ravb_tx_timeout()
ravb_remove()
unregister_netdev()
free_netdev(ndev)
// free priv
			ravb_tx_timeout_work()
			// use priv

unregister_netdev() will call .ndo_stop() so that ravb_stop() is
called. And, after phy_stop() is called, netif_carrier_off()
is also called. So that .ndo_tx_timeout() will not be called
after phy_stop().

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Reported-by: Zheng Wang <zyytlz.wz@163.com>
Closes: https://lore.kernel.org/netdev/20230725030026.1664873-1-zyytlz.wz@163.com/
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20231005011201.14368-3-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 49726183d264b..ef8f205f8ce1f 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2168,6 +2168,8 @@ static int ravb_close(struct net_device *ndev)
 			of_phy_deregister_fixed_link(np);
 	}
 
+	cancel_work_sync(&priv->work);
+
 	if (info->multi_irqs) {
 		free_irq(priv->tx_irqs[RAVB_NC], ndev);
 		free_irq(priv->rx_irqs[RAVB_NC], ndev);
-- 
2.40.1



