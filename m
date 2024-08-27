Return-Path: <stable+bounces-70857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509AC96105F
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089F628174B
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405531E520;
	Tue, 27 Aug 2024 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YQTT2tm8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFCA12E4D;
	Tue, 27 Aug 2024 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771292; cv=none; b=qXCNaLQlUjU2GLQrEoAHYiJPOm2cfqBkeMiZP5yDgEsrtJhdRpUloV84YhhHrSmqXnQC5Y5tWU5lo1jm9JHxCQJIjoHeIgAasZISzbHi5o/1V61Cy5wGwwfR/QQXvXMlycMMlpBr/gD9Bdg95XqN/zzOM1s0P6OewZOTxQT1nsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771292; c=relaxed/simple;
	bh=Hjbl1raZC+wVEyc5AW8JiZYJDdHpTxlvpil0oMwb9Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L246Kg7PXMmN3GWHkTAujb9Ek/MW0AcAS29JK1C7dBvoyZX3crjRhdBMUiLAOpVhSS+K0E0jxUvVY5o1oczIti1o09V2rb4HQSyE5qnDRqSK84P6EYNnogONRlESfF6FkoYc5eaF5yHgOLi2g25QrChBQQzhrvYWOYuWTKQHevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YQTT2tm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2A3C61074;
	Tue, 27 Aug 2024 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771291;
	bh=Hjbl1raZC+wVEyc5AW8JiZYJDdHpTxlvpil0oMwb9Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQTT2tm8QxuM5lr0Dd9bKwAPDT2eOlnem1s0nmoVGRZGuT61bmrpDkl0vlu8ggr+R
	 YNmDmK6qGdRqTd5cqOpayvTsc4Xp/S6b0QN23zeard3TXUb97bgR72y5iNgu5q8pP0
	 Bj4ECwqsed02+ihv5B4hc9fUIjtYC8Gz/egZdk6M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 145/273] wifi: ath12k: use 128 bytes aligned iova in transmit path for WCN7850
Date: Tue, 27 Aug 2024 16:37:49 +0200
Message-ID: <20240827143838.924976567@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 38055789d15155109b41602ad719d770af507030 ]

In transmit path, it is likely that the iova is not aligned to PCIe TLP
max payload size, which is 128 for WCN7850. Normally in such cases hardware
is expected to split the packet into several parts in a manner such that
they, other than the first one, have aligned iova. However due to hardware
limitations, WCN7850 does not behave like that properly with some specific
unaligned iova in transmit path. This easily results in target hang in a
KPI transmit test: packet send/receive failure, WMI command send timeout
etc. Also fatal error seen in PCIe level:

	...
	Capabilities: ...
		...
		DevSta: ... FatalErr+ ...
		...
	...

Work around this by manually moving/reallocating payload buffer such that
we can map it to a 128 bytes aligned iova. The moving requires sufficient
head room or tail room in skb: for the former we can do ourselves a favor
by asking some extra bytes when registering with mac80211, while for the
latter we can do nothing.

Moving/reallocating buffer consumes additional CPU cycles, but the good news
is that an aligned iova increases PCIe efficiency. In my tests on some X86
platforms the KPI results are almost consistent.

Since this is seen only with WCN7850, add a new hardware parameter to
differentiate from others.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <stable@vger.kernel.org>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240715023814.20242-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 72 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/hw.c    |  6 +++
 drivers/net/wireless/ath/ath12k/hw.h    |  4 ++
 drivers/net/wireless/ath/ath12k/mac.c   |  1 +
 4 files changed, 83 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index a7c7a868c14ce..fca9f7e510b41 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -124,6 +124,60 @@ static void ath12k_hal_tx_cmd_ext_desc_setup(struct ath12k_base *ab,
 						 HAL_TX_MSDU_EXT_INFO1_ENCRYPT_TYPE);
 }
 
+static void ath12k_dp_tx_move_payload(struct sk_buff *skb,
+				      unsigned long delta,
+				      bool head)
+{
+	unsigned long len = skb->len;
+
+	if (head) {
+		skb_push(skb, delta);
+		memmove(skb->data, skb->data + delta, len);
+		skb_trim(skb, len);
+	} else {
+		skb_put(skb, delta);
+		memmove(skb->data + delta, skb->data, len);
+		skb_pull(skb, delta);
+	}
+}
+
+static int ath12k_dp_tx_align_payload(struct ath12k_base *ab,
+				      struct sk_buff **pskb)
+{
+	u32 iova_mask = ab->hw_params->iova_mask;
+	unsigned long offset, delta1, delta2;
+	struct sk_buff *skb2, *skb = *pskb;
+	unsigned int headroom = skb_headroom(skb);
+	int tailroom = skb_tailroom(skb);
+	int ret = 0;
+
+	offset = (unsigned long)skb->data & iova_mask;
+	delta1 = offset;
+	delta2 = iova_mask - offset + 1;
+
+	if (headroom >= delta1) {
+		ath12k_dp_tx_move_payload(skb, delta1, true);
+	} else if (tailroom >= delta2) {
+		ath12k_dp_tx_move_payload(skb, delta2, false);
+	} else {
+		skb2 = skb_realloc_headroom(skb, iova_mask);
+		if (!skb2) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		dev_kfree_skb_any(skb);
+
+		offset = (unsigned long)skb2->data & iova_mask;
+		if (offset)
+			ath12k_dp_tx_move_payload(skb2, offset, true);
+		*pskb = skb2;
+	}
+
+out:
+	return ret;
+}
+
 int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 		 struct sk_buff *skb)
 {
@@ -145,6 +199,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 	u8 ring_selector, ring_map = 0;
 	bool tcl_ring_retry;
 	bool msdu_ext_desc = false;
+	u32 iova_mask = ab->hw_params->iova_mask;
 
 	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
 		return -ESHUTDOWN;
@@ -240,6 +295,23 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 		goto fail_remove_tx_buf;
 	}
 
+	if (iova_mask &&
+	    (unsigned long)skb->data & iova_mask) {
+		ret = ath12k_dp_tx_align_payload(ab, &skb);
+		if (ret) {
+			ath12k_warn(ab, "failed to align TX buffer %d\n", ret);
+			/* don't bail out, give original buffer
+			 * a chance even unaligned.
+			 */
+			goto map;
+		}
+
+		/* hdr is pointing to a wrong place after alignment,
+		 * so refresh it for later use.
+		 */
+		hdr = (void *)skb->data;
+	}
+map:
 	ti.paddr = dma_map_single(ab->dev, skb->data, skb->len, DMA_TO_DEVICE);
 	if (dma_mapping_error(ab->dev, ti.paddr)) {
 		atomic_inc(&ab->soc_stats.tx_err.misc_fail);
diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index bff8cf97a18c6..2a92147d15fa1 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -922,6 +922,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_sta_ps = false,
 
 		.acpi_guid = NULL,
+
+		.iova_mask = 0,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -997,6 +999,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_sta_ps = true,
 
 		.acpi_guid = &wcn7850_uuid,
+
+		.iova_mask = ATH12K_PCIE_MAX_PAYLOAD_SIZE - 1,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1067,6 +1071,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.supports_sta_ps = false,
 
 		.acpi_guid = NULL,
+
+		.iova_mask = 0,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 2a314cfc8cb84..400bda17e02f6 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -96,6 +96,8 @@
 #define ATH12K_M3_FILE			"m3.bin"
 #define ATH12K_REGDB_FILE_NAME		"regdb.bin"
 
+#define ATH12K_PCIE_MAX_PAYLOAD_SIZE	128
+
 enum ath12k_hw_rate_cck {
 	ATH12K_HW_RATE_CCK_LP_11M = 0,
 	ATH12K_HW_RATE_CCK_LP_5_5M,
@@ -214,6 +216,8 @@ struct ath12k_hw_params {
 	bool supports_sta_ps;
 
 	const guid_t *acpi_guid;
+
+	u32 iova_mask;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ead37a4e002a2..8474e25d2ac64 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8737,6 +8737,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 
 	hw->vif_data_size = sizeof(struct ath12k_vif);
 	hw->sta_data_size = sizeof(struct ath12k_sta);
+	hw->extra_tx_headroom = ab->hw_params->iova_mask;
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
-- 
2.43.0




