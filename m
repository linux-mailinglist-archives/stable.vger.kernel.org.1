Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871F87CA287
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjJPIvH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjJPIvF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:51:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523BE8
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:51:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E71C433C7;
        Mon, 16 Oct 2023 08:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446263;
        bh=ZQHgGbNNkb1OrEoCXTDXOZ8UUxQP0LKrcsFnqe3WMSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqllfmTOLz2iO5oaRehr/BvFP+8fdRL0OA2XAq06YTwlH1hkAWrPfA2XJI6/AjrD4
         0CHEL3wygbHOgXkF+yaxcq4nL1oxnFhMm0NGAjnAxtPGlnlU2RIPphbLIqUBes0MSH
         Fb0Iv/kT7IdUJv1QPYf8qgr32/szs/IfeHlzejLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 102/102] eth: remove remaining copies of the NAPI_POLL_WEIGHT define
Date:   Mon, 16 Oct 2023 10:41:41 +0200
Message-ID: <20231016083956.422343545@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

commit 36ffca1afea9b429d3e49aa0b6a68ecd93f3be11 upstream.

Defining local versions of NAPI_POLL_WEIGHT with the same
values in the drivers just makes refactoring harder.

This patch covers three more drivers which I missed in
commit 5f012b40ef63 ("eth: remove copies of the NAPI_POLL_WEIGHT define").

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |    4 +---
 drivers/net/ethernet/brocade/bna/bnad.c      |    3 +--
 drivers/net/ethernet/nvidia/forcedeth.c      |    6 +++---
 3 files changed, 5 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -31,8 +31,6 @@ MODULE_LICENSE("GPL");
 
 #define ENA_MAX_RINGS min_t(unsigned int, ENA_MAX_NUM_IO_QUEUES, num_possible_cpus())
 
-#define ENA_NAPI_BUDGET 64
-
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_IFUP | \
 		NETIF_MSG_TX_DONE | NETIF_MSG_TX_ERR | NETIF_MSG_RX_ERR)
 
@@ -2303,7 +2301,7 @@ static void ena_init_napi_in_range(struc
 		netif_napi_add(adapter->netdev,
 			       &napi->napi,
 			       ENA_IS_XDP_INDEX(adapter, i) ? ena_xdp_io_poll : ena_io_poll,
-			       ENA_NAPI_BUDGET);
+			       NAPI_POLL_WEIGHT);
 
 		if (!ENA_IS_XDP_INDEX(adapter, i)) {
 			napi->rx_ring = &adapter->rx_ring[i];
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -1881,7 +1881,6 @@ poll_exit:
 	return rcvd;
 }
 
-#define BNAD_NAPI_POLL_QUOTA		64
 static void
 bnad_napi_add(struct bnad *bnad, u32 rx_id)
 {
@@ -1892,7 +1891,7 @@ bnad_napi_add(struct bnad *bnad, u32 rx_
 	for (i = 0; i <	bnad->num_rxp_per_rx; i++) {
 		rx_ctrl = &bnad->rx_info[rx_id].rx_ctrl[i];
 		netif_napi_add(bnad->netdev, &rx_ctrl->napi,
-			       bnad_napi_poll_rx, BNAD_NAPI_POLL_QUOTA);
+			       bnad_napi_poll_rx, NAPI_POLL_WEIGHT);
 	}
 }
 
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -56,8 +56,8 @@
 
 #include <asm/irq.h>
 
-#define TX_WORK_PER_LOOP  64
-#define RX_WORK_PER_LOOP  64
+#define TX_WORK_PER_LOOP  NAPI_POLL_WEIGHT
+#define RX_WORK_PER_LOOP  NAPI_POLL_WEIGHT
 
 /*
  * Hardware access:
@@ -5869,7 +5869,7 @@ static int nv_probe(struct pci_dev *pci_
 	else
 		dev->netdev_ops = &nv_netdev_ops_optimized;
 
-	netif_napi_add(dev, &np->napi, nv_napi_poll, RX_WORK_PER_LOOP);
+	netif_napi_add(dev, &np->napi, nv_napi_poll, NAPI_POLL_WEIGHT);
 	dev->ethtool_ops = &ops;
 	dev->watchdog_timeo = NV_WATCHDOG_TIMEO;
 


