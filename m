Return-Path: <stable+bounces-11339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC87D82EED2
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 13:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DA91C22701
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 12:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554321B978;
	Tue, 16 Jan 2024 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O1W8IfyF"
X-Original-To: stable@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E031B80B;
	Tue, 16 Jan 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D8FD60002;
	Tue, 16 Jan 2024 12:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705407538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z8eiggSZ60rlf2uUj/3zwjpRu+iDhvHMyX3+FABqZqM=;
	b=O1W8IfyFEUweEwpFcMN1IDn0KxTkR0EpjN2zXpri1+OyfpGPAbTrJIDJ34+ueWTOlp6ENu
	sKesn7odpFwGHJiZla6vFQfU0ByuDN6kuESTsgpgwI/7W9OJbu5a9qY1DmGCmH3UIYX4dE
	2w+UcGULfmjMBUUGPtBhN7adJ5I1win9+qW87B3t2ClNSStFYL6zMGEx6FyLh5a2ZAWH6c
	8dv8pZ0c3dsUFlh5hHNxekf2o5oRfPN2AHiADlpDbeljmEwlCphT21zkGT+XK5lNENKs5L
	DploQq7sLv97I8Uh0qS3JSj1OTnbcyOPqHmk44mwWdNQXL8Fah24LZeC4ZFI1w==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 16 Jan 2024 13:19:17 +0100
Subject: [PATCH net v6] net: stmmac: Prevent DSA tags from breaking COE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-prevent_dsa_tags-v6-1-ec44ed59744b@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAEV0pmUC/23O0YrDIBAF0F8pPq/FsSaaPu1/LKWYOibCVotK6
 BLy7zsJ+7ChfbzDncOdWcEcsLDzYWYZp1BCihTajwO7jTYOyIOjzKSQSoAw/EEtjPXqir1WOxS
 u+1449ML1Bhi9UcGH50Z+sYiVXejoc7rzOma0Ow0AtNJHfTJacsmpZEM8DjbWFMpnn1L9pnxL9
 xUeQ6kp/2xTJ7Xxf073umpSHLg3xmgN3krf7rR10tT8IwDeEA0R7Ql111jlQHZ7YlmWX8+n/dY
 +AQAA
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Sylvain Girard <sylvain.girard@se.com>, 
 Pascal EBERHARD <pascal.eberhard@se.com>, 
 Richard Tresidder <rtresidd@electromag.com.au>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.12.4
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
Cc:  <stable@vger.kernel.org>
Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
Link: https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au/
Reported-by: Romain Gantois <romain.gantois@bootlin.com>
Link: https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@bootlin.com/
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Hello everyone,

This is the sixth version of my proposed fix for the stmmac checksum
offloading issue that has recently been reported.

significant changes in v4:
- Removed "inline" from declaration of stmmac_has_ip_ethertype

significant changes in v3:
- Use __vlan_get_protocol to make sure that 8021Q-encapsulated
  traffic is checked correctly.

significant changes in v2:
- Replaced the stmmac_link_up-based fix with an ethertype check in the TX
  and RX hotpaths.

The Checksum Offloading Engine of some stmmac cores (e.g. DWMAC1000)
computes an incorrect checksum when presented with DSA-tagged packets. This
causes all TCP/UDP transfers to break when the stmmac device is connected
to the CPU port of a DSA switch.

I ran some tests using different tagging protocols with DSA_LOOP, and all
of the protocols that set a custom ethertype field in the MAC header caused
the checksum offload engine to ignore the tagged packets. On TX, this
caused packets to egress with incorrect checksums. On RX, these packets
were similarly ignored by the COE, yet the stmmac driver set
CHECKSUM_UNNECESSARY, wrongly assuming that their checksums had been
verified in hardware.

Version 2 of this patch series fixes this issue by checking ethertype
fields in both the TX and RX hotpaths of the stmmac driver. On TX, if a
non-IP ethertype is detected, the packet is checksummed in software.  On
RX, the same condition causes stmmac to avoid setting CHECKSUM_UNNECESSARY.

To measure the performance degradation to the TX/RX hotpaths, I did some
iperf3 runs with 512-byte unfragmented UDP packets.

measured degradation on TX: -466 pps (-0.2%) on RX: -338 pps (-1.2%)
original performances on TX: 22kpps on RX: 27kpps

The performance hit on the RX path can be partly explained by the fact that
the stmmac driver doesn't set CHECKSUM_UNNECESSARY anymore.

The TX performance degradation observed in v2 seems to have improved.
It's not entirely clear to me why that is.

Best Regards,

Romain

Romain Gantois (1):
  net: stmmac: Prevent DSA tags from breaking COE

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

--
2.43.0
---
Changes in v6:
- Style fixes
- Link to v5: https://lore.kernel.org/r/20240111-prevent_dsa_tags-v5-1-63e795a4d129@bootlin.com

Changes in v5:
- Added missing "net" tag to subject of patch series
- Link to v4: https://lore.kernel.org/r/20240109-prevent_dsa_tags-v4-1-f888771fa2f6@bootlin.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 32 ++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c78a96b8eb64..a0e46369ae15 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4435,6 +4435,28 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+/**
+ * stmmac_has_ip_ethertype() - Check if packet has IP ethertype
+ * @skb: socket buffer to check
+ *
+ * Check if a packet has an ethertype that will trigger the IP header checks
+ * and IP/TCP checksum engine of the stmmac core.
+ *
+ * Return: true if the ethertype can trigger the checksum engine, false
+ * otherwise
+ */
+static bool stmmac_has_ip_ethertype(struct sk_buff *skb)
+{
+	int depth = 0;
+	__be16 proto;
+
+	proto = __vlan_get_protocol(skb, eth_header_parse_protocol(skb),
+				    &depth);
+
+	return (depth <= ETH_HLEN) &&
+		(proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));
+}
+
 /**
  *  stmmac_xmit - Tx entry point of the driver
  *  @skb : the socket buffer
@@ -4499,9 +4521,13 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
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
+	     !stmmac_has_ip_ethertype(skb))) {
 		if (unlikely(skb_checksum_help(skb)))
 			goto dma_map_err;
 		csum_insertion = !csum_insertion;
@@ -5066,7 +5092,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 		stmmac_rx_vlan(priv->dev, skb);
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
-	if (unlikely(!coe))
+	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
 		skb_checksum_none_assert(skb);
 	else
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -5589,7 +5615,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		skb->protocol = eth_type_trans(skb, priv->dev);
 
-		if (unlikely(!coe))
+		if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
 			skb_checksum_none_assert(skb);
 		else
 			skb->ip_summed = CHECKSUM_UNNECESSARY;

---
base-commit: a23aa04042187cbde16f470b49d4ad60d32e9206
change-id: 20240108-prevent_dsa_tags-7bb0def0db81

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


