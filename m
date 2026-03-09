Return-Path: <stable+bounces-223615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNHJMTqxrmkSHwIAu9opvQ
	(envelope-from <stable+bounces-223615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:38:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E787238018
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E423038F54
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 11:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2307E395244;
	Mon,  9 Mar 2026 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyGtJJuO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAECE3859CC
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056306; cv=none; b=N8noy9jTPLqPcPQ8WOcX/T/hDScdmtdgwhgktWapbt2Il4IryL0SCEe8JTbZnC4URS72VgcShlGzDG2YJ4YMnweS0vypnTMgAZ40VyDUyfe7ZgxKz2ZEknlE9clTbd5t++AkuTLfYmO7vzyaH2+poBwio9D0I6QOIjL98FGHKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056306; c=relaxed/simple;
	bh=orXFzxK06Z4GDOVb3R3QO9+H4QMpJOKmq2gLOO/TJxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrH88qk/K3bYffM1DAw0vuR8sqZ2juc7MuUCXvrfeJrvo1z2N4KKgspPHOK3lDyEaPPMMp6aPfV30OP56Xui+1r2QWXKezq01RDzfssGRwMovhCnC7clCxooG2nNGgtRtAhGfZicadZEBnBYkbqKFcjKKcI0eZBjCaVwxp4MmU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyGtJJuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153ACC4CEF7;
	Mon,  9 Mar 2026 11:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773056306;
	bh=orXFzxK06Z4GDOVb3R3QO9+H4QMpJOKmq2gLOO/TJxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QyGtJJuOiAl5xAMogjMV+0l4nKXLIBBh6QnU+V4zoLUawmTonyG10Sa+PB0tKTvVB
	 sS3zTx/m1IBnX2QQsef82bS/bWk5ms4uk3nan9fSuVw3kYA4+2ayz4+dVMBWRF9J45
	 tw4wX+CjcGlJdWjdr4+QvQuljQT/32Nb+qBpF2ZruSktdCHA+bjx9bW2lj1s9tD8mK
	 I38aTsBRuF/t6zVZdHsIaoyLmdQRNb4Qrp31V9kT+VZnH9IgxK5sACWlDBdsUFy/Ji
	 BfRCdLQ0W/hriuM+rdtd/OrLEs/h38QoAgu/Dwg8IdUJ7nmq8WhTfgx1Hy7UGvbyVz
	 8XTPH8RlNz/uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] wifi: cfg80211: move scan done work to wiphy work
Date: Mon,  9 Mar 2026 07:38:22 -0400
Message-ID: <20260309113823.823525-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030934-undocked-comic-8b24@gregkh>
References: <2026030934-undocked-comic-8b24@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3E787238018
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223615-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit fe0af9fe54d0ff53aa49eef390c8962355b274e2 ]

Move the scan done work to the new wiphy work to
simplify the code a bit.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 767d23ade706 ("wifi: cfg80211: cancel rfkill_block work in wiphy_unregister()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/core.c |  3 +--
 net/wireless/core.h |  4 ++--
 net/wireless/scan.c | 14 ++++----------
 3 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 2b6bdb7eaf18d..bc84953510e71 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -525,7 +525,7 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	spin_lock_init(&rdev->bss_lock);
 	INIT_LIST_HEAD(&rdev->bss_list);
 	INIT_LIST_HEAD(&rdev->sched_scan_req_list);
-	INIT_WORK(&rdev->scan_done_wk, __cfg80211_scan_done);
+	wiphy_work_init(&rdev->scan_done_wk, __cfg80211_scan_done);
 	INIT_DELAYED_WORK(&rdev->dfs_update_channels_wk,
 			  cfg80211_dfs_channels_update_work);
 #ifdef CONFIG_CFG80211_WEXT
@@ -1125,7 +1125,6 @@ void wiphy_unregister(struct wiphy *wiphy)
 	/* this has nothing to do now but make sure it's gone */
 	cancel_work_sync(&rdev->wiphy_work);
 
-	flush_work(&rdev->scan_done_wk);
 	cancel_work_sync(&rdev->conn_work);
 	flush_work(&rdev->event_work);
 	cancel_delayed_work_sync(&rdev->dfs_update_channels_wk);
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 17dfdf9fe7495..987c41b12856a 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -75,7 +75,7 @@ struct cfg80211_registered_device {
 	struct sk_buff *scan_msg;
 	struct list_head sched_scan_req_list;
 	time64_t suspend_at;
-	struct work_struct scan_done_wk;
+	struct wiphy_work scan_done_wk;
 
 	struct genl_info *cur_cmd_info;
 
@@ -447,7 +447,7 @@ bool cfg80211_valid_key_idx(struct cfg80211_registered_device *rdev,
 int cfg80211_validate_key_settings(struct cfg80211_registered_device *rdev,
 				   struct key_params *params, int key_idx,
 				   bool pairwise, const u8 *mac_addr);
-void __cfg80211_scan_done(struct work_struct *wk);
+void __cfg80211_scan_done(struct wiphy *wiphy, struct wiphy_work *wk);
 void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 			   bool send_message);
 void cfg80211_add_sched_scan_req(struct cfg80211_registered_device *rdev,
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 7369172819fdf..a2cab0593366a 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1096,16 +1096,9 @@ void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 		nl80211_send_scan_msg(rdev, msg);
 }
 
-void __cfg80211_scan_done(struct work_struct *wk)
+void __cfg80211_scan_done(struct wiphy *wiphy, struct wiphy_work *wk)
 {
-	struct cfg80211_registered_device *rdev;
-
-	rdev = container_of(wk, struct cfg80211_registered_device,
-			    scan_done_wk);
-
-	wiphy_lock(&rdev->wiphy);
-	___cfg80211_scan_done(rdev, true);
-	wiphy_unlock(&rdev->wiphy);
+	___cfg80211_scan_done(wiphy_to_rdev(wiphy), true);
 }
 
 void cfg80211_scan_done(struct cfg80211_scan_request *request,
@@ -1131,7 +1124,8 @@ void cfg80211_scan_done(struct cfg80211_scan_request *request,
 	}
 
 	request->notified = true;
-	queue_work(cfg80211_wq, &wiphy_to_rdev(request->wiphy)->scan_done_wk);
+	wiphy_work_queue(request->wiphy,
+			 &wiphy_to_rdev(request->wiphy)->scan_done_wk);
 }
 EXPORT_SYMBOL(cfg80211_scan_done);
 
-- 
2.51.0


