Return-Path: <stable+bounces-241079-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLBWO/QJ7GnDTwAAu9opvQ
	(envelope-from <stable+bounces-241079-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:25:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3C24643A3
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 02:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A94DD300DF49
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B71C146588;
	Sat, 25 Apr 2026 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEPkCYZq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57AE1CBEB9
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777076700; cv=none; b=aJNUuqcZFOukXxHRAU43mMegaHyxPN86zou6+kMwkTAxc5TKafPtynQr7KRcv/JPqgrTSgVRBh/wplP+tI7ARJ24vIS75WScUvLDGcpsq/+R8zf6iwBi7aP2FwGlZZvG/3nFap8TN5AKH4HxAlDw50gl/Rb6BscVwRQsScWlhlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777076700; c=relaxed/simple;
	bh=yekA/fLC52CZh9ofH4e0iJWuXm6tLedi58HlqbuGCuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A1jt/tJS8Z2MypWFN9Lb/xy8t2Ti0nUdb7yCkS7/Jn74/Jd14vH5ylyLr+aynRU3M1kXRhRUbDkA12FgDHVEL8thdjJXvYL1otqe8xdQk1/j5FgJRPaX7XbwKGxADvyL7wuJyM0tUR1obrpwv53LA/4+3xCRMBSP6sHGHjdDgSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEPkCYZq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4654f9bb6so87716545ad.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 17:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777076698; x=1777681498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4wiJYfQEx2I1gNyVCcAbOWCRuneaP+oLGnQ3LZHljgU=;
        b=YEPkCYZq31Up7koIQC+qwbubEd2KlrTvE8x8ow1BYsqgVnXM2SCxJ/1o7A5VFbBoFx
         GKUJGfh5ZnYSSpdW7rZEc6T87wDL5h6VQ77Alrr7yxFes7Qk01tQOmnrwufxoH5Ugzcy
         eu440yPJ58ZINEBDRNB1+g8QooqilJwLNXM6SB9YXdwgOZ1JXSFOjtZRZ+/yaEz9aYAa
         Kv1jyzLskLpSARJQsLGDqvEWRI6A1SZ0J0zmxPPfxSAH3Nbh6HaHBmFPo+ZVc+nZQJ38
         Zp5e1mxEGF0rfZ0jyIKihj2NkcBk3AZfO9/oivuOQ9BKXWM0HAdGlRwGsVGFUtyvZMOS
         o3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777076698; x=1777681498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wiJYfQEx2I1gNyVCcAbOWCRuneaP+oLGnQ3LZHljgU=;
        b=d8BNtcT3l9SwIZ+Et+lzk9zkYxB3KBOOtKZtS+4O7zRZ2JuLvNJqFJWan5nSsCwk06
         PSxf056xYdQDKbh1kdrlin6xzzbGfsRwtYU2F9WLslnV+il6bBRon/NNJdOTAd5SVsMD
         rm6qBc4qeayc9+Uamm+5AY/KTteMdPo78LepgHbwEMuD2AQ3/5QjlTsSQM7guqMuF3hB
         c6c071kkpKsBTOM51jX9odgChsxNwfxSe2Cg1qStmuUrevQ1Zc3SwuMEyKjhJddlLXXh
         y6rHGx13k2Sgt56zG1OB4ll3rOVVFOeEpINKTp+m8QRcLCSuwuimmNKaRJy4l6dq07Hq
         r9Gw==
X-Forwarded-Encrypted: i=1; AFNElJ/hpGUWKeE6wlPWdYHfZ3yX248YcdFGgRjPATGE+caXx5UiagN/SyNQzcIbqN41N+As5NABC28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfQzcyAPBEgqx10/8l53E0/IIKthzR/mh0VNtif5DRhGkfBGGC
	r2YEVqmNuxtAmFYoDBtz7BTCjqsvB1mr+IFR388tt4SSfc6B7wKSPmkLQtObDEZTpnCeXdOoyXE
	yTOrlHqGXxXYJLLVelGO1lbFlyQ==
X-Received: from plsa9.prod.google.com ([2002:a17:902:b589:b0:2b2:5616:36aa])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1aac:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2b5f9d69075mr306727115ad.0.1777076697866;
 Fri, 24 Apr 2026 17:24:57 -0700 (PDT)
Date: Sat, 25 Apr 2026 00:24:48 +0000
In-Reply-To: <20260425002450.163421-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425002450.163421-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425002450.163421-3-hramamurthy@google.com>
Subject: [PATCH net v2 2/4] gve: Fix backward stats when interface goes down
 or configuration is adjusted
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Debarghya Kundu <debarghyak@google.com>, 
	Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AD3C24643A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241079-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Debarghya Kundu <debarghyak@google.com>

gve_get_base_stats() sets all the stats to 0, so the stats go backwards
when interface goes down or configuration is adjusted.

Fix this by persisting baseline stats across interface down.

Cc: stable@vger.kernel.org
Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Co-developed-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
Changes in v2:
- Add a NULL pointer check in gve_get_ring_err_stats() (Sashiko)
- Use local variable to prevent inflates from u64_stats_fetch_retry()
  (Sashiko)
- Add u64_stats_fetch/begin to protect base stats (Sashiko)

 drivers/net/ethernet/google/gve/gve.h      |  7 ++
 drivers/net/ethernet/google/gve/gve_main.c | 88 ++++++++++++++++++++--
 2 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 1d66d3834f7e..702b1641d984 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -794,6 +794,10 @@ struct gve_ptp {
 	struct gve_priv *priv;
 };
 
+struct gve_ring_err_stats {
+	u64 rx_alloc_fails;
+};
+
 struct gve_priv {
 	struct net_device *dev;
 	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
@@ -883,6 +887,9 @@ struct gve_priv {
 	unsigned long service_task_flags;
 	unsigned long state_flags;
 
+	struct gve_ring_err_stats base_ring_err_stats;
+	struct rtnl_link_stats64 base_net_stats;
+	struct u64_stats_sync base_statss; /* sync stats for 32bit archs */
 	struct gve_stats_report *stats_report;
 	u64 stats_report_len;
 	dma_addr_t stats_report_bus; /* dma address for the stats report */
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index ef00d9ca1643..1fec8e1e4821 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -106,9 +106,34 @@ static netdev_tx_t gve_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		return gve_tx_dqo(skb, dev);
 }
 
-static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
+static void gve_add_base_stats(struct gve_priv *priv,
+			       struct rtnl_link_stats64 *s)
+{
+	struct rtnl_link_stats64 *base_stats = &priv->base_net_stats;
+	unsigned int start;
+	u64 rx_packets, rx_bytes, rx_dropped, tx_packets, tx_bytes, tx_dropped;
+
+	do {
+		start = u64_stats_fetch_begin(&priv->base_statss);
+		rx_packets = base_stats->rx_packets;
+		rx_bytes = base_stats->rx_bytes;
+		rx_dropped = base_stats->rx_dropped;
+		tx_packets = base_stats->tx_packets;
+		tx_bytes = base_stats->tx_bytes;
+		tx_dropped = base_stats->tx_dropped;
+	} while (u64_stats_fetch_retry(&priv->base_statss, start));
+
+	s->rx_packets += rx_packets;
+	s->rx_bytes += rx_bytes;
+	s->rx_dropped += rx_dropped;
+	s->tx_packets += tx_packets;
+	s->tx_bytes += tx_bytes;
+	s->tx_dropped += tx_dropped;
+}
+
+static void gve_get_ring_stats(struct gve_priv *priv,
+			       struct rtnl_link_stats64 *s)
 {
-	struct gve_priv *priv = netdev_priv(dev);
 	unsigned int start;
 	u64 packets, bytes;
 	int num_tx_queues;
@@ -143,6 +168,14 @@ static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
 	}
 }
 
+static void gve_get_stats(struct net_device *dev, struct rtnl_link_stats64 *s)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+
+	gve_get_ring_stats(priv, s);
+	gve_add_base_stats(priv, s);
+}
+
 static int gve_alloc_flow_rule_caches(struct gve_priv *priv)
 {
 	struct gve_flow_rules_cache *flow_rules_cache = &priv->flow_rules_cache;
@@ -1533,6 +1566,29 @@ static int gve_queues_stop(struct gve_priv *priv)
 	return gve_reset_recovery(priv, false);
 }
 
+static void gve_get_ring_err_stats(struct gve_priv *priv,
+				   struct gve_ring_err_stats *err_stats)
+{
+	int ring;
+
+	if (!priv->rx)
+		return;
+
+	for (ring = 0; ring < priv->rx_cfg.num_queues; ring++) {
+		struct gve_rx_ring *rx = &priv->rx[ring];
+		unsigned int start;
+		u64 rx_alloc_fails;
+
+		do {
+			start = u64_stats_fetch_begin(&rx->statss);
+			rx_alloc_fails = rx->rx_skb_alloc_fail +
+					 rx->rx_buf_alloc_fail;
+		} while (u64_stats_fetch_retry(&rx->statss, start));
+
+		err_stats->rx_alloc_fails += rx_alloc_fails;
+	}
+}
+
 static int gve_close(struct net_device *dev)
 {
 	struct gve_priv *priv = netdev_priv(dev);
@@ -1542,6 +1598,12 @@ static int gve_close(struct net_device *dev)
 	if (err)
 		return err;
 
+	/* Save ring queue and err stats before closing the interface */
+	u64_stats_update_begin(&priv->base_statss);
+	gve_get_ring_stats(priv, &priv->base_net_stats);
+	gve_get_ring_err_stats(priv, &priv->base_ring_err_stats);
+	u64_stats_update_end(&priv->base_statss);
+
 	gve_queues_mem_remove(priv);
 	return 0;
 }
@@ -2784,12 +2846,24 @@ static void gve_get_base_stats(struct net_device *dev,
 			       struct netdev_queue_stats_rx *rx,
 			       struct netdev_queue_stats_tx *tx)
 {
-	rx->packets = 0;
-	rx->bytes = 0;
-	rx->alloc_fail = 0;
+	const struct gve_ring_err_stats *base_err_stats;
+	const struct rtnl_link_stats64 *base_stats;
+	struct gve_priv *priv;
+	unsigned int start;
 
-	tx->packets = 0;
-	tx->bytes = 0;
+	priv = netdev_priv(dev);
+	base_stats = &priv->base_net_stats;
+	base_err_stats = &priv->base_ring_err_stats;
+
+	do {
+		start = u64_stats_fetch_begin(&priv->base_statss);
+		rx->packets = base_stats->rx_packets;
+		rx->bytes = base_stats->rx_bytes;
+		rx->alloc_fail = base_err_stats->rx_alloc_fails;
+
+		tx->packets = base_stats->tx_packets;
+		tx->bytes = base_stats->tx_bytes;
+	} while (u64_stats_fetch_retry(&priv->base_statss, start));
 }
 
 static const struct netdev_stat_ops gve_stat_ops = {
-- 
2.54.0.545.g6539524ca2-goog


