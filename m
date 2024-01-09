Return-Path: <stable+bounces-10390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1026082885F
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 15:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A135B23ABB
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47739AC4;
	Tue,  9 Jan 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ewWGbq+Q"
X-Original-To: stable@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F021381DA;
	Tue,  9 Jan 2024 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E765420019;
	Tue,  9 Jan 2024 14:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704811338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ln2A5S2uPwhRPFIFACLIF7C474ATGhYS0EjHcevuV6U=;
	b=ewWGbq+QrelWcWMziazToS3wyO48WRiyjvn4SdkqXTGhnOeHWBBm57rF0UAfOpycM1/WEH
	0ns02HFbOgZOsV9+ccbWA/8u3CwRTBEQ0Xd2CwIhjWnxTjSnsdt7K1bjUFeb/Opa/G094n
	lE+X4WPqrxfdqUfCzyQLKfeVGBeUDUyUCO3lfhopTOE6zTUYpFtNWxhTR2jUO5bTzS1R7h
	KEfRDJdG+gGdOCql6gOALwNZLUx+wvOZyYmnUEgETYADwV9u+Dj+l/2bfDryxp7z3+XXhl
	GCw0xZgMxEfhaH6C351RsoYXIXCpcO6Or8ZhdxH3EjDLGUjhZ/8DJB6Mn8F8Hg==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 09 Jan 2024 15:42:35 +0100
Subject: [PATCH v4] net: stmmac: Prevent DSA tags from breaking COE
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240109-prevent_dsa_tags-v4-1-f888771fa2f6@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAFtbnWUC/1XMQQrDIBCF4auEWdegVjB01XuUEDSOZqDRolIKI
 Xfv0F2XH/zvHdCwEja4DQdUfFOjkhnmMsC6uZxQUGCDltpIJSfx4gpzX0JzS3epCeu9DBhl8JM
 CnnEQ6fO7fMzsWMsu+lbR/R0ppayxo71OVgstOHKUx+RyL9TuvpT+ZK9lh/P8AuitioimAAAA
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
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Hello everyone,

This is the fourth version of my proposed fix for the stmmac checksum
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
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 29 ++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 37e64283f910..b30dba06dbd1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4371,6 +4371,25 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+/**
+ * stmmac_has_ip_ethertype() - Check if packet has IP ethertype
+ * @skb: socket buffer to check
+ *
+ * Check if a packet has an ethertype that will trigger the IP header checks
+ * and IP/TCP checksum engine of the stmmac core.
+ *
+ * Return: true if the ethertype can trigger the checksum engine, false otherwise
+ */
+static bool stmmac_has_ip_ethertype(struct sk_buff *skb)
+{
+	int depth = 0;
+	__be16 proto;
+
+	proto = __vlan_get_protocol(skb, eth_header_parse_protocol(skb), &depth);
+
+	return (depth <= ETH_HLEN) && (proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));
+}
+
 /**
  *  stmmac_xmit - Tx entry point of the driver
  *  @skb : the socket buffer
@@ -4435,9 +4454,13 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -4997,7 +5020,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 	stmmac_rx_vlan(priv->dev, skb);
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
-	if (unlikely(!coe))
+	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
 		skb_checksum_none_assert(skb);
 	else
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -5513,7 +5536,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		stmmac_rx_vlan(priv->dev, skb);
 		skb->protocol = eth_type_trans(skb, priv->dev);
 
-		if (unlikely(!coe))
+		if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
 			skb_checksum_none_assert(skb);
 		else
 			skb->ip_summed = CHECKSUM_UNNECESSARY;

---
base-commit: ac631873c9e7a50d2a8de457cfc4b9f86666403e
change-id: 20240108-prevent_dsa_tags-7bb0def0db81

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


