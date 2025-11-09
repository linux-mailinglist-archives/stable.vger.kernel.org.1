Return-Path: <stable+bounces-192801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 206D8C437A4
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 04:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FF93AFD5B
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 03:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E181B85FD;
	Sun,  9 Nov 2025 03:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r8AJXQXO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF3189906
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 03:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762657791; cv=none; b=f1TJC7zmMkCUb/R155NfzcDyUNdukiItHjUQoWUeuPl3Lps+WvQJpnv1gAI36EIeUK+q7r+BDvGo34nOb9FK/AoRyPXcqN4e8BruhmpcWSIKkK5ewZ1jNtQjjI/P+TqsCR1Xk4u7hADNaKo51w6067f5hmIeDoz2HSJ1wcAP9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762657791; c=relaxed/simple;
	bh=MsTrwkmqH/9ZKApzVTcJjHcMG6TSAn2BHHta/nZH+FE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RR8DIHIeIMY1gHjdJIfT2uTrpRhyucEngGKKkV4s+b/a1CfNxD2/VgvJpYMxDiXPtn9IkWI+Ck9PT0pTaHVsyK6k5k6GnuRMAsocuGwsdt7ZRSj4HW33LpjuDlo53njonBByqDIBKsX50xgP0tWbrWDcI7HiULsnl/5zFJSnjmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r8AJXQXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29C2C113D0;
	Sun,  9 Nov 2025 03:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762657791;
	bh=MsTrwkmqH/9ZKApzVTcJjHcMG6TSAn2BHHta/nZH+FE=;
	h=Subject:To:Cc:From:Date:From;
	b=r8AJXQXO2MXo65hND7/JGoAaeCTQ1zhgqdDVZ/VObPAsDc1X0SqWjt1RtQrkRUOSb
	 bBm+STxWRc+k3XaPxyRF0kuprOvzaRdWMkoTm7omNxCxY6isReJto0yNqTxDAe85pM
	 YtH05eCDvJDemRW9fa79U80uONyOwBJoEG4dcHUQ=
Subject: FAILED: patch "[PATCH] wifi: mac80211: use wiphy_hrtimer_work for csa.switch_work" failed to apply to 6.6-stable tree
To: benjamin.berg@intel.com,johannes.berg@intel.com,miriam.rachel.korenblit@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Nov 2025 12:09:48 +0900
Message-ID: <2025110947-demote-preppy-79bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fbc1cc6973099f45e4c30b86f12b4435c7cb7d24
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110947-demote-preppy-79bf@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fbc1cc6973099f45e4c30b86f12b4435c7cb7d24 Mon Sep 17 00:00:00 2001
From: Benjamin Berg <benjamin.berg@intel.com>
Date: Tue, 28 Oct 2025 12:58:40 +0200
Subject: [PATCH] wifi: mac80211: use wiphy_hrtimer_work for csa.switch_work

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

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 57065714cf8c..7f8799fd673e 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1290,7 +1290,7 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 				 &link->csa.finalize_work);
 		break;
 	case NL80211_IFTYPE_STATION:
-		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+		wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
 					 &link->u.mgd.csa.switch_work, 0);
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index eb38049b2252..878c3b14aeb8 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1017,10 +1017,10 @@ struct ieee80211_link_data_managed {
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
index d71eabe5abf8..4a19b765ccb6 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -472,10 +472,10 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
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
 
 	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f95bcf84ecc2..f3138d158535 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2594,7 +2594,7 @@ void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success,
 			return;
 		}
 
-		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+		wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
 					 &link->u.mgd.csa.switch_work, 0);
 	}
 
@@ -2753,7 +2753,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 		.timestamp = timestamp,
 		.device_timestamp = device_timestamp,
 	};
-	unsigned long now;
+	u32 csa_time_tu;
+	ktime_t now;
 	int res;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -2983,10 +2984,9 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 					  csa_ie.mode);
 
 	/* we may have to handle timeout for deactivated link in software */
-	now = jiffies;
-	link->u.mgd.csa.time = now +
-			       TU_TO_JIFFIES((max_t(int, csa_ie.count, 1) - 1) *
-					     link->conf->beacon_int);
+	now = ktime_get_boottime();
+	csa_time_tu = (max_t(int, csa_ie.count, 1) - 1) * link->conf->beacon_int;
+	link->u.mgd.csa.time = now + us_to_ktime(ieee80211_tu_to_usec(csa_time_tu));
 
 	if (ieee80211_vif_link_active(&sdata->vif, link->link_id) &&
 	    local->ops->channel_switch) {
@@ -3001,7 +3001,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	}
 
 	/* channel switch handled in software */
-	wiphy_delayed_work_queue(local->hw.wiphy,
+	wiphy_hrtimer_work_queue(local->hw.wiphy,
 				 &link->u.mgd.csa.switch_work,
 				 link->u.mgd.csa.time - now);
 	return;
@@ -8849,7 +8849,7 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	else
 		link->u.mgd.req_smps = IEEE80211_SMPS_OFF;
 
-	wiphy_delayed_work_init(&link->u.mgd.csa.switch_work,
+	wiphy_hrtimer_work_init(&link->u.mgd.csa.switch_work,
 				ieee80211_csa_switch_work);
 
 	ieee80211_clear_tpe(&link->conf->tpe);
@@ -10064,7 +10064,7 @@ void ieee80211_mgd_stop_link(struct ieee80211_link_data *link)
 			  &link->u.mgd.request_smps_work);
 	wiphy_work_cancel(link->sdata->local->hw.wiphy,
 			  &link->u.mgd.recalc_smps);
-	wiphy_delayed_work_cancel(link->sdata->local->hw.wiphy,
+	wiphy_hrtimer_work_cancel(link->sdata->local->hw.wiphy,
 				  &link->u.mgd.csa.switch_work);
 }
 


