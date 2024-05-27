Return-Path: <stable+bounces-46725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2F78D0AFD
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA0D1C20CCE
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E36155CA7;
	Mon, 27 May 2024 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Om7OmIPp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C817E90E;
	Mon, 27 May 2024 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836698; cv=none; b=ZyXXuTPxVscLAdowOKfmxboqEqboxw2ZCtsaOA+XpfB9oPVbIk9a6I6LMnYJimeJXrgMvzwtqzmlKSF27ouUcSwLoTe3GKgYS0U2Zqr5AEaEMWGpZzmDjnTJNSEwWtuZ4JgdU1sS6YNdv1rSAGHYmwsxUymKPNddTnFBKggXlOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836698; c=relaxed/simple;
	bh=eDu2eeoHKSpq0oB0BKm41QEPE9C/Tjw0m2sOgoXJlsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivNONIRbkQogBpFwhi5jbAny2f8TfcOnZsvcag1KXk4+6XM2oF1lbmSH7yIxeLcXpEwYYM/mHb4DCqFEwujL7mq/sXDFWs4PjRvoCejgVRUA+oAwKHrule5Ou6ijglIm1lB6rF74SWeRYGRU3qJUl79a73nRbuDgrJ2xxgsVXI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Om7OmIPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E8BC2BBFC;
	Mon, 27 May 2024 19:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836698;
	bh=eDu2eeoHKSpq0oB0BKm41QEPE9C/Tjw0m2sOgoXJlsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Om7OmIPpIXa6rdxHQHDfqCVdRwVsmObYqOlm1o8NSxZF8Jp4bFPP0Vjya5pqtnp60
	 BLrPr76G4D8h5reN1CtEWidJNjvHT9JTc8OD7Bo6P8dCfJBVeJc8lm2d1GJi1JAQjf
	 SAz2tqFdHD7QfvpwalIstM2CaF5nALCxFj+OAFqQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 154/427] wifi: mac80211: transmit deauth only if link is available
Date: Mon, 27 May 2024 20:53:21 +0200
Message-ID: <20240527185616.886123392@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 570944a094c24ee3a09b2cb5e580063cfde64d7a ]

There's an issue in that when we disconnect from an AP
due to the AP switching to an unsupported channel, we
might not tell the driver about this before we try to
send the deauth. If the underlying implementation has
detected the quiet CSA, this may cause issues if this
is the only active link. Avoid this by transmitting
(and flushing) the deauth only when there's an active
link available that's not affected by quiet CSA.

Since this introduces link->u.mgd.csa_blocked_tx and we
no longer check sdata->csa_blocked_tx for the TX itself
also rename the latter to csa_blocked_queues.

Fixes: 6f0107d195a8 ("wifi: mac80211: introduce a feature flag for quiet in CSA")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240415112355.1d91db5e95aa.Iad3a5df3367f305dff48cd61776abfd6cf0fd4ab@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c         | 12 ++++-----
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/iface.c       |  4 +--
 net/mac80211/mlme.c        | 53 ++++++++++++++++++++++++++------------
 4 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f67c1d0218121..07abaf7820c56 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1607,10 +1607,10 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	/* abort any running channel switch or color change */
 	link_conf->csa_active = false;
 	link_conf->color_change_active = false;
-	if (sdata->csa_blocked_tx) {
+	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = false;
+		sdata->csa_blocked_queues = false;
 	}
 
 	ieee80211_free_next_beacon(link);
@@ -3648,7 +3648,7 @@ void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_t
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
 
-	sdata->csa_blocked_tx = block_tx;
+	sdata->csa_blocked_queues = block_tx;
 	sdata_info(sdata, "channel switch failed, disconnecting\n");
 	wiphy_work_queue(local->hw.wiphy, &ifmgd->csa_connection_drop_work);
 }
@@ -3734,10 +3734,10 @@ static int __ieee80211_csa_finalize(struct ieee80211_link_data *link_data)
 
 	ieee80211_link_info_change_notify(sdata, link_data, changed);
 
-	if (sdata->csa_blocked_tx) {
+	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = false;
+		sdata->csa_blocked_queues = false;
 	}
 
 	err = drv_post_channel_switch(link_data);
@@ -4019,7 +4019,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	    !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA)) {
 		ieee80211_stop_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = true;
+		sdata->csa_blocked_queues = true;
 	}
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index bd507d6b65e3f..70c67c860e995 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -974,6 +974,7 @@ struct ieee80211_link_data_managed {
 
 	bool csa_waiting_bcn;
 	bool csa_ignored_same_chan;
+	bool csa_blocked_tx;
 	struct wiphy_delayed_work chswitch_work;
 
 	struct wiphy_work request_smps_work;
@@ -1092,7 +1093,7 @@ struct ieee80211_sub_if_data {
 
 	unsigned long state;
 
-	bool csa_blocked_tx;
+	bool csa_blocked_queues;
 
 	char name[IFNAMSIZ];
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 395de62d9cb2d..ef6b0fc82d022 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -544,10 +544,10 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	sdata->vif.bss_conf.csa_active = false;
 	if (sdata->vif.type == NL80211_IFTYPE_STATION)
 		sdata->deflink.u.mgd.csa_waiting_bcn = false;
-	if (sdata->csa_blocked_tx) {
+	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = false;
+		sdata->csa_blocked_queues = false;
 	}
 
 	wiphy_work_cancel(local->hw.wiphy, &sdata->deflink.csa_finalize_work);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3bbb216a0fc8c..497677e3d8b27 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1933,13 +1933,14 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 
 	WARN_ON(!link->conf->csa_active);
 
-	if (sdata->csa_blocked_tx) {
+	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = false;
+		sdata->csa_blocked_queues = false;
 	}
 
 	link->conf->csa_active = false;
+	link->u.mgd.csa_blocked_tx = false;
 	link->u.mgd.csa_waiting_bcn = false;
 
 	ret = drv_post_channel_switch(link);
@@ -1999,13 +2000,14 @@ ieee80211_sta_abort_chanswitch(struct ieee80211_link_data *link)
 
 	ieee80211_link_unreserve_chanctx(link);
 
-	if (sdata->csa_blocked_tx) {
+	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = false;
+		sdata->csa_blocked_queues = false;
 	}
 
 	link->conf->csa_active = false;
+	link->u.mgd.csa_blocked_tx = false;
 
 	drv_abort_channel_switch(link);
 }
@@ -2165,12 +2167,13 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	link->csa_chanreq = csa_ie.chanreq;
 	link->u.mgd.csa_ignored_same_chan = false;
 	link->u.mgd.beacon_crc_valid = false;
+	link->u.mgd.csa_blocked_tx = csa_ie.mode;
 
 	if (csa_ie.mode &&
 	    !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA)) {
 		ieee80211_stop_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = true;
+		sdata->csa_blocked_queues = true;
 	}
 
 	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chanreq.oper,
@@ -2199,7 +2202,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	 * reset when the disconnection worker runs.
 	 */
 	link->conf->csa_active = true;
-	sdata->csa_blocked_tx =
+	link->u.mgd.csa_blocked_tx = csa_ie.mode;
+	sdata->csa_blocked_queues =
 		csa_ie.mode && !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA);
 
 	wiphy_work_queue(sdata->local->hw.wiphy,
@@ -3252,12 +3256,13 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	}
 
 	sdata->vif.bss_conf.csa_active = false;
+	sdata->deflink.u.mgd.csa_blocked_tx = false;
 	sdata->deflink.u.mgd.csa_waiting_bcn = false;
 	sdata->deflink.u.mgd.csa_ignored_same_chan = false;
-	if (sdata->csa_blocked_tx) {
+	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = false;
+		sdata->csa_blocked_queues = false;
 	}
 
 	/* existing TX TSPEC sessions no longer exist */
@@ -3563,19 +3568,32 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
-	bool tx;
+	bool tx = false;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!ifmgd->associated)
 		return;
 
-	/*
-	 * MLO drivers should have HANDLES_QUIET_CSA, so that csa_blocked_tx
-	 * is always false; if they don't then this may try to transmit the
-	 * frame but queues will be stopped.
-	 */
-	tx = !sdata->csa_blocked_tx;
+	/* only transmit if we have a link that makes that worthwhile */
+	for (unsigned int link_id = 0;
+	     link_id < ARRAY_SIZE(sdata->link);
+	     link_id++) {
+		struct ieee80211_link_data *link;
+
+		if (!ieee80211_vif_link_active(&sdata->vif, link_id))
+			continue;
+
+		link = sdata_dereference(sdata->link[link_id], sdata);
+		if (WARN_ON_ONCE(!link))
+			continue;
+
+		if (link->u.mgd.csa_blocked_tx)
+			continue;
+
+		tx = true;
+		break;
+	}
 
 	if (!ifmgd->driver_disconnect) {
 		unsigned int link_id;
@@ -3608,10 +3626,11 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	/* the other links will be destroyed */
 	sdata->vif.bss_conf.csa_active = false;
 	sdata->deflink.u.mgd.csa_waiting_bcn = false;
-	if (sdata->csa_blocked_tx) {
+	sdata->deflink.u.mgd.csa_blocked_tx = false;
+	if (sdata->csa_blocked_queues) {
 		ieee80211_wake_vif_queues(local, sdata,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_tx = false;
+		sdata->csa_blocked_queues = false;
 	}
 
 	ieee80211_report_disconnect(sdata, frame_buf, sizeof(frame_buf), tx,
-- 
2.43.0




