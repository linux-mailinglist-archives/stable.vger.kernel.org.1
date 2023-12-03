Return-Path: <stable+bounces-3771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7204A80243E
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCAA280DFA
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DBBFC02;
	Sun,  3 Dec 2023 13:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RZdNaohl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA65EF9FC
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79CEC433CA;
	Sun,  3 Dec 2023 13:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701610530;
	bh=0ED8r/vHfhjCDWFS0lJaiA3tbtV81rX0NE0tIqMHvK8=;
	h=Subject:To:Cc:From:Date:From;
	b=RZdNaohlY8UFNXqsQWIyH8H33e93Ryk2LqgjMnA+9ujjdq6r5871XvnmJOQaylThK
	 hq9Z5eh3M71AfKVT/6LHgCRy4DytN7blyHK3fGdY5u/wWwRPbZqIV3phtgsL9xDljk
	 yiFNo2eMAZPgYLfIvhslqfxGhAFEXK/akw6k8mCg=
Subject: FAILED: patch "[PATCH] wifi: cfg80211: fix CQM for non-range use" failed to apply to 6.6-stable tree
To: johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:35:19 +0100
Message-ID: <2023120319-cubicle-showdown-d666@gregkh>
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
git cherry-pick -x 7e7efdda6adb385fbdfd6f819d76bc68c923c394
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120319-cubicle-showdown-d666@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

7e7efdda6adb ("wifi: cfg80211: fix CQM for non-range use")
7d6904bf26b9 ("Merge wireless into wireless-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7e7efdda6adb385fbdfd6f819d76bc68c923c394 Mon Sep 17 00:00:00 2001
From: Johannes Berg <johannes.berg@intel.com>
Date: Mon, 6 Nov 2023 23:17:16 +0100
Subject: [PATCH] wifi: cfg80211: fix CQM for non-range use

My prior race fix here broke CQM when ranges aren't used, as
the reporting worker now requires the cqm_config to be set in
the wdev, but isn't set when there's no range configured.

Rather than continuing to special-case the range version, set
the cqm_config always and configure accordingly, also tracking
if range was used or not to be able to clear the configuration
appropriately with the same API, which was actually not right
if both were implemented by a driver for some reason, as is
the case with mac80211 (though there the implementations are
equivalent so it doesn't matter.)

Also, the original multiple-RSSI commit lost checking for the
callback, so might have potentially crashed if a driver had
neither implementation, and userspace tried to use it despite
not being advertised as supported.

Cc: stable@vger.kernel.org
Fixes: 4a4b8169501b ("cfg80211: Accept multiple RSSI thresholds for CQM")
Fixes: 37c20b2effe9 ("wifi: cfg80211: fix cqm_config access race")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/wireless/core.h b/net/wireless/core.h
index 4c692c7faf30..cb61d33d4f1e 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -293,6 +293,7 @@ struct cfg80211_cqm_config {
 	u32 rssi_hyst;
 	s32 last_rssi_event_value;
 	enum nl80211_cqm_rssi_threshold_event last_rssi_event_type;
+	bool use_range_api;
 	int n_rssi_thresholds;
 	s32 rssi_thresholds[] __counted_by(n_rssi_thresholds);
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 569234bc2be6..dbfed5a2d7b6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12787,10 +12787,6 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	int i, n, low_index;
 	int err;
 
-	/* RSSI reporting disabled? */
-	if (!cqm_config)
-		return rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
-
 	/*
 	 * Obtain current RSSI value if possible, if not and no RSSI threshold
 	 * event has been received yet, we should receive an event after a
@@ -12865,23 +12861,25 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)
 		return -EOPNOTSUPP;
 
-	if (n_thresholds <= 1 && rdev->ops->set_cqm_rssi_config) {
-		if (n_thresholds == 0 || thresholds[0] == 0) /* Disabling */
-			return rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
-
-		return rdev_set_cqm_rssi_config(rdev, dev,
-						thresholds[0], hysteresis);
-	}
-
-	if (!wiphy_ext_feature_isset(&rdev->wiphy,
-				     NL80211_EXT_FEATURE_CQM_RSSI_LIST))
-		return -EOPNOTSUPP;
-
 	if (n_thresholds == 1 && thresholds[0] == 0) /* Disabling */
 		n_thresholds = 0;
 
 	old = wiphy_dereference(wdev->wiphy, wdev->cqm_config);
 
+	/* if already disabled just succeed */
+	if (!n_thresholds && !old)
+		return 0;
+
+	if (n_thresholds > 1) {
+		if (!wiphy_ext_feature_isset(&rdev->wiphy,
+					     NL80211_EXT_FEATURE_CQM_RSSI_LIST) ||
+		    !rdev->ops->set_cqm_rssi_range_config)
+			return -EOPNOTSUPP;
+	} else {
+		if (!rdev->ops->set_cqm_rssi_config)
+			return -EOPNOTSUPP;
+	}
+
 	if (n_thresholds) {
 		cqm_config = kzalloc(struct_size(cqm_config, rssi_thresholds,
 						 n_thresholds),
@@ -12894,13 +12892,26 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 		memcpy(cqm_config->rssi_thresholds, thresholds,
 		       flex_array_size(cqm_config, rssi_thresholds,
 				       n_thresholds));
+		cqm_config->use_range_api = n_thresholds > 1 ||
+					    !rdev->ops->set_cqm_rssi_config;
 
 		rcu_assign_pointer(wdev->cqm_config, cqm_config);
+
+		if (cqm_config->use_range_api)
+			err = cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
+		else
+			err = rdev_set_cqm_rssi_config(rdev, dev,
+						       thresholds[0],
+						       hysteresis);
 	} else {
 		RCU_INIT_POINTER(wdev->cqm_config, NULL);
+		/* if enabled as range also disable via range */
+		if (old->use_range_api)
+			err = rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
+		else
+			err = rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
 	}
 
-	err = cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
 	if (err) {
 		rcu_assign_pointer(wdev->cqm_config, old);
 		kfree_rcu(cqm_config, rcu_head);
@@ -19009,10 +19020,11 @@ void cfg80211_cqm_rssi_notify_work(struct wiphy *wiphy, struct wiphy_work *work)
 	s32 rssi_level;
 
 	cqm_config = wiphy_dereference(wdev->wiphy, wdev->cqm_config);
-	if (!wdev->cqm_config)
+	if (!cqm_config)
 		return;
 
-	cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
+	if (cqm_config->use_range_api)
+		cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
 
 	rssi_level = cqm_config->last_rssi_event_value;
 	rssi_event = cqm_config->last_rssi_event_type;


