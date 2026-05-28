Return-Path: <stable+bounces-255816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDNyCPWmGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:35:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FA05F903F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6546304D702
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED053016E0;
	Thu, 28 May 2026 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s6LKPfIb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C3254B1F;
	Thu, 28 May 2026 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999960; cv=none; b=uLjknmTtTIS4Ih1tyh9nOWI0zEEZmYewmS8I0uEGK0IMq6Qxs0e3ThsDHC42kTQiyu3tx8B49iOC5LY+LEU3JmRFV1KHo3d+XPTL39C9nPRYBuMEwok9eoeTaPZ7fKtgLj7u2LdzgZIKgkbRbCJK9zJ6zh/NUjIeethUC8+hFDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999960; c=relaxed/simple;
	bh=aP37UI3dDpFI07qL/ddMv613bJH3/2PI3c6xHGiyYRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdmqpwzgqFKsZ4c3KMthFNt2Y0ZT4AtrkgxUXacRFkDGORMWC8zcTZeG5fzTrFn4p7TSvLBF4++tfizUofV2+4MJuuTqAwxH0+WZBgVIqYhHrVhldAgQZfmxzW64T1GIjReZcwJYaIWQQMyzsCJ1eoFrn7rqdJQp4mXQ5gY4UI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s6LKPfIb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979301F000E9;
	Thu, 28 May 2026 20:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999959;
	bh=0C4dwnY/xoG9Tb6zpEf+hyS1LQsrBbDS5A+5lWZxR/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s6LKPfIbP0CeWCvK9VWW2xuXwodbqeEeZmedwYYfknqZfftTnOAxXo1w+GCA6Xr1D
	 kHLz3tW5jUAf8+dfmMonyEGHvwwIu+FD0GUTkKGAF7WIYFH3+Enz5DrxTpI8brbvEm
	 p/W0Ug/ZadngtScol2YbQoL2Z2GjNh2+MuZ3H094=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Walleij <linusw@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 252/377] net: ethernet: cortina: Carry over frag counter
Date: Thu, 28 May 2026 21:48:10 +0200
Message-ID: <20260528194645.672628078@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255816-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,sashiko.dev:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 71FA05F903F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linusw@kernel.org>

[ Upstream commit ebd8ec2b309e3a447851b456ccaf8fb39f3661e7 ]

The gmac_rx() NAPI poll function assembles packets in an
SKB from a ring buffer.

If the ring buffer gets completely emptied during a poll cycle,
we exit gmac_rx(), but the packet is not yet completely
assembled in the SKB, yet the fragment counter frag_nr is
reset to zero on the next invocation.

Solve this by making the RX fragment counter a part of the
port struct, and carry it over between invocations.

Reset the fragment counter only right after calling
napi_gro_frags(), on error (after calling napi_free_frags())
or if stopping the port.

Reset it in some place where not strictly necessary just to
emphasize what is going on.

This was found by Sashiko during normal patch review.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Link: https://sashiko.dev/#/patchset/20260505-gemini-ethernet-fix-v2-1-997c31d06079%40kernel.org
Signed-off-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260509-gemini-ethernet-fixes-v1-3-6c5d20ddc35b@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 63f444e13d6f2..40bec34f06a7b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -123,6 +123,7 @@ struct gemini_ethernet_port {
 	struct hrtimer		rx_coalesce_timer;
 	unsigned int		rx_coalesce_nsecs;
 	struct sk_buff		*rx_skb;
+	unsigned int		rx_frag_nr;
 
 	unsigned int		freeq_refill;
 	struct gmac_txq		txq[TX_QUEUE_NUM];
@@ -1445,6 +1446,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	unsigned short m = (1 << port->rxq_order) - 1;
 	struct gemini_ethernet *geth = port->geth;
 	void __iomem *ptr_reg = port->rxq_rwptr;
+	unsigned int frag_nr = port->rx_frag_nr;
 	struct sk_buff *skb = port->rx_skb;
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
@@ -1458,7 +1460,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	unsigned short r, w;
 	union dma_rwptr rw;
 	dma_addr_t mapping;
-	int frag_nr = 0;
 
 	spin_lock_irqsave(&geth->irq_lock, flags);
 	rw.bits32 = readl(ptr_reg);
@@ -1498,6 +1499,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 				napi_free_frags(&port->napi);
 				port->stats.rx_dropped++;
 				skb = NULL;
+				frag_nr = 0;
 			}
 			continue;
 		}
@@ -1508,6 +1510,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 				napi_free_frags(&port->napi);
 				port->stats.rx_dropped++;
 				skb = NULL;
+				frag_nr = 0;
 			}
 
 			skb = gmac_skb_if_good_frame(port, word0, frame_len);
@@ -1542,6 +1545,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 		if (word3.bits32 & EOF_BIT) {
 			napi_gro_frags(&port->napi);
 			skb = NULL;
+			frag_nr = 0;
 			--budget;
 		}
 		continue;
@@ -1550,6 +1554,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 		if (skb) {
 			napi_free_frags(&port->napi);
 			skb = NULL;
+			frag_nr = 0;
 		}
 
 		if (mapping)
@@ -1559,6 +1564,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	}
 
 	port->rx_skb = skb;
+	port->rx_frag_nr = frag_nr;
 	writew(r, ptr_reg);
 	return budget;
 }
@@ -1887,6 +1893,7 @@ static int gmac_stop(struct net_device *netdev)
 	gmac_stop_dma(port);
 	napi_disable(&port->napi);
 	port->rx_skb = NULL;
+	port->rx_frag_nr = 0;
 
 	gmac_enable_irq(netdev, 0);
 	gmac_cleanup_rxq(netdev);
-- 
2.53.0




