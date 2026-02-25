Return-Path: <stable+bounces-219477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JKCCM+gnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:12:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DEA19315D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACAA231F4C60
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235B53161BF;
	Wed, 25 Feb 2026 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ey/smgcA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A22D23A4;
	Wed, 25 Feb 2026 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002741; cv=none; b=E1sJvSozmr+Wdz6cunmX04io+cqKcWNnNFp9h1eJcCKPmHnckCadOJiJ8W1CA9K2X/XWLc3g2iksyuQBNRkSe3bnGGPU301dQ1xdYN9b/mf7fzS1+MixRqCmQI9ZXAfd/78DJbFPJS/AzgEcJIPu6+z5RYMK74/nbGCNK0lj/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002741; c=relaxed/simple;
	bh=C7ar17SO6TzNruO+fWF5tYnscp/gTLKzWnDGjVMq3/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2dB8XDXvMRPYo7wJIpA+r0tudqxK5+wvKQYf1PV+3a4Oe1+yo/26+hXPuDiZih+RKmcesevByjYwfZLMaCEGFJQmwIDWmgeKyuhIu5/nJqpKZvupOEhK4efkbv4A0Wz04T9PwXJ40NB4dEO5iKHsZPVgNWQ2QXqqdu/OZ5I2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ey/smgcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AB8C19422;
	Wed, 25 Feb 2026 06:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002741;
	bh=C7ar17SO6TzNruO+fWF5tYnscp/gTLKzWnDGjVMq3/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ey/smgcAGM673xwkeWVDdVikGFGny+ixGWlJjEOx3EILk3hAIQeQBQefRCXw4QlRB
	 ZUOt/oDXkbs0ggFdIBoweTokpFfetIq27R5hL+dbeRP3ACIbjMqexiUZpBwmBwIAA5
	 r1EbvJo3TglpP1KgXn9k4x/CDmd87fBTT+MiVLLI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 519/641] net: mscc: ocelot: extract ocelot_xmit_timestamp() helper
Date: Tue, 24 Feb 2026 17:24:05 -0800
Message-ID: <20260225012401.103046922@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219477-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[northwestern.edu:email,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 74DEA19315D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

[ Upstream commit 29372f07f7969a2f0490793226ecf6c8c6bde0fa ]

Extract the PTP timestamp handling logic from ocelot_port_xmit() into a
separate ocelot_xmit_timestamp() helper function. This is a pure
refactor with no behavioral change.

The helper returns false if the skb was consumed (freed) due to a
timestamp request failure, and true if the caller should continue with
frame injection. The rew_op value is returned via pointer.

This prepares for splitting ocelot_port_xmit() into separate FDMA and
register injection paths in a subsequent patch.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20260208225602.1339325-2-n7l8m4@u.northwestern.edu
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 026f6513c588 ("net: mscc: ocelot: add missing lock protection in ocelot_port_xmit_inj()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mscc/ocelot_net.c | 36 ++++++++++++++++----------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index 469784d3a1a67..ef4a6c768de9b 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -551,33 +551,41 @@ static int ocelot_port_stop(struct net_device *dev)
 	return 0;
 }
 
-static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
+static bool ocelot_xmit_timestamp(struct ocelot *ocelot, int port,
+				  struct sk_buff *skb, u32 *rew_op)
 {
-	struct ocelot_port_private *priv = netdev_priv(dev);
-	struct ocelot_port *ocelot_port = &priv->port;
-	struct ocelot *ocelot = ocelot_port->ocelot;
-	int port = priv->port.index;
-	u32 rew_op = 0;
-
-	if (!static_branch_unlikely(&ocelot_fdma_enabled) &&
-	    !ocelot_can_inject(ocelot, 0))
-		return NETDEV_TX_BUSY;
-
-	/* Check if timestamping is needed */
 	if (ocelot->ptp && (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
 		struct sk_buff *clone = NULL;
 
 		if (ocelot_port_txtstamp_request(ocelot, port, skb, &clone)) {
 			kfree_skb(skb);
-			return NETDEV_TX_OK;
+			return false;
 		}
 
 		if (clone)
 			OCELOT_SKB_CB(skb)->clone = clone;
 
-		rew_op = ocelot_ptp_rew_op(skb);
+		*rew_op = ocelot_ptp_rew_op(skb);
 	}
 
+	return true;
+}
+
+static netdev_tx_t ocelot_port_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct ocelot_port_private *priv = netdev_priv(dev);
+	struct ocelot_port *ocelot_port = &priv->port;
+	struct ocelot *ocelot = ocelot_port->ocelot;
+	int port = priv->port.index;
+	u32 rew_op = 0;
+
+	if (!static_branch_unlikely(&ocelot_fdma_enabled) &&
+	    !ocelot_can_inject(ocelot, 0))
+		return NETDEV_TX_BUSY;
+
+	if (!ocelot_xmit_timestamp(ocelot, port, skb, &rew_op))
+		return NETDEV_TX_OK;
+
 	if (static_branch_unlikely(&ocelot_fdma_enabled)) {
 		ocelot_fdma_inject_frame(ocelot, port, rew_op, skb, dev);
 	} else {
-- 
2.51.0




