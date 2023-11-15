Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD367ED325
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjKOUq2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbjKOUq1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:46:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BE9193
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:46:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1666C433C7;
        Wed, 15 Nov 2023 20:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081183;
        bh=98fIoFGfax2QWE9rCg6QaZ6inpsTGyfy1J3F/soXWQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmkBZ08M2MaJGnc8r4b1I1O5EdJ2UXkDs5WUniz+/yHetqiDwCCXJjp/unjEbFwt6
         YQpQBgA09Snw3eK5su4BoKgejJvCV3nYEE4jfTiJPaS8D9ph0WNxZqmYQbCnC+BFlo
         TG4SCjFkfuSRUIquPN0OqY28SCiMgqeT4xEabse8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 76/88] r8169: improve rtl_set_rx_mode
Date:   Wed, 15 Nov 2023 15:36:28 -0500
Message-ID: <20231115191430.646620158@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
References: <20231115191426.221330369@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 81cd17a4121d7dc7cad28e51251f31ff12b1de2b ]

This patch improves and simplifies rtl_set_rx_mode a little.
No functional change intended.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: efa5f1311c49 ("net: r8169: Disable multicast filter for RTL8168H and RTL8107E")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 52 ++++++++++-------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 92875a935eb13..2a59087364808 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -66,7 +66,7 @@
 
 /* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
    The RTL chips use a 64 element hash table based on the Ethernet CRC. */
-static const int multicast_filter_limit = 32;
+#define	MC_FILTER_LIMIT	32
 
 #define TX_DMA_BURST	7	/* Maximum PCI burst, '7' is unlimited */
 #define InterFrameGap	0x03	/* 3 means InterFrameGap = the shortest one */
@@ -4614,54 +4614,46 @@ static void rtl8169_set_magic_reg(struct rtl8169_private *tp, unsigned mac_versi
 
 static void rtl_set_rx_mode(struct net_device *dev)
 {
+	u32 rx_mode = AcceptBroadcast | AcceptMyPhys | AcceptMulticast;
+	/* Multicast hash filter */
+	u32 mc_filter[2] = { 0xffffffff, 0xffffffff };
 	struct rtl8169_private *tp = netdev_priv(dev);
-	u32 mc_filter[2];	/* Multicast hash filter */
-	int rx_mode;
-	u32 tmp = 0;
+	u32 tmp;
 
 	if (dev->flags & IFF_PROMISC) {
 		/* Unconditionally log net taps. */
 		netif_notice(tp, link, dev, "Promiscuous mode enabled\n");
-		rx_mode =
-		    AcceptBroadcast | AcceptMulticast | AcceptMyPhys |
-		    AcceptAllPhys;
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
-	} else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
-		   (dev->flags & IFF_ALLMULTI)) {
-		/* Too many to filter perfectly -- accept all multicasts. */
-		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
+		rx_mode |= AcceptAllPhys;
+	} else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
+		   dev->flags & IFF_ALLMULTI ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_35) {
+		/* accept all multicasts */
+	} else if (netdev_mc_empty(dev)) {
+		rx_mode &= ~AcceptMulticast;
 	} else {
 		struct netdev_hw_addr *ha;
 
-		rx_mode = AcceptBroadcast | AcceptMyPhys;
 		mc_filter[1] = mc_filter[0] = 0;
 		netdev_for_each_mc_addr(ha, dev) {
-			int bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
-			mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
-			rx_mode |= AcceptMulticast;
+			u32 bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
+			mc_filter[bit_nr >> 5] |= BIT(bit_nr & 31);
+		}
+
+		if (tp->mac_version > RTL_GIGA_MAC_VER_06) {
+			tmp = mc_filter[0];
+			mc_filter[0] = swab32(mc_filter[1]);
+			mc_filter[1] = swab32(tmp);
 		}
 	}
 
 	if (dev->features & NETIF_F_RXALL)
 		rx_mode |= (AcceptErr | AcceptRunt);
 
-	tmp = (RTL_R32(tp, RxConfig) & ~RX_CONFIG_ACCEPT_MASK) | rx_mode;
-
-	if (tp->mac_version > RTL_GIGA_MAC_VER_06) {
-		u32 data = mc_filter[0];
-
-		mc_filter[0] = swab32(mc_filter[1]);
-		mc_filter[1] = swab32(data);
-	}
-
-	if (tp->mac_version == RTL_GIGA_MAC_VER_35)
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
-
 	RTL_W32(tp, MAR0 + 4, mc_filter[1]);
 	RTL_W32(tp, MAR0 + 0, mc_filter[0]);
 
-	RTL_W32(tp, RxConfig, tmp);
+	tmp = RTL_R32(tp, RxConfig);
+	RTL_W32(tp, RxConfig, (tmp & ~RX_CONFIG_ACCEPT_MASK) | rx_mode);
 }
 
 static void rtl_hw_start(struct  rtl8169_private *tp)
-- 
2.42.0



