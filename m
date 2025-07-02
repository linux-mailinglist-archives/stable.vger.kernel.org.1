Return-Path: <stable+bounces-159225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA9AF11DF
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 12:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C3D484E7C
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948B324DCF6;
	Wed,  2 Jul 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2eRQgoR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E900254AFF
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452123; cv=none; b=Kt7TZq7NWWwtD9CWtI7SIAdXgudj2xLkIpBkvMUzAZFqRJxoplBjUvJh0sUlKQQzHvtoHHsO8DXV6kDVpJaxfYi1UW3cBJXCZ4n6iTN8j5YJ0ZwZpSMOlazb7c+p+oMwzg3JC1a7txyBY71RyNWlm1KUiEu0lF/UszYojdevsIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452123; c=relaxed/simple;
	bh=HDBXG/O7JQCvlzwOgCep0QwBxxEMyk8CMwyn7r5RPTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OS411WMU++q2gEcEKxYKDop9HpOWszUfsUgVhS/6bJGJRf0Et4H69eHzISet3n/GFDZGTug7EFgCTN7Ep+qnuFp+aQauEYKfDN8XQb5nwqD0GNiRBQ3WCV9Z0EZMnabyFTy0wmlPLJpIbd6JV/ovLy0yFCo51fAkf/xMQQaxBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2eRQgoR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so25133775e9.3
        for <stable@vger.kernel.org>; Wed, 02 Jul 2025 03:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751452120; x=1752056920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usnIA35T0xLaHElRDqvJn9KF+jVgAf0ByxVSy/+u93w=;
        b=Y2eRQgoRE/hvHEqVT7zRBlHcRFeXEo0nydEH8v+tgDKnI184iVN2Jf9BRecoKC/U2m
         fagVgIBWTiVRYKgETPYLdT/QBSrEuqfoOEVOVS50u1kdPSRkuOAfyJzVrAgy8ZfKTlMY
         9OjaWpaMHrwLszKLB5cJOnTHeKPydy+oV8c6kC268wq875ZlEg1f3fubaAQKRm0DEa5j
         1/ViID3tvOHS5Ku9/VONF+qtfZqRiALVEZ3JnBczKDKK0e+J4kDDXs6krV5HD7LSAUuK
         01aYO17WWBuENx3zU4OkzgBYzxB0Q9GoZ2uhp8HFAVjDdHCZLh4eeko079LiCyMf6sSB
         jfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751452120; x=1752056920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usnIA35T0xLaHElRDqvJn9KF+jVgAf0ByxVSy/+u93w=;
        b=r+9FZzWGRYzwf/raNFTZ3s4skgFPl5iQj14EreJecqFb2sfVNdmEd9g8pB1XbyUKTw
         5WIMIriYwMl6hnsnyjL8ZpDDzvgOU20lk8Re7d1ZrlVDXxGZ5WKL2wvdkn7ubRNyXtCB
         gEtmqqOWNJognc8hrVLDxIVzO6v3Iqw/80WMVyQ760brErgtBz+UxbaEv1U0RyvvlPKQ
         FZL2KunuBRzKGz+7J1LkuFQvts1+KSpZ3gaexch2fPuqXPTvdcJppkLOldR/36yHgVJb
         oFJYGOtMSjUbCjtteWM8JQIyJqjj7+wDhccq4wid2/7ST6puA5zY0WiRWOOCz9Utt98e
         TSGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpV20kaFe/Wx94gMdSenyJMSCEdHPICPJdNd4EZ+RL8XOsmMMXOIWgi2AkDI1yoVY+ylfmPxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC0FEO/Ya8WNG26XkHKMCFDiZzlQK+pGBvRJPSw1ryuotH+ybi
	kxsez6f0SLvXhzzhs+i5ptzDFDZn2qCLbfyRNr7HvVDR3G62IRvVWsdQ
X-Gm-Gg: ASbGncvHZbcZSSXL5jRfOnIbg4haqyG2S8JepZKayj8iIlu8lCjUrzXsX9rHCrdn4Ry
	KUN7CVDNLRsAf9mn6mtJoen9IQtKxDJUhPQ3EgQgrn4SuKp5ZWU7zncuGxun9WIiKxYxIG4qg+K
	ichMWvnigR2Rx0Y01dVYTiruaEzOZOmPjA3XvJcIW3iHhERKHXSLOh8A4QlN7CncJ7VIlD/8Ywb
	MFy/CMfdRzKrvugTs7/GD0TPeDgiAAhCADP/VwXT9Nn9VYaq3FCWFQ8xAbtE945n+aj8nj6DVQW
	29RYXdXkNSqZIGHRfGkA2y9efTCeHOwUJLQpUgVjYEPhBymtvUdxqHDETaBQnGR6skpUfDfI+DQ
	6M6yIDDfUWys=
X-Google-Smtp-Source: AGHT+IGQrdInctnIaRUaRaymV1gCdpHYvtOSTzEIiiTyJCk7ieR/5uJol4lQG1CQpzcjkAebU+FbjQ==
X-Received: by 2002:a05:600c:628c:b0:44a:b9e4:4e6f with SMTP id 5b1f17b1804b1-454a370952amr25450155e9.16.1751452119338;
        Wed, 02 Jul 2025 03:28:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb14:740:2b00:1a5e:fff:fe3d:95be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad20bsm224443185e9.20.2025.07.02.03.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:28:39 -0700 (PDT)
From: mathieu.tortuyaux@gmail.com
To: gregkh@linuxfoundation.org
Cc: mathieu.tortuyaux@gmail.com,
	mtortuyaux@microsoft.com,
	stable@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12.y v2 2/3] net: phy: realtek: merge the drivers for internal NBase-T PHY's
Date: Wed,  2 Jul 2025 12:28:06 +0200
Message-ID: <20250702102807.29282-3-mathieu.tortuyaux@gmail.com>
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

commit f87a17ed3b51fba4dfdd8f8b643b5423a85fc551 upstream.

The Realtek RTL8125/RTL8126 NBase-T MAC/PHY chips have internal PHY's
which are register-compatible, at least for the registers we use here.
So let's use just one PHY driver to support all of them.
These internal PHY's exist also as external C45 PHY's, but on the
internal PHY's no access to MMD registers is possible. This can be
used to differentiate between the internal and external version.

As a side effect the drivers for two now external-only drivers don't
require read_mmd/write_mmd hooks any longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://patch.msgid.link/c57081a6-811f-4571-ab35-34f4ca6de9af@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mathieu Tortuyaux <mtortuyaux@microsoft.com>
---
 drivers/net/phy/realtek.c | 53 +++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 166f6a728373..830a0d337de5 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -92,6 +92,7 @@
 
 #define RTL_GENERIC_PHYID			0x001cc800
 #define RTL_8211FVD_PHYID			0x001cc878
+#define RTL_8221B				0x001cc840
 #define RTL_8221B_VB_CG				0x001cc849
 #define RTL_8221B_VN_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
@@ -1040,6 +1041,23 @@ static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 	return val >= 0 && val & MDIO_PMA_SPEED_2_5G;
 }
 
+/* On internal PHY's MMD reads over C22 always return 0.
+ * Check a MMD register which is known to be non-zero.
+ */
+static bool rtlgen_supports_mmd(struct phy_device *phydev)
+{
+	int val;
+
+	phy_lock_mdio_bus(phydev);
+	__phy_write(phydev, MII_MMD_CTRL, MDIO_MMD_PCS);
+	__phy_write(phydev, MII_MMD_DATA, MDIO_PCS_EEE_ABLE);
+	__phy_write(phydev, MII_MMD_CTRL, MDIO_MMD_PCS | MII_MMD_CTRL_NOINCR);
+	val = __phy_read(phydev, MII_MMD_DATA);
+	phy_unlock_mdio_bus(phydev);
+
+	return val > 0;
+}
+
 static int rtlgen_match_phy_device(struct phy_device *phydev)
 {
 	return phydev->phy_id == RTL_GENERIC_PHYID &&
@@ -1049,7 +1067,8 @@ static int rtlgen_match_phy_device(struct phy_device *phydev)
 static int rtl8226_match_phy_device(struct phy_device *phydev)
 {
 	return phydev->phy_id == RTL_GENERIC_PHYID &&
-	       rtlgen_supports_2_5gbps(phydev);
+	       rtlgen_supports_2_5gbps(phydev) &&
+	       rtlgen_supports_mmd(phydev);
 }
 
 static int rtlgen_is_c45_match(struct phy_device *phydev, unsigned int id,
@@ -1061,6 +1080,11 @@ static int rtlgen_is_c45_match(struct phy_device *phydev, unsigned int id,
 		return !is_c45 && (id == phydev->phy_id);
 }
 
+static int rtl8221b_match_phy_device(struct phy_device *phydev)
+{
+	return phydev->phy_id == RTL_8221B && rtlgen_supports_mmd(phydev);
+}
+
 static int rtl8221b_vb_cg_c22_match_phy_device(struct phy_device *phydev)
 {
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);
@@ -1081,9 +1105,21 @@ static int rtl8221b_vn_cg_c45_match_phy_device(struct phy_device *phydev)
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, true);
 }
 
-static int rtl8251b_c22_match_phy_device(struct phy_device *phydev)
+static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev)
 {
-	return rtlgen_is_c45_match(phydev, RTL_8251B, false);
+	if (phydev->is_c45)
+		return false;
+
+	switch (phydev->phy_id) {
+	case RTL_GENERIC_PHYID:
+	case RTL_8221B:
+	case RTL_8251B:
+		break;
+	default:
+		return false;
+	}
+
+	return rtlgen_supports_2_5gbps(phydev) && !rtlgen_supports_mmd(phydev);
 }
 
 static int rtl8251b_c45_match_phy_device(struct phy_device *phydev)
@@ -1345,10 +1381,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
-		.read_mmd	= rtl822x_read_mmd,
-		.write_mmd	= rtl822x_write_mmd,
 	}, {
-		PHY_ID_MATCH_EXACT(0x001cc840),
+		.match_phy_device = rtl8221b_match_phy_device,
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
@@ -1359,8 +1393,6 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
-		.read_mmd	= rtl822x_read_mmd,
-		.write_mmd	= rtl822x_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc838),
 		.name           = "RTL8226-CG 2.5Gbps PHY",
@@ -1438,8 +1470,9 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 	}, {
-		.match_phy_device = rtl8251b_c22_match_phy_device,
-		.name           = "RTL8126A-internal 5Gbps PHY",
+		.match_phy_device = rtl_internal_nbaset_match_phy_device,
+		.name           = "Realtek Internal NBASE-T PHY",
+		.flags		= PHY_IS_INTERNAL,
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
-- 
2.49.0


