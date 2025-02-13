Return-Path: <stable+bounces-115154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABB1A34230
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F1A189007B
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0803A38389;
	Thu, 13 Feb 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvcors8n"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6928136F
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456999; cv=none; b=k/vXIH0b8hWRO9K2q2nYgSkgGQFZb3EiQl6wQ4ZtbCaq5PZXWYUP9nrZIr2oiiJoLkJYb7wi5NQYid7qS1xq6B71mIWcfupHlY+J1es3KOAxpnV48Dmkw44vgXa08XfHEku6pnyuaS3l/eT31DyBxh8SyPZZ17zP3/Suiw23qZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456999; c=relaxed/simple;
	bh=yOXqDxX7xqnaXxzmNml1TaIF3BOBC57MeLf4S1YzI0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iH5Yfi6eFNsY+9P/2LCCfVjGVV7xByjto9eNdKy4UZ3Myw2DTyDlnQlNVWxPUNv0Ex8KvfE/XCAjiEn1RwR/HleSWQ6Tuw9ZrqaXpRu9F+TIs/uyZ0D4GwuBCvZmvXqxkBuymeyfWJx/yHGatVztytwz02re7a7KErfbEAePnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvcors8n; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so802566a91.2
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 06:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739456997; x=1740061797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ce1ptGyW5z6SnlbvfugnAJ/T3Weg5xPZTleJuf7DPDE=;
        b=kvcors8nBxUHGDom0Y9a3vhNNhzwMGo45fsnnnr6OrbehHYAmV6wPbFhoAyKOqOoAc
         FNsgXNWKa7kNX+jwTemSZ7vx7TdkLWjqVIgit/9NNikGFRG+/+r/dCHs2nFh5q8/ciPH
         StE96y4RKBprU08PpzenDhQ9X6uimIdRzZoBTJXzurSAgUQxxfUudgt5iD7422IHIsLX
         PILghjhv5NlOdEnvrjdmYT0dAXbAgH8lv3smg0vmlORFnovZZ/wGHTUOCSRjygqS9Po7
         MU9o1K9mleHiwB1OvBbhIm8R/IT1G35rKTe8Hmv3N9WcYYSKiUZBMxUnK3Ggs0QJmZ7A
         5AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456997; x=1740061797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ce1ptGyW5z6SnlbvfugnAJ/T3Weg5xPZTleJuf7DPDE=;
        b=Rd8tmKCd90t3cMMAo+9vNrT20+cO9TFCfpH5nA+V4dSo94qfQ+X65zl2/4+Cmeeilq
         axYZqMvMl72fGi7nwiB4mZAqUpsmktz6UjhtuBzf8Hl7MeCY4E1X214uH8uPYuFICnpq
         zqepwdk31qut28vs6u7me46zNehprWTUD1fG3PG26zqhz3GYwu1aYs9+ZTLAl8k3rS4y
         ELGxzXIExN1KBnQzrHVjKPNTXSbrRoNu+AUd4MTN/JpkqidNytu6g7XzLARyQQuk+fih
         KCVv9/t9kGxTJ00pAohQFik90mqkMlbSTdPutd4gZ5KZoNcc7AOStbEefOG90PLx4i09
         3NdA==
X-Gm-Message-State: AOJu0YxwvlpbbJI+Q/g/avT2Ye2F5inGl9VEkoiWdd14g8wkyor1ni2U
	KTYNKNhWpPSQG1PTFvr/caQsKhK0W2u2jxv8KLG6Z/XsdouCG8Z5+1FCr3VS
X-Gm-Gg: ASbGncuvfd2ldz2hPqn2yZC89znkau/UoKrRHnkhLgRrmNv05B/F5wKnzr/WDpuEv0c
	OAvA46Z5qdUtFDh0LrxKjbk1X771jb51f2jlYeaugmNWsB+teCsRv6bTcxYJdnNZ4ghwUCm8/H0
	KYukjb/0hqWkrcr1s6+zFaKwmVittACTIt+VnmbM7B7aJOdoVBapWMKarLbQ8fbgj/Sti+gWvOs
	HGn88MNuLHk1pu0d5DAa2k3dMrrR028Zw2ZZIiyrzNbsn95tqyoNppMPAH9ATKLxAbhd7YRtPSd
	Fwmy0qO8Hpgp5MnZGB+J74LvcG7rKDZNVflxx4fN/6IjsKUcIBsCXnpE1wsxEXK+JQ==
X-Google-Smtp-Source: AGHT+IGbBpNdEtdVz0tS43hxQKVLcVuvSNOVg7HYE42ys+ol+Kxah54IjKvGiJ+h4q8E/dCRWntljA==
X-Received: by 2002:a17:90b:540c:b0:2ee:ee5e:42fb with SMTP id 98e67ed59e1d1-2fbf5bf36a7mr10740044a91.13.1739456997009;
        Thu, 13 Feb 2025 06:29:57 -0800 (PST)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d558edd1sm13147635ad.235.2025.02.13.06.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:29:56 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: stable@vger.kernel.org
Cc: pkshih@realtek.com,
	Zenm Chen <zenmchen@gmail.com>
Subject: [PATCH 6.12.y] wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
Date: Thu, 13 Feb 2025 22:29:46 +0800
Message-ID: <20250213142946.3111-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 9c1df813e08832c3836c254bc8a2f83ff22dbc06 ]

The PCIE wake bit is to control PCIE wake signal to host. When PCIE is
going down, clear this bit to prevent waking up host unexpectedly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20241111063835.15454-1-pkshih@realtek.com
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
Some users of RTL8852BE chip may encounter a shutdown issue [1] and this
upstream patch fixes it, so backport it to kernel 6.12.

[1] https://github.com/lwfinger/rtw89/issues/372
---
 drivers/net/wireless/realtek/rtw89/pci.c    | 17 ++++++++++++++---
 drivers/net/wireless/realtek/rtw89/pci.h    | 11 +++++++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c |  2 ++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 5aef7fa37..0ac84f968 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2492,7 +2492,7 @@ static int rtw89_pci_dphy_delay(struct rtw89_dev *rtwdev)
 				       PCIE_DPHY_DLY_25US, PCIE_PHY_GEN1);
 }
 
-static void rtw89_pci_power_wake(struct rtw89_dev *rtwdev, bool pwr_up)
+static void rtw89_pci_power_wake_ax(struct rtw89_dev *rtwdev, bool pwr_up)
 {
 	if (pwr_up)
 		rtw89_write32_set(rtwdev, R_AX_HCI_OPT_CTRL, BIT_WAKE_CTRL);
@@ -2799,6 +2799,8 @@ static int rtw89_pci_ops_deinit(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 
+	rtw89_pci_power_wake(rtwdev, false);
+
 	if (rtwdev->chip->chip_id == RTL8852A) {
 		/* ltr sw trigger */
 		rtw89_write32_set(rtwdev, R_AX_LTR_CTRL_0, B_AX_APP_LTR_IDLE);
@@ -2841,7 +2843,7 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
-	rtw89_pci_power_wake(rtwdev, true);
+	rtw89_pci_power_wake_ax(rtwdev, true);
 	rtw89_pci_autoload_hang(rtwdev);
 	rtw89_pci_l12_vmain(rtwdev);
 	rtw89_pci_gen2_force_ib(rtwdev);
@@ -2886,6 +2888,13 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_pci_ops_mac_pre_deinit_ax(struct rtw89_dev *rtwdev)
+{
+	rtw89_pci_power_wake_ax(rtwdev, false);
+
+	return 0;
+}
+
 int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev, bool en)
 {
 	u32 val;
@@ -4264,7 +4273,7 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 					    B_AX_RDU_INT},
 
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_ax,
-	.mac_pre_deinit = NULL,
+	.mac_pre_deinit = rtw89_pci_ops_mac_pre_deinit_ax,
 	.mac_post_init = rtw89_pci_ops_mac_post_init_ax,
 
 	.clr_idx_all = rtw89_pci_clr_idx_all_ax,
@@ -4280,6 +4289,8 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 	.aspm_set = rtw89_pci_aspm_set_ax,
 	.clkreq_set = rtw89_pci_clkreq_set_ax,
 	.l1ss_set = rtw89_pci_l1ss_set_ax,
+
+	.power_wake = rtw89_pci_power_wake_ax,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_ax);
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 48c3ab735..0ea4dcb84 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1276,6 +1276,8 @@ struct rtw89_pci_gen_def {
 	void (*aspm_set)(struct rtw89_dev *rtwdev, bool enable);
 	void (*clkreq_set)(struct rtw89_dev *rtwdev, bool enable);
 	void (*l1ss_set)(struct rtw89_dev *rtwdev, bool enable);
+
+	void (*power_wake)(struct rtw89_dev *rtwdev, bool pwr_up);
 };
 
 struct rtw89_pci_info {
@@ -1766,4 +1768,13 @@ static inline int rtw89_pci_poll_txdma_ch_idle(struct rtw89_dev *rtwdev)
 
 	return gen_def->poll_txdma_ch_idle(rtwdev);
 }
+
+static inline void rtw89_pci_power_wake(struct rtw89_dev *rtwdev, bool pwr_up)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+
+	gen_def->power_wake(rtwdev, pwr_up);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 7cc328222..2f0d9ff25 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -614,5 +614,7 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.aspm_set = rtw89_pci_aspm_set_be,
 	.clkreq_set = rtw89_pci_clkreq_set_be,
 	.l1ss_set = rtw89_pci_l1ss_set_be,
+
+	.power_wake = _patch_pcie_power_wake_be,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_be);
-- 
2.48.1


