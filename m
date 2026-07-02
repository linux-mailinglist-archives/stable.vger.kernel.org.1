Return-Path: <stable+bounces-270566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5E39FSKGRmpPXwsAu9opvQ
	(envelope-from <stable+bounces-270566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 17:39:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B496F9844
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 17:39:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=cgWww9OW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270566-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270566-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93EFF302C9EB
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 15:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9DD381E95;
	Thu,  2 Jul 2026 15:37:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C61353A71
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 15:37:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006644; cv=none; b=KMy4lBh6x8j53O1TIidMgx/c3pvAe6Xi0mcBv4OJS/kvCGWsPHb7bGcr8h/pCAo+L+CSeo8bW429cUvg4trkGyHBUNimTZS7mncsC8+9LshIT8M+mIEfkz6ixsFIDJnweFrh+KkiGU9NuOyMhRncpxOvMxbgnRO6Wb53kJzNLXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006644; c=relaxed/simple;
	bh=AIrYhi5OowtDq9G+B94nZBHdwHjATxJ6Q9liZf5as3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Y4Ppy7LJ88Anf2gRu2rAGxQKdtFduv/eg7FkdYRHRjEwGmhvY8df1JUfuuKuyjy1omeC+tPMn4/TlA0pGSb6WnNiUOZi270EpVB/jJvcNnc4N/rAoJkOeUa02Gau2dapOWZSCaUwM4hvRcg+FqADLPR25Dj3gGtgU4m/YFhTTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cgWww9OW; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EEC8E1A0DE7;
	Thu,  2 Jul 2026 15:37:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BFDB65FF03;
	Thu,  2 Jul 2026 15:37:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF14D104C9565;
	Thu,  2 Jul 2026 17:37:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783006637; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=lTA0HpAPorocbxVlyn/m7V1bsvYRqGh8CYfVJvJ2hys=;
	b=cgWww9OWl6A6RPBSxJRSknpPFsoMYFnVRCz/9OI3heR1ex+LDpE6gb+0kyBUGmgPlPOBTZ
	zjEwpJ+QRmqluIFI4X9wbqdQcyH1rsj1h7kVdcVBbMtZPFai9pjFkVy/GqRWkfB7/mjNKL
	V6NaZ6yweBcoSTurE44hBRDwXEd4XqqtZGnEuKzKPJ7OPBrCjQ8w2Om7L8H8yASr01HPIR
	Zda43+ydkTn4QPrY/Oi+p393+1V/NbXdXPulwk1aydIiU8Btoxu4gbVXQeUpyI3OqFaigx
	x6AFkEsgg4Cyd1HBBNV6lDHsKozXffBmyVJXl8uaecCAzg1Bgrku1LTNQpwdDg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 02 Jul 2026 17:37:02 +0200
Subject: [PATCH net v4] net: macb: drop in-flight Tx SKBs on close
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260702-macb-drop-tx-v4-1-1c833eebdbc8@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNSw6CMBCA4auQrh3TlkLBlfcwLmw7SI1S0laiI
 dzdgia+ljOZ75+RBPQWA9lkI/E42GBdlwaxyohuD90RwZo0E055SQXP4XLQCox3PcQbNLVGySW
 nhhYkkd5jY29Lbkc6jGT/XIarOqGOc2g+a22Izt+XpwNbjl998d0fGDBQOWolK2kqYbbKuXi23
 Vq7yxIf+CevfjgHCqWQTcHq2lSm+ef5m5dM/vA8cSO0xCI9r6n65tM0PQCtHESOPwEAAA==
X-Change-ID: 20260423-macb-drop-tx-f9ce72720d05
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jeff Garzik <jeff@garzik.org>, Conor Dooley <conor.dooley@microchip.com>
Cc: Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, stable@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270566-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jeff@garzik.org,m:conor.dooley@microchip.com,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:stable@vger.kernel.org,m:theo.lebrun@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,tipi-net.de:email,atmel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0B496F9844

The MACB driver has since forever leaked the outgoing SKBs that
have not yet been marked as completed. They live in queue->tx_skb
which gets freed without remorse nor checking.

macb_free_consistent() gets called in a few codepaths, but only close will
trigger the added expressions. In macb_open() and macb_alloc_consistent()
failure cases, queues' tx_skb just got allocated and are empty.

Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
Cc: stable@vger.kernel.org
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v4:
- Drop the skb_drop_reason code. No other Ethernet driver does that and
  the reasoning (because our stats are broken) is a bad one.
- Take Rb trailer from Nicolai.
- Drop <hskinnemoen@atmel.com> email that gets rejected.
- Rebase upon latest net/main (d8e8b85a85fe).
- Link to v3: https://patch.msgid.link/20260617-macb-drop-tx-v3-0-d4c7e57d890b@bootlin.com

Changes in v3:
- Drop stats fixing. A proper fix deserves its own net-next refactoring
  series to migrate to netdev_stat_ops (ynltool uAPI), which will come
  in later. We keep the tx_dropped++ because they are safe as every
  other context is disabled when macb_free_consistent() is called.
- Rebased to latest net/main (406e8a651a7b), nothing to report.
- Link to v2: https://patch.msgid.link/20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com

Changes in v2:
- Increment tx_dropped stat once per SKB, not once per frame.
- Reset tx_head & tx_tail to avoid keeping stalled cursors.
- Fix SKB dropped reasons throughout by adding the reason as parameter
  to macb_tx_unmap(). This is a new patch. Then the drop-all-on-close
  fix can use this ability to report we are not consuming SKBs.
- Add increment to stats->tx_dropped on DMA mapping failure and
  tx_error_task. Done as separate patches (3 and 4).
- Rebase upon net/main @ 46f74a3f7d57, nothing to report.
- Link to v1: https://patch.msgid.link/20260424-macb-drop-tx-v1-1-b3ecb787d84d@bootlin.com
---
 drivers/net/ethernet/cadence/macb_main.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index fd282a1700fb..d394f1f43b68 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2668,8 +2668,25 @@ static void macb_free_consistent(struct macb *bp)
 	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		kfree(queue->tx_skb);
-		queue->tx_skb = NULL;
+		if (queue->tx_skb) {
+			unsigned int dropped = 0, tail;
+
+			for (tail = queue->tx_tail; tail != queue->tx_head;
+			     tail++) {
+				if (macb_tx_skb(queue, tail)->skb)
+					dropped++;
+				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0);
+			}
+
+			queue->stats.tx_dropped += dropped;
+			bp->dev->stats.tx_dropped += dropped;
+
+			kfree(queue->tx_skb);
+			queue->tx_skb = NULL;
+		}
+
+		queue->tx_head = 0;
+		queue->tx_tail = 0;
 		queue->tx_ring = NULL;
 		queue->rx_ring = NULL;
 	}

---
base-commit: d8e8b85a85fe21954d303db68034aac4639df88d
change-id: 20260423-macb-drop-tx-f9ce72720d05

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>


