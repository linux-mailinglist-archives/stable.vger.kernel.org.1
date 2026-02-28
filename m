Return-Path: <stable+bounces-220359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE4WJnk1o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:35:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1184B1C602A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE955316E7AF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF2D347FFB;
	Sat, 28 Feb 2026 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoYojGtS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F36839F557;
	Sat, 28 Feb 2026 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300256; cv=none; b=VgwLSPpo/BQXXO8fCBggsGuKUJOjfh87y7KWnope8ZV8pFgJB/qG83RpMAdHBFfs3XHLwmEBZAlwYg+UnQKpF/ufLYiVylctObMlcMYvpxraZujvkgvIqXqgi4pcDfYZ1HQ7hJbX52dGH0KBKmqcZ4PldW9ZNfqq91XcarV6vxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300256; c=relaxed/simple;
	bh=qAzAVjQg2F7q+HOQT07q23f09EcjIIYvY67EeBdClVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtc+hNxyO6p8Jx2XNplb9rVitP0Kc+JfuNyXsKR0Rf7EH5zrMii5X10smhtVc2x5unPgNHVu2umBn5U7pP0uEKd7xyx/w/nDCn/VYe9/enZQgpLQEfycDilYYaafAAmq9y4fvqATKMDN+BoPMj2erYR9wbTRJGPB0gTBfp23/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoYojGtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC518C116D0;
	Sat, 28 Feb 2026 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300256;
	bh=qAzAVjQg2F7q+HOQT07q23f09EcjIIYvY67EeBdClVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoYojGtSwuoqzQ3CA+Y5+iSW1TTj9DOXV7oGSUhSq/kM87NwXvF2geBE/SypHZx3n
	 dCPPp3YvCSif1x6+mAJk5zP2+ObJGoMDgJ3sySSDJUaTingD4ohJVW66LmbHL+lEXC
	 xAuDCRurUnvkQEzOVgObiq1J67AyoF0ndoil+brda2L3QoWRytXVYIkQmGd/yy+Fvn
	 XWCG/QxMW0eW/4QRvjsUtugV0zfa57MkZs+EUgDdDQMygkd46oOKMORTeDV3YyfR2P
	 lTt0jWoK4U7Ht2jBOI7GFhjiGrNEFescfYu8siOnO3G8VHZnQM5KkG8v8D8JRVT1M2
	 QCtzWMUAtmzeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 281/844] wifi: ath12k: fix mac phy capability parsing
Date: Sat, 28 Feb 2026 12:23:14 -0500
Message-ID: <20260228173244.1509663-282-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220359-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1184B1C602A
X-Rspamd-Action: no action

From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

[ Upstream commit b5151c9b6e3a347416a4b4b55fc00195526d8771 ]

Currently ath12k_pull_mac_phy_cap_svc_ready_ext() assumes only one band
supported in each phy, hence it skips 5 GHz band if 2 GHz band support
is detected. This does not work for device which gets only one phy but
has both bands supported, such as QCC2072.

Change to check each band individually to fix this issue.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20260112-ath12k-support-qcc2072-v2-6-fc8ce1e43969@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 12f4d378f50d4..1613492b38350 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -496,6 +496,7 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 	struct ath12k_band_cap *cap_band;
 	struct ath12k_pdev_cap *pdev_cap = &pdev->cap;
 	struct ath12k_fw_pdev *fw_pdev;
+	u32 supported_bands;
 	u32 phy_map;
 	u32 hw_idx, phy_idx = 0;
 	int i;
@@ -519,14 +520,19 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 		return -EINVAL;
 
 	mac_caps = wmi_mac_phy_caps + phy_idx;
+	supported_bands = le32_to_cpu(mac_caps->supported_bands);
+
+	if (!(supported_bands & WMI_HOST_WLAN_2GHZ_CAP) &&
+	    !(supported_bands & WMI_HOST_WLAN_5GHZ_CAP))
+		return -EINVAL;
 
 	pdev->pdev_id = ath12k_wmi_mac_phy_get_pdev_id(mac_caps);
 	pdev->hw_link_id = ath12k_wmi_mac_phy_get_hw_link_id(mac_caps);
-	pdev_cap->supported_bands |= le32_to_cpu(mac_caps->supported_bands);
+	pdev_cap->supported_bands |= supported_bands;
 	pdev_cap->ampdu_density = le32_to_cpu(mac_caps->ampdu_density);
 
 	fw_pdev = &ab->fw_pdev[ab->fw_pdev_count];
-	fw_pdev->supported_bands = le32_to_cpu(mac_caps->supported_bands);
+	fw_pdev->supported_bands = supported_bands;
 	fw_pdev->pdev_id = ath12k_wmi_mac_phy_get_pdev_id(mac_caps);
 	fw_pdev->phy_id = le32_to_cpu(mac_caps->phy_id);
 	ab->fw_pdev_count++;
@@ -535,10 +541,12 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 	 * band to band for a single radio, need to see how this should be
 	 * handled.
 	 */
-	if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_2GHZ_CAP) {
+	if (supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
 		pdev_cap->tx_chain_mask = le32_to_cpu(mac_caps->tx_chain_mask_2g);
 		pdev_cap->rx_chain_mask = le32_to_cpu(mac_caps->rx_chain_mask_2g);
-	} else if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_5GHZ_CAP) {
+	}
+
+	if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
 		pdev_cap->vht_cap = le32_to_cpu(mac_caps->vht_cap_info_5g);
 		pdev_cap->vht_mcs = le32_to_cpu(mac_caps->vht_supp_mcs_5g);
 		pdev_cap->he_mcs = le32_to_cpu(mac_caps->he_supp_mcs_5g);
@@ -548,8 +556,6 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 			WMI_NSS_RATIO_EN_DIS_GET(mac_caps->nss_ratio);
 		pdev_cap->nss_ratio_info =
 			WMI_NSS_RATIO_INFO_GET(mac_caps->nss_ratio);
-	} else {
-		return -EINVAL;
 	}
 
 	/* tx/rx chainmask reported from fw depends on the actual hw chains used,
@@ -565,7 +571,7 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 	pdev_cap->rx_chain_mask_shift =
 			find_first_bit((unsigned long *)&pdev_cap->rx_chain_mask, 32);
 
-	if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_2GHZ_CAP) {
+	if (supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
 		cap_band = &pdev_cap->band[NL80211_BAND_2GHZ];
 		cap_band->phy_id = le32_to_cpu(mac_caps->phy_id);
 		cap_band->max_bw_supported = le32_to_cpu(mac_caps->max_bw_supported_2g);
@@ -585,7 +591,7 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 				le32_to_cpu(mac_caps->he_ppet2g.ppet16_ppet8_ru3_ru0[i]);
 	}
 
-	if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_5GHZ_CAP) {
+	if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
 		cap_band = &pdev_cap->band[NL80211_BAND_5GHZ];
 		cap_band->phy_id = le32_to_cpu(mac_caps->phy_id);
 		cap_band->max_bw_supported =
-- 
2.51.0


