Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837377A39A6
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbjIQTxE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbjIQTwl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:52:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E5BEE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:51:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2F7C433C7;
        Sun, 17 Sep 2023 19:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980313;
        bh=BDl1ghNq6ZYSm/m0JWtw3HgRI4Mk+7k/l+xaMsL73cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsywLI8m6wv9oBBZ3ive7TtSM5D2+z+r39aUTS0sPUr7ZLmZwGloZlzfZ6qM/qs7Q
         dlScIygT6CUimrXJkVNClLwFKuFpdo86CNO4dkuICstpN2GwU7LHPw9AcWy0N43SrE
         UuxSLfmJCLbscwMS6oeV6YhaUC3Pf0KbI1ng0/bk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 155/285] net: dsa: sja1105: complete tc-cbs offload support on SJA1110
Date:   Sun, 17 Sep 2023 21:12:35 +0200
Message-ID: <20230917191057.048932212@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 180a7419fe4adc8d9c8e0ef0fd17bcdd0cf78acd ]

The blamed commit left this delta behind:

  struct sja1105_cbs_entry {
 -	u64 port;
 -	u64 prio;
 +	u64 port; /* Not used for SJA1110 */
 +	u64 prio; /* Not used for SJA1110 */
  	u64 credit_hi;
  	u64 credit_lo;
  	u64 send_slope;
  	u64 idle_slope;
  };

but did not actually implement tc-cbs offload fully for the new switch.
The offload is accepted, but it doesn't work.

The difference compared to earlier switch generations is that now, the
table of CBS shapers is sparse, because there are many more shapers, so
the mapping between a {port, prio} and a table index is static, rather
than requiring us to store the port and prio into the sja1105_cbs_entry.

So, the problem is that the code programs the CBS shaper parameters at a
dynamic table index which is incorrect.

All that needs to be done for SJA1110 CBS shapers to work is to bypass
the logic which allocates shapers in a dense manner, as for SJA1105, and
use the fixed mapping instead.

Fixes: 3e77e59bf8cf ("net: dsa: sja1105: add support for the SJA1110 switch family")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/sja1105/sja1105.h      |  2 ++
 drivers/net/dsa/sja1105/sja1105_main.c | 13 +++++++++++++
 drivers/net/dsa/sja1105/sja1105_spi.c  |  4 ++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index dee35ba924ad2..0617d5ccd3ff1 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -132,6 +132,8 @@ struct sja1105_info {
 	int max_frame_mem;
 	int num_ports;
 	bool multiple_cascade_ports;
+	/* Every {port, TXQ} has its own CBS shaper */
+	bool fixed_cbs_mapping;
 	enum dsa_tag_protocol tag_proto;
 	const struct sja1105_dynamic_table_ops *dyn_ops;
 	const struct sja1105_table_ops *static_ops;
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index e6d82ac106bee..b6deba4a75121 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2122,12 +2122,22 @@ static void sja1105_bridge_leave(struct dsa_switch *ds, int port,
 }
 
 #define BYTES_PER_KBIT (1000LL / 8)
+/* Port 0 (the uC port) does not have CBS shapers */
+#define SJA1110_FIXED_CBS(port, prio) ((((port) - 1) * SJA1105_NUM_TC) + (prio))
 
 static int sja1105_find_cbs_shaper(struct sja1105_private *priv,
 				   int port, int prio)
 {
 	int i;
 
+	if (priv->info->fixed_cbs_mapping) {
+		i = SJA1110_FIXED_CBS(port, prio);
+		if (i >= 0 && i < priv->info->num_cbs_shapers)
+			return i;
+
+		return -1;
+	}
+
 	for (i = 0; i < priv->info->num_cbs_shapers; i++)
 		if (priv->cbs[i].port == port && priv->cbs[i].prio == prio)
 			return i;
@@ -2139,6 +2149,9 @@ static int sja1105_find_unused_cbs_shaper(struct sja1105_private *priv)
 {
 	int i;
 
+	if (priv->info->fixed_cbs_mapping)
+		return -1;
+
 	for (i = 0; i < priv->info->num_cbs_shapers; i++)
 		if (!priv->cbs[i].idle_slope && !priv->cbs[i].send_slope)
 			return i;
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
index 5ce29c8057a41..834b5c1b4db0c 100644
--- a/drivers/net/dsa/sja1105/sja1105_spi.c
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -781,6 +781,7 @@ const struct sja1105_info sja1110a_info = {
 	.tag_proto		= DSA_TAG_PROTO_SJA1110,
 	.can_limit_mcast_flood	= true,
 	.multiple_cascade_ports	= true,
+	.fixed_cbs_mapping	= true,
 	.ptp_ts_bits		= 32,
 	.ptpegr_ts_bytes	= 8,
 	.max_frame_mem		= SJA1110_MAX_FRAME_MEMORY,
@@ -831,6 +832,7 @@ const struct sja1105_info sja1110b_info = {
 	.tag_proto		= DSA_TAG_PROTO_SJA1110,
 	.can_limit_mcast_flood	= true,
 	.multiple_cascade_ports	= true,
+	.fixed_cbs_mapping	= true,
 	.ptp_ts_bits		= 32,
 	.ptpegr_ts_bytes	= 8,
 	.max_frame_mem		= SJA1110_MAX_FRAME_MEMORY,
@@ -881,6 +883,7 @@ const struct sja1105_info sja1110c_info = {
 	.tag_proto		= DSA_TAG_PROTO_SJA1110,
 	.can_limit_mcast_flood	= true,
 	.multiple_cascade_ports	= true,
+	.fixed_cbs_mapping	= true,
 	.ptp_ts_bits		= 32,
 	.ptpegr_ts_bytes	= 8,
 	.max_frame_mem		= SJA1110_MAX_FRAME_MEMORY,
@@ -931,6 +934,7 @@ const struct sja1105_info sja1110d_info = {
 	.tag_proto		= DSA_TAG_PROTO_SJA1110,
 	.can_limit_mcast_flood	= true,
 	.multiple_cascade_ports	= true,
+	.fixed_cbs_mapping	= true,
 	.ptp_ts_bits		= 32,
 	.ptpegr_ts_bytes	= 8,
 	.max_frame_mem		= SJA1110_MAX_FRAME_MEMORY,
-- 
2.40.1



