Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5007A3BB1
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbjIQUVW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbjIQUUu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:20:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED5D186
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:20:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24353C433C8;
        Sun, 17 Sep 2023 20:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982040;
        bh=l7uAbJLNv5VMvZpJIxuMKIvRG0NyjozB0cFeYKLFcmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ja1OMQfNcSrEQu06BDVz4buBw8mwEeentt2xpLRS+uRv6dwuFRvex04odlpszSovc
         QAirO6pynFdLAX3ekW2lpHupggmLsrpxUVW9d7GKqMKo065uc1BmAGUq7U0wFtGtEV
         2GcNpwePZe79w2Y8iU0bgzxcwdVUkw7WhL4x3vKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Harini Katakam <harini.katakam@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 209/219] net: macb: Enable PTP unicast
Date:   Sun, 17 Sep 2023 21:15:36 +0200
Message-ID: <20230917191048.488595561@linuxfoundation.org>
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

From: Harini Katakam <harini.katakam@xilinx.com>

[ Upstream commit ee4e92c26c60b7344b7261035683a37da5a6119b ]

Enable transmission and reception of PTP unicast packets by
updating PTP unicast config bit and setting current HW mac
address as allowed address in PTP unicast filter registers.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 403f0e771457 ("net: macb: fix sleep inside spinlock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb.h      |  4 ++++
 drivers/net/ethernet/cadence/macb_main.c | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 9c410f93a1039..1aa578c1ca4ad 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -95,6 +95,8 @@
 #define GEM_SA4B		0x00A0 /* Specific4 Bottom */
 #define GEM_SA4T		0x00A4 /* Specific4 Top */
 #define GEM_WOL			0x00b8 /* Wake on LAN */
+#define GEM_RXPTPUNI		0x00D4 /* PTP RX Unicast address */
+#define GEM_TXPTPUNI		0x00D8 /* PTP TX Unicast address */
 #define GEM_EFTSH		0x00e8 /* PTP Event Frame Transmitted Seconds Register 47:32 */
 #define GEM_EFRSH		0x00ec /* PTP Event Frame Received Seconds Register 47:32 */
 #define GEM_PEFTSH		0x00f0 /* PTP Peer Event Frame Transmitted Seconds Register 47:32 */
@@ -245,6 +247,8 @@
 #define MACB_TZQ_OFFSET		12 /* Transmit zero quantum pause frame */
 #define MACB_TZQ_SIZE		1
 #define MACB_SRTSM_OFFSET	15 /* Store Receive Timestamp to Memory */
+#define MACB_PTPUNI_OFFSET	20 /* PTP Unicast packet enable */
+#define MACB_PTPUNI_SIZE	1
 #define MACB_OSSMODE_OFFSET	24 /* Enable One Step Synchro Mode */
 #define MACB_OSSMODE_SIZE	1
 #define MACB_MIIONRGMII_OFFSET	28 /* MII Usage on RGMII Interface */
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5fb991835078a..9470e895591e5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -288,6 +288,11 @@ static void macb_set_hwaddr(struct macb *bp)
 	top = cpu_to_le16(*((u16 *)(bp->dev->dev_addr + 4)));
 	macb_or_gem_writel(bp, SA1T, top);
 
+	if (gem_has_ptp(bp)) {
+		gem_writel(bp, RXPTPUNI, bottom);
+		gem_writel(bp, TXPTPUNI, bottom);
+	}
+
 	/* Clear unused address register sets */
 	macb_or_gem_writel(bp, SA2B, 0);
 	macb_or_gem_writel(bp, SA2T, 0);
@@ -721,8 +726,12 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	/* Enable Rx and Tx */
-	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(RE) | MACB_BIT(TE));
+	/* Enable Rx and Tx; Enable PTP unicast */
+	ctrl = macb_readl(bp, NCR);
+	if (gem_has_ptp(bp))
+		ctrl |= MACB_BIT(PTPUNI);
+
+	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
 
 	netif_tx_wake_all_queues(ndev);
 }
-- 
2.40.1



