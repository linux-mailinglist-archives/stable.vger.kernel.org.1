Return-Path: <stable+bounces-192823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42D3C4382F
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 04:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CBA188A115
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 03:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799521D8DE1;
	Sun,  9 Nov 2025 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IlzFqFtO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F99B640
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762658797; cv=none; b=n+u5RvRF8iEDaqH1u5/mcBh8XsEcNeHghHZ+n5cA8OP+r/VA5Y6nPDnu8s7xXnmoF9c4XhyV9Kt9sBcaMKxedbxu14HerqXccfws2HeEqnodhrXh03g8Xo1qDNIXgD6bJ8uiK4fkIZkGYb8/azLcCJ6KUuFZ20B5JHm2MAXJSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762658797; c=relaxed/simple;
	bh=0I8rHLh1FjuAD3r7MK68cKkl0RFMLa7ZSSckBkTIefQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s6z/QnzjenXFJQ02lF49SCyZjvvhu761WnAJbvhHlBUF5tiFFOsr0F2qwH2SAvYHy2mT4KL6HsVkbULw6vrL8ykzGiBx0sg5sBz/udLdxH+kFu3w3ucZUwKG2NrfbmDmkLpiFFgAfdoOnKuGp+gfOBP21Devn7jEhAbx7mORU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IlzFqFtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67285C2BC86;
	Sun,  9 Nov 2025 03:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762658796;
	bh=0I8rHLh1FjuAD3r7MK68cKkl0RFMLa7ZSSckBkTIefQ=;
	h=Subject:To:Cc:From:Date:From;
	b=IlzFqFtOyhcK9GgxRH0SStPftC6qaj9xLUA2eD5At+mIvFBC4SUiCE+8kd6gblLsQ
	 gWJxqqQqR8ViDQIw+o3Na8aVipH1p8SaKSjEi5RP8UI/Erdc3KFV02syXST8Rh2XKV
	 2SZIk53PYec8o+Y+vkAw0sayRD7EwyiQX3Oxa6Y4=
Subject: FAILED: patch "[PATCH] wifi: mac80211: use wiphy_hrtimer_work for ttlm_work" failed to apply to 6.12-stable tree
To: benjamin.berg@intel.com,johannes.berg@intel.com,miriam.rachel.korenblit@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Nov 2025 12:26:34 +0900
Message-ID: <2025110934-construct-gestate-8ed7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x dfa865d490b1bd252045463588a91a4d3c82f3c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110934-construct-gestate-8ed7@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dfa865d490b1bd252045463588a91a4d3c82f3c8 Mon Sep 17 00:00:00 2001
From: Benjamin Berg <benjamin.berg@intel.com>
Date: Tue, 28 Oct 2025 12:58:38 +0200
Subject: [PATCH] wifi: mac80211: use wiphy_hrtimer_work for ttlm_work

The work item may be scheduled relatively far in the future. As the
event happens at a specific point in time, the normal timer accuracy is
not sufficient in that case.

Switch to use wiphy_hrtimer_work so that the accuracy is sufficient.

CC: stable@vger.kernel.org
Fixes: 702e80470a33 ("wifi: mac80211: support handling of advertised TID-to-link mapping")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20251028125710.83c2c611545e.I35498a6d883ea24b0dc4910cf521aa768d2a0e90@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 73fd86ec1bce..eb22279c6e01 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -616,7 +616,7 @@ struct ieee80211_if_managed {
 	u16 removed_links;
 
 	/* TID-to-link mapping support */
-	struct wiphy_delayed_work ttlm_work;
+	struct wiphy_hrtimer_work ttlm_work;
 	struct ieee80211_adv_ttlm_info ttlm_info;
 	struct wiphy_work teardown_ttlm_work;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3b5827ea438e..623a46b3214e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -45,7 +45,7 @@
 #define IEEE80211_ASSOC_TIMEOUT_SHORT	(HZ / 10)
 #define IEEE80211_ASSOC_MAX_TRIES	3
 
-#define IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS msecs_to_jiffies(100)
+#define IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS (100 * USEC_PER_MSEC)
 #define IEEE80211_ADV_TTLM_ST_UNDERFLOW 0xff00
 
 #define IEEE80211_NEG_TTLM_REQ_TIMEOUT (HZ / 5)
@@ -4242,7 +4242,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 
 	memset(&sdata->u.mgd.ttlm_info, 0,
 	       sizeof(sdata->u.mgd.ttlm_info));
-	wiphy_delayed_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
+	wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy, &ifmgd->ttlm_work);
 
 	memset(&sdata->vif.neg_ttlm, 0, sizeof(sdata->vif.neg_ttlm));
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
@@ -7095,7 +7095,7 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 			/* if a planned TID-to-link mapping was cancelled -
 			 * abort it
 			 */
-			wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+			wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy,
 						  &sdata->u.mgd.ttlm_work);
 		} else if (sdata->u.mgd.ttlm_info.active) {
 			/* if no TID-to-link element, set to default mapping in
@@ -7130,7 +7130,7 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 
 		if (ttlm_info.switch_time) {
 			u16 beacon_ts_tu, st_tu, delay;
-			u32 delay_jiffies;
+			u64 delay_usec;
 			u64 mask;
 
 			/* The t2l map switch time is indicated with a partial
@@ -7152,23 +7152,23 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 			if (delay > IEEE80211_ADV_TTLM_ST_UNDERFLOW)
 				return;
 
-			delay_jiffies = TU_TO_JIFFIES(delay);
+			delay_usec = ieee80211_tu_to_usec(delay);
 
 			/* Link switching can take time, so schedule it
 			 * 100ms before to be ready on time
 			 */
-			if (delay_jiffies > IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS)
-				delay_jiffies -=
+			if (delay_usec > IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS)
+				delay_usec -=
 					IEEE80211_ADV_TTLM_SAFETY_BUFFER_MS;
 			else
-				delay_jiffies = 0;
+				delay_usec = 0;
 
 			sdata->u.mgd.ttlm_info = ttlm_info;
-			wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+			wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy,
 						  &sdata->u.mgd.ttlm_work);
-			wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+			wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
 						 &sdata->u.mgd.ttlm_work,
-						 delay_jiffies);
+						 us_to_ktime(delay_usec));
 			return;
 		}
 	}
@@ -8802,7 +8802,7 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	timer_setup(&ifmgd->conn_mon_timer, ieee80211_sta_conn_mon_timer, 0);
 	wiphy_delayed_work_init(&ifmgd->tx_tspec_wk,
 				ieee80211_sta_handle_tspec_ac_params_wk);
-	wiphy_delayed_work_init(&ifmgd->ttlm_work,
+	wiphy_hrtimer_work_init(&ifmgd->ttlm_work,
 				ieee80211_tid_to_link_map_work);
 	wiphy_delayed_work_init(&ifmgd->neg_ttlm_timeout_work,
 				ieee80211_neg_ttlm_timeout_work);


