Return-Path: <stable+bounces-206131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C33CCFD805
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 12:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C418304012A
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2943431327F;
	Wed,  7 Jan 2026 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPRLSZgd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD5030CD82
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786842; cv=none; b=FuN007eC3F3fXhWlsoHM/aTBqMcyK4DeGcdgfbwlPRyeVyrNSa0oV+mOuYhtnl44itWgFMYIf9/ETktXW+duoV9X2zQeKvLdlal7U85CYLdYAaPNeTnfsaA97vq10oXJKek8CPtDvrJHRZIHTye0FU6hxdJXJUsFT6Y/ZRk8hFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786842; c=relaxed/simple;
	bh=joKk3MAmzgmBMjZurmynooO4+OYT3UE5Ugw6VhjpNdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmUe3t4r733tm2Xpaffb/0tySJtevZbGrYyfWn88BpGU8wZBq6g+LlkfSIUe83RK9B0H7DT3GE+iF1jVz4Q+4w7dW1ZVCEleHAT6ZVsvAGJw3CYC2kmt7dTxBe6ghHFL/roHuM2l+lnEsEfPd++s1lXwH9cue25wBHaocN9y02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPRLSZgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA968C4CEF7;
	Wed,  7 Jan 2026 11:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767786842;
	bh=joKk3MAmzgmBMjZurmynooO4+OYT3UE5Ugw6VhjpNdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XPRLSZgdW0pqgoVCwDGALJq8epqX5liqdsr/UH2XVifeSGC2cVgzp02nuVC0YlRi+
	 CqO5wIcPhAFZFx50jxLH/vPWUqMcHfJAJURSquF2XPsgC+ODOhHI+qBVCBF67zKRhZ
	 jkO0DakBSUd1giPtHutf0LEQpv/WtcTlLXMlxdZqZSEnuHWkqRPMFfcc6mVktSN+gv
	 61RFqA7Etd8atVKp1J3LBPwobGhbl8U/uf/q9Avfc/Fg/0woNmXxZk23C7zcsxlE2V
	 n3miYpXuDU06wDwM89VrG5rZNvkfzTyIJtqmeGrg8NUKEcWpP3XnoGxTrhqa0o0V55
	 W8MKhOxi3vHdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jouni Malinen <jouni.malinen@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: mac80211: Discard Beacon frames to non-broadcast address
Date: Wed,  7 Jan 2026 06:53:59 -0500
Message-ID: <20260107115359.3985007-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010524-editor-spinner-7ecb@gregkh>
References: <2026010524-editor-spinner-7ecb@gregkh>
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
index 98f06563d184..8f497fe234ed 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3189,6 +3189,11 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
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


