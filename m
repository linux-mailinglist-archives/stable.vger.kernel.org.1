Return-Path: <stable+bounces-158964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99194AEE0B0
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 16:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 588447A1AAE
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 14:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A0F28BABC;
	Mon, 30 Jun 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDjehArq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AA28C03E
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293670; cv=none; b=drJE8+83zoOMJf8ly5VOoTJllcx1gj1F5IvtGzh52bxDZl/XNTazJdCZGFGS3dSHL0PWJ4XEez695qucOJ1VIzz4uARRLKRlm4Guhm1qvbkh+q7yWwLRPOeam+WDJTf5KcMi+VdjYriJIyECE1p2qtHpbn8Yax3srr2fdFGZ3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293670; c=relaxed/simple;
	bh=2KnN1WQXTZclcTxdCcK+47cap7DTWrJ2d78j+ejhcy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDbPzCBkMbMRePYMTurjCvUN5ZG3Z+MzEqRR02nzoShak76nxGhNi6AEG2jg4ZlqzLwUqw7NRwWbfyLdc7zhPDkwmVcisGE/OLAjxjIIPd22mUdiVGxLnuIOnt2kGLXq/Goh6EaGhvN/do/oJyPO36VIXwNUibett0qmSiqP7+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDjehArq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so1954505f8f.3
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 07:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751293667; x=1751898467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPMToTBnaOvrwhblwxnmz8wGV0bxvsiZncyb1RYzzeo=;
        b=aDjehArqScOyiDzKDkEnBBBbMPdqdsSXzarjj5fVFOWWpZUbjjhzL2J8QTg0n7c9Ti
         AlEVgQAV2j3DiLILHEZQOR0pEdkJ0RRfSZlK6nbelZePhMxO4LoJYJJJXM/+rRxlUj1t
         CZlqsfARBm1x179YLyyprLTYQG1qiDcENvKLlT3EYBQklDpPX404+7YnXVtg4//5AgX/
         jP+9faI0NQNNzFtH5edllwRpBs/2IU2LxzHZtxJoX8tZdlYzrpsP6YiLo/zlobS/00x6
         XhJ6/N/WgXfS6EEIkxyJkPppdV/epKjgN07T+lm/koJBjAEMrdsWHWvBpnqbUb8ZYoBP
         Ic5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751293667; x=1751898467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPMToTBnaOvrwhblwxnmz8wGV0bxvsiZncyb1RYzzeo=;
        b=H/ywtnXcyVrNuGvu8PeRrd9taJYR0/kT/khwU8HI04D1hBGQvB15uZlUOwFTRuseWu
         +k8svGEYIgvOSSIwTBKEgQqkM1CTQRI01kvZd+rpyTPBHwMhaXU02iHj/Rtbc3PZ1pwO
         eTor8LO4CaRuyR7F8KzJJe11K2aRYy2N+jFSfKSepJRm5ZZmwbLpgzCHTV2umZb04IHj
         YPuDbfBc/m4zfj2mTmKlRK6uJp4HY4Ua9QfyqZgGmp1VGIlFDET8H96JHDQxLL+pSzhV
         C1KdRtdNwrAHxrc22yQ0G7wnpYOCxtBChIubWE9GzWQL4kjQuPk4xjgtj69xr05GkYE7
         PExQ==
X-Gm-Message-State: AOJu0Yx/VNYJRtrsY9vKHKJrsAzY/zEuA+z2KwK8Ypv47K+qnLZmxZo/
	fq1+S6ptD6gn5yZ/9JGFU0nD9qRhaZBg3dLA8hB7HeMbmQoKyBY06VxpsLCQU3O8
X-Gm-Gg: ASbGncvQEHr1+qMW9TsmoJl/PNV2xS74WCx/cR3vvJneNTHRrH80mhAt+nwO4Xgmknk
	g/XSakGXTUoAnO+EGCY0znMHPepq68RnP2meauqMgzUfsyTM2RAVK6/Hp78qmXwH3oLnrOjAoDN
	HB07fCuF4OU2TSIPui8ELH35EZaoN89P12ImrAoamshvlH+5bXlPcj9OPxb1V3Bhj54egjWSueg
	qjswqS+JWNtRw88Cyb3shSa4ZSv0TOtJzZaRH/M99VQkVQiJbcFAHAcIy0dm5PV9F5cBOlGsRsn
	cKgaIrpZA4hKMhhIhPR8Zn172nZsUOR0429WSEgH2cpy0FOSBJZ0df9db4/iprQ+TkNn4Vn74mv
	wOb1gNq4lCuw=
X-Google-Smtp-Source: AGHT+IFUDMwATAJNlYPJ8np1ZJyncwx0PO/H5ua7Ld20YybKKz+BZGXCLdLpi+vH8to5f1Hnkspnyw==
X-Received: by 2002:adf:b649:0:b0:3a4:dfa9:ce28 with SMTP id ffacd0b85a97d-3a8f4549152mr11164945f8f.5.1751293666610;
        Mon, 30 Jun 2025 07:27:46 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb14:740:2b00:1a5e:fff:fe3d:95be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm165871905e9.10.2025.06.30.07.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:27:46 -0700 (PDT)
From: mathieu.tortuyaux@gmail.com
To: stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y 1/3] r8169: add support for RTL8125D
Date: Mon, 30 Jun 2025 16:27:14 +0200
Message-ID: <20250630142717.70619-2-mathieu.tortuyaux@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630142717.70619-1-mathieu.tortuyaux@gmail.com>
References: <20250630142717.70619-1-mathieu.tortuyaux@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiner Kallweit <hkallweit1@gmail.com>

commit f75d1fbe7809bc5ed134204b920fd9e2fc5db1df upstream.

This adds support for new chip version RTL8125D, which can be found on
boards like Gigabyte X870E AORUS ELITE WIFI7. Firmware rtl8125d-1.fw
for this chip version is available in linux-firmware already.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/d0306912-e88e-4c25-8b5d-545ae8834c0c@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/realtek/r8169.h          |  1 +
 drivers/net/ethernet/realtek/r8169_main.c     | 23 +++++++++++++------
 .../net/ethernet/realtek/r8169_phy_config.c   | 10 ++++++++
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index e2db944e6fa8..be4c9622618d 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -68,6 +68,7 @@ enum mac_version {
 	/* support for RTL_GIGA_MAC_VER_60 has been removed */
 	RTL_GIGA_MAC_VER_61,
 	RTL_GIGA_MAC_VER_63,
+	RTL_GIGA_MAC_VER_64,
 	RTL_GIGA_MAC_VER_65,
 	RTL_GIGA_MAC_VER_66,
 	RTL_GIGA_MAC_NONE
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 85bb5121cd24..7b82779e4cd5 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -55,6 +55,7 @@
 #define FIRMWARE_8107E_2	"rtl_nic/rtl8107e-2.fw"
 #define FIRMWARE_8125A_3	"rtl_nic/rtl8125a-3.fw"
 #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
+#define FIRMWARE_8125D_1	"rtl_nic/rtl8125d-1.fw"
 #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
 #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
 
@@ -138,6 +139,7 @@ static const struct {
 	[RTL_GIGA_MAC_VER_61] = {"RTL8125A",		FIRMWARE_8125A_3},
 	/* reserve 62 for CFG_METHOD_4 in the vendor driver */
 	[RTL_GIGA_MAC_VER_63] = {"RTL8125B",		FIRMWARE_8125B_2},
+	[RTL_GIGA_MAC_VER_64] = {"RTL8125D",		FIRMWARE_8125D_1},
 	[RTL_GIGA_MAC_VER_65] = {"RTL8126A",		FIRMWARE_8126A_2},
 	[RTL_GIGA_MAC_VER_66] = {"RTL8126A",		FIRMWARE_8126A_3},
 };
@@ -707,6 +709,7 @@ MODULE_FIRMWARE(FIRMWARE_8168FP_3);
 MODULE_FIRMWARE(FIRMWARE_8107E_2);
 MODULE_FIRMWARE(FIRMWARE_8125A_3);
 MODULE_FIRMWARE(FIRMWARE_8125B_2);
+MODULE_FIRMWARE(FIRMWARE_8125D_1);
 MODULE_FIRMWARE(FIRMWARE_8126A_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_3);
 
@@ -2098,10 +2101,7 @@ static void rtl_set_eee_txidle_timer(struct rtl8169_private *tp)
 		tp->tx_lpi_timer = timer_val;
 		r8168_mac_ocp_write(tp, 0xe048, timer_val);
 		break;
-	case RTL_GIGA_MAC_VER_61:
-	case RTL_GIGA_MAC_VER_63:
-	case RTL_GIGA_MAC_VER_65:
-	case RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
 		tp->tx_lpi_timer = timer_val;
 		RTL_W16(tp, EEE_TXIDLE_TIMER_8125, timer_val);
 		break;
@@ -2233,6 +2233,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 		{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_66 },
 		{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_65 },
 
+		/* 8125D family. */
+		{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64 },
+
 		/* 8125B family. */
 		{ 0x7cf, 0x641,	RTL_GIGA_MAC_VER_63 },
 
@@ -2500,9 +2503,7 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_61:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
 		break;
-	case RTL_GIGA_MAC_VER_63:
-	case RTL_GIGA_MAC_VER_65:
-	case RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_66:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
 			RX_PAUSE_SLOT_ON);
 		break;
@@ -3840,6 +3841,12 @@ static void rtl_hw_start_8125b(struct rtl8169_private *tp)
 	rtl_hw_start_8125_common(tp);
 }
 
+static void rtl_hw_start_8125d(struct rtl8169_private *tp)
+{
+	rtl_set_def_aspm_entry_latency(tp);
+	rtl_hw_start_8125_common(tp);
+}
+
 static void rtl_hw_start_8126a(struct rtl8169_private *tp)
 {
 	rtl_disable_zrxdc_timeout(tp);
@@ -3889,6 +3896,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_53] = rtl_hw_start_8117,
 		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
 		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
+		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8126a,
 		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8126a,
 	};
@@ -3906,6 +3914,7 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 	/* disable interrupt coalescing */
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_61:
+	case RTL_GIGA_MAC_VER_64:
 		for (i = 0xa00; i < 0xb00; i += 4)
 			RTL_W32(tp, i, 0);
 		break;
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index cf29b1208482..d09b2a41cd06 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1104,6 +1104,15 @@ static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
 	rtl8125b_config_eee_phy(phydev);
 }
 
+static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
+				   struct phy_device *phydev)
+{
+	r8169_apply_firmware(tp);
+	rtl8125_legacy_force_mode(phydev);
+	rtl8168g_disable_aldps(phydev);
+	rtl8125b_config_eee_phy(phydev);
+}
+
 static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
 				   struct phy_device *phydev)
 {
@@ -1160,6 +1169,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_53] = rtl8117_hw_phy_config,
 		[RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
 		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
+		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
 		[RTL_GIGA_MAC_VER_65] = rtl8126a_hw_phy_config,
 		[RTL_GIGA_MAC_VER_66] = rtl8126a_hw_phy_config,
 	};
-- 
2.49.0


