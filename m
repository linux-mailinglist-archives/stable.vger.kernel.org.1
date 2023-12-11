Return-Path: <stable+bounces-5277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A9180C508
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 10:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B6E1C20E41
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2952137F;
	Mon, 11 Dec 2023 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EJ7F8jDS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAB125DC
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 09:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE40C433C7;
	Mon, 11 Dec 2023 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702287899;
	bh=SHAWNF2VWtOl+CSyK/PRRtYXXfTpDuzOCIzIkUHqqH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJ7F8jDSTtbqwcDGmKD77O//M+4fsiq3GlAs6+Bx7z7k7fz3yF/XYA5HRFChmWm14
	 1cEuBbU9CRLZy5lyTovIY0yEWDWbX1FU6HFO99ioGl6WFanTkfRQhvzysg7ArEcMOm
	 AQzOGW1ORdwFAk/4dEOVOMJqhLrYdyPHAJzeGKe8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.67
Date: Mon, 11 Dec 2023 10:44:47 +0100
Message-ID: <2023121147-turban-polish-002d@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023121147-finally-museum-8aad@gregkh>
References: <2023121147-finally-museum-8aad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 5d7e995d686c..c27600b90cad 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 66
+SUBLEVEL = 67
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/net/wireless/core.h b/net/wireless/core.h
index ee980965a7cf..e1accacc6f23 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -297,7 +297,6 @@ struct cfg80211_cqm_config {
 	u32 rssi_hyst;
 	s32 last_rssi_event_value;
 	enum nl80211_cqm_rssi_threshold_event last_rssi_event_type;
-	bool use_range_api;
 	int n_rssi_thresholds;
 	s32 rssi_thresholds[];
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 42c858219b34..b19b5acfaf3a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12574,6 +12574,10 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	int i, n, low_index;
 	int err;
 
+	/* RSSI reporting disabled? */
+	if (!cqm_config)
+		return rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
+
 	/*
 	 * Obtain current RSSI value if possible, if not and no RSSI threshold
 	 * event has been received yet, we should receive an event after a
@@ -12648,6 +12652,18 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)
 		return -EOPNOTSUPP;
 
+	if (n_thresholds <= 1 && rdev->ops->set_cqm_rssi_config) {
+		if (n_thresholds == 0 || thresholds[0] == 0) /* Disabling */
+			return rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
+
+		return rdev_set_cqm_rssi_config(rdev, dev,
+						thresholds[0], hysteresis);
+	}
+
+	if (!wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_CQM_RSSI_LIST))
+		return -EOPNOTSUPP;
+
 	if (n_thresholds == 1 && thresholds[0] == 0) /* Disabling */
 		n_thresholds = 0;
 
@@ -12655,20 +12671,6 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	old = rcu_dereference_protected(wdev->cqm_config,
 					lockdep_is_held(&wdev->mtx));
 
-	/* if already disabled just succeed */
-	if (!n_thresholds && !old)
-		return 0;
-
-	if (n_thresholds > 1) {
-		if (!wiphy_ext_feature_isset(&rdev->wiphy,
-					     NL80211_EXT_FEATURE_CQM_RSSI_LIST) ||
-		    !rdev->ops->set_cqm_rssi_range_config)
-			return -EOPNOTSUPP;
-	} else {
-		if (!rdev->ops->set_cqm_rssi_config)
-			return -EOPNOTSUPP;
-	}
-
 	if (n_thresholds) {
 		cqm_config = kzalloc(struct_size(cqm_config, rssi_thresholds,
 						 n_thresholds),
@@ -12683,26 +12685,13 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 		memcpy(cqm_config->rssi_thresholds, thresholds,
 		       flex_array_size(cqm_config, rssi_thresholds,
 				       n_thresholds));
-		cqm_config->use_range_api = n_thresholds > 1 ||
-					    !rdev->ops->set_cqm_rssi_config;
 
 		rcu_assign_pointer(wdev->cqm_config, cqm_config);
-
-		if (cqm_config->use_range_api)
-			err = cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
-		else
-			err = rdev_set_cqm_rssi_config(rdev, dev,
-						       thresholds[0],
-						       hysteresis);
 	} else {
 		RCU_INIT_POINTER(wdev->cqm_config, NULL);
-		/* if enabled as range also disable via range */
-		if (old->use_range_api)
-			err = rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
-		else
-			err = rdev_set_cqm_rssi_config(rdev, dev, 0, 0);
 	}
 
+	err = cfg80211_cqm_rssi_update(rdev, dev, cqm_config);
 	if (err) {
 		rcu_assign_pointer(wdev->cqm_config, old);
 		kfree_rcu(cqm_config, rcu_head);
@@ -18769,11 +18758,10 @@ void cfg80211_cqm_rssi_notify_work(struct wiphy *wiphy, struct wiphy_work *work)
 	wdev_lock(wdev);
 	cqm_config = rcu_dereference_protected(wdev->cqm_config,
 					       lockdep_is_held(&wdev->mtx));
-	if (!cqm_config)
+	if (!wdev->cqm_config)
 		goto unlock;
 
-	if (cqm_config->use_range_api)
-		cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
+	cfg80211_cqm_rssi_update(rdev, wdev->netdev, cqm_config);
 
 	rssi_level = cqm_config->last_rssi_event_value;
 	rssi_event = cqm_config->last_rssi_event_type;

