Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25352719D9A
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjFANYq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjFANYj (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:24:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261C1E48
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:24:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E74776447C
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E00FC433EF;
        Thu,  1 Jun 2023 13:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625860;
        bh=eouI4O4GF1MN+kQtO6CNvM9N2Hn2mJh/0cHdmV0jW8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g8WO5/gfkcXUXZLAzOMAdBNkcL8Qf8oJ8lU9mwqJuoirUojN2CZrRINiGiD3lU+se
         GuOvYL+zaaj0XbaHHzTvY1vz58wIwW+yqoRtK/8mrJoOgZvDn064vW+OcBE2dGd1qH
         j9pYdu3A3gnbZZvWkPHwUNTt9Atq9ZabKIqSVQk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <olteanv@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 22/42] net: dsa: mt7530: rework mt753[01]_setup
Date:   Thu,  1 Jun 2023 14:21:09 +0100
Message-Id: <20230601131937.717547856@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131936.699199833@linuxfoundation.org>
References: <20230601131936.699199833@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

[ Upstream commit 6e19bc26cccdd34739b8c42aba2758777d18b211 ]

Enumerate available cpu-ports instead of using hardcoded constant.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 120a56b01bee ("net: dsa: mt7530: fix network connectivity with multiple CPU ports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index e7a551570cf3c..0e64873fbc37b 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2094,11 +2094,12 @@ static int
 mt7530_setup(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
+	struct device_node *dn = NULL;
 	struct device_node *phy_node;
 	struct device_node *mac_np;
 	struct mt7530_dummy_poll p;
 	phy_interface_t interface;
-	struct device_node *dn;
+	struct dsa_port *cpu_dp;
 	u32 id, val;
 	int ret, i;
 
@@ -2106,7 +2107,19 @@ mt7530_setup(struct dsa_switch *ds)
 	 * controller also is the container for two GMACs nodes representing
 	 * as two netdev instances.
 	 */
-	dn = dsa_to_port(ds, MT7530_CPU_PORT)->master->dev.of_node->parent;
+	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
+		dn = cpu_dp->master->dev.of_node->parent;
+		/* It doesn't matter which CPU port is found first,
+		 * their masters should share the same parent OF node
+		 */
+		break;
+	}
+
+	if (!dn) {
+		dev_err(ds->dev, "parent OF node of DSA master not found");
+		return -EINVAL;
+	}
+
 	ds->assisted_learning_on_cpu_port = true;
 	ds->mtu_enforcement_ingress = true;
 
@@ -2279,6 +2292,7 @@ mt7531_setup(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
 	struct mt7530_dummy_poll p;
+	struct dsa_port *cpu_dp;
 	u32 val, id;
 	int ret, i;
 
@@ -2353,8 +2367,11 @@ mt7531_setup(struct dsa_switch *ds)
 				 CORE_PLL_GROUP4, val);
 
 	/* BPDU to CPU port */
-	mt7530_rmw(priv, MT7531_CFC, MT7531_CPU_PMAP_MASK,
-		   BIT(MT7530_CPU_PORT));
+	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
+		mt7530_rmw(priv, MT7531_CFC, MT7531_CPU_PMAP_MASK,
+			   BIT(cpu_dp->index));
+		break;
+	}
 	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
 		   MT753X_BPDU_CPU_ONLY);
 
-- 
2.39.2



