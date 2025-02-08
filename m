Return-Path: <stable+bounces-114412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADCAA2D835
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 20:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8857F3A729A
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33F318FDC5;
	Sat,  8 Feb 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DOC4jBhf"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB51241129;
	Sat,  8 Feb 2025 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739041228; cv=none; b=Ruqy12DtdSyDf7+YCwpg2Fc65H5nmjXLoKFcRUQ7h7ZawpdARYfvEQS6nLWrb85Z85E8CfLoHvfvAQOiiTMFIM4CDSPj5FrTcGCMNDWYZ/FFAkb3kmc8tnJliKuSnhLtsepj9keKS9rJJVQiCHB3BtRl78AS67XzuTzf4oGowmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739041228; c=relaxed/simple;
	bh=alWLYF/9OcbBa/I1+7yBqk1Z5iaf+prVR/oyQI0H9G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PZ6zuiZPiLxwMF6CV5AS7tW6FDgzcieAxk7PPimB/UW6UgGPrX4qKozsm+Pdt1Eo5Ri0yemGWR87AIiweiUVzCOB+j6PtvfqrJPF4Q4vPrmxE87vOfFGLgc8i+jaLSFcJN3LPIcNk21ZhUsHiXl31eX1xqLZpFR4LO3lxaAvlpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DOC4jBhf; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D2ADB25D01;
	Sat,  8 Feb 2025 20:00:16 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 55FrgB_ujl9K; Sat,  8 Feb 2025 20:00:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1739041215; bh=alWLYF/9OcbBa/I1+7yBqk1Z5iaf+prVR/oyQI0H9G4=;
	h=From:Date:Subject:To:Cc;
	b=DOC4jBhf/haJGplx2K8eiCjySQ5qbgEtpmkQ3ImmkbEXeHtImVv7v4Q3fGLF0mGE7
	 7L/OdfBlNBQCIssAqszLDs+H4f+GEskwUBTuThpvWz4DJLpyk7I13rv35duIoF0HIj
	 /ouUMNy8JwCqopdtjG2jKBi+M1Fz2V4bgJc+EjHZjbLHKZwwqgVa8OK2pNlc6PYcRI
	 bdf8ePyZCdfuXsUrTZK+3FShLaP30618vZcaABPPC4Wj/AXXguL7RKve5Pv6ZLbikK
	 xhalBciwDPH2s3/BZF79OXtG5DhHBeu/ojLzG2MQiAuJxWsx6zjhIDh4f/1dvtDzSL
	 biy7RX9N2lDew==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sun, 09 Feb 2025 00:29:30 +0530
Subject: [PATCH] phy: exynos5-usbdrd: fix MPLL_MULTIPLIER and SSC_REFCLKSEL
 masks in refclk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-exynos5-usbdrd-masks-v1-1-4f7f83f323d7@disroot.org>
X-B4-Tracking: v=1; b=H4sIAJGpp2cC/x3MQQ5AMBBA0avIrE1SjVKuIhboYCJKOiFE3F1j+
 Rb/PyAUmATq5IFAJwtvPiJLExjmzk+E7KJBK22UVhbpuv0mBg/pXXC4drIIllRRUVkz5L2FmO6
 BRr7+bdO+7wekWIFpZgAAAA==
X-Change-ID: 20250208-exynos5-usbdrd-masks-7e9e6985c4b8
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Vivek Gautam <gautam.vivek@samsung.com>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739041209; l=2085;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=alWLYF/9OcbBa/I1+7yBqk1Z5iaf+prVR/oyQI0H9G4=;
 b=u7SS0kBpPe4GLUkdpGBcrXSlzjYQ5lTUc9poNrKPxjumtkDDCLanuInoWrIfZdaYIYKdJwsQ8
 spQArA691vLAEsK3NzHrFjhY0s2A0LvAotGppdNelchuuQ1ZOtDXhue
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

In exynos5_usbdrd_{pipe3,utmi}_set_refclk(), the masks
PHYCLKRST_MPLL_MULTIPLIER_MASK and PHYCLKRST_SSC_REFCLKSEL_MASK are not
inverted when applied to the register values. Fix it.

Cc: stable@vger.kernel.org
Fixes: 59025887fb08 ("phy: Add new Exynos5 USB 3.0 PHY driver")
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Patch picked up from:
https://lore.kernel.org/all/20250204-exynos7870-usbphy-v1-1-f30a9857efeb@disroot.org/
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index c421b495eb0fe4396d76f8c9d7c198ad7cd08869..4a108fdab118c0edd76bd88dc9dbf6a498e064b3 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -488,9 +488,9 @@ exynos5_usbdrd_pipe3_set_refclk(struct phy_usb_instance *inst)
 	reg |=	PHYCLKRST_REFCLKSEL_EXT_REFCLK;
 
 	/* FSEL settings corresponding to reference clock */
-	reg &= ~PHYCLKRST_FSEL_PIPE_MASK |
-		PHYCLKRST_MPLL_MULTIPLIER_MASK |
-		PHYCLKRST_SSC_REFCLKSEL_MASK;
+	reg &= ~(PHYCLKRST_FSEL_PIPE_MASK |
+		 PHYCLKRST_MPLL_MULTIPLIER_MASK |
+		 PHYCLKRST_SSC_REFCLKSEL_MASK);
 	switch (phy_drd->extrefclk) {
 	case EXYNOS5_FSEL_50MHZ:
 		reg |= (PHYCLKRST_MPLL_MULTIPLIER_50M_REF |
@@ -532,9 +532,9 @@ exynos5_usbdrd_utmi_set_refclk(struct phy_usb_instance *inst)
 	reg &= ~PHYCLKRST_REFCLKSEL_MASK;
 	reg |=	PHYCLKRST_REFCLKSEL_EXT_REFCLK;
 
-	reg &= ~PHYCLKRST_FSEL_UTMI_MASK |
-		PHYCLKRST_MPLL_MULTIPLIER_MASK |
-		PHYCLKRST_SSC_REFCLKSEL_MASK;
+	reg &= ~(PHYCLKRST_FSEL_UTMI_MASK |
+		 PHYCLKRST_MPLL_MULTIPLIER_MASK |
+		 PHYCLKRST_SSC_REFCLKSEL_MASK);
 	reg |= PHYCLKRST_FSEL(phy_drd->extrefclk);
 
 	return reg;

---
base-commit: df4b2bbff898227db0c14264ac7edd634e79f755
change-id: 20250208-exynos5-usbdrd-masks-7e9e6985c4b8

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


