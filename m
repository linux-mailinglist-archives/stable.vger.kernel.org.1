Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEACA7352CB
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjFSKiU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjFSKiH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37526E68
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:38:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C89E260B73
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF972C433C0;
        Mon, 19 Jun 2023 10:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171083;
        bh=d05Mi+bVY9x/LoQAfBmUYpFURz9+W6YdgdHzqtK+fNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jSJtIuBEFRTQeXnWqUvUI9ky8Z2LBF285NId1NLsUg6Yuj2+WtoxZ86n3JgLO5wrK
         2cE5NalFH+2ofRqxElWabDh94wuXLwAh4W5eNnTXgl/Lex0qUmHGYRAOzJfYhDQKbt
         eGAURPamdHn7yr6V7axD0I88uH9EGXbW6M1QB5Qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Zhang <markzhang@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 141/187] RDMA/cma: Always set static rate to 0 for RoCE
Date:   Mon, 19 Jun 2023 12:29:19 +0200
Message-ID: <20230619102204.470012583@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

[ Upstream commit 58030c76cce473b6cfd630bbecb97215def0dff8 ]

Set static rate to 0 as it should be discovered by path query and
has no meaning for RoCE.
This also avoid of using the rtnl lock and ethtool API, which is
a bottleneck when try to setup many rdma-cm connections at the same
time, especially with multiple processes.

Fixes: 3c86aa70bf67 ("RDMA/cm: Add RDMA CM support for IBoE devices")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Link: https://lore.kernel.org/r/f72a4f8b667b803aee9fa794069f61afb5839ce4.1685960567.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cma.c |  4 ++--
 include/rdma/ib_addr.h        | 23 -----------------------
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 6b9563d4f23c9..033df909b92e1 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3297,7 +3297,7 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 	route->path_rec->traffic_class = tos;
 	route->path_rec->mtu = iboe_get_mtu(ndev->mtu);
 	route->path_rec->rate_selector = IB_SA_EQ;
-	route->path_rec->rate = iboe_get_rate(ndev);
+	route->path_rec->rate = IB_RATE_PORT_CURRENT;
 	dev_put(ndev);
 	route->path_rec->packet_life_time_selector = IB_SA_EQ;
 	/* In case ACK timeout is set, use this value to calculate
@@ -4966,7 +4966,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
 	if (!ndev)
 		return -ENODEV;
 
-	ib.rec.rate = iboe_get_rate(ndev);
+	ib.rec.rate = IB_RATE_PORT_CURRENT;
 	ib.rec.hop_limit = 1;
 	ib.rec.mtu = iboe_get_mtu(ndev->mtu);
 
diff --git a/include/rdma/ib_addr.h b/include/rdma/ib_addr.h
index d808dc3d239e8..811a0f11d0dbe 100644
--- a/include/rdma/ib_addr.h
+++ b/include/rdma/ib_addr.h
@@ -194,29 +194,6 @@ static inline enum ib_mtu iboe_get_mtu(int mtu)
 		return 0;
 }
 
-static inline int iboe_get_rate(struct net_device *dev)
-{
-	struct ethtool_link_ksettings cmd;
-	int err;
-
-	rtnl_lock();
-	err = __ethtool_get_link_ksettings(dev, &cmd);
-	rtnl_unlock();
-	if (err)
-		return IB_RATE_PORT_CURRENT;
-
-	if (cmd.base.speed >= 40000)
-		return IB_RATE_40_GBPS;
-	else if (cmd.base.speed >= 30000)
-		return IB_RATE_30_GBPS;
-	else if (cmd.base.speed >= 20000)
-		return IB_RATE_20_GBPS;
-	else if (cmd.base.speed >= 10000)
-		return IB_RATE_10_GBPS;
-	else
-		return IB_RATE_PORT_CURRENT;
-}
-
 static inline int rdma_link_local_addr(struct in6_addr *addr)
 {
 	if (addr->s6_addr32[0] == htonl(0xfe800000) &&
-- 
2.39.2



