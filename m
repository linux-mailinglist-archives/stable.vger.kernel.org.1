Return-Path: <stable+bounces-114231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F71A2C02F
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 11:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25203A54F5
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD14E1DE4E3;
	Fri,  7 Feb 2025 10:05:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32251DE2BC;
	Fri,  7 Feb 2025 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922713; cv=none; b=rCoRQw7gkKU53JNECsDc5PqV0GdNjsbEHlkZll2gybxWWAuorJVmriQeZJXH5tNW/KOhxIPSNrTtE2FWezViHRknu8RADicjvlJSpvxYljr71blcScpT6dABGI3/bsPzyv83MgXIWlAAc1b1vDswVba/prdLrgVoVFR6R1C5lJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922713; c=relaxed/simple;
	bh=Gpnv9rejVEnhq3aM2xqIjrvjr8pC7AsnALYMmjt13i0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nh4U5fVGVjD3D1AKfD5WjDVG8CE0xJNgRADM2RzdxCzawx12zZiLo5DTsJrWrDcjLd1DI6L+uARSHyfnySGJN31I+g/e+XAZrgKKCphsIuM5yRwn7IFwa2+GU61TISqL6yoKwlNgvIs+tmVeNDJzWJ/qhOD4YuYovNFXYZMg8nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c59725EfD8c202009b11B64500.dip0.t-ipconnect.de [IPv6:2003:c5:9725:efd8:c202:9b:11b6:4500])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id D13B4FA197;
	Fri,  7 Feb 2025 10:58:30 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/4] batman-adv: Ignore neighbor throughput metrics in error case
Date: Fri,  7 Feb 2025 10:58:21 +0100
Message-Id: <20250207095823.26043-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207095823.26043-1-sw@simonwunderlich.de>
References: <20250207095823.26043-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

If a temporary error happened in the evaluation of the neighbor throughput
information, then the invalid throughput result should not be stored in the
throughtput EWMA.

Cc: stable@vger.kernel.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c | 50 ++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index fbf499bcc671..65e52de52bcd 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -59,11 +59,13 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 /**
  * batadv_v_elp_get_throughput() - get the throughput towards a neighbour
  * @neigh: the neighbour for which the throughput has to be obtained
+ * @pthroughput: calculated throughput towards the given neighbour in multiples
+ *  of 100kpbs (a value of '1' equals 0.1Mbps, '10' equals 1Mbps, etc).
  *
- * Return: The throughput towards the given neighbour in multiples of 100kpbs
- *         (a value of '1' equals 0.1Mbps, '10' equals 1Mbps, etc).
+ * Return: true when value behind @pthroughput was set
  */
-static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
+static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
+					u32 *pthroughput)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
 	struct net_device *soft_iface = hard_iface->soft_iface;
@@ -77,14 +79,16 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	 * batman-adv interface
 	 */
 	if (!soft_iface)
-		return BATADV_THROUGHPUT_DEFAULT_VALUE;
+		return false;
 
 	/* if the user specified a customised value for this interface, then
 	 * return it directly
 	 */
 	throughput =  atomic_read(&hard_iface->bat_v.throughput_override);
-	if (throughput != 0)
-		return throughput;
+	if (throughput != 0) {
+		*pthroughput = throughput;
+		return true;
+	}
 
 	/* if this is a wireless device, then ask its throughput through
 	 * cfg80211 API
@@ -111,19 +115,24 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			 * possible to delete this neighbor. For now set
 			 * the throughput metric to 0.
 			 */
-			return 0;
+			*pthroughput = 0;
+			return true;
 		}
 		if (ret)
 			goto default_throughput;
 
-		if (sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT))
-			return sinfo.expected_throughput / 100;
+		if (sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)) {
+			*pthroughput = sinfo.expected_throughput / 100;
+			return true;
+		}
 
 		/* try to estimate the expected throughput based on reported tx
 		 * rates
 		 */
-		if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE))
-			return cfg80211_calculate_bitrate(&sinfo.txrate) / 3;
+		if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE)) {
+			*pthroughput = cfg80211_calculate_bitrate(&sinfo.txrate) / 3;
+			return true;
+		}
 
 		goto default_throughput;
 	}
@@ -142,8 +151,10 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			hard_iface->bat_v.flags &= ~BATADV_FULL_DUPLEX;
 
 		throughput = link_settings.base.speed;
-		if (throughput && throughput != SPEED_UNKNOWN)
-			return throughput * 10;
+		if (throughput && throughput != SPEED_UNKNOWN) {
+			*pthroughput = throughput * 10;
+			return true;
+		}
 	}
 
 default_throughput:
@@ -157,7 +168,8 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	}
 
 	/* if none of the above cases apply, return the base_throughput */
-	return BATADV_THROUGHPUT_DEFAULT_VALUE;
+	*pthroughput = BATADV_THROUGHPUT_DEFAULT_VALUE;
+	return true;
 }
 
 /**
@@ -169,15 +181,21 @@ void batadv_v_elp_throughput_metric_update(struct work_struct *work)
 {
 	struct batadv_hardif_neigh_node_bat_v *neigh_bat_v;
 	struct batadv_hardif_neigh_node *neigh;
+	u32 throughput;
+	bool valid;
 
 	neigh_bat_v = container_of(work, struct batadv_hardif_neigh_node_bat_v,
 				   metric_work);
 	neigh = container_of(neigh_bat_v, struct batadv_hardif_neigh_node,
 			     bat_v);
 
-	ewma_throughput_add(&neigh->bat_v.throughput,
-			    batadv_v_elp_get_throughput(neigh));
+	valid = batadv_v_elp_get_throughput(neigh, &throughput);
+	if (!valid)
+		goto put_neigh;
+
+	ewma_throughput_add(&neigh->bat_v.throughput, throughput);
 
+put_neigh:
 	/* decrement refcounter to balance increment performed before scheduling
 	 * this task
 	 */
-- 
2.39.5


