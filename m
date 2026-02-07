Return-Path: <stable+bounces-214818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zXZJN8KHh2lEZQQAu9opvQ
	(envelope-from <stable+bounces-214818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 19:43:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCB6106E3D
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 19:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 824683012BF1
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A652DAFD7;
	Sat,  7 Feb 2026 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp6BWfsc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DAB5FDA7
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770489789; cv=none; b=LtmqIZl2wIYO0SJ5rzWtLPaKEOLCqrWIxRORPaGvUTcFgGCl5mb0hwtYMbfQ5Dancp7gd2Ped8hugWXGvJA29WmXQv+21M8OkF/mmii0joEFXZjkjnjPDx7MfyzWwdYZXb3mzx+XCK2M/IB4MBd4dt8HvbhjdNCvLwhGZmmPdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770489789; c=relaxed/simple;
	bh=Mc5yHHi+w3uBrxhLT43L+EZ9n/F7qjNiDpkoHtiYJTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YiSiBURphEXwXm3AWAXN8WesHpERTCFmMSQu300OrGEN4rHZIs6ceaDI45W/Yw/OD2ExsVXpmPIkPXDbaVljp2r5/mWmPAiJ46moSArhKoah8m8TSVJzYLV0B7vztp+y4w+9s0dGjtQPWc3wurLOVL3OKM1h6i8w+q/V3DAmVZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp6BWfsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D80CC116D0;
	Sat,  7 Feb 2026 18:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770489788;
	bh=Mc5yHHi+w3uBrxhLT43L+EZ9n/F7qjNiDpkoHtiYJTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sp6BWfscgIWU9AaD6hQN5xHRilpnCAagT/PxjwiihsKQgNmgACfh7nWURXvfkJyFF
	 RtwfdPoRf5czncFQhyybmsSICN5zwGXnV7Oye+MtZbXM2EkLb4l3qQoIU1Tu+1BMG+
	 ReIY6CMsh5tLBGP1jhL0/4KAR2d8BxjwbqVlvIT/KRi0EiCbQr0/CX3mpTC9ozcYZz
	 8qJWIRTfQAwaeS3iC9rmfW1eWk7F2pzdfOE3U4iAZ9velwM8zV5mL8daicKWrvmXh+
	 sgXu0dkGqOaEzNfEJ/UI/TPjdF68SjDxh97gllocTHB6WVLSFSpL6128KTEM7zjljG
	 hWDth4n8rVVhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Max Yuan <maxyuan@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Joshua Washington <joshwash@google.com>,
	Matt Olson <maolson@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] gve: Correct ethtool rx_dropped calculation
Date: Sat,  7 Feb 2026 13:43:05 -0500
Message-ID: <20260207184305.497723-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020757-credibly-prologue-e2b8@gregkh>
References: <2026020757-credibly-prologue-e2b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214818-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 1CCB6106E3D
X-Rspamd-Action: no action

From: Max Yuan <maxyuan@google.com>

[ Upstream commit c7db85d579a1dccb624235534508c75fbf2dfe46 ]

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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20260202193925.3106272-3-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 26 ++++++++++++++-----
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 22317acf16ba4..997e1d7736a84 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -156,9 +156,11 @@ gve_get_ethtool_stats(struct net_device *netdev,
 {
 	u64 tmp_rx_pkts, tmp_rx_bytes, tmp_rx_skb_alloc_fail,
 		tmp_rx_buf_alloc_fail, tmp_rx_desc_err_dropped_pkt,
-		tmp_tx_pkts, tmp_tx_bytes;
+		tmp_tx_pkts, tmp_tx_bytes,
+		tmp_xdp_tx_errors, tmp_xdp_redirect_errors;
 	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_pkts,
-		rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes, tx_dropped;
+		rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes, tx_dropped,
+		xdp_tx_errors, xdp_redirect_errors;
 	int stats_idx, base_stats_idx, max_stats_idx;
 	struct stats *report_stats;
 	int *rx_qid_to_stats_idx;
@@ -186,7 +188,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 		return;
 	}
 	for (rx_pkts = 0, rx_bytes = 0, rx_skb_alloc_fail = 0,
-	     rx_buf_alloc_fail = 0, rx_desc_err_dropped_pkt = 0, ring = 0;
+	     rx_buf_alloc_fail = 0, rx_desc_err_dropped_pkt = 0,
+	     xdp_tx_errors = 0, xdp_redirect_errors = 0, ring = 0;
 	     ring < priv->rx_cfg.num_queues; ring++) {
 		if (priv->rx) {
 			do {
@@ -200,6 +203,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
 				tmp_rx_desc_err_dropped_pkt =
 					rx->rx_desc_err_dropped_pkt;
+				tmp_xdp_tx_errors = rx->xdp_tx_errors;
+				tmp_xdp_redirect_errors =
+					rx->xdp_redirect_errors;
 			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
 						       start));
 			rx_pkts += tmp_rx_pkts;
@@ -207,6 +213,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			rx_skb_alloc_fail += tmp_rx_skb_alloc_fail;
 			rx_buf_alloc_fail += tmp_rx_buf_alloc_fail;
 			rx_desc_err_dropped_pkt += tmp_rx_desc_err_dropped_pkt;
+			xdp_tx_errors += tmp_xdp_tx_errors;
+			xdp_redirect_errors += tmp_xdp_redirect_errors;
 		}
 	}
 	for (tx_pkts = 0, tx_bytes = 0, tx_dropped = 0, ring = 0;
@@ -231,8 +239,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
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
@@ -281,6 +289,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
 				tmp_rx_desc_err_dropped_pkt =
 					rx->rx_desc_err_dropped_pkt;
+				tmp_xdp_tx_errors = rx->xdp_tx_errors;
+				tmp_xdp_redirect_errors =
+					rx->xdp_redirect_errors;
 			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
 						       start));
 			data[i++] = tmp_rx_bytes;
@@ -290,8 +301,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
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
2.51.0


