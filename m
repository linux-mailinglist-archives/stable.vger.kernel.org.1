Return-Path: <stable+bounces-214817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iODwN/WAh2lQYwQAu9opvQ
	(envelope-from <stable+bounces-214817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 19:14:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 467E5106D43
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 19:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E89F3011045
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 18:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927112EAD10;
	Sat,  7 Feb 2026 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uey4M/Nb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F828151C
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770488050; cv=none; b=c9yh6eMBv5hiVTOlmDnfyufhi9HxLkp6MKf93jUCmkiGUamjhir8vWK5dprFWQoXpjmzD2AaqdzTvSBNLVYqzIjQPtK3XdSVs3QeFTJeeAOhkOisnDlc1P0GVHT6EXjb7sDhAtmeh0t1pqCEcqjy/HiFDpInDZgdllKJMxqisjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770488050; c=relaxed/simple;
	bh=WfzWqYvBhfhwKH2bpxWIXvXIPpkKgHZ2jwMszq4rCXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzEPuMpOcLVvUCtCP4XNHCHq06X/xO/O7zRLqc7MQAUXhp5ffxJqgL/RNyHe1tCTVbUhFQyp4CB3joCYyHUSrZf/PcmIf/S9quvdvskkdqTOhWMl3z449gTDvM+2+dK6ayFi94h4AEn1uQVrIpcd2o218YydzKeeRmTFUE3yCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uey4M/Nb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23729C116D0;
	Sat,  7 Feb 2026 18:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770488049;
	bh=WfzWqYvBhfhwKH2bpxWIXvXIPpkKgHZ2jwMszq4rCXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uey4M/Nbg4DnDhX6ZufaYMRYlh7RmBoISdSll7WGNZoO/7oVda8OG6ocGj9ayQXzn
	 DbW88zJakD29tnFCqV++f4RoLnXVq41m6aQCV5yNyQZdb3Yy7TAL6gagC0F0ZVlYMf
	 9I41oLPCjo0QmqX/Z0yeTZ9srTT5f8F/0uh9p/UWSgTf3bqcWIbTd7FSgWpZ6SaUwB
	 /RZ+0FBpyKyvvYrAIjZODAW8yIjES/Kv47zGjO5r4l4iYSfGO0rUJ0M6Zn9cC+KfJ7
	 ED9SOGio/15E5KgqZiW7zx1hxAPhuJ9WXJ3gFKU5TQKfH6jNnab4JjxkIaTAYpDgvl
	 vWMKBIf9Cn+2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Debarghya Kundu <debarghyak@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] gve: Fix stats report corruption on queue count change
Date: Sat,  7 Feb 2026 13:14:04 -0500
Message-ID: <20260207181404.488041-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020744-emperor-sighing-915f@gregkh>
References: <2026020744-emperor-sighing-915f@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214817-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 467E5106D43
X-Rspamd-Action: no action

From: Debarghya Kundu <debarghyak@google.com>

[ Upstream commit 7b9ebcce0296e104a0d82a6b09d68564806158ff ]

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
[ Same changes as 6.1 + context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_ethtool.c | 42 +++++++++++++------
 drivers/net/ethernet/google/gve/gve_main.c    |  4 +-
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index cbfd007449351..3b4ecc223f1a5 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -140,7 +140,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 		tmp_rx_desc_err_dropped_pkt, tmp_tx_pkts, tmp_tx_bytes;
 	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_pkts,
 		rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes;
-	int stats_idx, base_stats_idx, max_stats_idx;
+	int rx_base_stats_idx, max_rx_stats_idx, max_tx_stats_idx;
+	int stats_idx, stats_region_len, nic_stats_len;
 	struct stats *report_stats;
 	int *rx_qid_to_stats_idx;
 	int *tx_qid_to_stats_idx;
@@ -226,14 +227,33 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = priv->stats_report_trigger_cnt;
 	i = GVE_MAIN_STATS_LEN;
 
-	/* For rx cross-reporting stats, start from nic rx stats in report */
-	base_stats_idx = GVE_TX_STATS_REPORT_NUM * priv->tx_cfg.num_queues +
-		GVE_RX_STATS_REPORT_NUM * priv->rx_cfg.num_queues;
-	max_stats_idx = NIC_RX_STATS_REPORT_NUM * priv->rx_cfg.num_queues +
-		base_stats_idx;
+	rx_base_stats_idx = 0;
+	max_rx_stats_idx = 0;
+	max_tx_stats_idx = 0;
+	stats_region_len = priv->stats_report_len -
+				sizeof(struct gve_stats_report);
+	nic_stats_len = (NIC_RX_STATS_REPORT_NUM * priv->rx_cfg.num_queues +
+		NIC_TX_STATS_REPORT_NUM * priv->tx_cfg.num_queues) *
+		sizeof(struct stats);
+	if (unlikely((stats_region_len -
+				nic_stats_len) % sizeof(struct stats))) {
+		net_err_ratelimited("Starting index of NIC stats should be multiple of stats size");
+	} else {
+		/* For rx cross-reporting stats,
+		 * start from nic rx stats in report
+		 */
+		rx_base_stats_idx = (stats_region_len - nic_stats_len) /
+							sizeof(struct stats);
+		max_rx_stats_idx = NIC_RX_STATS_REPORT_NUM *
+			priv->rx_cfg.num_queues +
+			rx_base_stats_idx;
+		max_tx_stats_idx = NIC_TX_STATS_REPORT_NUM *
+			priv->tx_cfg.num_queues +
+			max_rx_stats_idx;
+	}
 	/* Preprocess the stats report for rx, map queue id to start index */
 	skip_nic_stats = false;
-	for (stats_idx = base_stats_idx; stats_idx < max_stats_idx;
+	for (stats_idx = rx_base_stats_idx; stats_idx < max_rx_stats_idx;
 		stats_idx += NIC_RX_STATS_REPORT_NUM) {
 		u32 stat_name = be32_to_cpu(report_stats[stats_idx].stat_name);
 		u32 queue_id = be32_to_cpu(report_stats[stats_idx].queue_id);
@@ -286,13 +306,9 @@ gve_get_ethtool_stats(struct net_device *netdev,
 		i += priv->rx_cfg.num_queues * NUM_GVE_RX_CNTS;
 	}
 
-	/* For tx cross-reporting stats, start from nic tx stats in report */
-	base_stats_idx = max_stats_idx;
-	max_stats_idx = NIC_TX_STATS_REPORT_NUM * priv->tx_cfg.num_queues +
-		max_stats_idx;
-	/* Preprocess the stats report for tx, map queue id to start index */
 	skip_nic_stats = false;
-	for (stats_idx = base_stats_idx; stats_idx < max_stats_idx;
+	/* NIC TX stats start right after NIC RX stats */
+	for (stats_idx = max_rx_stats_idx; stats_idx < max_tx_stats_idx;
 		stats_idx += NIC_TX_STATS_REPORT_NUM) {
 		u32 stat_name = be32_to_cpu(report_stats[stats_idx].stat_name);
 		u32 queue_id = be32_to_cpu(report_stats[stats_idx].queue_id);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index c409e46e3cfd8..c22605e697719 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -124,9 +124,9 @@ static int gve_alloc_stats_report(struct gve_priv *priv)
 	int tx_stats_num, rx_stats_num;
 
 	tx_stats_num = (GVE_TX_STATS_REPORT_NUM + NIC_TX_STATS_REPORT_NUM) *
-		       priv->tx_cfg.num_queues;
+				priv->tx_cfg.max_queues;
 	rx_stats_num = (GVE_RX_STATS_REPORT_NUM + NIC_RX_STATS_REPORT_NUM) *
-		       priv->rx_cfg.num_queues;
+				priv->rx_cfg.max_queues;
 	priv->stats_report_len = struct_size(priv->stats_report, stats,
 					     size_add(tx_stats_num, rx_stats_num));
 	priv->stats_report =
-- 
2.51.0


