Return-Path: <stable+bounces-171329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78DAB2A90A
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CDA62699F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAFA1D88D7;
	Mon, 18 Aug 2025 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JNdiI8ix"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C727B358;
	Mon, 18 Aug 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525556; cv=none; b=M0PX70nZml/Efl2KLMv7I/ISZFWo5ZdHKelPSBXjNplQXgRqyd8JblCcD8yC2fIoAGgoz6eRGWZWiLA6yb+RIbVX0EEhrrHk6jzGoDyLIIG1d4NGK5sH9WM6nDugLH+aSARlgoBx5uhPiU+gaS/k8/7Ql4YRnP81k1uvF6c58RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525556; c=relaxed/simple;
	bh=37nbH6HNLJJkm6jUWv0P/OUUhaK8heVq78SIm46f0y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgZVHVfVMTbz0hz0TnfOCa/SyENDwAHOv2Zr3QznJYPICru5vhbQzRpnHha22W3XHYY+9HYWOjU/qffwFOkQg1iab/ewtRazkF3JDFA6zJG8OcPviAgD0gZFHxxSBz1Z9m+AogFQ60qZ1nvKuMzcIzpdghhjWZ0PKDw3B2Rj10s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JNdiI8ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F89DC4CEEB;
	Mon, 18 Aug 2025 13:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755525556;
	bh=37nbH6HNLJJkm6jUWv0P/OUUhaK8heVq78SIm46f0y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JNdiI8ixSlGrRDdcCTKN2lM19f1xHIWpwNy4maIZAjFuEFaDdujFQUdyIFUAw/KX2
	 8zDe/9vEZVMB5otiw4v1bJxluiG+fu3VajiJFaCraOihH9pkAXBo1vi5I8weR4M4up
	 CwL/IkbmoirkCKlhyDdnhLrjABfQ99TNmrIWDSs0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 298/570] wifi: ath12k: Fix beacon reception for sta associated to Non-TX AP
Date: Mon, 18 Aug 2025 14:44:45 +0200
Message-ID: <20250818124517.330213630@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

[ Upstream commit ce7c93d196bfd2190dc4a0b86deee04e82042ed1 ]

Currently, when a station is associated with a Non-Transmitting BSS of an
MBSSID set, beacons are not frequently received from the firmware. This
results in missing events via beacons, such as channel switches, leading
to the station not switching to new channel as the AP does, eventually
causing a kick out event from the firmware. This issue arises due to
missing configuration of Non-Transmitting BSS information in station's
vdev up command.

Fix this by filling information such as the Transmitting BSSID, profile index
and profile count in vdev up command of station.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250530035615.3178480-3-rameshkumar.sundaram@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 56 ++++++++++++++++++---------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 23469d0cc9b3..13f44239abde 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -602,6 +602,33 @@ ath12k_mac_get_tx_arvif(struct ath12k_link_vif *arvif,
 	return NULL;
 }
 
+static const u8 *ath12k_mac_get_tx_bssid(struct ath12k_link_vif *arvif)
+{
+	struct ieee80211_bss_conf *link_conf;
+	struct ath12k_link_vif *tx_arvif;
+	struct ath12k *ar = arvif->ar;
+
+	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
+
+	link_conf = ath12k_mac_get_link_bss_conf(arvif);
+	if (!link_conf) {
+		ath12k_warn(ar->ab,
+			    "unable to access bss link conf for link %u required to retrieve transmitting link conf\n",
+			    arvif->link_id);
+		return NULL;
+	}
+	if (link_conf->vif->type == NL80211_IFTYPE_STATION) {
+		if (link_conf->nontransmitted)
+			return link_conf->transmitter_bssid;
+	} else {
+		tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
+		if (tx_arvif)
+			return tx_arvif->bssid;
+	}
+
+	return NULL;
+}
+
 struct ieee80211_bss_conf *
 ath12k_mac_get_link_bss_conf(struct ath12k_link_vif *arvif)
 {
@@ -1691,8 +1718,6 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 {
 	struct ath12k_wmi_vdev_up_params params = {};
 	struct ath12k_vif *ahvif = arvif->ahvif;
-	struct ieee80211_bss_conf *link_conf;
-	struct ath12k_link_vif *tx_arvif;
 	struct ath12k *ar = arvif->ar;
 	int ret;
 
@@ -1723,18 +1748,8 @@ static void ath12k_control_beaconing(struct ath12k_link_vif *arvif,
 	params.vdev_id = arvif->vdev_id;
 	params.aid = ahvif->aid;
 	params.bssid = arvif->bssid;
-
-	link_conf = ath12k_mac_get_link_bss_conf(arvif);
-	if (!link_conf) {
-		ath12k_warn(ar->ab,
-			    "unable to access bss link conf for link %u required to retrieve transmitting link conf\n",
-			    arvif->link_id);
-		return;
-	}
-
-	tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
-	if (tx_arvif) {
-		params.tx_bssid = tx_arvif->bssid;
+	params.tx_bssid = ath12k_mac_get_tx_bssid(arvif);
+	if (params.tx_bssid) {
 		params.nontx_profile_idx = info->bssid_index;
 		params.nontx_profile_cnt = 1 << info->bssid_indicator;
 	}
@@ -3265,6 +3280,11 @@ static void ath12k_bss_assoc(struct ath12k *ar,
 	params.vdev_id = arvif->vdev_id;
 	params.aid = ahvif->aid;
 	params.bssid = arvif->bssid;
+	params.tx_bssid = ath12k_mac_get_tx_bssid(arvif);
+	if (params.tx_bssid) {
+		params.nontx_profile_idx = bss_conf->bssid_index;
+		params.nontx_profile_cnt = 1 << bss_conf->bssid_indicator;
+	}
 	ret = ath12k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to set vdev %d up: %d\n",
@@ -10010,7 +10030,7 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 			   int n_vifs)
 {
 	struct ath12k_wmi_vdev_up_params params = {};
-	struct ath12k_link_vif *arvif, *tx_arvif;
+	struct ath12k_link_vif *arvif;
 	struct ieee80211_bss_conf *link_conf;
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_vif *vif;
@@ -10082,10 +10102,8 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 		params.vdev_id = arvif->vdev_id;
 		params.aid = ahvif->aid;
 		params.bssid = arvif->bssid;
-
-		tx_arvif = ath12k_mac_get_tx_arvif(arvif, link_conf);
-		if (tx_arvif) {
-			params.tx_bssid = tx_arvif->bssid;
+		params.tx_bssid = ath12k_mac_get_tx_bssid(arvif);
+		if (params.tx_bssid) {
 			params.nontx_profile_idx = link_conf->bssid_index;
 			params.nontx_profile_cnt = 1 << link_conf->bssid_indicator;
 		}
-- 
2.39.5




