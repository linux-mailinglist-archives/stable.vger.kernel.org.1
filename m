Return-Path: <stable+bounces-5275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27580C505
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 10:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8518F1F20FE5
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69202137F;
	Mon, 11 Dec 2023 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gSQH5TBO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B8125DC
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 09:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1E3C433C7;
	Mon, 11 Dec 2023 09:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702287891;
	bh=4BTiMdT9q5mx+/tzW9mg6vOWlKOWVR2s8a8hoDUEFvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSQH5TBOshFZ1S2en6SeU92tws+5E1TgNiv1SOd+yzk8f7VTPKVrFpjlnRBLFOAyY
	 wONFA8/o9qcpvav1L6knxNcIe2v7zTdt52p3Yr/SddIhmrRM5DoG8hQ4ULUzXFG4ME
	 yR65pFSfXK5qxj0d39a+a70+54wE1+ay9qame5UU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.6
Date: Mon, 11 Dec 2023 10:44:41 +0100
Message-ID: <2023121141-mongoose-dazzler-be1b@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023121140-nervy-directed-5a9e@gregkh>
References: <2023121140-nervy-directed-5a9e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index ee4e504a3e78..1eefa893f048 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 5
+SUBLEVEL = 6
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/net/wireless/core.h b/net/wireless/core.h
index f0a3a2317638..e536c0b615a0 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -299,7 +299,6 @@ struct cfg80211_cqm_config {
 	u32 rssi_hyst;
 	s32 last_rssi_event_value;
 	enum nl80211_cqm_rssi_threshold_event last_rssi_event_type;
-	bool use_range_api;
 	int n_rssi_thresholds;
 	s32 rssi_thresholds[] __counted_by(n_rssi_thresholds);
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6a82dd876f27..931a03f4549c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12824,6 +12824,10 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	int i, n, low_index;
 	int err;
 
+	/* RSSI reporting disabled? */
+	if (!cqm_config)
+		return rdev_set_cqm_rssi_range_config(rdev, dev, 0, 0);
+
 	/*
 	 * Obtain current RSSI value if possible, if not and no RSSI threshold
 	 * event has been received yet, we should receive an event after a
@@ -12898,6 +12902,18 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
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
 
@@ -12905,20 +12921,6 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
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
@@ -12933,26 +12935,13 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
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
@@ -19142,11 +19131,10 @@ void cfg80211_cqm_rssi_notify_work(struct wiphy *wiphy, struct wiphy_work *work)
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

