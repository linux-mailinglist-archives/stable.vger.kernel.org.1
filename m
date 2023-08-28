Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA7978AA3C
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjH1KUP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjH1KTz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:19:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D2CFA
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70DB863873
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA4EC433C8;
        Mon, 28 Aug 2023 10:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217974;
        bh=XV5JX4T3LdUPfKqSETlHBPiUgjJYus2C5+7kiNdJLEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/wvnxz4dDFA1Rk7gawM8oI54JpIMmdlETv2ZuVugvmgPXM7J1D+TYTzMXXXtc0j8
         OaAaEDJvXTFPJF7sS3/bmqRc8jpsTvYAOMoIXhyesMvf+3exEJvT2Ly5LxiQdZ7ndw
         idNiANM2N3mqzSnK2VuwBDXdj1Pfuzmf1PcgMFqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, susan.zheng@veritas.com,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 050/129] bonding: fix macvlan over alb bond support
Date:   Mon, 28 Aug 2023 12:12:09 +0200
Message-ID: <20230828101159.046940425@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit e74216b8def3803e98ae536de78733e9d7f3b109 ]

The commit 14af9963ba1e ("bonding: Support macvlans on top of tlb/rlb mode
bonds") aims to enable the use of macvlans on top of rlb bond mode. However,
the current rlb bond mode only handles ARP packets to update remote neighbor
entries. This causes an issue when a macvlan is on top of the bond, and
remote devices send packets to the macvlan using the bond's MAC address
as the destination. After delivering the packets to the macvlan, the macvlan
will rejects them as the MAC address is incorrect. Consequently, this commit
makes macvlan over bond non-functional.

To address this problem, one potential solution is to check for the presence
of a macvlan port on the bond device using netif_is_macvlan_port(bond->dev)
and return NULL in the rlb_arp_xmit() function. However, this approach
doesn't fully resolve the situation when a VLAN exists between the bond and
macvlan.

So let's just do a partial revert for commit 14af9963ba1e in rlb_arp_xmit().
As the comment said, Don't modify or load balance ARPs that do not originate
locally.

Fixes: 14af9963ba1e ("bonding: Support macvlans on top of tlb/rlb mode bonds")
Reported-by: susan.zheng@veritas.com
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2117816
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_alb.c |  6 +++---
 include/net/bonding.h          | 11 +----------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index b9dbad3a8af82..fc5da5d7744da 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -660,10 +660,10 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
 		return NULL;
 	arp = (struct arp_pkt *)skb_network_header(skb);
 
-	/* Don't modify or load balance ARPs that do not originate locally
-	 * (e.g.,arrive via a bridge).
+	/* Don't modify or load balance ARPs that do not originate
+	 * from the bond itself or a VLAN directly above the bond.
 	 */
-	if (!bond_slave_has_mac_rx(bond, arp->mac_src))
+	if (!bond_slave_has_mac_rcu(bond, arp->mac_src))
 		return NULL;
 
 	dev = ip_dev_find(dev_net(bond->dev), arp->ip_src);
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 59955ac331578..6e4e406d8cd20 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -724,23 +724,14 @@ static inline struct slave *bond_slave_has_mac(struct bonding *bond,
 }
 
 /* Caller must hold rcu_read_lock() for read */
-static inline bool bond_slave_has_mac_rx(struct bonding *bond, const u8 *mac)
+static inline bool bond_slave_has_mac_rcu(struct bonding *bond, const u8 *mac)
 {
 	struct list_head *iter;
 	struct slave *tmp;
-	struct netdev_hw_addr *ha;
 
 	bond_for_each_slave_rcu(bond, tmp, iter)
 		if (ether_addr_equal_64bits(mac, tmp->dev->dev_addr))
 			return true;
-
-	if (netdev_uc_empty(bond->dev))
-		return false;
-
-	netdev_for_each_uc_addr(ha, bond->dev)
-		if (ether_addr_equal_64bits(mac, ha->addr))
-			return true;
-
 	return false;
 }
 
-- 
2.40.1



