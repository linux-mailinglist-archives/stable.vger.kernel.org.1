Return-Path: <stable+bounces-204755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A7CF390C
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 13:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B12C3004611
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 12:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC6C22D7A1;
	Mon,  5 Jan 2026 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xIt5wLgu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B96E22B5A5
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616779; cv=none; b=KXliXkgMCOHQNxrbsoKIYHEZnSNsy7qcvaFlOHDeGN7o7swyDsodWC83WQE5+1MndUYY4t3ZKtia51tLa80rA5MsB8HSS+1Ox4FFDpp/lIMVUxF0idttKetmpq1HMdt1WU8rtmn149rKY9/7HFIpi0UKJ2FO8p+954ewnD7vZkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616779; c=relaxed/simple;
	bh=TaRK0ZyPKpYlBuz/IFVeEEfH6mqIDDimbb03Rf2tVfk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t9smz6P7wuDKAvw8i9Dr3uKtgszh66xMK538Hd2Y7gyav12uNFO19ziiwjLvGfMYWjTAngaa23bnoWw1m+7NIEizTB84Vr341DdspkkQzMChDZIkx6wiZkKfXWmNV+53IUY4D7XvHx5TuIql+FvZM4w1bGsKatx0Cxhgzu6af1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xIt5wLgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20661C116D0;
	Mon,  5 Jan 2026 12:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767616778;
	bh=TaRK0ZyPKpYlBuz/IFVeEEfH6mqIDDimbb03Rf2tVfk=;
	h=Subject:To:Cc:From:Date:From;
	b=xIt5wLgu3h+wNjq5IkuI0gstIQre2lpYmJVCxyxfwER+tQyonJAQpQ7S/Cj9gv0rq
	 jmyY07GKzH+84pheoucaGYywRSJzaq53XbMMS7mbFuXIXlAMJSTH289xCUPuDA9ddr
	 e3x2HmnjTOxOo4Oa9/B60n286k3TR9uwCVWnzZPs=
Subject: FAILED: patch "[PATCH] wifi: mac80211: Discard Beacon frames to non-broadcast" failed to apply to 5.10-stable tree
To: jouni.malinen@oss.qualcomm.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 13:39:24 +0100
Message-ID: <2026010524-editor-spinner-7ecb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 193d18f60588e95d62e0f82b6a53893e5f2f19f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010524-editor-spinner-7ecb@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 193d18f60588e95d62e0f82b6a53893e5f2f19f8 Mon Sep 17 00:00:00 2001
From: Jouni Malinen <jouni.malinen@oss.qualcomm.com>
Date: Mon, 15 Dec 2025 17:11:34 +0200
Subject: [PATCH] wifi: mac80211: Discard Beacon frames to non-broadcast
 address

Beacon frames are required to be sent to the broadcast address, see IEEE
Std 802.11-2020, 11.1.3.1 ("The Address 1 field of the Beacon .. frame
shall be set to the broadcast address"). A unicast Beacon frame might be
used as a targeted attack to get one of the associated STAs to do
something (e.g., using CSA to move it to another channel). As such, it
is better have strict filtering for this on the received side and
discard all Beacon frames that are sent to an unexpected address.

This is even more important for cases where beacon protection is used.
The current implementation in mac80211 is correctly discarding unicast
Beacon frames if the Protected Frame bit in the Frame Control field is
set to 0. However, if that bit is set to 1, the logic used for checking
for configured BIGTK(s) does not actually work. If the driver does not
have logic for dropping unicast Beacon frames with Protected Frame bit
1, these frames would be accepted in mac80211 processing as valid Beacon
frames even though they are not protected. This would allow beacon
protection to be bypassed. While the logic for checking beacon
protection could be extended to cover this corner case, a more generic
check for discard all Beacon frames based on A1=unicast address covers
this without needing additional changes.

Address all these issues by dropping received Beacon frames if they are
sent to a non-broadcast address.

Cc: stable@vger.kernel.org
Fixes: af2d14b01c32 ("mac80211: Beacon protection using the new BIGTK (STA)")
Signed-off-by: Jouni Malinen <jouni.malinen@oss.qualcomm.com>
Link: https://patch.msgid.link/20251215151134.104501-1-jouni.malinen@oss.qualcomm.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6a1899512d07..e0ccd9749853 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3511,6 +3511,11 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 	    rx->skb->len < IEEE80211_MIN_ACTION_SIZE)
 		return RX_DROP_U_RUNT_ACTION;
 
+	/* Drop non-broadcast Beacon frames */
+	if (ieee80211_is_beacon(mgmt->frame_control) &&
+	    !is_broadcast_ether_addr(mgmt->da))
+		return RX_DROP;
+
 	if (rx->sdata->vif.type == NL80211_IFTYPE_AP &&
 	    ieee80211_is_beacon(mgmt->frame_control) &&
 	    !(rx->flags & IEEE80211_RX_BEACON_REPORTED)) {


