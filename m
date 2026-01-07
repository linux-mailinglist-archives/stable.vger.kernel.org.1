Return-Path: <stable+bounces-206080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4BCCFBC10
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 03:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B038302BA83
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 02:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1452A1FF1B4;
	Wed,  7 Jan 2026 02:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJRAgvCA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83133B2AA
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767753282; cv=none; b=bB2JzZc45X2mFy731y4rQP8Azy2K5pmE+efroFmJ7s/GyA9qGdmhMosASoKO09Bpq683aWYGsP5VTISPKIJ6pZW1ymSjueIVD6xjDZb1XAWRAV7TULO71h/JL32DJMNC8h/BAzQeEsKFFL3uC/EizvVHq6orOEZ1zCiJiqhVxvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767753282; c=relaxed/simple;
	bh=1IjOXcz1B3MecJBjqRkSbDY3RxmB48GmRfe4bBOMDd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XY6Npo0X3z6Wv6xPsTJh34aNXbBm/qUKsmeQ2reNbKXM783OtlJJyI/qQ6UoXf8MUW9HfRz38DG3xumLOipxd8ZpYDyhvfGPFXKCVJZs5ar7ohaehQHUTUPrCVZ1rMz3m6MrbsBeZ/vwHH8m9uL34Bg6m+NRqCmsFFeiwiMJ7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJRAgvCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225CAC116C6;
	Wed,  7 Jan 2026 02:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767753282;
	bh=1IjOXcz1B3MecJBjqRkSbDY3RxmB48GmRfe4bBOMDd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJRAgvCADMYG9ojkY3KMiM3yRTwKX0wqkNR9Ph8StRx2KpXdkrjoGdBx09axwHIsr
	 Q8z3TCITH0i1YpgyxqiadhHdO94Wx8pklT2Fmwm6RxFGRQZVj85bLfo2iquyzdhvBw
	 /1mMFIG+56nDUF6JjDx0pr8XnWhbHx8K/+dr5dHlYpZi8BiMNS1hLEZlrpy3Y3QM8/
	 zfrxwuNVIWZt35oxDwcyK8hWXrseaJEqvrys0DOyaPYHXgAmzoVHOUYhWEJdU4TzEe
	 gLYt1dhCnAeltD4iw35UEwJ3SbvNKxmEHF4FG/c+U3sWvS/PAC4XT6dSYl22Xw4OkA
	 OhULNVHV8kbAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jouni Malinen <jouni.malinen@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: mac80211: Discard Beacon frames to non-broadcast address
Date: Tue,  6 Jan 2026 21:34:39 -0500
Message-ID: <20260107023440.3510800-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010523-dice-pyramid-9839@gregkh>
References: <2026010523-dice-pyramid-9839@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jouni Malinen <jouni.malinen@oss.qualcomm.com>

[ Upstream commit 193d18f60588e95d62e0f82b6a53893e5f2f19f8 ]

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
[ adapted RX_DROP return value to RX_DROP_MONITOR ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 1cd75c200cfe..42dd7d1dda39 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3299,6 +3299,11 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 	if (!ieee80211_is_mgmt(mgmt->frame_control))
 		return RX_DROP_MONITOR;
 
+	/* Drop non-broadcast Beacon frames */
+	if (ieee80211_is_beacon(mgmt->frame_control) &&
+	    !is_broadcast_ether_addr(mgmt->da))
+		return RX_DROP_MONITOR;
+
 	if (rx->sdata->vif.type == NL80211_IFTYPE_AP &&
 	    ieee80211_is_beacon(mgmt->frame_control) &&
 	    !(rx->flags & IEEE80211_RX_BEACON_REPORTED)) {
-- 
2.51.0


