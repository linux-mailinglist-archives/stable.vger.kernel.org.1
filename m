Return-Path: <stable+bounces-121705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFFAA5947F
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 13:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370353A6DC5
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 12:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6F022759B;
	Mon, 10 Mar 2025 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENbRSXNm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931C7227E8A;
	Mon, 10 Mar 2025 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609678; cv=none; b=JtMTKtRFHrLDER2JuHvB4aJvjurZCkUIhdsq7x2QTjK2lMAz9HU7BMpKkps8Nd9xtSes0Aeq0kcID+x144uQD1XJ/Onr5O/JNXbGoHRepNP5832/bvmexqUAlerb3njNCre0RgyKGGCE8rpS+ykTN1KE6R55oYcO1Y6BuzqdmEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609678; c=relaxed/simple;
	bh=nfghLeOpazL62fRqIJWQz1MP6JIaYaoFaN69gx/8b4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XahLDA/wJ/8JYBlGM3pd+8oWFCdoKioq1AnXgNXCfYidC6MSwZmjXYE6KrvZ9McSIH88V6PllltXIJAzrQwDPmvkX0PCparB3Y96JRvagIqh1SNiM/wEKgR1cWMvHyvyQlrdgAbpv3XlMYusEztvMDvqRt69EKn23ilTWLDHegQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENbRSXNm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso8836815e9.3;
        Mon, 10 Mar 2025 05:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741609675; x=1742214475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y07tVQtayKingIMzHvY+mUqyx0BK9tRXRpx87DXqL0Y=;
        b=ENbRSXNmNy29S2e3KLbciMx5Rk26oTtEFAUBrhn7DVO06ykXtgEJoVFlaxSmvScF3W
         hmW0noB3yb3scqDQHLT3cxSsGRL3ACG9uLR+xEryteuYFb70kZpdOwlBkVFGjANNKO5E
         pLFpVoIPr+gjeSxEjUjnGlWKhivBQvn39Uxfsv4kY7MVBwjCbE7lSRxTQfiPdgLIMzvX
         sg3XmqMS+SnJbZOmC3rXklR/KBabpP/MZGQohgRonzGORH9b3EmdAWe22Ut8d2tcdT9M
         iOuuFPr5Ynze/Wi+3AiG6Q5F4t89+RfZR4P9Yh3APMvvRfEyy4PckAQ+mQvqtWBq5ued
         KyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741609675; x=1742214475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y07tVQtayKingIMzHvY+mUqyx0BK9tRXRpx87DXqL0Y=;
        b=oI4rmDA9mwi6FpPwANiE1v7zBff3A4OOkvTcdcxcMK5b+f7blaUYgHrOIhcBxMip0z
         8vED4IU8fFjAkI1i1gv9vcO2FK57nqOvgvPk5Gt16ax+KmmYy6MBTVxmENUK/mJll/3b
         mlwRzaJjvfsntTvQTH6fZXdYq1qSuvdhsrsuJ/jlRSBDbelsRc1BS1XPLb1fEfQ4YE3r
         CUfr+rFnDS76nPMOxzXNwm1nXNuD7ZVRh8ZQDqdWDwq9/lbfrXdWlZ3D2D918ii5PDSM
         UvciXRqXd8+6JTNTRBLoAy87nbHaALGNfgDzLJA9HigGb3yGRZWKIXzuzZ9isEI0dW4h
         jHNw==
X-Forwarded-Encrypted: i=1; AJvYcCUVjxbDZ+T7mtwC7io0SJZtcJeXJ0bbuZ558Pgbm6HzjJ6e8qUpGxu30HnoneVIlbzp619lfcK2@vger.kernel.org, AJvYcCVp6W3zkuE2m2IStRb+D75IsVeWh0l7Ju9mmhQms3iM8uyXuiMhCfwWkr/2uiLGhmbkYK7aelRSsLLM/z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfHc7j6vypT//yuwiOgBshmNH9XuawapGvjrj5SRKzBILJ/ndE
	1buvt+QoF+PlRtGP0GL6Rm+mFD4oEhSSQ5IqStnmEtnX7hUDXdbq
X-Gm-Gg: ASbGncs4hRLuEqTeuhGxSVIBVjzCHl3AsMM2OW80LNSmxkiZEnMlkHYfGwYBZLGVtk2
	5o/C/806fnEfxWAMIHQFxo63dfoBAcuMOivDuyDuRLbjmoLbDaWyJD9q0jay1puu0+DPicx5fxR
	E3IFRPw4DU5dkXgfn0TkYi9/RWI5UaUAbZoFqpASCS6XP3wEBlC8aI453GKoNe+I9BikF33M71a
	jU1+hNySfWnzixIcOcInd1qceevJDHvG9Mkh95yyj5FbphnLeFEWcFhgCWxUYChR1TdvS7vsWYS
	gaHHJxoUN8ZyRwtSifTmkSYUYCM1vSRnl0i7Olo2+ie6xQaCy1ZK0J1ieJYeC/PLTpiWF3Dg7Fb
	4xQ0WWjJjeMeICrZe
X-Google-Smtp-Source: AGHT+IHyEEGGzhCMZxMwRjQ82ccOJZrD+gnc4+NfGxz62Tu6AF+ZAKBbTzzBzG5J8FJd1mZ+MeHucw==
X-Received: by 2002:a05:600c:4f41:b0:43c:ec28:d301 with SMTP id 5b1f17b1804b1-43cec28d3c2mr31513105e9.26.1741609674640;
        Mon, 10 Mar 2025 05:27:54 -0700 (PDT)
Received: from eichest-laptop.toradex.int (85-195-230-40.fiber7.init7.net. [85.195.230.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd6530f26sm171963245e9.4.2025.03.10.05.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:27:53 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	p.zabel@pengutronix.de,
	hongxing.zhu@nxp.com,
	tharvey@gateworks.com,
	Frank.Li@nxp.com,
	francesco.dolcini@toradex.com
Cc: linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] phy: freescale: imx8m-pcie: assert phy reset and perst in power off
Date: Mon, 10 Mar 2025 13:27:04 +0100
Message-ID: <20250310122745.34947-3-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250310122745.34947-1-eichest@gmail.com>
References: <20250310122745.34947-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Ensure the PHY reset and perst is asserted during power-off to
guarantee it is in a reset state upon repeated power-on calls. This
resolves an issue where the PHY may not properly initialize during
subsequent power-on cycles. Power-on will deassert the reset at the
appropriate time after tuning the PHY parameters.

During suspend/resume cycles, we observed that the PHY PLL failed to
lock during resume when the CPU temperature increased from 65C to 75C.
The observed errors were:
  phy phy-32f00000.pcie-phy.3: phy poweron failed --> -110
  imx6q-pcie 33800000.pcie: waiting for PHY ready timeout!
  imx6q-pcie 33800000.pcie: PM: dpm_run_callback(): genpd_resume_noirq+0x0/0x80 returns -110
  imx6q-pcie 33800000.pcie: PM: failed to resume noirq: error -110

This resulted in a complete CPU freeze, which is resolved by ensuring
the PHY is in reset during power-on, thus preventing PHY PLL failures.

Cc: stable@vger.kernel.org
Fixes: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index 5b505e34ca364..7355d9921b646 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -156,6 +156,16 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 	return ret;
 }
 
+static int imx8_pcie_phy_power_off(struct phy *phy)
+{
+	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
+
+	reset_control_assert(imx8_phy->reset);
+	reset_control_assert(imx8_phy->perst);
+
+	return 0;
+}
+
 static int imx8_pcie_phy_init(struct phy *phy)
 {
 	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
@@ -176,6 +186,7 @@ static const struct phy_ops imx8_pcie_phy_ops = {
 	.init		= imx8_pcie_phy_init,
 	.exit		= imx8_pcie_phy_exit,
 	.power_on	= imx8_pcie_phy_power_on,
+	.power_off	= imx8_pcie_phy_power_off,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.45.2


