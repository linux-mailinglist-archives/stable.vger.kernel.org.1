Return-Path: <stable+bounces-214984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Mq4JwPviWn4EQAAu9opvQ
	(envelope-from <stable+bounces-214984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:28:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F02961104C4
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEE293020ED5
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0D037AA91;
	Mon,  9 Feb 2026 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g5Gz35Bt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EED637756C;
	Mon,  9 Feb 2026 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647290; cv=none; b=ohhyZV6y4LvdlrjQ1NzlN2Q5BRuDtUJ4ltPONGmFG4IR0ZvwhxKs8OZ5h2RF6utX2CvCq0CS35Ad1uxkH41WQXesBxTNIJPqkCCFXRMTP7KsYeFXiIsrLw60J1bsx4jpwpVXIZomecWduE/BLAaPALHrWCne8/yRtPdXvgkE5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647290; c=relaxed/simple;
	bh=0rni/7jpQkWxuAlBoHfVDah4YWHFv/0KEFfxot1ZUaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qI1HLjaG1rpnyjcN2PzlMdtCMgC98lt/vwTeOEsJ9D1M3hXFmgblYp2cLAf9E/QmhxWdSchs5HMD5qCdyLFMxMubcjhcqexe4B3C/ye4SNlDWwxy1Qilji8N8PziVAy8zhAp/0GTeVbHlT06KIl2SKJ7Mf88zrzSxyqg1RxpqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g5Gz35Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4497C116C6;
	Mon,  9 Feb 2026 14:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647290;
	bh=0rni/7jpQkWxuAlBoHfVDah4YWHFv/0KEFfxot1ZUaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5Gz35BtJ2zx+gGHecoloXL7cN61LPjHNnbBeMdMOh9KHDz7y8AGzyAOwjzhj3dTx
	 GFu0neKkhfg1aNU8tp7f5B7NX8F6yFXw2o3GhX6myrV+AVRil2j7Ld79cvt6NY8b51
	 RGAz1T1+B957WWoHmy4+eNI7brNyvdDlXR8JH+2M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Debarghya Kundu <debarghyak@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 022/175] gve: Fix stats report corruption on queue count change
Date: Mon,  9 Feb 2026 15:21:35 +0100
Message-ID: <20260209142321.277832132@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214984-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: F02961104C4
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Debarghya Kundu <debarghyak@google.com>

commit 7b9ebcce0296e104a0d82a6b09d68564806158ff upstream.

The driver and the NIC share a region in memory for stats reporting.
The NIC calculates its offset into this region based on the total size
of the stats region and the size of the NIC's stats.

When the number of queues is changed, the driver's stats region is
resized. If the queue count is increased, the NIC can write past
the end of the allocated stats region, causing memory corruption.
If the queue count is decreased, there is a gap between the driver
and NIC stats, leading to incorrect stats reporting.

This change fixes the issue by allocating stats region with maximum
size, and the offset calculation for NIC stats is changed to match
with the calculation of the NIC.

Cc: stable@vger.kernel.org
Fixes: 24aeb56f2d38 ("gve: Add Gvnic stats AQ command and ethtool show/set-priv-flags.")
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20260202193925.3106272-2-hramamurthy@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c |   54 ++++++++++++++++----------
 drivers/net/ethernet/google/gve/gve_main.c    |    4 -
 2 files changed, 36 insertions(+), 22 deletions(-)

--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -156,7 +156,8 @@ gve_get_ethtool_stats(struct net_device
 	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_unsplit_pkt,
 		rx_pkts, rx_hsplit_pkt, rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes,
 		tx_dropped;
-	int stats_idx, base_stats_idx, max_stats_idx;
+	int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
+	int stats_idx, stats_region_len, nic_stats_len;
 	struct stats *report_stats;
 	int *rx_qid_to_stats_idx;
 	int *tx_qid_to_stats_idx;
@@ -265,20 +266,38 @@ gve_get_ethtool_stats(struct net_device
 	data[i++] = priv->stats_report_trigger_cnt;
 	i = GVE_MAIN_STATS_LEN;
 
-	/* For rx cross-reporting stats, start from nic rx stats in report */
-	base_stats_idx = GVE_TX_STATS_REPORT_NUM * num_tx_queues +
-		GVE_RX_STATS_REPORT_NUM * priv->rx_cfg.num_queues;
-	/* The boundary between driver stats and NIC stats shifts if there are
-	 * stopped queues.
-	 */
-	base_stats_idx += NIC_RX_STATS_REPORT_NUM * num_stopped_rxqs +
-		NIC_TX_STATS_REPORT_NUM * num_stopped_txqs;
-	max_stats_idx = NIC_RX_STATS_REPORT_NUM *
-		(priv->rx_cfg.num_queues - num_stopped_rxqs) +
-		base_stats_idx;
+	rx_base_stats_idx = 0;
+	max_rx_stats_idx = 0;
+	max_tx_stats_idx = 0;
+	stats_region_len = priv->stats_report_len -
+				sizeof(struct gve_stats_report);
+	nic_stats_len = (NIC_RX_STATS_REPORT_NUM * priv->rx_cfg.num_queues +
+		NIC_TX_STATS_REPORT_NUM * num_tx_queues) * sizeof(struct stats);
+	if (unlikely((stats_region_len -
+				nic_stats_len) % sizeof(struct stats))) {
+		net_err_ratelimited("Starting index of NIC stats should be multiple of stats size");
+	} else {
+		/* For rx cross-reporting stats,
+		 * start from nic rx stats in report
+		 */
+		rx_base_stats_idx = (stats_region_len - nic_stats_len) /
+							sizeof(struct stats);
+		/* The boundary between driver stats and NIC stats
+		 * shifts if there are stopped queues
+		 */
+		rx_base_stats_idx += NIC_RX_STATS_REPORT_NUM *
+			num_stopped_rxqs + NIC_TX_STATS_REPORT_NUM *
+			num_stopped_txqs;
+		max_rx_stats_idx = NIC_RX_STATS_REPORT_NUM *
+			(priv->rx_cfg.num_queues - num_stopped_rxqs) +
+			rx_base_stats_idx;
+		max_tx_stats_idx = NIC_TX_STATS_REPORT_NUM *
+			(num_tx_queues - num_stopped_txqs) +
+			max_rx_stats_idx;
+	}
 	/* Preprocess the stats report for rx, map queue id to start index */
 	skip_nic_stats = false;
-	for (stats_idx = base_stats_idx; stats_idx < max_stats_idx;
+	for (stats_idx = rx_base_stats_idx; stats_idx < max_rx_stats_idx;
 		stats_idx += NIC_RX_STATS_REPORT_NUM) {
 		u32 stat_name = be32_to_cpu(report_stats[stats_idx].stat_name);
 		u32 queue_id = be32_to_cpu(report_stats[stats_idx].queue_id);
@@ -354,14 +373,9 @@ gve_get_ethtool_stats(struct net_device
 		i += priv->rx_cfg.num_queues * NUM_GVE_RX_CNTS;
 	}
 
-	/* For tx cross-reporting stats, start from nic tx stats in report */
-	base_stats_idx = max_stats_idx;
-	max_stats_idx = NIC_TX_STATS_REPORT_NUM *
-		(num_tx_queues - num_stopped_txqs) +
-		max_stats_idx;
-	/* Preprocess the stats report for tx, map queue id to start index */
 	skip_nic_stats = false;
-	for (stats_idx = base_stats_idx; stats_idx < max_stats_idx;
+	/* NIC TX stats start right after NIC RX stats */
+	for (stats_idx = max_rx_stats_idx; stats_idx < max_tx_stats_idx;
 		stats_idx += NIC_TX_STATS_REPORT_NUM) {
 		u32 stat_name = be32_to_cpu(report_stats[stats_idx].stat_name);
 		u32 queue_id = be32_to_cpu(report_stats[stats_idx].queue_id);
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -283,9 +283,9 @@ static int gve_alloc_stats_report(struct
 	int tx_stats_num, rx_stats_num;
 
 	tx_stats_num = (GVE_TX_STATS_REPORT_NUM + NIC_TX_STATS_REPORT_NUM) *
-		       gve_num_tx_queues(priv);
+				priv->tx_cfg.max_queues;
 	rx_stats_num = (GVE_RX_STATS_REPORT_NUM + NIC_RX_STATS_REPORT_NUM) *
-		       priv->rx_cfg.num_queues;
+				priv->rx_cfg.max_queues;
 	priv->stats_report_len = struct_size(priv->stats_report, stats,
 					     size_add(tx_stats_num, rx_stats_num));
 	priv->stats_report =



