Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458207A3B1D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbjIQUNy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240606AbjIQUNZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:13:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49481197
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:12:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8036AC433C9;
        Sun, 17 Sep 2023 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981557;
        bh=2NnO2pLOzToTkxrJytKxraV2QfcI5DQqP1RgHN0kczM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htQHDNyaZ0KxmRRHs/9/Dl4jEsii8Rv9MB4G7BhtHcjs7M+M9rt4QhiAvbPXfeiI5
         HlSM8iULOs8ohyrlNYgptwBWF1SwLJeRQ+oSVvnVZ6p4iqghfvsQ+lecCoKHjH8ryo
         5umIoOW+L2Xr2/EKL38Z+a1eF401aCfmqPl5Brfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 122/219] net: dsa: sja1105: fix -ENOSPC when replacing the same tc-cbs too many times
Date:   Sun, 17 Sep 2023 21:14:09 +0200
Message-ID: <20230917191045.387863974@linuxfoundation.org>
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 894cafc5c62ccced758077bd4e970dc714c42637 ]

After running command [2] too many times in a row:

[1] $ tc qdisc add dev sw2p0 root handle 1: mqprio num_tc 8 \
	map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 hw 0
[2] $ tc qdisc replace dev sw2p0 parent 1:1 cbs offload 1 \
	idleslope 120000 sendslope -880000 locredit -1320 hicredit 180

(aka more than priv->info->num_cbs_shapers times)

we start seeing the following error message:

Error: Specified device failed to setup cbs hardware offload.

This comes from the fact that ndo_setup_tc(TC_SETUP_QDISC_CBS) presents
the same API for the qdisc create and replace cases, and the sja1105
driver fails to distinguish between the 2. Thus, it always thinks that
it must allocate the same shaper for a {port, queue} pair, when it may
instead have to replace an existing one.

Fixes: 4d7525085a9b ("net: dsa: sja1105: offload the Credit-Based Shaper qdisc")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 377f177502003..9dd5cdcda2843 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2123,6 +2123,18 @@ static void sja1105_bridge_leave(struct dsa_switch *ds, int port,
 
 #define BYTES_PER_KBIT (1000LL / 8)
 
+static int sja1105_find_cbs_shaper(struct sja1105_private *priv,
+				   int port, int prio)
+{
+	int i;
+
+	for (i = 0; i < priv->info->num_cbs_shapers; i++)
+		if (priv->cbs[i].port == port && priv->cbs[i].prio == prio)
+			return i;
+
+	return -1;
+}
+
 static int sja1105_find_unused_cbs_shaper(struct sja1105_private *priv)
 {
 	int i;
@@ -2163,9 +2175,14 @@ static int sja1105_setup_tc_cbs(struct dsa_switch *ds, int port,
 	if (!offload->enable)
 		return sja1105_delete_cbs_shaper(priv, port, offload->queue);
 
-	index = sja1105_find_unused_cbs_shaper(priv);
-	if (index < 0)
-		return -ENOSPC;
+	/* The user may be replacing an existing shaper */
+	index = sja1105_find_cbs_shaper(priv, port, offload->queue);
+	if (index < 0) {
+		/* That isn't the case - see if we can allocate a new one */
+		index = sja1105_find_unused_cbs_shaper(priv);
+		if (index < 0)
+			return -ENOSPC;
+	}
 
 	cbs = &priv->cbs[index];
 	cbs->port = port;
-- 
2.40.1



