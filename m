Return-Path: <stable+bounces-213509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN3/No5cg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:49:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75165E76BF
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF6B33017070
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6919C264614;
	Wed,  4 Feb 2026 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="agPmVCgA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCA541B366;
	Wed,  4 Feb 2026 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216575; cv=none; b=XzvOa0COn2BKCtQVjCMmcPXRCxc09O2dvD7QSCF6NwhiJ2rVadifjMKQ1NQrMWoj1zOpC9O0XZhcfCAjWQcblQU5yZT9UGWDoD/o8Wi60M/1WddqKACsLDYWfF8uBH/GzseiB8nYgedOQtGTI67kSsi7Zrff1IPAshcyTmAr40w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216575; c=relaxed/simple;
	bh=yuWQ79nxhpfN8wSEIc2zM3eAARPTBFCspz3lvKBIZDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYxx9ZNA/n06VT0hqQp/6XVc08LjLbDFwHoil4Gk6O7pmj5fOkAihdBIhWrFER0rq24oU3AMHUQabLaLgD/99ZutpjLSHb3zW4JmCF8EW/gISYs33/wqrevTi0ce7c/r2m2ijeimCkzneQ0en1loDSeZcird/cCncMzCeUDQgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=agPmVCgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F470C19423;
	Wed,  4 Feb 2026 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216574;
	bh=yuWQ79nxhpfN8wSEIc2zM3eAARPTBFCspz3lvKBIZDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=agPmVCgAKpR7BVW1ScClrICB8wgfDJRup1P/Q1NlRimjBgPV65sKwnHhlyByTNHn/
	 ruyz/j/LAleHYdwS1zRibEYdVPUxfPSj46QFdKwfSbsoUGuwcu8bl+eRWa5H+tffIU
	 VQVa8fziZ7Y+inT6zvsq9DbOj5dNK9Ul92J15C8s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 127/161] net/mlx5e: Account for netdev stats in ndo_get_stats64
Date: Wed,  4 Feb 2026 15:39:50 +0100
Message-ID: <20260204143856.313455441@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213509-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75165E76BF
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gal Pressman <gal@nvidia.com>

[ Upstream commit 476681f10cc1e0e56e26856684e75d4678b072b2 ]

The driver's ndo_get_stats64 callback is only reporting mlx5 counters,
without accounting for the netdev stats, causing errors from the network
stack to be invisible in statistics.

Add netdev_stats_to_stats64() call to first populate the counters, then
add mlx5 counters on top, ensuring both are accounted for (where
appropriate).

Fixes: f62b8bb8f2d3 ("net/mlx5: Extend mlx5_core to support ConnectX-4 Ethernet functionality")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/1769411695-18820-4-git-send-email-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 36f5d5e449209..9c5ccbaa160b1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3679,6 +3679,8 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		mlx5e_queue_update_stats(priv);
 	}
 
+	netdev_stats_to_stats64(stats, &dev->stats);
+
 	if (mlx5e_is_uplink_rep(priv)) {
 		struct mlx5e_vport_stats *vstats = &priv->stats.vport;
 
@@ -3695,21 +3697,21 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		mlx5e_fold_sw_stats64(priv, stats);
 	}
 
-	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer;
-	stats->rx_dropped = PPORT_2863_GET(pstats, if_in_discards);
+	stats->rx_missed_errors += priv->stats.qcnt.rx_out_of_buffer;
+	stats->rx_dropped += PPORT_2863_GET(pstats, if_in_discards);
 
-	stats->rx_length_errors =
+	stats->rx_length_errors +=
 		PPORT_802_3_GET(pstats, a_in_range_length_errors) +
 		PPORT_802_3_GET(pstats, a_out_of_range_length_field) +
 		PPORT_802_3_GET(pstats, a_frame_too_long_errors) +
 		VNIC_ENV_GET(&priv->stats.vnic, eth_wqe_too_small);
-	stats->rx_crc_errors =
+	stats->rx_crc_errors +=
 		PPORT_802_3_GET(pstats, a_frame_check_sequence_errors);
-	stats->rx_frame_errors = PPORT_802_3_GET(pstats, a_alignment_errors);
-	stats->tx_aborted_errors = PPORT_2863_GET(pstats, if_out_discards);
-	stats->rx_errors = stats->rx_length_errors + stats->rx_crc_errors +
-			   stats->rx_frame_errors;
-	stats->tx_errors = stats->tx_aborted_errors + stats->tx_carrier_errors;
+	stats->rx_frame_errors += PPORT_802_3_GET(pstats, a_alignment_errors);
+	stats->tx_aborted_errors += PPORT_2863_GET(pstats, if_out_discards);
+	stats->rx_errors += stats->rx_length_errors + stats->rx_crc_errors +
+			    stats->rx_frame_errors;
+	stats->tx_errors += stats->tx_aborted_errors + stats->tx_carrier_errors;
 }
 
 static void mlx5e_set_rx_mode(struct net_device *dev)
-- 
2.51.0




