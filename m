Return-Path: <stable+bounces-124340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D62A5FB4A
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 17:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557C8161FAD
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5459269D0D;
	Thu, 13 Mar 2025 16:17:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C617269808;
	Thu, 13 Mar 2025 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882671; cv=none; b=hQEQIma2x9OX3TJXa23ShqtYCHGlUI2MrS+bNHqhJkaoLjtqknzcTCDgkPBA3kKwPzpTxDMuXHtG2vgxU7oEGmsyZZNm3mBufb2WR2UIandjeUvxjvrQAZl/26kLLx5628CxwWGZf+wXDg1L7hiOKoK/Ef93rqCBT/hdWqKQp8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882671; c=relaxed/simple;
	bh=7v3TujD06KFAViD9d3T0ENPYjJimOlUrSpxn1dfBAXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HUwqdwgXeOhUQthF3BDRU2Q5gJ09eSWZMmD30UJrPypKncDQmSUChwCo7vLGjXcvixqmt8iNh99z72NYiCyYgIHAcTzCYvzrhqtACW9AvelgWM52EYNPheDacZinf/JMqySzoejlO/E+lnyiD5pH71yrB9Tgq4jUwuk6TIY84DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300fa272413901a38a4bC9c0De305.dip0.t-ipconnect.de [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 8687EFA132;
	Thu, 13 Mar 2025 17:17:41 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Andy Strohman <andrew@andrewstrohman.com>,
	stable@vger.kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/5] batman-adv: fix panic during interface removal
Date: Thu, 13 Mar 2025 17:17:34 +0100
Message-Id: <20250313161738.71299-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313161738.71299-1-sw@simonwunderlich.de>
References: <20250313161738.71299-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Strohman <andrew@andrewstrohman.com>

Reference counting is used to ensure that
batadv_hardif_neigh_node and batadv_hard_iface
are not freed before/during
batadv_v_elp_throughput_metric_update work is
finished.

But there isn't a guarantee that the hard if will
remain associated with a soft interface up until
the work is finished.

This fixes a crash triggered by reboot that looks
like this:

Call trace:
 batadv_v_mesh_free+0xd0/0x4dc [batman_adv]
 batadv_v_elp_throughput_metric_update+0x1c/0xa4
 process_one_work+0x178/0x398
 worker_thread+0x2e8/0x4d0
 kthread+0xd8/0xdc
 ret_from_fork+0x10/0x20

(the batadv_v_mesh_free call is misleading,
and does not actually happen)

I was able to make the issue happen more reliably
by changing hardif_neigh->bat_v.metric_work work
to be delayed work. This allowed me to track down
and confirm the fix.

Cc: stable@vger.kernel.org
Fixes: c833484e5f38 ("batman-adv: ELP - compute the metric based on the estimated throughput")
Signed-off-by: Andy Strohman <andrew@andrewstrohman.com>
[sven@narfation.org: prevent entering batadv_v_elp_get_throughput without
 soft_iface]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 1d704574e6bf..fbf499bcc671 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -66,12 +66,19 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
+	struct net_device *soft_iface = hard_iface->soft_iface;
 	struct ethtool_link_ksettings link_settings;
 	struct net_device *real_netdev;
 	struct station_info sinfo;
 	u32 throughput;
 	int ret;
 
+	/* don't query throughput when no longer associated with any
+	 * batman-adv interface
+	 */
+	if (!soft_iface)
+		return BATADV_THROUGHPUT_DEFAULT_VALUE;
+
 	/* if the user specified a customised value for this interface, then
 	 * return it directly
 	 */
@@ -141,7 +148,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 
 default_throughput:
 	if (!(hard_iface->bat_v.flags & BATADV_WARNING_DEFAULT)) {
-		batadv_info(hard_iface->soft_iface,
+		batadv_info(soft_iface,
 			    "WiFi driver or ethtool info does not provide information about link speeds on interface %s, therefore defaulting to hardcoded throughput values of %u.%1u Mbps. Consider overriding the throughput manually or checking your driver.\n",
 			    hard_iface->net_dev->name,
 			    BATADV_THROUGHPUT_DEFAULT_VALUE / 10,
-- 
2.39.5


