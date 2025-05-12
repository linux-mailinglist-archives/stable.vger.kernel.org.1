Return-Path: <stable+bounces-143378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A93A0AB3F8D
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A6C16BAC0
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6E0296FA4;
	Mon, 12 May 2025 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVXPMijo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF61296D35;
	Mon, 12 May 2025 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071791; cv=none; b=lN2z2nDuVzysStnqvNWJCwWq/JdZbDKiYW7cDH4jGebr72JfEg2xpASkDXDOpv0ZxeZAmD/ukYsm9tjxG/br3QQovzlluAg7u8LRPqW8C0iVP9p3YUzmLSqXiuwruU0DWvyAfImE3xF2Y8pRab9Z2pLLruhEBGPeUqjmRXRpCa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071791; c=relaxed/simple;
	bh=zwGlHyiQToS616KeTGho3fu/Ut83EV+zCm5ohFdcb3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9YU5EnZUh+ZchhevNFkeTKgLOM7itH6lz5cgTcB/snkDViqA106dhoHioK2JkgqompYpy2hUH2Ik++HClONrlQ7xoLPAWKCsvqzjrK+kqWmljnf3u/OIY6RWweR6lEulz9rx9f6icTOQ4tEiAB8aS3gHKmIKqdyzZeGpH8C0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NVXPMijo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C314C4CEE7;
	Mon, 12 May 2025 17:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747071790;
	bh=zwGlHyiQToS616KeTGho3fu/Ut83EV+zCm5ohFdcb3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NVXPMijoyt169FfGgyWO6XQD8eWQtMccDjkO4paPmxgeGoJYGcg5Pq0bFcg3Kb4kE
	 HSp8JumuYpo3SoNStbxUmb7FJ9+01bWOBJbTovomUPr/YMpJug0rN6HQIpr+w2xUHS
	 w9AvIZrCHTBoAHmuUz6UTjXJKoqFNW1ebkZsjj5A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael-CY Lee <michael-cy.lee@mediatek.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 028/197] wifi: mac80211: fix the type of status_code for negotiated TID to Link Mapping
Date: Mon, 12 May 2025 19:37:58 +0200
Message-ID: <20250512172045.510152843@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
References: <20250512172044.326436266@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael-CY Lee <michael-cy.lee@mediatek.com>

[ Upstream commit e12a42f64fc3d74872b349eedd47f90c6676b78a ]

The status code should be type of __le16.

Fixes: 83e897a961b8 ("wifi: ieee80211: add definitions for negotiated TID to Link map")
Fixes: 8f500fbc6c65 ("wifi: mac80211: process and save negotiated TID to Link mapping request")
Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Link: https://patch.msgid.link/20250505081946.3927214-1-michael-cy.lee@mediatek.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ieee80211.h |  2 +-
 net/mac80211/mlme.c       | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 16741e542e81c..07dcd80f3310c 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1526,7 +1526,7 @@ struct ieee80211_mgmt {
 				struct {
 					u8 action_code;
 					u8 dialog_token;
-					u8 status_code;
+					__le16 status_code;
 					u8 variable[];
 				} __packed ttlm_res;
 				struct {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 99e9b03d7fe19..e3deb89674b23 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7412,6 +7412,7 @@ ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.ttlm_res);
 	int ttlm_max_len = 2 + 1 + sizeof(struct ieee80211_ttlm_elem) + 1 +
 		2 * 2 * IEEE80211_TTLM_NUM_TIDS;
+	u16 status_code;
 
 	skb = dev_alloc_skb(local->tx_headroom + hdr_len + ttlm_max_len);
 	if (!skb)
@@ -7434,19 +7435,18 @@ ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 		WARN_ON(1);
 		fallthrough;
 	case NEG_TTLM_RES_REJECT:
-		mgmt->u.action.u.ttlm_res.status_code =
-			WLAN_STATUS_DENIED_TID_TO_LINK_MAPPING;
+		status_code = WLAN_STATUS_DENIED_TID_TO_LINK_MAPPING;
 		break;
 	case NEG_TTLM_RES_ACCEPT:
-		mgmt->u.action.u.ttlm_res.status_code = WLAN_STATUS_SUCCESS;
+		status_code = WLAN_STATUS_SUCCESS;
 		break;
 	case NEG_TTLM_RES_SUGGEST_PREFERRED:
-		mgmt->u.action.u.ttlm_res.status_code =
-			WLAN_STATUS_PREF_TID_TO_LINK_MAPPING_SUGGESTED;
+		status_code = WLAN_STATUS_PREF_TID_TO_LINK_MAPPING_SUGGESTED;
 		ieee80211_neg_ttlm_add_suggested_map(skb, neg_ttlm);
 		break;
 	}
 
+	mgmt->u.action.u.ttlm_res.status_code = cpu_to_le16(status_code);
 	ieee80211_tx_skb(sdata, skb);
 }
 
@@ -7612,7 +7612,7 @@ void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 	 * This can be better implemented in the future, to handle request
 	 * rejections.
 	 */
-	if (mgmt->u.action.u.ttlm_res.status_code != WLAN_STATUS_SUCCESS)
+	if (le16_to_cpu(mgmt->u.action.u.ttlm_res.status_code) != WLAN_STATUS_SUCCESS)
 		__ieee80211_disconnect(sdata);
 }
 
-- 
2.39.5




