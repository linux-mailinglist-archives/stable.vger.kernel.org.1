Return-Path: <stable+bounces-157558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB5DAE5498
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904AC160979
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006AD2236E9;
	Mon, 23 Jun 2025 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q86dvtBI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F721FF50;
	Mon, 23 Jun 2025 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716161; cv=none; b=ZcVwLme/a+wUbcIHjkXTmIAQWKoNu4E4PCtpIlasaWknXKwd3YD3rxD4+M87omugf5AXfa65ToKlW5yozJqvYqbM9iTL/Vm+HiSdP1yc8V85XqdhFdA+VzBGcWM9OkxSWWOgrvGrBRZ4nAVuzGzWjxrODCSGncQBKmby3bDoi74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716161; c=relaxed/simple;
	bh=LB9NUiJwwaFwrlD0LUQ03efmimOKOX3f7+Kc7mc/6P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqpXqugKApr7pKF+qcoMPyXNUfLxv58zdcDd++rboH1TjNkaqD8x4Zxz5KkCFS3L66Q++/pxxRLNSjRN3Fr3XMew6v0Cqkzi2v0i1/X/BvE3XS5in5aNuMKQWY5Oh841ocDmSxPrxQLniNEIHjGsoQ0VBz8jv6NXxSKe6VYwmD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q86dvtBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48425C4CEEA;
	Mon, 23 Jun 2025 22:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716161;
	bh=LB9NUiJwwaFwrlD0LUQ03efmimOKOX3f7+Kc7mc/6P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q86dvtBILIG4rhy40A3pIdNsUk5PC+Ja9iMrkuFXrVfyUbNXY+RaDcwZvlKJcbi7F
	 dJJfhtHGYaUxKj+IcxpYxavhjhSwKD96/Tshh4A8uHp27pFEZssnRXhcizNOxC4mGV
	 1uzhfqKgPngVuZzZNB4p9EzAkhNPc8w5bsf+VstM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Taht <dave.taht@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 254/414] Revert "mac80211: Dynamically set CoDel parameters per station"
Date: Mon, 23 Jun 2025 15:06:31 +0200
Message-ID: <20250623130648.395245422@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toke Høiland-Jørgensen <toke@toke.dk>

[ Upstream commit 4876376988081d636a4c4e5f03a5556386b49087 ]

This reverts commit 484a54c2e597dbc4ace79c1687022282905afba0. The CoDel
parameter change essentially disables CoDel on slow stations, with some
questionable assumptions, as Dave pointed out in [0]. Quoting from
there:

  But here are my pithy comments as to why this part of mac80211 is so
  wrong...

   static void sta_update_codel_params(struct sta_info *sta, u32 thr)
   {
  -       if (thr && thr < STA_SLOW_THRESHOLD * sta->local->num_sta) {

  1) sta->local->num_sta is the number of associated, rather than
  active, stations. "Active" stations in the last 50ms or so, might have
  been a better thing to use, but as most people have far more than that
  associated, we end up with really lousy codel parameters, all the
  time. Mistake numero uno!

  2) The STA_SLOW_THRESHOLD was completely arbitrary in 2016.

  -               sta->cparams.target = MS2TIME(50);

  This, by itself, was probably not too bad. 30ms might have been
  better, at the time, when we were battling powersave etc, but 20ms was
  enough, really, to cover most scenarios, even where we had low rate
  2Ghz multicast to cope with. Even then, codel has a hard time finding
  any sane drop rate at all, with a target this high.

  -               sta->cparams.interval = MS2TIME(300);

  But this was horrible, a total mistake, that is leading to codel being
  completely ineffective in almost any scenario on clients or APS.
  100ms, even 80ms, here, would be vastly better than this insanity. I'm
  seeing 5+seconds of delay accumulated in a bunch of otherwise happily
  fq-ing APs....

  100ms of observed jitter during a flow is enough. Certainly (in 2016)
  there were interactions with powersave that I did not understand, and
  still don't, but if you are transmitting in the first place, powersave
  shouldn't be a problemmmm.....

  -               sta->cparams.ecn = false;

  At the time we were pretty nervous about ecn, I'm kind of sanguine
  about it now, and reliably indicating ecn seems better than turning it
  off for any reason.

  [...]

  In production, on p2p wireless, I've had 8ms and 80ms for target and
  interval for years now, and it works great.

I think Dave's arguments above are basically sound on the face of it,
and various experimentation with tighter CoDel parameters in the OpenWrt
community have show promising results[1]. So I don't think there's any
reason to keep this parameter fiddling; hence this revert.

[0] https://lore.kernel.org/linux-wireless/CAA93jw6NJ2cmLmMauz0xAgC2MGbBq6n0ZiZzAdkK0u4b+O2yXg@mail.gmail.com/
[1] https://forum.openwrt.org/t/reducing-multiplexing-latencies-still-further-in-wifi/133605/130

Suggested-By: Dave Taht <dave.taht@gmail.com>
In-memory-of: Dave Taht <dave.taht@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
Link: https://patch.msgid.link/20250403183930.197716-1-toke@toke.dk
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/mac80211.h     | 16 ----------------
 net/mac80211/debugfs_sta.c |  6 ------
 net/mac80211/rate.c        |  2 --
 net/mac80211/sta_info.c    | 28 ----------------------------
 net/mac80211/sta_info.h    | 11 -----------
 net/mac80211/tx.c          |  9 +--------
 6 files changed, 1 insertion(+), 71 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index fee854892bec5..8e70941602064 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5311,22 +5311,6 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
 			    struct ieee80211_tx_rate *dest,
 			    int max_rates);
 
-/**
- * ieee80211_sta_set_expected_throughput - set the expected tpt for a station
- *
- * Call this function to notify mac80211 about a change in expected throughput
- * to a station. A driver for a device that does rate control in firmware can
- * call this function when the expected throughput estimate towards a station
- * changes. The information is used to tune the CoDel AQM applied to traffic
- * going towards that station (which can otherwise be too aggressive and cause
- * slow stations to starve).
- *
- * @pubsta: the station to set throughput for.
- * @thr: the current expected throughput in kbps.
- */
-void ieee80211_sta_set_expected_throughput(struct ieee80211_sta *pubsta,
-					   u32 thr);
-
 /**
  * ieee80211_tx_rate_update - transmit rate update callback
  *
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 1e9389c49a57d..e6f937cfedcf6 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -152,12 +152,6 @@ static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
 	spin_lock_bh(&local->fq.lock);
 	rcu_read_lock();
 
-	p += scnprintf(p,
-		       bufsz + buf - p,
-		       "target %uus interval %uus ecn %s\n",
-		       codel_time_to_us(sta->cparams.target),
-		       codel_time_to_us(sta->cparams.interval),
-		       sta->cparams.ecn ? "yes" : "no");
 	p += scnprintf(p,
 		       bufsz + buf - p,
 		       "tid ac backlog-bytes backlog-packets new-flows drops marks overlimit collisions tx-bytes tx-packets flags\n");
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 3dc9752188d58..1b045b62961f5 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -971,8 +971,6 @@ int rate_control_set_rates(struct ieee80211_hw *hw,
 	if (sta->uploaded)
 		drv_sta_rate_tbl_update(hw_to_local(hw), sta->sdata, pubsta);
 
-	ieee80211_sta_set_expected_throughput(pubsta, sta_get_expected_throughput(sta));
-
 	return 0;
 }
 EXPORT_SYMBOL(rate_control_set_rates);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 49095f19a0f22..4eb45e08b97e7 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -18,7 +18,6 @@
 #include <linux/timer.h>
 #include <linux/rtnetlink.h>
 
-#include <net/codel.h>
 #include <net/mac80211.h>
 #include "ieee80211_i.h"
 #include "driver-ops.h"
@@ -683,12 +682,6 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	sta->cparams.ce_threshold = CODEL_DISABLED_THRESHOLD;
-	sta->cparams.target = MS2TIME(20);
-	sta->cparams.interval = MS2TIME(100);
-	sta->cparams.ecn = true;
-	sta->cparams.ce_threshold_selector = 0;
-	sta->cparams.ce_threshold_mask = 0;
 
 	sta_dbg(sdata, "Allocated STA %pM\n", sta->sta.addr);
 
@@ -2878,27 +2871,6 @@ unsigned long ieee80211_sta_last_active(struct sta_info *sta)
 	return sta->deflink.status_stats.last_ack;
 }
 
-static void sta_update_codel_params(struct sta_info *sta, u32 thr)
-{
-	if (thr && thr < STA_SLOW_THRESHOLD * sta->local->num_sta) {
-		sta->cparams.target = MS2TIME(50);
-		sta->cparams.interval = MS2TIME(300);
-		sta->cparams.ecn = false;
-	} else {
-		sta->cparams.target = MS2TIME(20);
-		sta->cparams.interval = MS2TIME(100);
-		sta->cparams.ecn = true;
-	}
-}
-
-void ieee80211_sta_set_expected_throughput(struct ieee80211_sta *pubsta,
-					   u32 thr)
-{
-	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
-
-	sta_update_codel_params(sta, thr);
-}
-
 int ieee80211_sta_allocate_link(struct sta_info *sta, unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 9195d5a2de0a8..a9cfeeb13e53f 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -466,14 +466,6 @@ struct ieee80211_fragment_cache {
 	unsigned int next;
 };
 
-/*
- * The bandwidth threshold below which the per-station CoDel parameters will be
- * scaled to be more lenient (to prevent starvation of slow stations). This
- * value will be scaled by the number of active stations when it is being
- * applied.
- */
-#define STA_SLOW_THRESHOLD 6000 /* 6 Mbps */
-
 /**
  * struct link_sta_info - Link STA information
  * All link specific sta info are stored here for reference. This can be
@@ -619,7 +611,6 @@ struct link_sta_info {
  * @sta: station information we share with the driver
  * @sta_state: duplicates information about station state (for debug)
  * @rcu_head: RCU head used for freeing this station struct
- * @cparams: CoDel parameters for this station.
  * @reserved_tid: reserved TID (if any, otherwise IEEE80211_TID_UNRESERVED)
  * @amsdu_mesh_control: track the mesh A-MSDU format used by the peer:
  *
@@ -710,8 +701,6 @@ struct sta_info {
 	struct dentry *debugfs_dir;
 #endif
 
-	struct codel_params cparams;
-
 	u8 reserved_tid;
 	s8 amsdu_mesh_control;
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ef16ff149730a..00c309e7768e1 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1401,16 +1401,9 @@ static struct sk_buff *fq_tin_dequeue_func(struct fq *fq,
 
 	local = container_of(fq, struct ieee80211_local, fq);
 	txqi = container_of(tin, struct txq_info, tin);
+	cparams = &local->cparams;
 	cstats = &txqi->cstats;
 
-	if (txqi->txq.sta) {
-		struct sta_info *sta = container_of(txqi->txq.sta,
-						    struct sta_info, sta);
-		cparams = &sta->cparams;
-	} else {
-		cparams = &local->cparams;
-	}
-
 	if (flow == &tin->default_flow)
 		cvars = &txqi->def_cvars;
 	else
-- 
2.39.5




