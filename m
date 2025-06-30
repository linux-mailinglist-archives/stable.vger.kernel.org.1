Return-Path: <stable+bounces-158965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA0CAEE126
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 16:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B62E188D7B5
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E483E28C031;
	Mon, 30 Jun 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7WvG6wH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E628C014
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293675; cv=none; b=jo5LnusQWMz6FB9m9n/nnml/dDAyZw0bVnEaOfpgWDev+VroESjaZ6GSvn5/Gn9UUfEViaVbxY4yTQgTIr2GcoLsew/P4BICiC657tAJGGOoD6WhN0soZQJCRG+xFa3HggGZ4bSSTfYuGMsuWW2WLyuebSZeTZPwRmlMxAlu5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293675; c=relaxed/simple;
	bh=Bgc0MREU1fOvtWhkn9kG+aq5FYrFseWHynQyS7eFaVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUppWzBlZXKYHrdoxZEXFWD6pL0bErV9GUFqv+g2oqI9Bcp5vj1utK7J4RLUouKS1dCOPw8KC50YwgCFSr5b56DCGDqgQYTthT56hZqi3XNIINZN5YC9WlIIrVEibYg1y8ulgCT2sq7ANEbPjGPCoz9OWoF0pY+AciFtpFyWVWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7WvG6wH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-453608ed113so22624985e9.0
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 07:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751293672; x=1751898472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mcl2J+FRU9/v6S7AK3hPNwR82s0qXN2xVjJynVb9oNI=;
        b=d7WvG6wHlZB4qAfHTFK1Kzvq3Tky0DEvKQ57GFFLEtj76xStvMwGm5K7JBclV34XUy
         +zmO+cAw7vmriTZ0RHjFKM+i0Ra9Rn4VQFtK04gaREZ1LfxC66moprP+t+cqgyU8UPqB
         GVV0wpHy/6PVH6mNN/fMiNISI8ZGAaI31uZdZ5cpKUPudJdBsny/dZlUUOXu2Yh5SBiL
         hqENp+ZmARdfmd0MVz65+7K7KFekZBQdxJsD7mR+qJxS0p0flr60hC5a6Lzp5cmb/cdl
         HgvRDoPEK5hcCwk8q7TYcr7VuhapRhh5uLtWzmJF6YPQdCBJGCC+BPTcqdoNcg9muVtM
         QSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751293672; x=1751898472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mcl2J+FRU9/v6S7AK3hPNwR82s0qXN2xVjJynVb9oNI=;
        b=Q2M7gwf55KZf+05lidOwYoehMx+085dtNvrn8SmwHZ5K+y14mFSKJ3JptqfMLWGAYl
         K4EAK+nfYnOCYJqjey2jrhXb1n0T9WIIndl/XlS6IJkEDXKNgg8laC2Ixei1DUloJMrv
         40jg2Sh8jplaQ79ePuWve/oeKnXWjOL9+ENlZfPG80z0d7iU+a/bSTYh0MwYBMxBm2FS
         c9oOcAbna3Jd8rmuWF80fD/Pc8zGYhUVsF5yCAR3M5lNwkP/ICi/w+o+TJMG5TCkemQr
         v3LnRwOApafygjJPqasvfr9V6vCToGeWpZn6O5q+A2bHVUELrzMNJcl0XBURdZjkmnL/
         whcQ==
X-Gm-Message-State: AOJu0YwnQld6eoh2xuaxHjRxmjDc+EZjYro0PYhdqsdrx8sUNUOrMgTP
	g5vOfmFd/BydBeFqzGTA1pq3jR50Hfgv3mJuFqVTIzguMjYfzOpHWog+kJee32NM
X-Gm-Gg: ASbGncsZtYYN2fU1WqIEtrZYhbeBLPQgLrCsfzhuuXOIvzlx5RJojaXRuiB3Kk3hNV+
	a6/3bA7bfVuFrIIYYcPUfJw7d9gvyChRYi1VdBZK9p6FIyzbBwQ6JSrbvPpL3HJA4g+m7cxW8hP
	biGfyOK5MmpnI7tgv9wbYsmnUEl0OSExkeoAz7HKKSmTMxvMN6kMQ9mQv5gcLWKvrFsahlFxEgm
	q7ehxWW8llFYBVe7QzPDVprn8Vmb5wtzlQz9B8/c94pOv9Q84v/7hCZEXkJa/RlRB7vHeJhWAZg
	A+C0PFgPlf2iaNC33TNTj8M79zbhH0JsIWLvOKmWuItF5JZ98Y6byjdsJHib/Ow/QPxE8Zx9Jgg
	Zp+FKP0+FOYA=
X-Google-Smtp-Source: AGHT+IEhfPCov+XXcwAT192yBcRLrRWo3p+a94Qg73Doa4nCCqTpHwLbqEBeyvDQI/KwTHjszQTRHQ==
X-Received: by 2002:a05:600c:6212:b0:442:f8e7:25ef with SMTP id 5b1f17b1804b1-45399c3ca08mr66170225e9.11.1751293671409;
        Mon, 30 Jun 2025 07:27:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb14:740:2b00:1a5e:fff:fe3d:95be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm165871905e9.10.2025.06.30.07.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:27:51 -0700 (PDT)
From: mathieu.tortuyaux@gmail.com
To: stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12.y 2/3] net: phy: realtek: merge the drivers for internal NBase-T PHY's
Date: Mon, 30 Jun 2025 16:27:15 +0200
Message-ID: <20250630142717.70619-3-mathieu.tortuyaux@gmail.com>
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


