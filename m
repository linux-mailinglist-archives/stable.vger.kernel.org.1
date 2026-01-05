Return-Path: <stable+bounces-204753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0689DCF3972
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 13:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 858F2301FB6F
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 12:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2672F1F239B;
	Mon,  5 Jan 2026 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f0jqtib3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32D32F84F
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616766; cv=none; b=RkVVWRNMp+co0KlDLJor7ZzwO8N21zYpk6SKb4KNNfDxcdZFMTS5lU9HTLvVI6dWHNuD3NTe8NLa+EWzlB6kaRASLf3jWLcBkPPYdjUThGlj2yHhiWOpNHQCnq9lXEtasVxS0+HUJvgmOGMl5DM+K0SShUPVrEWwpT5lfUxWGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616766; c=relaxed/simple;
	bh=0JmgsA9MeqFAJ1IUU/XqB/ZQZaZAdR4Mvx2IBZf9lD0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Pgf5vnI5qyj+z1dfmpTGLelMYSsZm3dE7UCJ1TNEfBBonhW5RDdJtE7FF4IEkfD/Vd2UMTJZSYCAc+cOXj6HOnwmBRWKAGI1hDkvbQ5ps6gIT4PpoPD4NTXtt2MTIsmzvA8L6xRTs7Lfe/1WhMtDtpAajjnHLLu5WgDQGB5XpNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f0jqtib3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FAEC116D0;
	Mon,  5 Jan 2026 12:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767616766;
	bh=0JmgsA9MeqFAJ1IUU/XqB/ZQZaZAdR4Mvx2IBZf9lD0=;
	h=Subject:To:Cc:From:Date:From;
	b=f0jqtib3BvHoAP7cNlKNy5QW9//2mJosA5/szbvOsho/cjFTwsp+WhrUOT9tg7yDW
	 U8QFKhgw18e+iwhGnLs9JcRNAWDh3jbpcy7QV/m/+XVJshvMOSZFV+TMPsW0RXWMH4
	 wowTaiMTB299tXnAR/JFh8nZURlrdYRV7yOcJzus=
Subject: FAILED: patch "[PATCH] wifi: mac80211: Discard Beacon frames to non-broadcast" failed to apply to 6.1-stable tree
To: jouni.malinen@oss.qualcomm.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 13:39:23 +0100
Message-ID: <2026010523-dice-pyramid-9839@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 193d18f60588e95d62e0f82b6a53893e5f2f19f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010523-dice-pyramid-9839@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


