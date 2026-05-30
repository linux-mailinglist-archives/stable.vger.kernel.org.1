Return-Path: <stable+bounces-257872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKShKOUgG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-257872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:39:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2EF61023E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B23CF308ED0A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C02D3403F9;
	Sat, 30 May 2026 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G2RJ15au"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4130E853;
	Sat, 30 May 2026 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162455; cv=none; b=dso23S6gR657MqAocAl+Po0HJuJER5qgmtjwmrmzMpZ3Dr9yj08QQT5ZieL1aW96nl0h18Dctngda26TZlK+qjDmqYrAgTue6f5bS8/YsHR2it5iCErYtwhu+Zy1kyZRbFUI8IRmjpQFJJTIGrA5H1DNFlm47MqLFtZLf5m9gdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162455; c=relaxed/simple;
	bh=AePlaPkjoRMwNjkeFlKlPQdMpxVqG/Pn7tUFkbDlUac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvQ9e2yFRsVUJWbeNDRL3YTgfdST4vsH6lMNK2xT9msCkCK9+N+JBC9bsQfGUDRUMc+/o+CNAdyCjkayzmeoTh+P1PocIUJxWFp5OIW56BESGyOGp/tr7qvYJkUFX1HF5lmlSsQfRb2USTOuC0SJJmoB61MI5Q+EKPKeFMoH1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G2RJ15au; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732F31F00893;
	Sat, 30 May 2026 17:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162454;
	bh=rxmc86KbjSJlEM8D2iYdnqrBn+kncD2DynhOkJh5Fds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G2RJ15au0XPtndJBcR5LheBePw8FBen70jWrIcjDqny5UM/vwezwFgmAUJLI3K4qb
	 VGyAl64glYSf16tAgStmeUShdKsiaAa92rWLRbh4E8zs6H1LgT//47AAS8xdL+sNsA
	 za8rayrmPUTqYVt88jboIQ5tJ0TyVF6MHqR9i+yY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Walleij <linusw@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 926/969] net: ethernet: cortina: Make RX SKB per-port
Date: Sat, 30 May 2026 18:07:30 +0200
Message-ID: <20260530160326.311981516@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257872-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sashiko.dev:url]
X-Rspamd-Queue-Id: 4A2EF61023E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linusw@kernel.org>

[ Upstream commit 06937db21ee311ed07eba47954447245041a982d ]

The SKB used to assemble packets from fragments in gmac_rx()
is static local, but the Gemini has two ethernet ports, meaning
there can be races between the ports on a bad day if a device
is using both.

Make the RX SKB a per-port variable and carry it over between
invocations in the port struct instead.

Zero the pointer once we call napi_gro_frags(), on error (after
calling napi_free_frags()) or if the port is stopped.

Zero it in some place where not strictly necessary just to
emphasize what is going on.

This was found by Sashiko during normal patch review.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Link: https://sashiko.dev/#/patchset/20260505-gemini-ethernet-fix-v2-1-997c31d06079%40kernel.org
Signed-off-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260509-gemini-ethernet-fixes-v1-2-6c5d20ddc35b@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 729a69007ec47..dbfcbdb8d751a 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -121,6 +121,8 @@ struct gemini_ethernet_port {
 	struct napi_struct	napi;
 	struct hrtimer		rx_coalesce_timer;
 	unsigned int		rx_coalesce_nsecs;
+	struct sk_buff		*rx_skb;
+
 	unsigned int		freeq_refill;
 	struct gmac_txq		txq[TX_QUEUE_NUM];
 	unsigned int		txq_order;
@@ -1447,10 +1449,10 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	unsigned short m = (1 << port->rxq_order) - 1;
 	struct gemini_ethernet *geth = port->geth;
 	void __iomem *ptr_reg = port->rxq_rwptr;
+	struct sk_buff *skb = port->rx_skb;
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
 	struct gmac_queue_page *gpage;
-	static struct sk_buff *skb;
 	union gmac_rxdesc_0 word0;
 	union gmac_rxdesc_1 word1;
 	union gmac_rxdesc_3 word3;
@@ -1504,6 +1506,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 			if (skb) {
 				napi_free_frags(&port->napi);
 				port->stats.rx_dropped++;
+				skb = NULL;
 			}
 
 			skb = gmac_skb_if_good_frame(port, word0, frame_len);
@@ -1554,6 +1557,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 		port->stats.rx_dropped++;
 	}
 
+	port->rx_skb = skb;
 	writew(r, ptr_reg);
 	return budget;
 }
@@ -1882,6 +1886,7 @@ static int gmac_stop(struct net_device *netdev)
 	gmac_disable_tx_rx(netdev);
 	gmac_stop_dma(port);
 	napi_disable(&port->napi);
+	port->rx_skb = NULL;
 
 	gmac_enable_irq(netdev, 0);
 	gmac_cleanup_rxq(netdev);
-- 
2.53.0




