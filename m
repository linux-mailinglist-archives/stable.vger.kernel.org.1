Return-Path: <stable+bounces-55178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA9B916270
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11850282056
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A4F1494DC;
	Tue, 25 Jun 2024 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tKcfnzB8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238FFBEF;
	Tue, 25 Jun 2024 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308141; cv=none; b=oVUoeyW655nfZrSavyvwY+C6tfL8ZG2EN5r6eJiOZUA4+QSIucbleQHKHUhivY+3mDJdoS25tiUxBxv6lLsIvHXiNSztmaGvuyv+vP1Np0PsnVF13Cae361tASm0vQDc/FypcNY+hlUDJXHHzgIYALUaJsMAXyuuQSC74+zgqPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308141; c=relaxed/simple;
	bh=Z+XG3xtmLKsughA8uqtg5SMGzNVvdn6R7jcfXstsbO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWkpPChHz7RJgNXsr9I40x/bUjOTyG1JhIBxhr8Ikbv7ruFuaxp9m6x8gDGxWEeN9nUXpxc/QTVMZGGcwbWR4G8lLawgY2rmUkLOdBPDcHlCiVWV6HrulY9vUSCPmJROq0n1T6wyPraGL2WJtg80fo8CW3uubTSytdHgeIoRsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tKcfnzB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD14EC32781;
	Tue, 25 Jun 2024 09:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308141;
	bh=Z+XG3xtmLKsughA8uqtg5SMGzNVvdn6R7jcfXstsbO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tKcfnzB8f4QZvyXdVJYlZsOAeQqJ9RexaWxhD0XhIfH/DRNUJmQi1f797qn4OoNof
	 Bx72JU7H68/6/jqwL7VCVMBeUfj6bwh3GyY/M9WRiBBPONdb8BwDP7bx6shBwsNLqS
	 qrxv/Q9kF3BVRs/KkkbQAAbbN7AtFL1sOcWqiTDA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 020/250] wifi: rtw89: 8852c: add quirk to set PCI BER for certain platforms
Date: Tue, 25 Jun 2024 11:29:38 +0200
Message-ID: <20240625085548.829787573@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 5b919d726b613c78d4dc463dd9f90c55843fd1b3 ]

Increase PCI BER (bit error rate) count depth setting which could increase
PHY circuit fault tolerance and improve compatibility.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://msgid.link/20240329015251.22762-4-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 18 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     | 10 ++++++++
 drivers/net/wireless/realtek/rtw89/pci.c      | 19 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h      |  5 ++++
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    | 23 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  1 +
 9 files changed, 79 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d474b8d5df3dd..b8d419a5b9db0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4069,6 +4069,24 @@ void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg eve
 	}
 }
 
+void rtw89_check_quirks(struct rtw89_dev *rtwdev, const struct dmi_system_id *quirks)
+{
+	const struct dmi_system_id *match;
+	enum rtw89_quirks quirk;
+
+	if (!quirks)
+		return;
+
+	for (match = dmi_first_match(quirks); match; match = dmi_first_match(match + 1)) {
+		quirk = (uintptr_t)match->driver_data;
+		if (quirk >= NUM_OF_RTW89_QUIRKS)
+			continue;
+
+		set_bit(quirk, rtwdev->quirks);
+	}
+}
+EXPORT_SYMBOL(rtw89_check_quirks);
+
 int rtw89_core_start(struct rtw89_dev *rtwdev)
 {
 	int ret;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2e854c9af7099..509d84a493348 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -7,6 +7,7 @@
 
 #include <linux/average.h>
 #include <linux/bitfield.h>
+#include <linux/dmi.h>
 #include <linux/firmware.h>
 #include <linux/iopoll.h>
 #include <linux/workqueue.h>
@@ -3977,6 +3978,7 @@ union rtw89_bus_info {
 
 struct rtw89_driver_info {
 	const struct rtw89_chip_info *chip;
+	const struct dmi_system_id *quirks;
 	union rtw89_bus_info bus;
 };
 
@@ -4324,6 +4326,12 @@ enum rtw89_flags {
 	NUM_OF_RTW89_FLAGS,
 };
 
+enum rtw89_quirks {
+	RTW89_QUIRK_PCI_BER,
+
+	NUM_OF_RTW89_QUIRKS,
+};
+
 enum rtw89_pkt_drop_sel {
 	RTW89_PKT_DROP_SEL_MACID_BE_ONCE,
 	RTW89_PKT_DROP_SEL_MACID_BK_ONCE,
@@ -5084,6 +5092,7 @@ struct rtw89_dev {
 	DECLARE_BITMAP(mac_id_map, RTW89_MAX_MAC_ID_NUM);
 	DECLARE_BITMAP(flags, NUM_OF_RTW89_FLAGS);
 	DECLARE_BITMAP(pkt_offload, RTW89_MAX_PKT_OFLD_NUM);
+	DECLARE_BITMAP(quirks, NUM_OF_RTW89_QUIRKS);
 
 	struct rtw89_phy_stat phystat;
 	struct rtw89_rfk_wait_info rfk_wait;
@@ -6129,6 +6138,7 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 void rtw89_core_set_tid_config(struct rtw89_dev *rtwdev,
 			       struct ieee80211_sta *sta,
 			       struct cfg80211_tid_config *tid_config);
+void rtw89_check_quirks(struct rtw89_dev *rtwdev, const struct dmi_system_id *quirks);
 int rtw89_core_init(struct rtw89_dev *rtwdev);
 void rtw89_core_deinit(struct rtw89_dev *rtwdev);
 int rtw89_core_register(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 0afe22e568f43..3b0d97da048dc 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2299,6 +2299,22 @@ static int rtw89_pci_deglitch_setting(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static void rtw89_pci_ber(struct rtw89_dev *rtwdev)
+{
+	u32 phy_offset;
+
+	if (!test_bit(RTW89_QUIRK_PCI_BER, rtwdev->quirks))
+		return;
+
+	phy_offset = R_RAC_DIRECT_OFFSET_G1;
+	rtw89_write16(rtwdev, phy_offset + RAC_ANA1E * RAC_MULT, RAC_ANA1E_G1_VAL);
+	rtw89_write16(rtwdev, phy_offset + RAC_ANA2E * RAC_MULT, RAC_ANA2E_VAL);
+
+	phy_offset = R_RAC_DIRECT_OFFSET_G2;
+	rtw89_write16(rtwdev, phy_offset + RAC_ANA1E * RAC_MULT, RAC_ANA1E_G2_VAL);
+	rtw89_write16(rtwdev, phy_offset + RAC_ANA2E * RAC_MULT, RAC_ANA2E_VAL);
+}
+
 static void rtw89_pci_rxdma_prefth(struct rtw89_dev *rtwdev)
 {
 	if (rtwdev->chip->chip_id != RTL8852A)
@@ -2696,6 +2712,7 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	int ret;
 
+	rtw89_pci_ber(rtwdev);
 	rtw89_pci_rxdma_prefth(rtwdev);
 	rtw89_pci_l1off_pwroff(rtwdev);
 	rtw89_pci_deglitch_setting(rtwdev);
@@ -4172,6 +4189,8 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rtwdev->hci.rpwm_addr = pci_info->rpwm_addr;
 	rtwdev->hci.cpwm_addr = pci_info->cpwm_addr;
 
+	rtw89_check_quirks(rtwdev, info->quirks);
+
 	SET_IEEE80211_DEV(rtwdev->hw, &pdev->dev);
 
 	ret = rtw89_core_init(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index a63b6b7c9bfaf..87e7081664c1f 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -26,11 +26,16 @@
 #define RAC_REG_FLD_0			0x1D
 #define BAC_AUTOK_N_MASK		GENMASK(3, 2)
 #define PCIE_AUTOK_4			0x3
+#define RAC_ANA1E			0x1E
+#define RAC_ANA1E_G1_VAL		0x66EA
+#define RAC_ANA1E_G2_VAL		0x6EEA
 #define RAC_ANA1F			0x1F
 #define RAC_ANA24			0x24
 #define B_AX_DEGLITCH			GENMASK(11, 8)
 #define RAC_ANA26			0x26
 #define B_AX_RXEN			GENMASK(15, 14)
+#define RAC_ANA2E			0x2E
+#define RAC_ANA2E_VAL			0xFFFE
 #define RAC_CTRL_PPR_V1			0x30
 #define B_AX_CLK_CALIB_EN		BIT(12)
 #define B_AX_CALIB_EN			BIT(13)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851be.c b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
index ca1374a717272..ec3629d95fda1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851be.c
@@ -63,6 +63,7 @@ static const struct rtw89_pci_info rtw8851b_pci_info = {
 
 static const struct rtw89_driver_info rtw89_8851be_info = {
 	.chip = &rtw8851b_chip_info,
+	.quirks = NULL,
 	.bus = {
 		.pci = &rtw8851b_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 7c6ffedb77e27..fdee5dd4ba148 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -61,6 +61,7 @@ static const struct rtw89_pci_info rtw8852a_pci_info = {
 
 static const struct rtw89_driver_info rtw89_8852ae_info = {
 	.chip = &rtw8852a_chip_info,
+	.quirks = NULL,
 	.bus = {
 		.pci = &rtw8852a_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852be.c b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
index ed71364e6437b..5f941122655c4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852be.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852be.c
@@ -63,6 +63,7 @@ static const struct rtw89_pci_info rtw8852b_pci_info = {
 
 static const struct rtw89_driver_info rtw89_8852be_info = {
 	.chip = &rtw8852b_chip_info,
+	.quirks = NULL,
 	.bus = {
 		.pci = &rtw8852b_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index 583ea673a4f54..e07c7f3ade41e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -68,8 +68,31 @@ static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.recognize_intrs	= rtw89_pci_recognize_intrs_v1,
 };
 
+static const struct dmi_system_id rtw8852c_pci_quirks[] = {
+	{
+		.ident = "Dell Inc. Vostro 16 5640",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 16 5640"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "0CA0"),
+		},
+		.driver_data = (void *)RTW89_QUIRK_PCI_BER,
+	},
+	{
+		.ident = "Dell Inc. Inspiron 16 5640",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 16 5640"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "0C9F"),
+		},
+		.driver_data = (void *)RTW89_QUIRK_PCI_BER,
+	},
+	{},
+};
+
 static const struct rtw89_driver_info rtw89_8852ce_info = {
 	.chip = &rtw8852c_chip_info,
+	.quirks = rtw8852c_pci_quirks,
 	.bus = {
 		.pci = &rtw8852c_pci_info,
 	},
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 4981b657bd7b0..ce8aaa9501e16 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -61,6 +61,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 
 static const struct rtw89_driver_info rtw89_8922ae_info = {
 	.chip = &rtw8922a_chip_info,
+	.quirks = NULL,
 	.bus = {
 		.pci = &rtw8922a_pci_info,
 	},
-- 
2.43.0




