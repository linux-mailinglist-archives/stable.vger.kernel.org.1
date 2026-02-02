Return-Path: <stable+bounces-213097-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KKLDXz+gGk6DgMAu9opvQ
	(envelope-from <stable+bounces-213097-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 20:43:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF397D0A07
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 20:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A67273073F66
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 19:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3232305064;
	Mon,  2 Feb 2026 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSQCeXBB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25263093B6
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061180; cv=none; b=pkLaPJAubEnTKsdSqs/Wa7rggRY0ZyD9BX72rlNtSl3L6k6mXvs0evelhCifFmcZAXufE2J47FI60cH1cR5R/zhD4U0Wa6zrTVY+7MpMzweEh2w0/fyAdsauQ+MU9yWsRywhxOq+Fp3mFEd93Spg7vyFuxF6UbsarL8jKS3gKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061180; c=relaxed/simple;
	bh=n6E9zvFMWoY03F3m73ZI1gx6xlels/hxNGufX6evA1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NpCXVFOepq1OqqQoIXEYF3lNtbZVhyFetiCBSpmdZFZnqTnZSgpLA32HlP9tzA3D0GIupBQpHKJzrbjxeB+f3R9J9cCRgeYNKfjKT2okQIjoKCTyDq4iJ9R2J87MY8tQ9W22u6prcj54ve30Bmyy9DgiKrGrp7I64O4ZJVBf0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSQCeXBB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a8c273332cso127173685ad.1
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 11:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770061178; x=1770665978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sq8UgQHMkDt9URltVgoRQ8Smj0jrcUPq0dpsGS66bCA=;
        b=JSQCeXBBA8DPCXpZzgvVKmiTIwHypuwAr/vKsFpQQUFkLvZHy6F/Pag9l85UAmN7Al
         JcweXrfDTaQmRxyKO0YckBAmQVN0dlpadq5EmeZTTB+32Ln24HXbKKuu268w7vjIjvqn
         bUT+zqLxI8vgfdfsOo/NkvkgaZ14KLV51g/yf5GiG90vRBCBpHrBH6kRET//3alm9LHL
         i0qRq2ousufwcSLd46mNRN08Q2Rntacn/PB+/vyTtzqN+QKJDITTXLEDGkVzWGYR1Djh
         4YYFs4Hdy8qCJesqzgkkjsBm1lSifaExcQt7SN/sCkvPk5nKSG0KpMOmUDsiA0ff5Xry
         tnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770061178; x=1770665978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sq8UgQHMkDt9URltVgoRQ8Smj0jrcUPq0dpsGS66bCA=;
        b=M7PdTKHIMOa8C4O/WGVscyT1A0I0gOHms+LsB0bdFBzOHFLj5VO7hSl079u7WyeoZw
         DyEZUb9pgND8eBxnEi1p8KfDGAfcSiYX5gRHzBsG/28SIKuS7iVBCBYdKx2cpUQMxyyy
         N23alzFNmyrh6Hy4l+76ciRI62c3fqEYNPjUBGq9/1rmkSHDQbjZnih4GMAG7pAvyD1F
         BKBzHg5AiOq7JDAgTLbOA0XbXZCM3VAEjpo1woQBhpRCa28Ygv0GGLQWlJh6tzd0sJse
         ARS+WPnweZC/V8lt09M5O3CputvZlcUtml3IbboLw5fpcXJ6B0Rua+cICl8OaAYPtX31
         4bZg==
X-Forwarded-Encrypted: i=1; AJvYcCU6B0tsfluvvBsD2kz8pKNa+zpMCHyjGtIep45g/jN6bArl3RT20mvqXTInpkZk3M7XV2yHCfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw/VjFeV80KoQhjjE+ObOCY7nrGr+s1B9cAk2XmiPSStnQM9nT
	OaW1xOwzbyLnfTukUsybSwvd4dqLrVn0kr1+ou7FmVIlJsIJ1OQqDMc76LDJPc3xvXG0gdAPTL/
	LlvWXR8wl/3ULF/WBhu7VUKeQzw==
X-Received: from plbjw4.prod.google.com ([2002:a17:903:2784:b0:2a0:f5f5:419d])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4c5:b0:2a9:4c2:e47 with SMTP id d9443c01a7336-2a904c241c5mr61022835ad.56.1770061178166;
 Mon, 02 Feb 2026 11:39:38 -0800 (PST)
Date: Mon,  2 Feb 2026 19:39:25 +0000
In-Reply-To: <20260202193925.3106272-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260202193925.3106272-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260202193925.3106272-3-hramamurthy@google.com>
Subject: [PATCH net 2/2] gve: Correct ethtool rx_dropped calculation
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, ziweixiao@google.com, jordanrhee@google.com, 
	nktgrg@google.com, kuozhao@google.com, yangchun@google.com, 
	awogbemila@google.com, maolson@google.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.com, Max Yuan <maxyuan@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213097-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,vger.kernel.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF397D0A07
X-Rspamd-Action: no action

From: Max Yuan <maxyuan@google.com>

The gve driver's "rx_dropped" statistic, exposed via `ethtool -S`,
incorrectly includes `rx_buf_alloc_fail` counts. These failures
represent an inability to allocate receive buffers, not true packet
drops where a received packet is discarded. This misrepresentation can
lead to inaccurate diagnostics.

This patch rectifies the ethtool "rx_dropped" calculation. It removes
`rx_buf_alloc_fail` from the total and adds `xdp_tx_errors` and
`xdp_redirect_errors`, which represent legitimate packet drops within
the XDP path.

Cc: stable@vger.kernel.org
Fixes: 433e274b8f7b ("gve: Add stats for gve.")
Signed-off-by: Max Yuan <maxyuan@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Matt Olson <maolson@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index f7864ae7..9fd954d1 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -152,10 +152,11 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	u64 tmp_rx_pkts, tmp_rx_hsplit_pkt, tmp_rx_bytes, tmp_rx_hsplit_bytes,
 		tmp_rx_skb_alloc_fail, tmp_rx_buf_alloc_fail,
 		tmp_rx_desc_err_dropped_pkt, tmp_rx_hsplit_unsplit_pkt,
-		tmp_tx_pkts, tmp_tx_bytes;
+		tmp_tx_pkts, tmp_tx_bytes,
+		tmp_xdp_tx_errors, tmp_xdp_redirect_errors;
 	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_unsplit_pkt,
 		rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes,
-		tx_dropped;
+		tx_dropped, xdp_tx_errors, xdp_redirect_errors;
 	int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
 	int stats_idx, stats_region_len, nic_stats_len;
 	struct stats *report_stats;
@@ -199,6 +200,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	for (rx_pkts = 0, rx_bytes = 0, rx_hsplit_pkt = 0,
 	     rx_skb_alloc_fail = 0, rx_buf_alloc_fail = 0,
 	     rx_desc_err_dropped_pkt = 0, rx_hsplit_unsplit_pkt = 0,
+	     xdp_tx_errors = 0, xdp_redirect_errors = 0,
 	     ring = 0;
 	     ring < priv->rx_cfg.num_queues; ring++) {
 		if (priv->rx) {
@@ -216,6 +218,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 					rx->rx_desc_err_dropped_pkt;
 				tmp_rx_hsplit_unsplit_pkt =
 					rx->rx_hsplit_unsplit_pkt;
+				tmp_xdp_tx_errors = rx->xdp_tx_errors;
+				tmp_xdp_redirect_errors =
+					rx->xdp_redirect_errors;
 			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
 						       start));
 			rx_pkts += tmp_rx_pkts;
@@ -225,6 +230,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			rx_buf_alloc_fail += tmp_rx_buf_alloc_fail;
 			rx_desc_err_dropped_pkt += tmp_rx_desc_err_dropped_pkt;
 			rx_hsplit_unsplit_pkt += tmp_rx_hsplit_unsplit_pkt;
+			xdp_tx_errors += tmp_xdp_tx_errors;
+			xdp_redirect_errors += tmp_xdp_redirect_errors;
 		}
 	}
 	for (tx_pkts = 0, tx_bytes = 0, tx_dropped = 0, ring = 0;
@@ -250,8 +257,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = rx_bytes;
 	data[i++] = tx_bytes;
 	/* total rx dropped packets */
-	data[i++] = rx_skb_alloc_fail + rx_buf_alloc_fail +
-		    rx_desc_err_dropped_pkt;
+	data[i++] = rx_skb_alloc_fail + rx_desc_err_dropped_pkt +
+		    xdp_tx_errors + xdp_redirect_errors;
 	data[i++] = tx_dropped;
 	data[i++] = priv->tx_timeo_cnt;
 	data[i++] = rx_skb_alloc_fail;
@@ -330,6 +337,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
 				tmp_rx_desc_err_dropped_pkt =
 					rx->rx_desc_err_dropped_pkt;
+				tmp_xdp_tx_errors = rx->xdp_tx_errors;
+				tmp_xdp_redirect_errors =
+					rx->xdp_redirect_errors;
 			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
 						       start));
 			data[i++] = tmp_rx_bytes;
@@ -340,8 +350,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			data[i++] = rx->rx_frag_alloc_cnt;
 			/* rx dropped packets */
 			data[i++] = tmp_rx_skb_alloc_fail +
-				tmp_rx_buf_alloc_fail +
-				tmp_rx_desc_err_dropped_pkt;
+				    tmp_rx_desc_err_dropped_pkt +
+				    tmp_xdp_tx_errors +
+				    tmp_xdp_redirect_errors;
 			data[i++] = rx->rx_copybreak_pkt;
 			data[i++] = rx->rx_copied_pkt;
 			/* stats from NIC */
-- 
2.53.0.rc1.225.gd81095ad13-goog


