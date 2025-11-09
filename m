Return-Path: <stable+bounces-192868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 522CEC44A17
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 00:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21A374E1537
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 23:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C449C26B2DA;
	Sun,  9 Nov 2025 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJlcnJUw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338F1891AB
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730479; cv=none; b=DgLNKEM01aJplUdg54jf8p/UXf8lb5RrdgKWOvKIKYd+u4qD0b/1QMQFB3XOcUO3bQMnMXiy8hs9kp+1vhZZtIYqR5Kh/ezJOppGhow1DlK0yYpB2JAvia9WQO/nqQWxmUuWm+4N0U/iDUvTKfIgr4VCSwOquodeP9hVDH5h/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730479; c=relaxed/simple;
	bh=IGkGRNF8PqqnKyG0jJbQNl8VST7i2VdbsLTCvVug+LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SW/ckFMuCwO8l4Zmk1fZdLhRsO31S2+BcrkwB4/DeyCtwgjHo/fPaBhX9ENIBqL0M3YiHobf/TP2/+8hX+zxeqDdRF/3ZCawmHWu+1uFgp99QQoNRNmoThABED2Vs9K4dXHjmSQIEjlixbgoTfUvuDUlTDjvdMq8/kh065NUIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJlcnJUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA9EC2BC86;
	Sun,  9 Nov 2025 23:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762730479;
	bh=IGkGRNF8PqqnKyG0jJbQNl8VST7i2VdbsLTCvVug+LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJlcnJUwbJVioOOLspKpCmz7citkoaSi9n7yuZA3g/gzSqeFaxwPWsOQ5PfV4Qn0d
	 3jC8Fh7QcnTii/YTZdmHisUkPM2yyryrG9T83/7sbm4OSLlFFm4/93LgiqPMMiyfCm
	 KqvBbu54ALzagv5YOMcS2D68jjxBj1EhP9QftoX+0E9c0PhSQ0DtbALkISnaqTC2Vy
	 FLqmlwsoMU45Tki5lOhE59pltHtQZiPk5Ad9fMxLtTlLIH5IdTloqg/MEeF27P6e9/
	 4qnG+SV38cdbnskR1xHFw0+NDRXo8VqIuJryTKGDfTJSvOAJrm73hVg5bgO5U3mi2Q
	 wmBhCBKI8SqcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] wifi: mac80211: use wiphy_hrtimer_work for csa.switch_work
Date: Sun,  9 Nov 2025 18:21:14 -0500
Message-ID: <20251109232114.531375-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109232114.531375-1-sashal@kernel.org>
References: <2025110956-smile-parade-ac75@gregkh>
 <20251109232114.531375-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit fbc1cc6973099f45e4c30b86f12b4435c7cb7d24 ]

The work item may be scheduled relatively far in the future. As the
event happens at a specific point in time, the normal timer accuracy is
not sufficient in that case.

Switch to use wiphy_hrtimer_work so that the accuracy is sufficient. To
make this work, use the same clock to store the timestamp.

CC: stable@vger.kernel.org
Fixes: ec3252bff7b6 ("wifi: mac80211: use wiphy work for channel switch")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20251028125710.68258c7e4ac4.I4ff2b2cdffbbf858bf5f08baccc7a88c4f9efe6f@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/chan.c        |  2 +-
 net/mac80211/ieee80211_i.h |  4 ++--
 net/mac80211/link.c        |  4 ++--
 net/mac80211/mlme.c        | 18 +++++++++---------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index e3b46df95b71b..95ec5f0b83240 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1246,7 +1246,7 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 				 &link->csa.finalize_work);
 		break;
 	case NL80211_IFTYPE_STATION:
-		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+		wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
 					 &link->u.mgd.csa.switch_work, 0);
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2f017dbbcb975..8e4405082106c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -979,10 +979,10 @@ struct ieee80211_link_data_managed {
 	bool operating_11g_mode;
 
 	struct {
-		struct wiphy_delayed_work switch_work;
+		struct wiphy_hrtimer_work switch_work;
 		struct cfg80211_chan_def ap_chandef;
 		struct ieee80211_parsed_tpe tpe;
-		unsigned long time;
+		ktime_t time;
 		bool waiting_bcn;
 		bool ignored_same_chan;
 		bool blocked_tx;
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index cafedc5ecd443..28ce41356341f 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -469,10 +469,10 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 		 * from there.
 		 */
 		if (link->conf->csa_active)
-			wiphy_delayed_work_queue(local->hw.wiphy,
+			wiphy_hrtimer_work_queue(local->hw.wiphy,
 						 &link->u.mgd.csa.switch_work,
 						 link->u.mgd.csa.time -
-						 jiffies);
+						 ktime_get_boottime());
 	}
 
 	list_for_each_entry(sta, &local->sta_list, list) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5a9a84a0cc35d..d2b6e73719a0e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2224,7 +2224,7 @@ void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success,
 			return;
 		}
 
-		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+		wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
 					 &link->u.mgd.csa.switch_work, 0);
 	}
 
@@ -2383,7 +2383,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 		.timestamp = timestamp,
 		.device_timestamp = device_timestamp,
 	};
-	unsigned long now;
+	u32 csa_time_tu;
+	ktime_t now;
 	int res;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -2613,10 +2614,9 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 					  csa_ie.mode);
 
 	/* we may have to handle timeout for deactivated link in software */
-	now = jiffies;
-	link->u.mgd.csa.time = now +
-			       TU_TO_JIFFIES((max_t(int, csa_ie.count, 1) - 1) *
-					     link->conf->beacon_int);
+	now = ktime_get_boottime();
+	csa_time_tu = (max_t(int, csa_ie.count, 1) - 1) * link->conf->beacon_int;
+	link->u.mgd.csa.time = now + ns_to_ktime(ieee80211_tu_to_usec(csa_time_tu) * NSEC_PER_USEC);
 
 	if (ieee80211_vif_link_active(&sdata->vif, link->link_id) &&
 	    local->ops->channel_switch) {
@@ -2631,7 +2631,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	}
 
 	/* channel switch handled in software */
-	wiphy_delayed_work_queue(local->hw.wiphy,
+	wiphy_hrtimer_work_queue(local->hw.wiphy,
 				 &link->u.mgd.csa.switch_work,
 				 link->u.mgd.csa.time - now);
 	return;
@@ -8136,7 +8136,7 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	else
 		link->u.mgd.req_smps = IEEE80211_SMPS_OFF;
 
-	wiphy_delayed_work_init(&link->u.mgd.csa.switch_work,
+	wiphy_hrtimer_work_init(&link->u.mgd.csa.switch_work,
 				ieee80211_csa_switch_work);
 
 	ieee80211_clear_tpe(&link->conf->tpe);
@@ -9266,7 +9266,7 @@ void ieee80211_mgd_stop_link(struct ieee80211_link_data *link)
 			  &link->u.mgd.request_smps_work);
 	wiphy_work_cancel(link->sdata->local->hw.wiphy,
 			  &link->u.mgd.recalc_smps);
-	wiphy_delayed_work_cancel(link->sdata->local->hw.wiphy,
+	wiphy_hrtimer_work_cancel(link->sdata->local->hw.wiphy,
 				  &link->u.mgd.csa.switch_work);
 }
 
-- 
2.51.0


