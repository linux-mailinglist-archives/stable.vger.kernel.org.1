Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED147A3B87
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbjIQUTO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240739AbjIQUSx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:18:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E895F1
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:18:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE57C433C7;
        Sun, 17 Sep 2023 20:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981927;
        bh=/dt2wDhwFmLPeLXKqaZBrgCOpmHNwUDPBUu1PAUPcNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/mz5BfaAhmpvkGsnk7kfNKb+rewAxf595jb9H4qIHEa2UoLeiguLeE1eWOnpLGan
         SnU/AcOZM8SXFUT2IlOKB7s7INaosqB/UEhZHaxwP+Z1Nt+k0E4nxJrWTjWOoRY9YQ
         a1BPRNCOhGKExj063S0hp43EGZEJM7M6m0TAGnMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Yingliang <yangyingliang@huawei.com>,
        Simon Horman <horms@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 194/219] net: ethernet: adi: adin1110: use eth_broadcast_addr() to assign broadcast address
Date:   Sun, 17 Sep 2023 21:15:21 +0200
Message-ID: <20230917191047.952536716@linuxfoundation.org>
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

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 54024dbec95585243391caeb9f04a2620e630765 ]

Use eth_broadcast_addr() to assign broadcast address instead
of memset().

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 32530dba1bd4 ("net:ethernet:adi:adin1110: Fix forwarding offload")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/adi/adin1110.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index ecce5f7a549f2..cc026780ee0e8 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -740,7 +740,7 @@ static int adin1110_broadcasts_filter(struct adin1110_port_priv *port_priv,
 	u32 port_rules = 0;
 	u8 mask[ETH_ALEN];
 
-	memset(mask, 0xFF, ETH_ALEN);
+	eth_broadcast_addr(mask);
 
 	if (accept_broadcast && port_priv->state == BR_STATE_FORWARDING)
 		port_rules = adin1110_port_rules(port_priv, true, true);
@@ -761,7 +761,7 @@ static int adin1110_set_mac_address(struct net_device *netdev,
 		return -EADDRNOTAVAIL;
 
 	eth_hw_addr_set(netdev, dev_addr);
-	memset(mask, 0xFF, ETH_ALEN);
+	eth_broadcast_addr(mask);
 
 	mac_slot = (!port_priv->nr) ?  ADIN_MAC_P1_ADDR_SLOT : ADIN_MAC_P2_ADDR_SLOT;
 	port_rules = adin1110_port_rules(port_priv, true, false);
@@ -1251,7 +1251,7 @@ static int adin1110_port_set_blocking_state(struct adin1110_port_priv *port_priv
 		goto out;
 
 	/* Allow only BPDUs to be passed to the CPU */
-	memset(mask, 0xFF, ETH_ALEN);
+	eth_broadcast_addr(mask);
 	port_rules = adin1110_port_rules(port_priv, true, false);
 	ret = adin1110_write_mac_address(port_priv, mac_slot, mac,
 					 mask, port_rules);
@@ -1366,7 +1366,7 @@ static int adin1110_fdb_add(struct adin1110_port_priv *port_priv,
 
 	other_port = priv->ports[!port_priv->nr];
 	port_rules = adin1110_port_rules(port_priv, false, true);
-	memset(mask, 0xFF, ETH_ALEN);
+	eth_broadcast_addr(mask);
 
 	return adin1110_write_mac_address(other_port, mac_nr, (u8 *)fdb->addr,
 					  mask, port_rules);
-- 
2.40.1



