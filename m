Return-Path: <stable+bounces-217601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CBqO/DXmGnJNQMAu9opvQ
	(envelope-from <stable+bounces-217601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 22:53:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E09416B129
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 22:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D536C303CC06
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 21:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6605930E824;
	Fri, 20 Feb 2026 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2piBnNs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D77309DB1
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771624416; cv=none; b=LHanLQymY11obBnYoRT9cOoVeJi7rhFmcx84fw/WREYdI+NpeVKYldQlKWCURg38NCNlEj1H4NQvSQLRVPFOhaj/ai0HxbW1UecZXoyK9ZhYIXrbN9dIBj6cw9GUiUK/MvIay1hQ7CeM30lqxleNIF5pYp+HgBM/50fTlCrfhXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771624416; c=relaxed/simple;
	bh=2W8xM0Ob3ienbz8oe2WhVPLywE7WqUXP/3asHzkIZ0E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eVKHJitpYbYV9+L/JXTJKxUrC37MP0l033tBeT6WtprOgkYV8paWZYeI7i2Xd1EwqFVR2m4LlrP3fUZlnFwWHhBB2Gd9c3IUeReidRMOEcJvKs6COczJtRwG9tFXV6dadhQd7bPOy3/PiaXMBcze4p64F1gbJz+TQ8wff36aCog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2piBnNs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a7a98ba326so39123985ad.1
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 13:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771624414; x=1772229214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zNnXU2rQFrrZwDNDExXkVvTwmDaf1Rl3je1sHwkbBVo=;
        b=W2piBnNs4xXjKoJ7PPq7PtHE8SRKTGVZaimudBR7dtj0drfTG3jxsykvbGBd+/jF6e
         kYHnU83VozqSHRw9lF87DvTQTGstucIqsyxRIvlDOb3I1MZCdavRS1grdrQp+E9ZJZnB
         3DsDXRTb8SOu1EPL3PR/hF8gYBq8fEZttps2YcYLrCEPd7ZM5xkV+acYIW4NTBMclWXg
         o9UEckqB1ASLxD45m1pX7j3T2wb0iWqqe1NvTSM0IQdmzdFgRCysTnMrTIRZ6ssAErZG
         1J5pHm6dOqIjNCNTDPjo8XG885CDN9KSX8GR73NAOi+m7xUpptcpEDBm/h1L968mKosA
         RETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771624414; x=1772229214;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNnXU2rQFrrZwDNDExXkVvTwmDaf1Rl3je1sHwkbBVo=;
        b=dF2H6Bktg2lrAMPMtntDtTuyYzv5NHDH7A5ACsB13yc22KBt/Ok2LTLQ7syp1Xzp9K
         YmMSy3HlAPpWILeiYzC8Sj7ASRnTMFp86b/eyF9jYVk53XtW0zp8OTkbhceJbmWYzPft
         U6bROjHeyWHUfDVmT3mYMWa3iIDAjQL+n99Jof/toTFadaFJaPwWfFK/h2d3JWbjNabA
         bV+Umi/JW92pVtu20sFvQgk3Tbj1KytFFxCWRKHvnH9BLKPChFQwEK0tZnFhR0lQWnR7
         /bpOf624G0BNPEJYmrUkxVGR9ShhJ9w6/cnUxhGLjHloBlhtCv4tDt87cZCK2EWpVmVc
         CuUg==
X-Forwarded-Encrypted: i=1; AJvYcCWwLyMDbczgjAN2C668eTD0O+P1v35Ldrw/gYHtSEz1SnL/5JXNlRNxwiOXH5WeEVSWlrDM5SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJmwJ+t6nt8qL1V9V4ThrVtoXFIMOE42MBxhe6HCqqKMT29g7U
	1Cq5pUNJTGRHqnsLgc/TgMiB0u9EZyE2exNXjPPP1XCorVJX76HVjRVWaunyAwssJnyHn4FyvgO
	q+Bpb5otwWMl4JQ==
X-Received: from pglc4.prod.google.com ([2002:a63:d04:0:b0:c6e:1f6a:ef71])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:b45:b0:2a0:9934:a3f3 with SMTP id d9443c01a7336-2ad5f7a4e05mr59737705ad.24.1771624413654;
 Fri, 20 Feb 2026 13:53:33 -0800 (PST)
Date: Fri, 20 Feb 2026 13:53:24 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260220215324.1631350-1-joshwash@google.com>
Subject: [PATCH net v2] gve: fix incorrect buffer cleanup in
 gve_tx_clean_pending_packets for QPL
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Rushil Gupta <rushilg@google.com>, Bailey Forrest <bcf@google.com>, linux-kernel@vger.kernel.org, 
	Ankit Garg <nktgrg@google.com>, stable@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217601-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E09416B129
X-Rspamd-Action: no action

From: Ankit Garg <nktgrg@google.com>

In DQ-QPL mode, gve_tx_clean_pending_packets() incorrectly uses the RDA
buffer cleanup path. It iterates num_bufs times and attempts to unmap
entries in the dma array.

This leads to two issues:
1. The dma array shares storage with tx_qpl_buf_ids (union).
 Interpreting buffer IDs as DMA addresses results in attempting to
 unmap incorrect memory locations.
2. num_bufs in QPL mode (counting 2K chunks) can significantly exceed
 the size of the dma array, causing out-of-bounds access warnings
(trace below is how we noticed this issue).

UBSAN: array-index-out-of-bounds in
drivers/net/ethernet/drivers/net/ethernet/google/gve/gve_tx_dqo.c:178:5 index 18 is out of
range for type 'dma_addr_t[18]' (aka 'unsigned long long[18]')
Workqueue: gve gve_service_task [gve]
Call Trace:
<TASK>
dump_stack_lvl+0x33/0xa0
__ubsan_handle_out_of_bounds+0xdc/0x110
gve_tx_stop_ring_dqo+0x182/0x200 [gve]
gve_close+0x1be/0x450 [gve]
gve_reset+0x99/0x120 [gve]
gve_service_task+0x61/0x100 [gve]
process_scheduled_works+0x1e9/0x380

Fix this by properly checking for QPL mode and delegating to
gve_free_tx_qpl_bufs() to reclaim the buffers.

Cc: stable@vger.kernel.org
Fixes: a6fb8d5a8b69 ("gve: Tx path for DQO-QPL")
Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
Changes in v2:
* Moved gve_unmap_packet up instead of forward declaration
  (Jakub Kicinski)
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 56 ++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 40b89b3e..e5e33966 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -167,6 +167,25 @@ gve_free_pending_packet(struct gve_tx_ring *tx,
 	}
 }
 
+static void gve_unmap_packet(struct device *dev,
+			     struct gve_tx_pending_packet_dqo *pkt)
+{
+	int i;
+
+	if (!pkt->num_bufs)
+		return;
+
+	/* SKB linear portion is guaranteed to be mapped */
+	dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
+			 dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
+	for (i = 1; i < pkt->num_bufs; i++) {
+		netmem_dma_unmap_page_attrs(dev, dma_unmap_addr(pkt, dma[i]),
+					    dma_unmap_len(pkt, len[i]),
+					    DMA_TO_DEVICE, 0);
+	}
+	pkt->num_bufs = 0;
+}
+
 /* gve_tx_free_desc - Cleans up all pending tx requests and buffers.
  */
 static void gve_tx_clean_pending_packets(struct gve_tx_ring *tx)
@@ -176,21 +195,12 @@ static void gve_tx_clean_pending_packets(struct gve_tx_ring *tx)
 	for (i = 0; i < tx->dqo.num_pending_packets; i++) {
 		struct gve_tx_pending_packet_dqo *cur_state =
 			&tx->dqo.pending_packets[i];
-		int j;
-
-		for (j = 0; j < cur_state->num_bufs; j++) {
-			if (j == 0) {
-				dma_unmap_single(tx->dev,
-					dma_unmap_addr(cur_state, dma[j]),
-					dma_unmap_len(cur_state, len[j]),
-					DMA_TO_DEVICE);
-			} else {
-				dma_unmap_page(tx->dev,
-					dma_unmap_addr(cur_state, dma[j]),
-					dma_unmap_len(cur_state, len[j]),
-					DMA_TO_DEVICE);
-			}
-		}
+
+		if (tx->dqo.qpl)
+			gve_free_tx_qpl_bufs(tx, cur_state);
+		else
+			gve_unmap_packet(tx->dev, cur_state);
+
 		if (cur_state->skb) {
 			dev_consume_skb_any(cur_state->skb);
 			cur_state->skb = NULL;
@@ -1160,22 +1170,6 @@ static void remove_from_list(struct gve_tx_ring *tx,
 	}
 }
 
-static void gve_unmap_packet(struct device *dev,
-			     struct gve_tx_pending_packet_dqo *pkt)
-{
-	int i;
-
-	/* SKB linear portion is guaranteed to be mapped */
-	dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
-			 dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
-	for (i = 1; i < pkt->num_bufs; i++) {
-		netmem_dma_unmap_page_attrs(dev, dma_unmap_addr(pkt, dma[i]),
-					    dma_unmap_len(pkt, len[i]),
-					    DMA_TO_DEVICE, 0);
-	}
-	pkt->num_bufs = 0;
-}
-
 /* Completion types and expected behavior:
  * No Miss compl + Packet compl = Packet completed normally.
  * Miss compl + Re-inject compl = Packet completed normally.
-- 
2.53.0.335.g19a08e0c02-goog


