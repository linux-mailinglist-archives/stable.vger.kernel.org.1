Return-Path: <stable+bounces-192800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8850CC437A1
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 04:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2506A347738
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 03:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187001B85FD;
	Sun,  9 Nov 2025 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NLdnHz+h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA5189906
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762657756; cv=none; b=XppPZEHFI1oVM2oCXxl1IT5ngPQSfMWTQvbY7MqNwtsCi0g3LnQPqlrzpub+7acCM4PfgpKRLpf/iUwgXwUpp3/AADlZfrKQFAsb4+p8ZZbL62wfoTwFxnWsy8J7b7XgUL/wQ8+dUnWiftz3a/5UGRz20qxoZ+F7YXosZOpSh44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762657756; c=relaxed/simple;
	bh=gO4sp5mgeZ45npV7Oe5gtazYsy3XaVrrMWUA2o7c9n8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iclDD6EF8LcuAn5y0GH/jXXNyLdrFnici7s7/H6Svbo1+uQSYKa8EGh6YJj2kTLYVTFCxN71QvhXDB/3pFgl23sy/h/9Yv8ZKgoaECAa9kxV8EXlMpdnwQfMv8rIt/iW1r/hgnpXIBT2Vqh63FrRo+1UN9bI92KBP+7oYJ4AVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NLdnHz+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3C5C16AAE;
	Sun,  9 Nov 2025 03:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762657756;
	bh=gO4sp5mgeZ45npV7Oe5gtazYsy3XaVrrMWUA2o7c9n8=;
	h=Subject:To:Cc:From:Date:From;
	b=NLdnHz+hqvXYFwJ2FwKtl2xI0pPZ2uoyqL19yHfdcWI/xbuRNDX/dH93UYA9QGJRg
	 htzGSudKU4EnLzLKTUIt6TeRHJ89SNq4+9vIHf8di3PVOZ9W7+3ReFQLzLERp6Cso6
	 ynBvihzy+sNBHNxFWBw2QJpmwoSfWhP41KP+nYOM=
Subject: FAILED: patch "[PATCH] wifi: mac80211: use wiphy_hrtimer_work for ml_reconf_work" failed to apply to 6.6-stable tree
To: benjamin.berg@intel.com,johannes.berg@intel.com,miriam.rachel.korenblit@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Nov 2025 12:09:12 +0900
Message-ID: <2025110912-underfeed-detached-8895@gregkh>
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
git cherry-pick -x 3f654d53dff565095d83a84e3b6187526dadf4c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110912-underfeed-detached-8895@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3f654d53dff565095d83a84e3b6187526dadf4c8 Mon Sep 17 00:00:00 2001
From: Benjamin Berg <benjamin.berg@intel.com>
Date: Tue, 28 Oct 2025 12:58:39 +0200
Subject: [PATCH] wifi: mac80211: use wiphy_hrtimer_work for ml_reconf_work

The work item may be scheduled relatively far in the future. As the
event happens at a specific point in time, the normal timer accuracy is
not sufficient in that case.

Switch to use wiphy_hrtimer_work so that the accuracy is sufficient.

CC: stable@vger.kernel.org
Fixes: 8eb8dd2ffbbb ("wifi: mac80211: Support link removal using Reconfiguration ML element")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20251028125710.24a7b54e9e37.I063c5c15bf7672f94cea75f83e486a3ca52d098f@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index eb22279c6e01..eb38049b2252 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -612,7 +612,7 @@ struct ieee80211_if_managed {
 	u8 *assoc_req_ies;
 	size_t assoc_req_ies_len;
 
-	struct wiphy_delayed_work ml_reconf_work;
+	struct wiphy_hrtimer_work ml_reconf_work;
 	u16 removed_links;
 
 	/* TID-to-link mapping support */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 623a46b3214e..f95bcf84ecc2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4249,7 +4249,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 				  &ifmgd->neg_ttlm_timeout_work);
 
 	sdata->u.mgd.removed_links = 0;
-	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+	wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy,
 				  &sdata->u.mgd.ml_reconf_work);
 
 	wiphy_work_cancel(sdata->local->hw.wiphy,
@@ -6876,7 +6876,7 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 		/* In case the removal was cancelled, abort it */
 		if (sdata->u.mgd.removed_links) {
 			sdata->u.mgd.removed_links = 0;
-			wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
+			wiphy_hrtimer_work_cancel(sdata->local->hw.wiphy,
 						  &sdata->u.mgd.ml_reconf_work);
 		}
 		return;
@@ -6906,9 +6906,9 @@ static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
 	}
 
 	sdata->u.mgd.removed_links = removed_links;
-	wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+	wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
 				 &sdata->u.mgd.ml_reconf_work,
-				 TU_TO_JIFFIES(delay));
+				 us_to_ktime(ieee80211_tu_to_usec(delay)));
 }
 
 static int ieee80211_ttlm_set_links(struct ieee80211_sub_if_data *sdata,
@@ -8793,7 +8793,7 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 			ieee80211_csa_connection_drop_work);
 	wiphy_delayed_work_init(&ifmgd->tdls_peer_del_work,
 				ieee80211_tdls_peer_del_work);
-	wiphy_delayed_work_init(&ifmgd->ml_reconf_work,
+	wiphy_hrtimer_work_init(&ifmgd->ml_reconf_work,
 				ieee80211_ml_reconf_work);
 	wiphy_delayed_work_init(&ifmgd->reconf.wk,
 				ieee80211_ml_sta_reconf_timeout);


