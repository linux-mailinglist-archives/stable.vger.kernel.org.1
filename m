Return-Path: <stable+bounces-212513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GqDAsc6emlN4wEAu9opvQ
	(envelope-from <stable+bounces-212513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:35:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22AA5D72
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FAF931F982D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8063530EF92;
	Wed, 28 Jan 2026 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fYibRpIH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E89530C635;
	Wed, 28 Jan 2026 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615769; cv=none; b=XTr09rUUpKtFkc83KvCZ9HFHJwrEluiIeGHKd7I0vngmTGglvDJ8pN7qZmXLsbJUpR0VYi4DR1hNaGtK3Mq0VdiikMu+Hw5SiYrPBvQwThI5OkA78P9Mvr05cYWSMY43RVeVSJ+zpFW2fr7wLZu7xE6GuvBYqBPDOFwtggMygKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615769; c=relaxed/simple;
	bh=3ciJv7fGj0AZ95SbbItfINt/izwfVR+y05BgTNL4uIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCXXvhj9dmEX7+jpq/gpRPlOCjDps78tznL9rfzC8jkS/sGxdu9XVJ2E25C8mX/ZBF24ofLqu5vErO0BXp+IxgtiFpBBe0HDxnHi0attAsEj8lT0jzURyyKwmdJ5POo4Y/0ASBv1H1s4bGTXROhsU9z1//qXjNjE+b4l3HeFRwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fYibRpIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93378C4CEF1;
	Wed, 28 Jan 2026 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615769;
	bh=3ciJv7fGj0AZ95SbbItfINt/izwfVR+y05BgTNL4uIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fYibRpIHpFRFAIiAg/PM2Welob5RUHCiyZ8OhY7QcjvskW6jbEJeD1PAirnz35C38
	 pU6HOY9BXO13dVP8RVVky0d38tfSNUhCTULxVYnURpeOvjz0+mOOZJp0Dnfdg271Bg
	 qONF3cndxPbnc5JqiPGzqDogg+A/pGG5xKnEBKO8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Yang <mmyangfl@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 109/227] net: hns3: fix data race in hns3_fetch_stats
Date: Wed, 28 Jan 2026 16:22:34 +0100
Message-ID: <20260128145348.391309458@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212513-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 5C22AA5D72
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index bfa5568baa926..e976a88b952f0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2500,44 +2500,47 @@ static netdev_features_t hns3_features_check(struct sk_buff *skb,
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




