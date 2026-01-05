Return-Path: <stable+bounces-204756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38832CF3915
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 13:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7215D300752B
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 12:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279333195EC;
	Mon,  5 Jan 2026 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kes8t4wI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405083112D3
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616820; cv=none; b=X5pv7DT3KbvUw+kFLfyM6+kCsi1ZYf8R9NLfyxB+AidhyO9qCxrVNZmrJMY/XYZAgafL1LW2188Og3YPm9mUypgjc5SX7+Rk1V4bcQQtH1E0Cy1W3YUAM6eTNK4b6HQ608w7fxOLOhkWBnkUbpgxlHIaJjLPi0rAggFbO1ewTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616820; c=relaxed/simple;
	bh=WTgA6QM8BpmiDilBpQmwx7IE6Qu3fRjAVQj/Vj1Ubfg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UxhOzlUUtNkDtncd+ulSVQLcO53D6bd8RWSJI2nHkZk9Y3aGyvFB6TmKUFdBMLl8hEL0auH8B9zKedumPmTH2bZVc8FirV21ZzFq0auj48fCfzGLhjtBAzvPNGMNTM10zENbxZXZkvqVDyrj0IGRuLxNWIuNeKWkNrEfFcW/1W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kes8t4wI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D886CC116D0;
	Mon,  5 Jan 2026 12:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767616819;
	bh=WTgA6QM8BpmiDilBpQmwx7IE6Qu3fRjAVQj/Vj1Ubfg=;
	h=Subject:To:Cc:From:Date:From;
	b=Kes8t4wI31KANTaq47P4Milp3EPx5AWOIrmVA83s40+LeIHtr6m6Fz90EJQOdp4c7
	 s79jjQ+WdOYjaoz0B8nSTVcmTEj2unlUrX0aP0KwAkE9W0DdUZYjN9c5hW0A/iFYI3
	 hhY6WbMdryfB9PPBiJRGZcE4WRHxqp55c91jA9jM=
Subject: FAILED: patch "[PATCH] wifi: mac80211: Discard Beacon frames to non-broadcast" failed to apply to 6.12-stable tree
To: jouni.malinen@oss.qualcomm.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 13:40:10 +0100
Message-ID: <2026010510-wronged-recovery-c8c5@gregkh>
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
git cherry-pick -x 193d18f60588e95d62e0f82b6a53893e5f2f19f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010510-wronged-recovery-c8c5@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


