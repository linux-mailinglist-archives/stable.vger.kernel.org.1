Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3885E7ECCFE
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjKOTdq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjKOTdq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:33:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028101B1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:33:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613C3C43391;
        Wed, 15 Nov 2023 19:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076821;
        bh=PpmwybdV6XOG/gQXTkTV08g7zmY7BSUfdU3DeX8/9ks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IK0B5vUYPrILniSsOS5Nr2S7u07lts+Y+g53uZJRXtL6Frs5xTYeQNHyOACfeBz7e
         WvHVuJl9Dar7jiY2cWJAyUg5YNb4B+vcUBsXmYRkMJHcV+IQNpPrJaXLJVK0W5XBXj
         WpF2b/HdRx3LCg9I9+FrQh6R9DB4tMmXnwY4u0uI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 037/603] wifi: cfg80211: add flush functions for wiphy work
Date:   Wed, 15 Nov 2023 14:09:42 -0500
Message-ID: <20231115191615.734155126@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 56cfb8ce1f7f6c4e5ca571a2ec0880e131cd0311 ]

There may be sometimes reasons to actually run the work
if it's pending, add flush functions for both regular and
delayed wiphy work that will do this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: eadfb54756ae ("wifi: mac80211: move sched-scan stop work to wiphy work")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/cfg80211.h | 21 +++++++++++++++++++++
 net/wireless/core.c    | 34 ++++++++++++++++++++++++++++++++--
 net/wireless/core.h    |  3 ++-
 net/wireless/sysfs.c   |  4 ++--
 4 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7192346e4a22d..308a004c1d1dc 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5826,6 +5826,16 @@ void wiphy_work_queue(struct wiphy *wiphy, struct wiphy_work *work);
  */
 void wiphy_work_cancel(struct wiphy *wiphy, struct wiphy_work *work);
 
+/**
+ * wiphy_work_flush - flush previously queued work
+ * @wiphy: the wiphy, for debug purposes
+ * @work: the work to flush, this can be %NULL to flush all work
+ *
+ * Flush the work (i.e. run it if pending). This must be called
+ * under the wiphy mutex acquired by wiphy_lock().
+ */
+void wiphy_work_flush(struct wiphy *wiphy, struct wiphy_work *work);
+
 struct wiphy_delayed_work {
 	struct wiphy_work work;
 	struct wiphy *wiphy;
@@ -5869,6 +5879,17 @@ void wiphy_delayed_work_queue(struct wiphy *wiphy,
 void wiphy_delayed_work_cancel(struct wiphy *wiphy,
 			       struct wiphy_delayed_work *dwork);
 
+/**
+ * wiphy_delayed work_flush - flush previously queued delayed work
+ * @wiphy: the wiphy, for debug purposes
+ * @work: the work to flush
+ *
+ * Flush the work (i.e. run it if pending). This must be called
+ * under the wiphy mutex acquired by wiphy_lock().
+ */
+void wiphy_delayed_work_flush(struct wiphy *wiphy,
+			      struct wiphy_delayed_work *dwork);
+
 /**
  * struct wireless_dev - wireless device state
  *
diff --git a/net/wireless/core.c b/net/wireless/core.c
index acec41c1809a8..563cfbe3237c9 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1049,7 +1049,8 @@ void wiphy_rfkill_start_polling(struct wiphy *wiphy)
 }
 EXPORT_SYMBOL(wiphy_rfkill_start_polling);
 
-void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev)
+void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev,
+				  struct wiphy_work *end)
 {
 	unsigned int runaway_limit = 100;
 	unsigned long flags;
@@ -1068,6 +1069,10 @@ void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev)
 		wk->func(&rdev->wiphy, wk);
 
 		spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
+
+		if (wk == end)
+			break;
+
 		if (WARN_ON(--runaway_limit == 0))
 			INIT_LIST_HEAD(&rdev->wiphy_work_list);
 	}
@@ -1118,7 +1123,7 @@ void wiphy_unregister(struct wiphy *wiphy)
 #endif
 
 	/* surely nothing is reachable now, clean up work */
-	cfg80211_process_wiphy_works(rdev);
+	cfg80211_process_wiphy_works(rdev, NULL);
 	wiphy_unlock(&rdev->wiphy);
 	rtnl_unlock();
 
@@ -1640,6 +1645,21 @@ void wiphy_work_cancel(struct wiphy *wiphy, struct wiphy_work *work)
 }
 EXPORT_SYMBOL_GPL(wiphy_work_cancel);
 
+void wiphy_work_flush(struct wiphy *wiphy, struct wiphy_work *work)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	unsigned long flags;
+	bool run;
+
+	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
+	run = !work || !list_empty(&work->entry);
+	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
+
+	if (run)
+		cfg80211_process_wiphy_works(rdev, work);
+}
+EXPORT_SYMBOL_GPL(wiphy_work_flush);
+
 void wiphy_delayed_work_timer(struct timer_list *t)
 {
 	struct wiphy_delayed_work *dwork = from_timer(dwork, t, timer);
@@ -1672,6 +1692,16 @@ void wiphy_delayed_work_cancel(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL_GPL(wiphy_delayed_work_cancel);
 
+void wiphy_delayed_work_flush(struct wiphy *wiphy,
+			      struct wiphy_delayed_work *dwork)
+{
+	lockdep_assert_held(&wiphy->mtx);
+
+	del_timer_sync(&dwork->timer);
+	wiphy_work_flush(wiphy, &dwork->work);
+}
+EXPORT_SYMBOL_GPL(wiphy_delayed_work_flush);
+
 static int __init cfg80211_init(void)
 {
 	int err;
diff --git a/net/wireless/core.h b/net/wireless/core.h
index ba9c7170afa44..e536c0b615a09 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -464,7 +464,8 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 			  struct net_device *dev, enum nl80211_iftype ntype,
 			  struct vif_params *params);
 void cfg80211_process_rdev_events(struct cfg80211_registered_device *rdev);
-void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev);
+void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev,
+				  struct wiphy_work *end);
 void cfg80211_process_wdev_events(struct wireless_dev *wdev);
 
 bool cfg80211_does_bw_fit_range(const struct ieee80211_freq_range *freq_range,
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index c629bac3f2983..565511a3f461e 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -105,14 +105,14 @@ static int wiphy_suspend(struct device *dev)
 			cfg80211_leave_all(rdev);
 			cfg80211_process_rdev_events(rdev);
 		}
-		cfg80211_process_wiphy_works(rdev);
+		cfg80211_process_wiphy_works(rdev, NULL);
 		if (rdev->ops->suspend)
 			ret = rdev_suspend(rdev, rdev->wiphy.wowlan_config);
 		if (ret == 1) {
 			/* Driver refuse to configure wowlan */
 			cfg80211_leave_all(rdev);
 			cfg80211_process_rdev_events(rdev);
-			cfg80211_process_wiphy_works(rdev);
+			cfg80211_process_wiphy_works(rdev, NULL);
 			ret = rdev_suspend(rdev, NULL);
 		}
 		if (ret == 0)
-- 
2.42.0



