Return-Path: <stable+bounces-20683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C078585AB3F
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C181C21DF4
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FAC4CB52;
	Mon, 19 Feb 2024 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bR4WRP38"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77024C617
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368066; cv=none; b=jQFRjBemj2FVSqSD+63VZ+wbxU1069K3eijuAfUkx0SfwVbbE8OaymyGL2sT4K4N+BEp1gjhY6vjLZaYcIhv746ZO6cXWptsgxc2q42gGBQnuPAKq63GTMAP8h7sL6QFC6fO9Zinv/5fJNrODu/3Q/gfHDh8BmtXJwT/X2MyerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368066; c=relaxed/simple;
	bh=HKResDpKQM0++/89k2b54FAIroodB3necyBQRa+PZYw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZOWdFOcLLSIkebY75X9MIG6hwS6RkYB153J4Vz6mXRJSDrsrOmwJB3diync39U1Auv8z5R6A+n/VLhSNWbaUMsOJmYRKy1Ajx+cCTSTVfP3Mz71xkarPhf1g/WSSf5BvnaBzl+5avxBsAgwfjK9PkwxldHl2Vuavk0I18SlnErA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bR4WRP38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2741DC43399;
	Mon, 19 Feb 2024 18:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368066;
	bh=HKResDpKQM0++/89k2b54FAIroodB3necyBQRa+PZYw=;
	h=Subject:To:Cc:From:Date:From;
	b=bR4WRP38powAvEgZNAgNhmy3mgfAoloDG9TdvoO4d/2abUD6OIvi5D2YfyHTIibeN
	 6LQV4aTNrSLqLzOKpOz08x1+14zng85lKYJvi7RCKJ3NWsHd0+EET9uCYa0jWB5HRS
	 WlT/iKItwKykKhXC9+y4Z1V13WdTMsvDOIRrgMG4=
Subject: FAILED: patch "[PATCH] wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()" failed to apply to 4.19-stable tree
To: johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:39:48 +0100
Message-ID: <2024021948-regally-festival-39c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x c98d8836b817d11fdff4ca7749cbbe04ff7f0c64
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021948-regally-festival-39c8@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

c98d8836b817 ("wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()")
23a5f0af6ff4 ("wifi: mac80211: remove cipher scheme support")
6d501764288c ("mac80211: introduce channel switch disconnect function")
71abf71e9e63 ("mac80211: Remove unused assignment statements")
77dfc2bc0bb4 ("mac80211: do not access the IV when it was stripped")
63214f02cff9 ("mac80211: save transmit power envelope element and power constraint")
405fca8a9461 ("ieee80211: add power type definition for 6 GHz")
5d24828d05f3 ("mac80211: always allocate struct ieee802_11_elems")
c6e37ed498f9 ("mac80211: move CRC into struct ieee802_11_elems")
a5b983c60731 ("mac80211: mesh: clean up rx_bcn_presp API")
65be6aa36ded ("mac80211: add HE 6 GHz capability only if supported")
15fae3410f1d ("mac80211: notify driver on mgd TX completion")
9bd6a83e53a7 ("mac80211: add vendor-specific capabilities to assoc request")
bac2fd3d7534 ("mac80211: remove use of ieee80211_get_he_sta_cap()")
c74025f47ac8 ("mac80211: rearrange struct txq_info for fewer holes")
d8b261548dcf ("mac80211: add to bss_conf if broadcast TWT is supported")
bbc6f03ff26e ("mac80211: reset profile_periodicity/ema_ap")
bf30ca922a0c ("mac80211: check defrag PN against current frame")
3a11ce08c45b ("mac80211: add fragment cache to sta_info")
270032a2a9c4 ("mac80211: drop A-MSDUs on old ciphers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c98d8836b817d11fdff4ca7749cbbe04ff7f0c64 Mon Sep 17 00:00:00 2001
From: Johannes Berg <johannes.berg@intel.com>
Date: Wed, 31 Jan 2024 16:49:10 +0100
Subject: [PATCH] wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()

This pointer can change here since the SKB can change, so we
actually later open-coded IEEE80211_SKB_CB() again. Reload
the pointer where needed, so the monitor-mode case using it
gets fixed, and then use info-> later as well.

Cc: stable@vger.kernel.org
Fixes: 531682159092 ("mac80211: fix VLAN handling with TXQs")
Link: https://msgid.link/20240131164910.b54c28d583bc.I29450cec84ea6773cff5d9c16ff92b836c331471@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index e448ab338448..6fbb15b65902 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  *
  * Transmit and frame generation functions.
  */
@@ -3927,6 +3927,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 			goto begin;
 
 		skb = __skb_dequeue(&tx.skbs);
+		info = IEEE80211_SKB_CB(skb);
 
 		if (!skb_queue_empty(&tx.skbs)) {
 			spin_lock_bh(&fq->lock);
@@ -3971,7 +3972,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	}
 
 encap_out:
-	IEEE80211_SKB_CB(skb)->control.vif = vif;
+	info->control.vif = vif;
 
 	if (tx.sta &&
 	    wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {


