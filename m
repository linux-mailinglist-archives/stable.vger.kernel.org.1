Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1647D3395
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjJWLcA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjJWLcA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:32:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F54AE4
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:31:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1ACC433C7;
        Mon, 23 Oct 2023 11:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060718;
        bh=U+5LrY8A0Pl8Q5pZL+hypf6ffMRbKawglF2QLWUFaB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kWzo7EueS65lBRIbzFikO1Iu46nOG4n0dnHyrUrdruvCLz7eohFBiWWeJum1LS5HH
         iFKVnGmvyTr2YCZsirTI5+2yc+ZULQZ+vuFeiaXQPOO7p/WuEXNWFUbyZV2gfKc29R
         KSppUau7Rg4zWPUHKE24QjkMnp+oglj/5XlIBJhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 042/123] ravb: Fix use-after-free issue in ravb_tx_timeout_work()
Date:   Mon, 23 Oct 2023 12:56:40 +0200
Message-ID: <20231023104819.135011750@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 3971442870713de527684398416970cf025b4f89 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/renesas/ravb_main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1703,6 +1703,8 @@ static int ravb_close(struct net_device
 			of_phy_deregister_fixed_link(np);
 	}
 
+	cancel_work_sync(&priv->work);
+
 	if (priv->chip_id != RCAR_GEN2) {
 		free_irq(priv->tx_irqs[RAVB_NC], ndev);
 		free_irq(priv->rx_irqs[RAVB_NC], ndev);


