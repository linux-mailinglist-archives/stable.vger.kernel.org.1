Return-Path: <stable+bounces-112626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84337A28DAB
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680081888ACF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4895A2E634;
	Wed,  5 Feb 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eo6NQVmW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4F15198D;
	Wed,  5 Feb 2025 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764204; cv=none; b=GYxvStUe/NdnbWcRNBEwYAuM2lfjac3yTIPriJo3zCFwnvTN2gufjW8cH3ET2l1vV+Q+BtqQ2VW/ooi+faTSdKymekYgvssF4R/koZdrJIuospjRp2s+IQWgLQHXZHgTLbJKwWW4d+If5Z/cOJt+K0SQ4kvcpX5LbpSX8mP19Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764204; c=relaxed/simple;
	bh=BK0asVENmBEi0OVNJYM0Hl5/vQ6yntgBwwt+Z6YXXog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ci2v0xIw4U+EIyiO3RkzJoGwNj41nToNgkiigRWY9qag/1wL4Ogay74aCUbnIQVOOgHpVOv7zi0ghchW8CX0DqKFQNYW4HD2qG7FM8VGNiv6kqiANJzXjXfzt3OmnVPavxVfpK+EOWpO3KgSrluTiy56vCCxcpURhtXWUbk04JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eo6NQVmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02701C4CED6;
	Wed,  5 Feb 2025 14:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764203;
	bh=BK0asVENmBEi0OVNJYM0Hl5/vQ6yntgBwwt+Z6YXXog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eo6NQVmWbIRXmPcXbavTKpfEetSTgLzQaf42fp9OaxYCPBuzZe83mMyR/VcShFXyO
	 jXs1caj22sUS0xGfjP7ZBlIeyWtrdrKRsHOXWJ0fyBgNympTABvV+Jql6U55SCogEC
	 zXecRBcsIsOQF8o9Y9OdCOya9hTRmbVTp4AxRcko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilan Peer <ilan.peer@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 134/393] wifi: cfg80211: Handle specific BSSID in 6GHz scanning
Date: Wed,  5 Feb 2025 14:40:53 +0100
Message-ID: <20250205134425.424608815@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 0fca7784b7a14d4ede64f479662afb98876ec7f8 ]

When the scan parameters for a 6GHz scan specify a unicast
BSSID address, and the corresponding AP is found in the scan
list, add a corresponding entry in the collocated AP list,
so this AP would be directly probed even if it was not
advertised as a collocated AP.

This is needed for handling a scan request that is intended
for a ML probe flow, where user space can requests a scan
to retrieve information for other links in the AP MLD.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230928172905.54b954bc02ad.I1c072793d3d77a4c8fbbc64b4db5cce1bbb00382@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 1a0d24775cde ("wifi: cfg80211: adjust allocation of colocated AP data")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 4fc6279750ea1..c76ac1959fe8d 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -831,10 +831,47 @@ static int cfg80211_scan_6ghz(struct cfg80211_registered_device *rdev)
 		list_for_each_entry(intbss, &rdev->bss_list, list) {
 			struct cfg80211_bss *res = &intbss->pub;
 			const struct cfg80211_bss_ies *ies;
+			const struct element *ssid_elem;
+			struct cfg80211_colocated_ap *entry;
+			u32 s_ssid_tmp;
+			int ret;
 
 			ies = rcu_access_pointer(res->ies);
 			count += cfg80211_parse_colocated_ap(ies,
 							     &coloc_ap_list);
+
+			/* In case the scan request specified a specific BSSID
+			 * and the BSS is found and operating on 6GHz band then
+			 * add this AP to the collocated APs list.
+			 * This is relevant for ML probe requests when the lower
+			 * band APs have not been discovered.
+			 */
+			if (is_broadcast_ether_addr(rdev_req->bssid) ||
+			    !ether_addr_equal(rdev_req->bssid, res->bssid) ||
+			    res->channel->band != NL80211_BAND_6GHZ)
+				continue;
+
+			ret = cfg80211_calc_short_ssid(ies, &ssid_elem,
+						       &s_ssid_tmp);
+			if (ret)
+				continue;
+
+			entry = kzalloc(sizeof(*entry) + IEEE80211_MAX_SSID_LEN,
+					GFP_ATOMIC);
+
+			if (!entry)
+				continue;
+
+			memcpy(entry->bssid, res->bssid, ETH_ALEN);
+			entry->short_ssid = s_ssid_tmp;
+			memcpy(entry->ssid, ssid_elem->data,
+			       ssid_elem->datalen);
+			entry->ssid_len = ssid_elem->datalen;
+			entry->short_ssid_valid = true;
+			entry->center_freq = res->channel->center_freq;
+
+			list_add_tail(&entry->list, &coloc_ap_list);
+			count++;
 		}
 		spin_unlock_bh(&rdev->bss_lock);
 	}
-- 
2.39.5




