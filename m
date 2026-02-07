Return-Path: <stable+bounces-214783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPCwCoNPh2k7WQQAu9opvQ
	(envelope-from <stable+bounces-214783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 15:43:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 422951063DC
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 15:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C9FA3004438
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B133033F5;
	Sat,  7 Feb 2026 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AnWv+GR9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07EE27F4E7
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770475390; cv=none; b=aDyXQqd9qwVmt379jRLeEcwESi0TOSYaTdGL0urilVhiNUKgagOdwWSzOZ9TiSUhhUTfFIJRKhhRVj0CQxatvDvki7MPSHUU17txklE2wGq5yp/ZsufE1Jrtqyb5tVVAXzUtiBilcf3ZN/JG5kTd+H+h+5SHTxpyk7h8kWGqGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770475390; c=relaxed/simple;
	bh=8761L0NbbSOjvAG6/+vbsPw6YFX9of+WnwZiVm/fjKQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YqKjf6GckYJdBlbVfXmm3eG5ABM3RBBrM6xEmEpr6LYAHMo40bLLgqstQSo7gBGZ2c7UaZpTlBu5h5JUXpaACMgxTuXMT7l9aofb7mNJ3/9NPmfyPXHt4IiEredkQq69oO0ALly5xsLeGaOFVnzBju/LviIYLe7yKkYCjCl8Wnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AnWv+GR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122D3C116D0;
	Sat,  7 Feb 2026 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770475389;
	bh=8761L0NbbSOjvAG6/+vbsPw6YFX9of+WnwZiVm/fjKQ=;
	h=Subject:To:Cc:From:Date:From;
	b=AnWv+GR9BPVyX62wkWzUiEUXsigfwKqxJByvX9b4pkeG8J8WE79o4GFgX3t3Nej5b
	 JoVH5PfX4pUXi7qjf/3WaNJs76WHxmh5fYEyBpJyyLacHQViigoVkAWScUhM5FxAGe
	 fChjtmuS65Xh6He2dcEXl81i/KYB6HHUNnA/5zg0=
Subject: FAILED: patch "[PATCH] gve: Correct ethtool rx_dropped calculation" failed to apply to 6.1-stable tree
To: maxyuan@google.com,hramamurthy@google.com,jacob.e.keller@intel.com,jordanrhee@google.com,joshwash@google.com,kuba@kernel.org,maolson@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 07 Feb 2026 15:42:58 +0100
Message-ID: <2026020758-gravy-resupply-beb4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214783-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,msgid.link:url,gregkh:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 422951063DC
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c7db85d579a1dccb624235534508c75fbf2dfe46
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020758-gravy-resupply-beb4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c7db85d579a1dccb624235534508c75fbf2dfe46 Mon Sep 17 00:00:00 2001
From: Max Yuan <maxyuan@google.com>
Date: Mon, 2 Feb 2026 19:39:25 +0000
Subject: [PATCH] gve: Correct ethtool rx_dropped calculation

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

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 137dd7285bda..66ddc4413f8d 100644
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


