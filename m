Return-Path: <stable+bounces-120610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B855CA5079B
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8517A32D4
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890EA2512CB;
	Wed,  5 Mar 2025 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2k4zHwqK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FB71C6FFE;
	Wed,  5 Mar 2025 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197459; cv=none; b=tASiE2J2Z2cKZbBfBT50VmrAuT8h4hOW2f0E6sI9vsq5V+bfcVR3BBRUwMSML2TQn1WvyWeozwHX+eI2eP0gJm8SXkZWyfuMzxAxttbskyq86BWvRdYVEcHMrTDhZdMm2ApC4sALvj7tW64eqjDHpQDJtdAZQhS9mzkY6c9EvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197459; c=relaxed/simple;
	bh=UyIUNsx0TOH3vLIP15TMw+F5+MfZrpw7A/NBXRT6Wec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWvRhA1/PohnJnJnLVEz9X7ZBMjXzux2OiVpGDeR0/OC3gySZ31Kj3wq9z9v2bg3rckuehyMq04Xu1Ac8lfiGOGcJ93OKF3xBTxvZ3AOnLU5Eg+TN30v7AEDs2VNHdHfBE/sFnAvSYexIg6qDjqFg51rRLEZHXHt+BMXnn0zTOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2k4zHwqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48F2C4CED1;
	Wed,  5 Mar 2025 17:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197459;
	bh=UyIUNsx0TOH3vLIP15TMw+F5+MfZrpw7A/NBXRT6Wec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2k4zHwqK56xj1tmzpkZBG2oJL9WtfeHQrGyEHmAJAvn6YsqMHCPN45JPrAItGVodJ
	 8gZQE0Ua6j+G+bWD23RuUx8XWui38tI4WOpvtf4laKtt1lgPL0snizvgO9pSXPGChU
	 GagJdKekmXcMHHPtPxcsDSMM4fOuVAh9JP1iDpTU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Anand Moon <linux.amoon@gmail.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.1 163/176] phy: exynos5-usbdrd: fix MPLL_MULTIPLIER and SSC_REFCLKSEL masks in refclk
Date: Wed,  5 Mar 2025 18:48:52 +0100
Message-ID: <20250305174511.987411248@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kaustabh Chakraborty <kauschluss@disroot.org>

commit e2158c953c973adb49383ddea2504faf08d375b7 upstream.

In exynos5_usbdrd_{pipe3,utmi}_set_refclk(), the masks
PHYCLKRST_MPLL_MULTIPLIER_MASK and PHYCLKRST_SSC_REFCLKSEL_MASK are not
inverted when applied to the register values. Fix it.

Cc: stable@vger.kernel.org
Fixes: 59025887fb08 ("phy: Add new Exynos5 USB 3.0 PHY driver")
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Anand Moon <linux.amoon@gmail.com>
Link: https://lore.kernel.org/r/20250209-exynos5-usbdrd-masks-v1-1-4f7f83f323d7@disroot.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -288,9 +288,9 @@ exynos5_usbdrd_pipe3_set_refclk(struct p
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
@@ -332,9 +332,9 @@ exynos5_usbdrd_utmi_set_refclk(struct ph
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



