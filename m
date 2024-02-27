Return-Path: <stable+bounces-24010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C27869233
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FE91C26345
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4CB1419AD;
	Tue, 27 Feb 2024 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hFpFXw5s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D284514199F;
	Tue, 27 Feb 2024 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040774; cv=none; b=AF3rUJ+r7y3MklUsJfvdi67RIjGvhc1k/eLI4eE7DTNdKT8rJ2SP51LNyuCo0EaMElY6O/GM7fAUEwzreIdaOqZ+loAh+p9et9vsBbz2V5PilGcVKm4WwWWPRvuABcj6nP+CKe9IMKqPk63eyScGBZrRgiENvahic/E7/0DMgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040774; c=relaxed/simple;
	bh=h/xzK/LJyc7Aix5evB7f+/r9yBz2Nuf3lNqRh7QZ+KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imrhmQghguXzJ8usYA1wjuwtsPHzuTEFXeWsU9K8H8yvHmi8QBmUKHoViG5GeZSpKb0WOPToNyO7IGcB04/CtJ+n7SV7uY91CnDF8eyNZl8CUE8qcTLCWvIj+EnnRYU0DfmvTT1ndxcv5Ln6xDBWGyuKEZptmclhC8OlfzIrnoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hFpFXw5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E26EC433F1;
	Tue, 27 Feb 2024 13:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040774;
	bh=h/xzK/LJyc7Aix5evB7f+/r9yBz2Nuf3lNqRh7QZ+KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFpFXw5sjXnaOvSpFjoiQaGPN815f4eNosuqeXNojP5FCniVU7zQdO/cmRH445SIT
	 lotaAoXe9XxSPDeU2JNHLXc0FDCqh5oqVYn49ht+DtNNoEoZhRm9rHyiv3d+Hdqfa+
	 FPZHShbEE1BjBXZsymRxzW+2ozNm13CfCHe6EwNg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 105/334] wifi: mac80211: accept broadcast probe responses on 6 GHz
Date: Tue, 27 Feb 2024 14:19:23 +0100
Message-ID: <20240227131633.876220123@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 62a6183c13319e4d2227473a04abd104c4f56dcf ]

On the 6 GHz band, probe responses are sent as broadcast to
optimise medium usage. However, without OCE configuration
we weren't accepting them, which is wrong, even if wpa_s is
by default enabling OCE. Accept them without the OCE config
as well.

Link: https://msgid.link/20240129200907.5a89c2821897.I92e9dfa0f9b350bc7f37dd4bb38031d156d78d8a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/scan.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 24fa06105378d..fca3f67ac0e8e 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright 2016-2017  Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #include <linux/if_arp.h>
@@ -216,14 +216,18 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 }
 
 static bool ieee80211_scan_accept_presp(struct ieee80211_sub_if_data *sdata,
+					struct ieee80211_channel *channel,
 					u32 scan_flags, const u8 *da)
 {
 	if (!sdata)
 		return false;
-	/* accept broadcast for OCE */
-	if (scan_flags & NL80211_SCAN_FLAG_ACCEPT_BCAST_PROBE_RESP &&
-	    is_broadcast_ether_addr(da))
+
+	/* accept broadcast on 6 GHz and for OCE */
+	if (is_broadcast_ether_addr(da) &&
+	    (channel->band == NL80211_BAND_6GHZ ||
+	     scan_flags & NL80211_SCAN_FLAG_ACCEPT_BCAST_PROBE_RESP))
 		return true;
+
 	if (scan_flags & NL80211_SCAN_FLAG_RANDOM_ADDR)
 		return true;
 	return ether_addr_equal(da, sdata->vif.addr);
@@ -272,6 +276,12 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 		wiphy_delayed_work_queue(local->hw.wiphy, &local->scan_work, 0);
 	}
 
+	channel = ieee80211_get_channel_khz(local->hw.wiphy,
+					    ieee80211_rx_status_to_khz(rx_status));
+
+	if (!channel || channel->flags & IEEE80211_CHAN_DISABLED)
+		return;
+
 	if (ieee80211_is_probe_resp(mgmt->frame_control)) {
 		struct cfg80211_scan_request *scan_req;
 		struct cfg80211_sched_scan_request *sched_scan_req;
@@ -289,19 +299,15 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 		/* ignore ProbeResp to foreign address or non-bcast (OCE)
 		 * unless scanning with randomised address
 		 */
-		if (!ieee80211_scan_accept_presp(sdata1, scan_req_flags,
+		if (!ieee80211_scan_accept_presp(sdata1, channel,
+						 scan_req_flags,
 						 mgmt->da) &&
-		    !ieee80211_scan_accept_presp(sdata2, sched_scan_req_flags,
+		    !ieee80211_scan_accept_presp(sdata2, channel,
+						 sched_scan_req_flags,
 						 mgmt->da))
 			return;
 	}
 
-	channel = ieee80211_get_channel_khz(local->hw.wiphy,
-					ieee80211_rx_status_to_khz(rx_status));
-
-	if (!channel || channel->flags & IEEE80211_CHAN_DISABLED)
-		return;
-
 	bss = ieee80211_bss_info_update(local, rx_status,
 					mgmt, skb->len,
 					channel);
-- 
2.43.0




