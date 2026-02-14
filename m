Return-Path: <stable+bounces-216311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFwXF/i9j2niTAEAu9opvQ
	(envelope-from <stable+bounces-216311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:12:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD47413A1F3
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24891301FA80
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 00:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FDF13C8E8;
	Sat, 14 Feb 2026 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8zzbYU9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F2145B3F
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 00:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771027953; cv=none; b=Bq5qTgZ4c1ct36R/B09E2fqRD3btIz1CJmEuPUPoSO46D5yrjp5UZdzJzpVBuucQc5oUYN45jsPgJzqGwkan1Pep5YC3UXWgC/9f7qPK+KNyb2Yh90qyhH8y4Mi/zxfqoUMQwN+NJus224mM+5BkVTMgnC1HoiaxFP8BB7virmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771027953; c=relaxed/simple;
	bh=aBiHy1g5Xkc5IxdeCktMrrpGsFp7xUT4c0xxkiTjR9I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FSrA6Vhp44p79fK1lgrh1YUApimetwbTLTlVcJB7d+e3m4I78/TqttwCA8OpyyoK6VQI2fxwsIixoDkLZmoasDXqPVc0HKb0jshVH0jVcGFXoQouMNHxD3obzIFl4QvQqO2U5kv2Bqo1b5VZJ2tnxWWVbpwCwErvdnA8Id0KlQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K8zzbYU9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso1271458a12.1
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 16:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771027950; x=1771632750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/SseZuPVACGvCyr+zfyDhJIPT4Lkz8kZ02Cj7LiP/hw=;
        b=K8zzbYU9+hAD31AsSqII/oDsvF+VT4t2EaZti+P0lZrFDiW6HPhMS8dc1OGauzer14
         gm614zNXU4GvDJvVmOtJu3MYE+ngD0xiRm/0CdesaH24F3POOgf+8qZ+bk9mKbrGvaGX
         0Qf7NqTG6xbYV7+vcPWIID4Gc23FJdPpSmPEkhJWR2I3dzBJC20pKbBNg8amB/U4Qe4/
         tIOK4TJk0wVuxOFfesnikc39KkvUqE6Z2q7KTS8ktl6i+6AywhfVdx+jxzua4gd4B4b7
         aDHhj8/U1y9x32pbN7Zm8/2laQRrcEdQKqxIXqXfcteBxNQAJMWV2qfqJiy6FgH9w07Z
         XugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771027950; x=1771632750;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/SseZuPVACGvCyr+zfyDhJIPT4Lkz8kZ02Cj7LiP/hw=;
        b=RFOpvxznAfzEcFqLI0yqvrIlsHilegDnbcT21+bIN/wymHv671e12EkTE1jJmLDA5D
         l0vvSdh0ZCu+7cBg25gHlMIIXa9gJ/+AtvTrw+eFiRtXB5b/xwqcNKtuUzhTYf0UUQvS
         A8pB9nv/urlt/IjUUrho4QPQxdw0BzaStAT93D6V5ljGzzsbq6sHhjnJP8j7qbfCSc8Q
         6L7oRB0SFVNMX3WQUdC3js4XJJxF7arlQHmoCbRzN3OCu6Tfe6EiVVshci/b667si84o
         sD8Co22aaom8LLlcCfyvp/uU7uSgAuQGN7qCZSopuJ8fr3FWa6C9Vwi4MOUJ+dldREG+
         ahEg==
X-Forwarded-Encrypted: i=1; AJvYcCX14UYi03YxKVF8UX9Vn3Tfm07ZayZ8NjUvtiBxM3G0/z6NyshMwOq/DIIbna+TRgcHyRtQb0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfWo4Arsn/chPkeLBhVhvUp25oal4vbWX7lF1gGUyMHqRoURCk
	9tgyis3y/MHfh9vMdc2YkRmqvYBvktu5cYB/f5hMv0smakYF0fB9RgHaevdFMXotjxVQ9HZQKaS
	1phYhMT5V2jpNAg==
X-Received: from pgbfe12.prod.google.com ([2002:a05:6a02:288c:b0:c64:8fdc:63f7])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:e598:b0:38d:fa67:e87f with SMTP id adf61e73a8af0-394837805a6mr901084637.12.1771027949947;
 Fri, 13 Feb 2026 16:12:29 -0800 (PST)
Date: Fri, 13 Feb 2026 16:12:26 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260214001226.744193-1-joshwash@google.com>
Subject: [PATCH net] gve: fix incorrect buffer cleanup in gve_tx_clean_pending_packets
 for QPL
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216311-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD47413A1F3
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
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 40b89b3e..6a31cb49 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -167,6 +167,9 @@ gve_free_pending_packet(struct gve_tx_ring *tx,
 	}
 }
 
+static void gve_unmap_packet(struct device *dev,
+			     struct gve_tx_pending_packet_dqo *pkt);
+
 /* gve_tx_free_desc - Cleans up all pending tx requests and buffers.
  */
 static void gve_tx_clean_pending_packets(struct gve_tx_ring *tx)
@@ -176,21 +179,12 @@ static void gve_tx_clean_pending_packets(struct gve_tx_ring *tx)
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
@@ -1165,6 +1159,9 @@ static void gve_unmap_packet(struct device *dev,
 {
 	int i;
 
+	if (!pkt->num_bufs)
+		return;
+
 	/* SKB linear portion is guaranteed to be mapped */
 	dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
 			 dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
-- 
2.53.0.273.g2a3d683680-goog


