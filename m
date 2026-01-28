Return-Path: <stable+bounces-212141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHoeLN8semnd3gEAu9opvQ
	(envelope-from <stable+bounces-212141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:35:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62264A4097
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 886F0302A1A0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312ED2D5940;
	Wed, 28 Jan 2026 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ceZzNA0O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89B72C237E;
	Wed, 28 Jan 2026 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614529; cv=none; b=BWaAEu4sT2dTJGmtqQ1NSZ8ouLbqeQ1xGyka/Odzhtcr+yi4vltIH0I/JuqdkcK+VQJwaWmmasGOt5y3ZvtHNDklu9AIhMyCr5Eys62tEMG95+nczPZxDd60azb8gmNVECcUngIDklKbJz3h6iV2WRb6rr1NSt5ygV13G9YRlmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614529; c=relaxed/simple;
	bh=LhmwDEDeId1LFjbgKT/XxaiAo62cgSU+cSDHbOz7xz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXMbyY2j/cP9+phhhWuQzGC6sNE8kBomzn/qIe+d7BKfUJ1HFjTa8hlfENqb1aFWH5sr6tBzi9CYXow8KLnLYYRDhyFlCNLUmXPZgjmtT7msLJozUTwX1WulKtqqGNH0ePLpvkxth/BKxsW1wiBlhC4MwFlr9hPbo+R6LfabhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ceZzNA0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327B6C4CEF1;
	Wed, 28 Jan 2026 15:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614528;
	bh=LhmwDEDeId1LFjbgKT/XxaiAo62cgSU+cSDHbOz7xz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ceZzNA0OB6VikSByXGLvnAsdTL3HktUKmCcwFow60RHnyDh4BSrdWVo9X0H9DRhH/
	 cSftlX0NDqn7qjCVD1YjVu0x4ynTgwNmpxF9w/wGphQ817h48ZcbFJq56+KwqeKd9R
	 R3Wbf30GLy/3DKXyK/nIUSHo1Q4HZXzqwHB+UJno=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Yang <mmyangfl@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 164/254] net: hns3: fix data race in hns3_fetch_stats
Date: Wed, 28 Jan 2026 16:22:20 +0100
Message-ID: <20260128145350.710985430@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212141-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 62264A4097
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Yang <mmyangfl@gmail.com>

[ Upstream commit 748a81c8ceda1fdbdcd0af595947422e810442aa ]

In hns3_fetch_stats(), ring statistics, protected by u64_stats_sync, are
read and accumulated in ignorance of possible u64_stats_fetch_retry()
events. These statistics are already accumulated by
hns3_ring_stats_update(). Fix this by reading them into a temporary
buffer first.

Fixes: b20d7fe51e0d ("net: hns3: add some statitics info to tx process")
Signed-off-by: David Yang <mmyangfl@gmail.com>
Link: https://patch.msgid.link/20260119160759.1455950-1-mmyangfl@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 69 ++++++++++---------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index dbf44a17987eb..34627de2e311e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2505,44 +2505,47 @@ static netdev_features_t hns3_features_check(struct sk_buff *skb,
 static void hns3_fetch_stats(struct rtnl_link_stats64 *stats,
 			     struct hns3_enet_ring *ring, bool is_tx)
 {
+	struct ring_stats ring_stats;
 	unsigned int start;
 
 	do {
 		start = u64_stats_fetch_begin(&ring->syncp);
-		if (is_tx) {
-			stats->tx_bytes += ring->stats.tx_bytes;
-			stats->tx_packets += ring->stats.tx_pkts;
-			stats->tx_dropped += ring->stats.sw_err_cnt;
-			stats->tx_dropped += ring->stats.tx_vlan_err;
-			stats->tx_dropped += ring->stats.tx_l4_proto_err;
-			stats->tx_dropped += ring->stats.tx_l2l3l4_err;
-			stats->tx_dropped += ring->stats.tx_tso_err;
-			stats->tx_dropped += ring->stats.over_max_recursion;
-			stats->tx_dropped += ring->stats.hw_limitation;
-			stats->tx_dropped += ring->stats.copy_bits_err;
-			stats->tx_dropped += ring->stats.skb2sgl_err;
-			stats->tx_dropped += ring->stats.map_sg_err;
-			stats->tx_errors += ring->stats.sw_err_cnt;
-			stats->tx_errors += ring->stats.tx_vlan_err;
-			stats->tx_errors += ring->stats.tx_l4_proto_err;
-			stats->tx_errors += ring->stats.tx_l2l3l4_err;
-			stats->tx_errors += ring->stats.tx_tso_err;
-			stats->tx_errors += ring->stats.over_max_recursion;
-			stats->tx_errors += ring->stats.hw_limitation;
-			stats->tx_errors += ring->stats.copy_bits_err;
-			stats->tx_errors += ring->stats.skb2sgl_err;
-			stats->tx_errors += ring->stats.map_sg_err;
-		} else {
-			stats->rx_bytes += ring->stats.rx_bytes;
-			stats->rx_packets += ring->stats.rx_pkts;
-			stats->rx_dropped += ring->stats.l2_err;
-			stats->rx_errors += ring->stats.l2_err;
-			stats->rx_errors += ring->stats.l3l4_csum_err;
-			stats->rx_crc_errors += ring->stats.l2_err;
-			stats->multicast += ring->stats.rx_multicast;
-			stats->rx_length_errors += ring->stats.err_pkt_len;
-		}
+		ring_stats = ring->stats;
 	} while (u64_stats_fetch_retry(&ring->syncp, start));
+
+	if (is_tx) {
+		stats->tx_bytes += ring_stats.tx_bytes;
+		stats->tx_packets += ring_stats.tx_pkts;
+		stats->tx_dropped += ring_stats.sw_err_cnt;
+		stats->tx_dropped += ring_stats.tx_vlan_err;
+		stats->tx_dropped += ring_stats.tx_l4_proto_err;
+		stats->tx_dropped += ring_stats.tx_l2l3l4_err;
+		stats->tx_dropped += ring_stats.tx_tso_err;
+		stats->tx_dropped += ring_stats.over_max_recursion;
+		stats->tx_dropped += ring_stats.hw_limitation;
+		stats->tx_dropped += ring_stats.copy_bits_err;
+		stats->tx_dropped += ring_stats.skb2sgl_err;
+		stats->tx_dropped += ring_stats.map_sg_err;
+		stats->tx_errors += ring_stats.sw_err_cnt;
+		stats->tx_errors += ring_stats.tx_vlan_err;
+		stats->tx_errors += ring_stats.tx_l4_proto_err;
+		stats->tx_errors += ring_stats.tx_l2l3l4_err;
+		stats->tx_errors += ring_stats.tx_tso_err;
+		stats->tx_errors += ring_stats.over_max_recursion;
+		stats->tx_errors += ring_stats.hw_limitation;
+		stats->tx_errors += ring_stats.copy_bits_err;
+		stats->tx_errors += ring_stats.skb2sgl_err;
+		stats->tx_errors += ring_stats.map_sg_err;
+	} else {
+		stats->rx_bytes += ring_stats.rx_bytes;
+		stats->rx_packets += ring_stats.rx_pkts;
+		stats->rx_dropped += ring_stats.l2_err;
+		stats->rx_errors += ring_stats.l2_err;
+		stats->rx_errors += ring_stats.l3l4_csum_err;
+		stats->rx_crc_errors += ring_stats.l2_err;
+		stats->multicast += ring_stats.rx_multicast;
+		stats->rx_length_errors += ring_stats.err_pkt_len;
+	}
 }
 
 static void hns3_nic_get_stats64(struct net_device *netdev,
-- 
2.51.0




