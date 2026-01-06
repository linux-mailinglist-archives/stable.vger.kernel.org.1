Return-Path: <stable+bounces-206054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C846DCFB587
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 00:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02AAF3045CEB
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 23:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BDB2DE6FC;
	Tue,  6 Jan 2026 23:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDRS6o97"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5DB2C15A0
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742122; cv=none; b=jzh5uQSR7aDJLbXN7DSYsItT2mkZeXhtt/NPdQCWr276xjT/5chbpByl/ldmD/W+gLk+aeeo1UooVRCsG6Qv92PC+Uk7f4RZBoKaxlcT5eEbqEwbb+hB09NyjJQ7z1K+p4c+up7GPzK5tfd4wDeV8QkqAS9FDc8yUvrSOFN5g7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742122; c=relaxed/simple;
	bh=cGmwM5Zz7fUlcVZ8t/bvcO/X06pX09ahQg5VG9sn0+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPSdEvtJFL3QqbZLafBPlast42k/gSP3jIIizplDSuEGMepIjeL20UGJ+gHJ07QgL3+8ZpTpjariPG7iBl27N7fUQ//CGQRS5u/6Eetqrh3Tmp9phFtmNuF2+OHAfKmE8WOQSknYugVE/GOdUns9yDg2MbymTm37wAsQbEyrduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDRS6o97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C41C116C6;
	Tue,  6 Jan 2026 23:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767742121;
	bh=cGmwM5Zz7fUlcVZ8t/bvcO/X06pX09ahQg5VG9sn0+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDRS6o97JtGoHZwqrVMlaA6YxIUAdZrcJPYaBj9zQ1rj2IHZWMnj7wJj5eLQjy0HI
	 E18z+0nwTYexxckFDMQKNnHQrjqA9A2fd64NQM2gNa1Z0Wwc/Mz92X/kNk410luGLh
	 Rd31kOOcO4VMpjZeFrpdnDG96bLRYBAt3ZteZKDja5OkEOcJOJRdfdKRZ/U3a3VI3e
	 Kksde+6JIRH2WRv4tXl/xvRbiZRLKU3UvpqCi8PvcQXnIX1nCa+Omn+me/MeTrpSxV
	 g9N6aYtB+OvL1iBbzthS994MOkcJVN12NCrv81NOccFmm1grCuzZ36Je/qMnjLZReq
	 xrZGfPk/mJ9bA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jouni Malinen <jouni.malinen@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: mac80211: Discard Beacon frames to non-broadcast address
Date: Tue,  6 Jan 2026 18:28:39 -0500
Message-ID: <20260106232839.3452928-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010516-playmate-shorthand-2e97@gregkh>
References: <2026010516-playmate-shorthand-2e97@gregkh>
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
[ changed RX_DROP to RX_DROP_MONITOR ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e6a0a65d4d43..1303b15e2b29 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3388,6 +3388,11 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 	    rx->skb->len < IEEE80211_MIN_ACTION_SIZE)
 		return RX_DROP_UNUSABLE;
 
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


