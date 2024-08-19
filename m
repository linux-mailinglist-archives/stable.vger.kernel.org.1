Return-Path: <stable+bounces-69509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7272095677C
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82651F2228F
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1B615C14A;
	Mon, 19 Aug 2024 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EcW5ZPQO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D59E15B12C
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724061042; cv=none; b=fHZwowTPuXhxwWpQ1YX6GrsX+XblevGFXDaHZg5darv1/FpS5nW76hVTCl3F+nIrzK6aNnvzVUyQ240OHaMi27OcJ9JnN6EvP0xO7nkwMJjoj0J48A1DfF3Ij0PhpdyU5cBVKb2804QNWL5nCadfVy+b0dzP833CwKkNwACp/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724061042; c=relaxed/simple;
	bh=YAgZUXbmwRQUdvwlC7aSFg0E68GBLeKCsNj1fdM2WPI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tzG7OnJUhc1TUy5CvWi5qtKZYSCOVl2nmPDfcPijymJlTdmbT2cptdbNbEs367vW8qesVvnel6NQzcLN9X2OM1pXD86pAM5G650uuC1DNFodJjC63UvVCdolRdZpC0Lfl/Clr+8eyd7XNtiFdK0UV62RGBvkKuGt0C5M/7x8cHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EcW5ZPQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9E2C32782;
	Mon, 19 Aug 2024 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724061042;
	bh=YAgZUXbmwRQUdvwlC7aSFg0E68GBLeKCsNj1fdM2WPI=;
	h=Subject:To:Cc:From:Date:From;
	b=EcW5ZPQOdFg4LFoFJWR0dBh2Bqhe6TksAxZ0+CLflbYs+cN54ofvgU5xd3DzR1onP
	 7W86LDUcxCNFshUiM8JkQfnVWjjV4AZF+gx0X86gGCdWxj6Aa84rdfp298jX+FXCfd
	 sWnORyN0/Gi4t6JtEYsENi+oqJxsrD4IClcvb36I=
Subject: FAILED: patch "[PATCH] wifi: ath12k: use 128 bytes aligned iova in transmit path for" failed to apply to 4.19-stable tree
To: quic_bqiang@quicinc.com,mpearson-lenovo@squebb.ca,quic_kvalo@quicinc.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:50:27 +0200
Message-ID: <2024081927-arrogance-stowing-7314@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 38055789d15155109b41602ad719d770af507030
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081927-arrogance-stowing-7314@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

38055789d151 ("wifi: ath12k: use 128 bytes aligned iova in transmit path for WCN7850")
26dd8ccdba4d ("wifi: ath12k: dynamic VLAN support")
97b7cbb7a3cb ("wifi: ath12k: support SMPS configuration for 6 GHz")
f0e61dc7ecf9 ("wifi: ath12k: refactor SMPS configuration")
112dbc6af807 ("wifi: ath12k: add 6 GHz params in peer assoc command")
576771c9fa21 ("wifi: ath12k: ACPI TAS support")
8d5f4da8d70b ("wifi: ath12k: support suspend/resume")
2652f6b472ff ("wifi: ath12k: avoid stopping mac80211 queues in ath12k_core_restart()")
c7b2da3c0a57 ("wifi: ath12k: rearrange IRQ enable/disable in reset path")
303c017821d8 ("wifi: ath12k: fix kernel crash during resume")
f8bde02a26b9 ("wifi: ath12k: initial debugfs support")
54ca3308a23c ("wifi: ath12k: enable 802.11 power save mode in station mode")
2d3a7384b9c8 ("wifi: ath12k: disable QMI PHY capability learn in split-phy QCN9274")
af9bc78d14fb ("wifi: ath12k: Read board id to support split-PHY QCN9274")
f7019c2fcdf6 ("wifi: ath12k: split hal_ops to support RX TLVs word mask compaction")
12f491cd6d81 ("wifi: ath12k: add firmware-2.bin support")
53a65445c144 ("wifi: ath12k: add QMI PHY capability learn support")
76fece36f17a ("wifi: ath12k: refactor QMI MLO host capability helper function")
ce20a10fdff4 ("wifi: ath12k: refactor ath12k_bss_assoc()")
e7ab40b73309 ("wifi: ath12k: Make QMI message rules const")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 38055789d15155109b41602ad719d770af507030 Mon Sep 17 00:00:00 2001
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Thu, 1 Aug 2024 18:04:07 +0300
Subject: [PATCH] wifi: ath12k: use 128 bytes aligned iova in transmit path for
 WCN7850

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

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index d08c04343e90..44406e0b4a34 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -162,6 +162,60 @@ static int ath12k_dp_prepare_htt_metadata(struct sk_buff *skb)
 	return 0;
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
@@ -184,6 +238,7 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 	bool tcl_ring_retry;
 	bool msdu_ext_desc = false;
 	bool add_htt_metadata = false;
+	u32 iova_mask = ab->hw_params->iova_mask;
 
 	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
 		return -ESHUTDOWN;
@@ -279,6 +334,23 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
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
index 2e11ea763574..7b0b6a7f4701 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -924,6 +924,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.acpi_guid = NULL,
 		.supports_dynamic_smps_6ghz = true,
+
+		.iova_mask = 0,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -1000,6 +1002,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.acpi_guid = &wcn7850_uuid,
 		.supports_dynamic_smps_6ghz = false,
+
+		.iova_mask = ATH12K_PCIE_MAX_PAYLOAD_SIZE - 1,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1072,6 +1076,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.acpi_guid = NULL,
 		.supports_dynamic_smps_6ghz = true,
+
+		.iova_mask = 0,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index e792eb6b249b..b1d302c48326 100644
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
@@ -215,6 +217,8 @@ struct ath12k_hw_params {
 
 	const guid_t *acpi_guid;
 	bool supports_dynamic_smps_6ghz;
+
+	u32 iova_mask;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8106297f0bc1..ce41c8153080 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9193,6 +9193,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 
 	hw->vif_data_size = sizeof(struct ath12k_vif);
 	hw->sta_data_size = sizeof(struct ath12k_sta);
+	hw->extra_tx_headroom = ab->hw_params->iova_mask;
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);


