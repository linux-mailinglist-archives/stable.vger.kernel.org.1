Return-Path: <stable+bounces-159224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3419CAF11E1
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 12:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C3B4A3015
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117C252292;
	Wed,  2 Jul 2025 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0Gthd+G"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4E24BBFD
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452121; cv=none; b=GqXCgke7joZBO2Xd/zSVRWmpfiQtQdEOawddilqzXJnbNiZMzsQHoe253QF+DZqLHHp9nl3Vsd/6lcndecBxY0BSJF629FZqdXS8FX7DSokN/b9ukpRgH3zH1oUy6KLiB42JWZRrdqvCjRFrzsitVu1BJp3nXYC3JThPJAejCYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452121; c=relaxed/simple;
	bh=MwEEFtPil4w1/Va4fJ1vSB1UPO7n8i7Keim6FjLz86Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U81jNHv6vFtqGFF3FNQ8Mjy5hzWn3j4CuNMlMPASue8N1ZJ5HntGcVoTO7QSrXH5AW2oFiIwBaqxOVlOiu6rhlBcFZ+6jj+qnEX89Gixe/zL6aRj0WGVAHUKmYYs2nVRgZxiAo+cxVwHDPnH0SnbJN+t4Tfo8gZBvHx+viivKB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0Gthd+G; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-453749af004so36460765e9.1
        for <stable@vger.kernel.org>; Wed, 02 Jul 2025 03:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751452118; x=1752056918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=revuwE0c1RcSvIrFQ9cI/evd/6k0JA5pSec1/NIzqtA=;
        b=O0Gthd+G9WgjhrRWkfcEXqp65sWG1bqWDxcjQF16tBQbN5NJxUSXSz1F7j5L57TUg9
         y3Qj6grzc4zqNzSYCC9jjnpukTdLE/ptJDpQLWL+AQJp4I0X31yTN9CFwfHlwvZw8CA2
         zR786y4g0MEKZoi1JdBdEykgTthy3fQJu3XIMDskLkeApxPfdJH0HMLYA2XrrWJrPq2W
         Ug7TkqP3SF5WQPtIO+Jl9oMbWcaR6FM6VXOvOEVTiNkOjl6KguCyqUxMzOshwJv1rEQR
         GlonoLViuPj4dBEwZIJne6mH0Jk2Q4L+Il8K7SQJ2Q92LsWAeHnAchDGnHQYcGs7z1S8
         n75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751452118; x=1752056918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=revuwE0c1RcSvIrFQ9cI/evd/6k0JA5pSec1/NIzqtA=;
        b=ul6FsUvGLkoyqN1hUhnExMWnAHppmtFgyvYQDder9OhpY0Gu4/jayLy3i0VtKnWilO
         sw4O+SJNfTyw0+p0Mb87YvbRgpFIBZvinlZAG1AnaobHW5j9t6mjlFclU02zQDj+7mTq
         htEu6bqo+8/K0Mv5umwVOrfTEzgx3AILuqXWF6Zk1eIAXbGSlW44U2I7FkShcnhRgAad
         BKi7ltD4EWOIRoSTu/O9E5NYPgKQJ3J5VXr5SdDeEJARTA2k7eW4CQkPnMCKfTFV9FMJ
         1tKJPaUAkbTmVF4R2XcQ154UBdP7lfHRWzUK6vtOpHHbKwYH79oZlKY4rrp8v/fkp9No
         HnLA==
X-Forwarded-Encrypted: i=1; AJvYcCWyQUjgbibOoNPy0+68YjsquazIHgPedYcdm+928ZwikyOtDewIv1O5jPhHey3HqYuYQQz8SqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMQITAahbTVvydz7MuFq08mHq1zyJ8OmoZzzIeEMGLPFc0xEAK
	TQ6uRz4u1ovuHDHZmPQnpXqJFFtMnH/qxBG0DKsApS0MXKDFkTbaNs8Z
X-Gm-Gg: ASbGncvguaCWLYvr59gndjFlV539DcU5fUgfIdFocPddOUwsq8r9mjOLUf2Ys1f32S0
	D4BBwrSCZDpqTgM4BPI1+FA1dCmIiziuutB7NlljFTKE/p67wL7y+v1y3kfq1H1rTHwxiB8atRo
	Q49Sb8KMZ8HeF5iCHb+B06Vf+PU/eT1r3WEmAguqQuOrALXPAg8qZ6/849KI9XWuwyrrzKzZjM9
	+lumPqflXJmORZu3NYR0PuZpo53cZXwv6HqmrXRJbBcvgUM3v6kEJqaB1q0rP6BomwUw/uCsI7E
	skOfI9PXTX00BzSgnm7g6rOF/m0OBvOhIRPMzMQe0kUxu+7wuqkdaA/MqVeL+v3rvcSz30sA7rp
	vYwjclQ15pXc=
X-Google-Smtp-Source: AGHT+IGr49AiEsPVYh1tBdATra5OeoiKdPzvAKqQnsGDFwO4BtyiQzTwXWJ2EPIldUrOjC+WANSxvA==
X-Received: by 2002:a05:6000:310b:b0:3a5:2a24:fbf5 with SMTP id ffacd0b85a97d-3b1fe1e68bfmr1758027f8f.18.1751452117459;
        Wed, 02 Jul 2025 03:28:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb14:740:2b00:1a5e:fff:fe3d:95be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad20bsm224443185e9.20.2025.07.02.03.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:28:36 -0700 (PDT)
From: mathieu.tortuyaux@gmail.com
To: gregkh@linuxfoundation.org
Cc: mathieu.tortuyaux@gmail.com,
	mtortuyaux@microsoft.com,
	stable@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y v2 1/3] r8169: add support for RTL8125D
Date: Wed,  2 Jul 2025 12:28:05 +0200
Message-ID: <20250702102807.29282-2-mathieu.tortuyaux@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702102807.29282-1-mathieu.tortuyaux@gmail.com>
References: <2025070224-plethora-thread-8ef2@gregkh>
 <20250702102807.29282-1-mathieu.tortuyaux@gmail.com>
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
Signed-off-by: Mathieu Tortuyaux <mtortuyaux@microsoft.com>
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


