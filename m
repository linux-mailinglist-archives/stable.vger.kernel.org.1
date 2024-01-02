Return-Path: <stable+bounces-9216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C90821F7C
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 17:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C4D1F230D0
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 16:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF27A14F85;
	Tue,  2 Jan 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SZz5lXHV"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E361D14F72;
	Tue,  2 Jan 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25CBEFF806;
	Tue,  2 Jan 2024 16:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704212836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7cxWoJM9w+1FI31UHJehEm/IvYL6DqOGbObkcXQG4qY=;
	b=SZz5lXHV10YBd8Ws4yXv/mcksXy1mnVFpon+BHHS9NqqfFA7uX9H665wKZFZ82c7NQ+vEB
	jMm13tJ/sM4AliHx7nlIdAF4N0XxMmb1aPjOYLVSc2TwnP308cHk92ASRYHQ8hjKHoib4u
	D20gm36wtRlJ8o7CVTW5rPYnmYqpUG5qaUUGE/BVUHEzUc9kg97C3n55NG/Zyu7ReMigRP
	Bu2VGsEhNKUgLl0UgQIZ5X6tcLbWldvmttTBxLZmFBV6FFGYXrpYi2a2Cq31lmhu6mnxCY
	AxwpzVyjZVsh+OaT644mBLd0/8qjcfLCuHjmudNfuTkTWgEzxWwhEDKE8q9+PA==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Sylvain Girard <sylvain.girard@se.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Pascal EBERHARD <pascal.eberhard@se.com>,
	Richard Tresidder <rtresidd@electromag.com.au>,
	Linus Walleij <linus.walleij@linaro.org>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/1] net: stmmac: Prevent DSA tags from breaking COE on stmmac
Date: Tue,  2 Jan 2024 17:27:15 +0100
Message-ID: <20240102162718.268271-2-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102162718.268271-1-romain.gantois@bootlin.com>
References: <20240102162718.268271-1-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: romain.gantois@bootlin.com

Some DSA tagging protocols change the EtherType field in the MAC header
e.g.  DSA_TAG_PROTO_(DSA/EDSA/BRCM/MTK/RTL4C_A/SJA1105). On TX these tagged
frames are ignored by the checksum offload engine and IP header checker of
some stmmac cores.

On RX, the stmmac driver wrongly assumes that checksums have been computed
for these tagged packets, and sets CHECKSUM_UNNECESSARY.

Add an additional check in the stmmac tx and rx hotpaths so that COE is
deactivated for packets with ethertypes that will not trigger the COE and
ip header checks.

Fixes: 6b2c6e4a938f ("net: stmmac: propagate feature flags to vlan")
Cc: stable@vger.kernel.org
Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
Closes: https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au/
Reported-by: Romain Gantois <romain.gantois@bootlin.com>
Closes: https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com/
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 37e64283f910..bb2ae6b32b2f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4371,6 +4371,17 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+/* Check if ethertype will trigger IP
+ * header checks/COE in hardware
+ */
+static inline bool stmmac_has_ip_ethertype(struct sk_buff *skb)
+{
+	__be16 proto = eth_header_parse_protocol(skb);
+
+	return (proto == htons(ETH_P_IP)) || (proto == htons(ETH_P_IPV6)) ||
+		(proto == htons(ETH_P_8021Q));
+}
+
 /**
  *  stmmac_xmit - Tx entry point of the driver
  *  @skb : the socket buffer
@@ -4435,9 +4446,13 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* DWMAC IPs can be synthesized to support tx coe only for a few tx
 	 * queues. In that case, checksum offloading for those queues that don't
 	 * support tx coe needs to fallback to software checksum calculation.
+	 *
+	 * Packets that won't trigger the COE e.g. most DSA-tagged packets will
+	 * also have to be checksummed in software.
 	 */
 	if (csum_insertion &&
-	    priv->plat->tx_queues_cfg[queue].coe_unsupported) {
+	    (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
+	    !stmmac_has_ip_ethertype(skb))) {
 		if (unlikely(skb_checksum_help(skb)))
 			goto dma_map_err;
 		csum_insertion = !csum_insertion;
@@ -4997,7 +5012,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 	stmmac_rx_vlan(priv->dev, skb);
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
-	if (unlikely(!coe))
+	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
 		skb_checksum_none_assert(skb);
 	else
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -5513,7 +5528,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_rx_vlan(priv->dev, skb);
 		skb->protocol = eth_type_trans(skb, priv->dev);
 
-		if (unlikely(!coe))
+		if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
 			skb_checksum_none_assert(skb);
 		else
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
-- 
2.43.0


