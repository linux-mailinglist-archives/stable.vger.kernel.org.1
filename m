Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ECD7A3D5F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbjIQUmJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbjIQUlk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:41:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B36D10F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:41:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CA0C433CB;
        Sun, 17 Sep 2023 20:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983294;
        bh=iNWYJM94zPuVJ1OGhM68kB3gRxptOcxzRPoeLHhJWik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R7mgQ7JZaZE+Pa7ZBni2F3fnzXOuRF0C0mqNHuBeRaGw14BkVQ3izaLaJWnrf1QyD
         R+XcoOLz0KX81Btol3YqlpRbhcKaHH4hFBHSmX1omIZ3Ekj0DAl44FPwkXaiYzea9C
         e3Y03cL0O3vtXu2ZP3UUepPnIuZBDzZ3jMxpg2hA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 499/511] net: dsa: sja1105: hide all multicast addresses from "bridge fdb show"
Date:   Sun, 17 Sep 2023 21:15:26 +0200
Message-ID: <20230917191125.775409427@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 02c652f5465011126152bbd93b6a582a1d0c32f1 ]

Commit 4d9423549501 ("net: dsa: sja1105: offload bridge port flags to
device") has partially hidden some multicast entries from showing up in
the "bridge fdb show" output, but it wasn't enough. Addresses which are
added through "bridge mdb add" still show up. Hide them all.

Fixes: 291d1e72b756 ("net: dsa: sja1105: Add support for FDB and MDB management")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index d5600d0d6ef10..493192a8000c8 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1794,13 +1794,14 @@ static int sja1105_fdb_dump(struct dsa_switch *ds, int port,
 		if (!(l2_lookup.destports & BIT(port)))
 			continue;
 
-		/* We need to hide the FDB entry for unknown multicast */
-		if (l2_lookup.macaddr == SJA1105_UNKNOWN_MULTICAST &&
-		    l2_lookup.mask_macaddr == SJA1105_UNKNOWN_MULTICAST)
-			continue;
-
 		u64_to_ether_addr(l2_lookup.macaddr, macaddr);
 
+		/* Hardware FDB is shared for fdb and mdb, "bridge fdb show"
+		 * only wants to see unicast
+		 */
+		if (is_multicast_ether_addr(macaddr))
+			continue;
+
 		/* We need to hide the dsa_8021q VLANs from the user. */
 		if (!priv->vlan_aware)
 			l2_lookup.vlanid = 0;
-- 
2.40.1



