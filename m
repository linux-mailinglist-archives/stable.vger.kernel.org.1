Return-Path: <stable+bounces-241733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tLmtGP3y8GnUbQEAu9opvQ
	(envelope-from <stable+bounces-241733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 19:48:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5492648A2C4
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 19:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8370131A5068
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F87327C13;
	Tue, 28 Apr 2026 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tpujZFg8"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AED280037;
	Tue, 28 Apr 2026 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394012; cv=none; b=kduhHVybitUivgPEoRYyjwsWAF/WGSx5w4rN3IlrwcGDHEsiK/bRMEuAnO0AUVebinBbRJKd5OjG/uYsjkQ0lV4nYakNFz70qC42Ul/+IOVwzdOOuJ61WVgrl5mkJeL/mtB/PBKO3PKPOV1gbJeDsjsdz5IztZYkcPxDqgb1qBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394012; c=relaxed/simple;
	bh=dAGm4PiwWs80ZnheUKD2LU5YAlmFHcW8oMdB+VthDOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HsdAV41HCIMvj1FzHCsWWRTkWSNI7ZVNX2biD1azUwZCNAjvBTvTsbVXRYofU84fxSzfAtHnanPESjyhQrihfFqxMBsagsKnsxTbYuzartFFsdLmKj7kn/qDTJ6LO5F9KAdbPTw9AGM0xoqqzVL++jDBzVo41jpWGKaL2+33xmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tpujZFg8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6198F1A3471;
	Tue, 28 Apr 2026 16:33:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F420601D0;
	Tue, 28 Apr 2026 16:33:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFB1E10728F25;
	Tue, 28 Apr 2026 18:33:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777394007; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+0AqFZZvY0X0WypoYom4SAfWrYqe9FmXmaw/Ruojua0=;
	b=tpujZFg8P80/C/0+z6G3WGNUMBqqd6OBU/2f0bUtBrfwu9kUCAupJ15DyHo5htcWXJgFwu
	QJrO6pxRVobTz4UZQFXWsrheAkrB9QerOAUw617WALNUBKV9HzhklPJ2ntOsgVpzr4yVH6
	P0zcZU+JCdf7Vu5yzUB70kSzjPJ6EVaNj/jA4lQcoG4Ld8xJ/6VuevqH49um+zjuvLbDiI
	34rhUJEC67WWFRMPo41ivUIVMzqbT0vRkxAhLbz5aRFRPtfunoP77E0msbkSPFfB7yUJv4
	Yg+6H35lIeS+Az9QtPvgzH9+BDRzeDw0uErmAVT+TQSgGL/vEYQS6YCpmcRQrw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 28 Apr 2026 18:32:57 +0200
Subject: [PATCH net v2 1/4] net: macb: give reasons for Tx SKB kfree
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260428-macb-drop-tx-v2-1-647f5199d8df@bootlin.com>
References: <20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com>
In-Reply-To: <20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Haavard Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>
Cc: Paolo Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 5492648A2C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241733-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Using dev_consume_skb_any() marks the drop reason as SKB_CONSUMED every
time we free a Tx SKB. Instead, replace by SKB_DROP_REASON_NOT_SPECIFIED
when packet has been dropped without sending.

It is not precise but at least differs from SKB_CONSUMED and is used by
many drivers for their error codepaths through dev_kfree_skb_{any,irq}().

Pass a reason around rather than call dev_consume_skb_any() or
dev_kfree_skb_any() because macb_tx_unmap() is called for cleanup in
all cases.

macb_tx_error_task() is made complex because some SKBs encountered have
been successfully sent.

Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a12aa21244e8..9caae1ef52b1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1201,7 +1201,8 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
-static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budget)
+static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb,
+			  int budget, enum skb_drop_reason reason)
 {
 	if (tx_skb->mapping) {
 		if (tx_skb->mapped_as_page)
@@ -1214,7 +1215,7 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budge
 	}
 
 	if (tx_skb->skb) {
-		dev_consume_skb_any(tx_skb->skb);
+		dev_kfree_skb_any_reason(tx_skb->skb, reason);
 		tx_skb->skb = NULL;
 	}
 }
@@ -1297,7 +1298,8 @@ static void macb_tx_error_task(struct work_struct *work)
 	 * Free transmit buffers in upper layer.
 	 */
 	for (tail = queue->tx_tail; tail != queue->tx_head; tail++) {
-		u32	ctrl;
+		enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
+		u32 ctrl;
 
 		desc = macb_tx_desc(queue, tail);
 		ctrl = desc->ctrl;
@@ -1307,7 +1309,10 @@ static void macb_tx_error_task(struct work_struct *work)
 		if (ctrl & MACB_BIT(TX_USED)) {
 			/* skb is set for the last buffer of the frame */
 			while (!skb) {
-				macb_tx_unmap(bp, tx_skb, 0);
+				/* The reason parameter is unused because it
+				 * only matters when skb is valid.
+				 */
+				macb_tx_unmap(bp, tx_skb, 0, SKB_CONSUMED);
 				tail++;
 				tx_skb = macb_tx_skb(queue, tail);
 				skb = tx_skb->skb;
@@ -1326,6 +1331,7 @@ static void macb_tx_error_task(struct work_struct *work)
 				bp->dev->stats.tx_bytes += skb->len;
 				queue->stats.tx_bytes += skb->len;
 				bytes += skb->len;
+				reason = SKB_CONSUMED;
 			}
 		} else {
 			/* "Buffers exhausted mid-frame" errors may only happen
@@ -1339,7 +1345,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
-		macb_tx_unmap(bp, tx_skb, 0);
+		macb_tx_unmap(bp, tx_skb, 0, reason);
 	}
 
 	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
@@ -1458,7 +1464,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 			}
 
 			/* Now we can safely release resources */
-			macb_tx_unmap(bp, tx_skb, budget);
+			macb_tx_unmap(bp, tx_skb, budget, SKB_CONSUMED);
 
 			/* skb is set only for the last buffer of the frame.
 			 * WARNING: at this point skb has been freed by
@@ -2357,7 +2363,11 @@ static unsigned int macb_tx_map(struct macb *bp,
 	for (i = queue->tx_head; i != tx_head; i++) {
 		tx_skb = macb_tx_skb(queue, i);
 
-		macb_tx_unmap(bp, tx_skb, 0);
+		/* The reason parameter is unused, tx_skb->skb has not yet
+		 * been assigned. Parent caller is responsible for freeing
+		 * the SKB.
+		 */
+		macb_tx_unmap(bp, tx_skb, 0, SKB_DROP_REASON_NOT_SPECIFIED);
 	}
 
 	return -ENOMEM;

-- 
2.54.0


