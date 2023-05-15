Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9E9703635
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbjEORHq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbjEORHX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194B2A5EC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 318C762AD1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BABC433EF;
        Mon, 15 May 2023 17:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170313;
        bh=Z5Vrw/tXmHB+1r+/ATi69pULaH6SnGr9jVdwoNHAEyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oWzWy0qk+c9uZlYfq+nQlZ2Ok10ZEzH80buaVD9e7V+v1R80hKpZ1a8XxZBNGC0xl
         MbWvw0iMv84y+hGZrHcyodylg8svai1quKUO+qrBd/7yzEYA9Ke/HJFFik4tpCMyGl
         EytOILyskD48gdGdiXdbve7jFDQBr+G9aTS7cdeM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Golle <daniel@makrotopia.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 084/239] net: dsa: mt7530: split-off common parts from mt7531_setup
Date:   Mon, 15 May 2023 18:25:47 +0200
Message-Id: <20230515161724.198572734@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit 7f54cc9772ced2d76ac11832f0ada43798443ac9 ]

MT7988 shares a significant part of the setup function with MT7531.
Split-off those parts into a shared function which is going to be used
also by mt7988_setup.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 120a56b01bee ("net: dsa: mt7530: fix network connectivity with multiple CPU ports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 99 ++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 3ef92ac7815c1..4e63f14c42228 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2312,12 +2312,65 @@ mt7530_setup(struct dsa_switch *ds)
 	return 0;
 }
 
+static int
+mt7531_setup_common(struct dsa_switch *ds)
+{
+	struct mt7530_priv *priv = ds->priv;
+	struct dsa_port *cpu_dp;
+	int ret, i;
+
+	/* BPDU to CPU port */
+	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
+		mt7530_rmw(priv, MT7531_CFC, MT7531_CPU_PMAP_MASK,
+			   BIT(cpu_dp->index));
+		break;
+	}
+	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
+		   MT753X_BPDU_CPU_ONLY);
+
+	/* Enable and reset MIB counters */
+	mt7530_mib_reset(ds);
+
+	for (i = 0; i < MT7530_NUM_PORTS; i++) {
+		/* Disable forwarding by default on all ports */
+		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
+			   PCR_MATRIX_CLR);
+
+		/* Disable learning by default on all ports */
+		mt7530_set(priv, MT7530_PSC_P(i), SA_DIS);
+
+		mt7530_set(priv, MT7531_DBG_CNT(i), MT7531_DIS_CLR);
+
+		if (dsa_is_cpu_port(ds, i)) {
+			ret = mt753x_cpu_port_enable(ds, i);
+			if (ret)
+				return ret;
+		} else {
+			mt7530_port_disable(ds, i);
+
+			/* Set default PVID to 0 on all user ports */
+			mt7530_rmw(priv, MT7530_PPBV1_P(i), G0_PORT_VID_MASK,
+				   G0_PORT_VID_DEF);
+		}
+
+		/* Enable consistent egress tag */
+		mt7530_rmw(priv, MT7530_PVC_P(i), PVC_EG_TAG_MASK,
+			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
+	}
+
+	/* Flush the FDB table */
+	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int
 mt7531_setup(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
 	struct mt7530_dummy_poll p;
-	struct dsa_port *cpu_dp;
 	u32 val, id;
 	int ret, i;
 
@@ -2395,44 +2448,7 @@ mt7531_setup(struct dsa_switch *ds)
 	mt7531_ind_c45_phy_write(priv, MT753X_CTRL_PHY_ADDR, MDIO_MMD_VEND2,
 				 CORE_PLL_GROUP4, val);
 
-	/* BPDU to CPU port */
-	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
-		mt7530_rmw(priv, MT7531_CFC, MT7531_CPU_PMAP_MASK,
-			   BIT(cpu_dp->index));
-		break;
-	}
-	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
-		   MT753X_BPDU_CPU_ONLY);
-
-	/* Enable and reset MIB counters */
-	mt7530_mib_reset(ds);
-
-	for (i = 0; i < MT7530_NUM_PORTS; i++) {
-		/* Disable forwarding by default on all ports */
-		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
-			   PCR_MATRIX_CLR);
-
-		/* Disable learning by default on all ports */
-		mt7530_set(priv, MT7530_PSC_P(i), SA_DIS);
-
-		mt7530_set(priv, MT7531_DBG_CNT(i), MT7531_DIS_CLR);
-
-		if (dsa_is_cpu_port(ds, i)) {
-			ret = mt753x_cpu_port_enable(ds, i);
-			if (ret)
-				return ret;
-		} else {
-			mt7530_port_disable(ds, i);
-
-			/* Set default PVID to 0 on all user ports */
-			mt7530_rmw(priv, MT7530_PPBV1_P(i), G0_PORT_VID_MASK,
-				   G0_PORT_VID_DEF);
-		}
-
-		/* Enable consistent egress tag */
-		mt7530_rmw(priv, MT7530_PVC_P(i), PVC_EG_TAG_MASK,
-			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
-	}
+	mt7531_setup_common(ds);
 
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
 	ret = mt7530_setup_vlan0(priv);
@@ -2442,11 +2458,6 @@ mt7531_setup(struct dsa_switch *ds)
 	ds->assisted_learning_on_cpu_port = true;
 	ds->mtu_enforcement_ingress = true;
 
-	/* Flush the FDB table */
-	ret = mt7530_fdb_cmd(priv, MT7530_FDB_FLUSH, NULL);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
-- 
2.39.2



