Return-Path: <stable+bounces-9981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FC6826C65
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 12:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD1E283083
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 11:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533AE14287;
	Mon,  8 Jan 2024 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rtm4nptB"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E114266;
	Mon,  8 Jan 2024 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A65371C0003;
	Mon,  8 Jan 2024 11:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704712661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nk8hHoIHrRN7+QFS8gawwQJ97/we7D2OtB32m3h4FLM=;
	b=Rtm4nptBllHnw24uuafDuZLS2DP+SmyikKCie7NWvXW7WQmsTnvc+PaJRz2rAso50ct2l3
	CbjyZB6YwzFw1BYlFxCiyHKGaLS7C3tOuT20+J7MhjUKcjeOX5Dw3WkeZ+1qDl6flnQk2X
	SChCYhNThrYHaIyVwUVtCmo0dfRw2rubmUGtuDVZrJPwribVUAWYWfcEnLZwZczmwC7Phj
	DCW/MIRpBi2zpdkr61P/qKgeBI85HWRa/6pqnikLlw9wiISpHgXmxT5iHnJ1rYZ4s4T9X4
	RoJIqg6325AwasS2EXNQ+iXHXnB4j+dHIew+2VP+IciSk0jgRC+rrxRa+v+sLg==
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
	Pascal EBERHARD <pascal.eberhard@se.com>,
	Richard Tresidder <rtresidd@electromag.com.au>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/1] net: stmmac: Prevent DSA tags from breaking COE
Date: Mon,  8 Jan 2024 12:17:45 +0100
Message-ID: <20240108111747.73872-2-romain.gantois@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108111747.73872-1-romain.gantois@bootlin.com>
References: <20240108111747.73872-1-romain.gantois@bootlin.com>
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

Add an additional check in the stmmac TX and RX hotpaths so that COE is
deactivated for packets with ethertypes that will not trigger the COE and
IP header checks.

Fixes: 6b2c6e4a938f ("net: stmmac: propagate feature flags to vlan")
Cc: stable@vger.kernel.org
Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
Link: https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au/
Reported-by: Romain Gantois <romain.gantois@bootlin.com>
Link: https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com/
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a9b6b383e863..6797c944a2ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4371,6 +4371,19 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+/* Check if ethertype will trigger IP
+ * header checks/COE in hardware
+ */
+static inline bool stmmac_has_ip_ethertype(struct sk_buff *skb)
+{
+	int depth = 0;
+	__be16 proto;
+
+	proto = __vlan_get_protocol(skb, eth_header_parse_protocol(skb), &depth);
+
+	return depth <= ETH_HLEN && (proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));
+}
+
 /**
  *  stmmac_xmit - Tx entry point of the driver
  *  @skb : the socket buffer
@@ -4435,9 +4448,13 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -4997,7 +5014,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 	stmmac_rx_vlan(priv->dev, skb);
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
-	if (unlikely(!coe))
+	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
 		skb_checksum_none_assert(skb);
 	else
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -5513,7 +5530,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_rx_vlan(priv->dev, skb);
 		skb->protocol = eth_type_trans(skb, priv->dev);
 
-		if (unlikely(!coe))
+		if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
 			skb_checksum_none_assert(skb);
 		else
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
-- 
2.43.0


