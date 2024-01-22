Return-Path: <stable+bounces-12782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776CD83738D
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C7C1C27044
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF1F405EA;
	Mon, 22 Jan 2024 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TN7kQnmF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03713DB86
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705954391; cv=none; b=had2hbgup4CJRG7O/U2SH+7z4uF+v1nfWAzw+PT1YGoHCSZj7LqdoZT+SvIZ/RDlJnQBIBuWTvPZnrYUCHaN3Y6hcAdoraDgM/G7+F19wSUPeY0cdGNQFZugybeGdV7ktAgH7AZzq2xNWr2TiF4wrKsqaOOL4CGGcfJKL9LMdeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705954391; c=relaxed/simple;
	bh=3Lhk/3P+Xn70e+EamwRga7tSL2dkLrRSudCLZsUyczk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jCBMDEzxihFZiXjmf6/ZXBz7VNAPnRO5KcWnMWq35k2AZIUm7oneg+ts2K+OgO/Yo3zqdUQ9K4/R8aa5llubLU7C4/Wi5qOmZBCoqpEcS5dgmg5Nkr1NnqDkcxU7QUqPgKzg6hzRywPQnitNO5XDV8PlM4Ruxcfppbq9PVGT+Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TN7kQnmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686F9C433F1;
	Mon, 22 Jan 2024 20:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705954391;
	bh=3Lhk/3P+Xn70e+EamwRga7tSL2dkLrRSudCLZsUyczk=;
	h=Subject:To:Cc:From:Date:From;
	b=TN7kQnmFE0knH/h0jdOXjBGt5xLs8K2TAzPKQxJXVu9HpmNbX04xBRzydaHt1YngM
	 7hmykOOufw/x13Yhde+5pkNLtKDCgcEg9N5NuQzdunWHfyT+/JIJi5mnDfN+2hm8TY
	 QyHzUy2E7tXGCn67daH4+ICH+OCm/3CxCxy/VrOk=
Subject: FAILED: patch "[PATCH] net: stmmac: Prevent DSA tags from breaking COE" failed to apply to 6.6-stable tree
To: romain.gantois@bootlin.com,davem@davemloft.net,florian.fainelli@broadcom.com,linus.walleij@linaro.org,rtresidd@electromag.com.au,stable@vger.kernel.org,vladimir.oltean@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:13:10 -0800
Message-ID: <2024012210-answering-vacate-2c6a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c2945c435c999c63e47f337bc7c13c98c21d0bcc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012210-answering-vacate-2c6a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

c2945c435c99 ("net: stmmac: Prevent DSA tags from breaking COE")
8452a05b2c63 ("net: stmmac: Tx coe sw fallback")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c2945c435c999c63e47f337bc7c13c98c21d0bcc Mon Sep 17 00:00:00 2001
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 16 Jan 2024 13:19:17 +0100
Subject: [PATCH] net: stmmac: Prevent DSA tags from breaking COE

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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

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


