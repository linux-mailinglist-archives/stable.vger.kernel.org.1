Return-Path: <stable+bounces-215370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8X9kEO33iWn5FAAAu9opvQ
	(envelope-from <stable+bounces-215370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:06:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283E111844
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 016623145827
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3138D2DB7B4;
	Mon,  9 Feb 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E3gG5Unm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F762690EC;
	Mon,  9 Feb 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648573; cv=none; b=A5vqXDeDAaj8utn37v+o5TL9yQ74wZBxlW1SqhDhxh7Ano/WNaKQ/L4Fm9RzcJ48wv1BJbf9NL9vzD/UatK7tx9VTE68tqcj+NhQjw/WyKD6SazSMd1Vz3K5wBj6Su2A5tB9EVKqGH4bsP+RLi/J4kmHRJTMfkTCxvvK/mUP/I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648573; c=relaxed/simple;
	bh=S7mg6I4wk2ujloylxxaYa3v09PrnPzyc8prx9qmJNCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AArDMyBq/j+m/jbunF3sB/SdehQps5MGbOF6PBpwzVxGyCesLZ0PDgueYEFGNVyBD36I+6yla3XWHby1K8+VENWl0aYiEmHObYfttekGTb4ZrWq5GxxD5u50semT3Ehl6brG76pJM2v/gM7IPS6lhc926JknQn+wJZCy+Yn25NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E3gG5Unm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63206C116C6;
	Mon,  9 Feb 2026 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648572;
	bh=S7mg6I4wk2ujloylxxaYa3v09PrnPzyc8prx9qmJNCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E3gG5UnmCjUPV9L5RzPk7tIQvmvZhG+OTIzO3Yjj/uI6aKErczwfQQAf8h/zIbJJv
	 JpyUib59J2F/bo4LTuYPeKaa3cMYQqMivha/vtg6Ndy1xAYx1bb+l8GuYl/SrNKATX
	 r2x3q3JLP37i6qgYYJrla8mhsMZALRaDMaGe77Pg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Yuan <maxyuan@google.com>,
	Jordan Rhee <jordanrhee@google.com>,
	Joshua Washington <joshwash@google.com>,
	Matt Olson <maolson@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 78/86] gve: Correct ethtool rx_dropped calculation
Date: Mon,  9 Feb 2026 15:24:41 +0100
Message-ID: <20260209142307.593172527@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
References: <20260209142304.770150175@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215370-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8283E111844
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 27 ++++++++++++++-----
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 59c509ade2625..b1c4df3bab292 100644
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
 	int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
 	int stats_idx, stats_region_len, nic_stats_len;
 	struct stats *report_stats;
@@ -187,7 +189,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 		return;
 	}
 	for (rx_pkts = 0, rx_bytes = 0, rx_skb_alloc_fail = 0,
-	     rx_buf_alloc_fail = 0, rx_desc_err_dropped_pkt = 0, ring = 0;
+	     rx_buf_alloc_fail = 0, rx_desc_err_dropped_pkt = 0,
+	     xdp_tx_errors = 0, xdp_redirect_errors = 0,
+	     ring = 0;
 	     ring < priv->rx_cfg.num_queues; ring++) {
 		if (priv->rx) {
 			do {
@@ -201,6 +205,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
 				tmp_rx_desc_err_dropped_pkt =
 					rx->rx_desc_err_dropped_pkt;
+				tmp_xdp_tx_errors = rx->xdp_tx_errors;
+				tmp_xdp_redirect_errors =
+					rx->xdp_redirect_errors;
 			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
 						       start));
 			rx_pkts += tmp_rx_pkts;
@@ -208,6 +215,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			rx_skb_alloc_fail += tmp_rx_skb_alloc_fail;
 			rx_buf_alloc_fail += tmp_rx_buf_alloc_fail;
 			rx_desc_err_dropped_pkt += tmp_rx_desc_err_dropped_pkt;
+			xdp_tx_errors += tmp_xdp_tx_errors;
+			xdp_redirect_errors += tmp_xdp_redirect_errors;
 		}
 	}
 	for (tx_pkts = 0, tx_bytes = 0, tx_dropped = 0, ring = 0;
@@ -232,8 +241,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
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
@@ -300,6 +309,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
 				tmp_rx_desc_err_dropped_pkt =
 					rx->rx_desc_err_dropped_pkt;
+				tmp_xdp_tx_errors = rx->xdp_tx_errors;
+				tmp_xdp_redirect_errors =
+					rx->xdp_redirect_errors;
 			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
 						       start));
 			data[i++] = tmp_rx_bytes;
@@ -309,8 +321,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
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




