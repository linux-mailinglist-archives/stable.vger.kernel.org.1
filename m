Return-Path: <stable+bounces-204754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57355CF3909
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 13:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C28D730081AA
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 12:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1879F30EF6F;
	Mon,  5 Jan 2026 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IaXBtd0Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B02D9EFC
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616775; cv=none; b=beXZp62rLG826KTT62hMfHYm3A9MzV+8aPYAQ/e2Dts9mcdlZil/PyUwkJ8+8U/SGPPVc8yxM6iYDyj2GfHLlKTlhBJLWQdrey3EDApzQH4ZFEjSsNCmS+YqeEI/qMmi0DkH6QHD7rvTcs1EaOtRWtJRxRCGu0FnRxF85XL4xDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616775; c=relaxed/simple;
	bh=v2f2utIbp9qHu6YjQl9ZvE7doScHbANbdwdHyMvyNKM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KwuHrw4ZU9TzEjvnG1OD3hQWtTiuxS7JENdmOD+n3GQTXO8F56+GsMDez4dOc3PCFbHgLgjxtw0+FT2TLyxMvqB68oyw6P1qbr5aVtbFc8GX7Ez4IBzqBo42iTLJ8vH0Sqya48+dmgjwf9xuv5O+LRmvKp3b4FlYMiHFhwTrDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IaXBtd0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42CBC116D0;
	Mon,  5 Jan 2026 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767616775;
	bh=v2f2utIbp9qHu6YjQl9ZvE7doScHbANbdwdHyMvyNKM=;
	h=Subject:To:Cc:From:Date:From;
	b=IaXBtd0QoF3CCpz22kSo/IMXVJVS27NwTs3wegUMVVvLZuSNVYOIl8h7LISVvS8AG
	 ZxHf/nSLygD4aW4PpEEiE+KAG0fh8PQb9IPhGmVC/gJTjNduVKKeSYopKxs8Pu+EM6
	 YV+YKiF3ar0wcGzitnHr0tGkcrCsHqc49et+9Acs=
Subject: FAILED: patch "[PATCH] wifi: mac80211: Discard Beacon frames to non-broadcast" failed to apply to 5.15-stable tree
To: jouni.malinen@oss.qualcomm.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 13:39:23 +0100
Message-ID: <2026010523-fifty-navigator-ec96@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 193d18f60588e95d62e0f82b6a53893e5f2f19f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010523-fifty-navigator-ec96@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


