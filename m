Return-Path: <stable+bounces-120443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B052BA5029B
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 15:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9EF188A64A
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C1524EF77;
	Wed,  5 Mar 2025 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVwPIcCr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F224FBFF;
	Wed,  5 Mar 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185855; cv=none; b=utjceKNDTDyFjcIBBIMdpp5eDCH4M7GhCX2JFiYltiU9pgPt/3nq8izAtZXXDFfIfTxLIPbLpCN9K1vBDeKza4MDVvILckW3t/yqjGDCPrAmPVhA4P9PaUCNg71FvCuKCiSt9tCzRpP3YymTIoutlqs1/oBAzCVR1FphFprZqII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185855; c=relaxed/simple;
	bh=8YPkqmU4X8iTIjEGD6+u3qjdqvLAhcHfMt6fUOhJLtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaiSLW2C5Zt73r8mUN/MocRCOnu15Zjaz9l2tmcu+Nd3ZWZRb3j3r17Yb+EbTVkK4xVz15syd3elkK0lo1FDn5ORRW8SJjWEjOBZE9z6ssBqm5rVEI0Bgmphhjygbnx51mckeBZE9o+c5AIGAtw6Btsr2r4XjxSrJwjjHw9DFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVwPIcCr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43948021a45so62821255e9.1;
        Wed, 05 Mar 2025 06:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741185852; x=1741790652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNwIlbvFX4QRldBXaIs5/RL9LSC9AEjKyZahDbOst8Q=;
        b=CVwPIcCrsyAlLoV29YpftDIttE/vnozdzs7MTAg5idVEI1s9yQqyiLPHop5u4NjjoE
         vyOVfIaD/JwYeeVO1x8MdpdKnw3AZP1uVVcHuqjfd/cvGVB2ClaJ4yX9mXh7FEB/sPqW
         tcJOXcNFoce0nPzIHyIr0WnK+THlvn6+no0KQBPFrSzdCocsS+MxSY1Hil5chAF930PI
         J9/tqQ6o4Q7nSeuGkHcrcA8ZcaGdXUTxu+KtZYAowFT/tHc8RHw3ol86e/LBLMnsA3xR
         3/m8q380CJrAEMgEHxEUGS/o3epOGKzJB3/LLeaKiE16xpxbXwO4nF2UqDUgx0drlgMS
         DE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185852; x=1741790652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNwIlbvFX4QRldBXaIs5/RL9LSC9AEjKyZahDbOst8Q=;
        b=sAeyAwnC76hcPgE8USzf/vMCEyc75WJfxEGiOpGaF8BHttfaKUlrk60X8G6xsTCv4O
         0/8R1bJpfk8OwpzHCAVFVJbsYsAUCPa+QV2B5QtmJa7tHUkjCNYkjgIHiAB8GmNxXZBw
         B84DP/7liIu6HsSFNkA2QohT3bGW2POP0x+lid8O3Hbs+gNCGgi5OA6x9810HkFUBo5m
         3jcyWh/exG5Rvq3U/gJ3vWIn8+Io7RpSeUanGW+Pha/ei+DOutIRQ1V3a0pQs004ZVjG
         R+4dP8RVWVABCIt6qHiCVnrv1DBvjO5Lj3QGZRAaa3hW49QB/cOhc9ddKgNSZfIl0sPc
         9mzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxwicMoCga04bmqXii8vur1iZGAEDZyDCqvq7oINrw/IvW4Y20UzYzbys1jiQPFSj/9OxzSfKc@vger.kernel.org, AJvYcCXipwupwsQmZYERhDskMMr5kO5uq7sgsyDHJrw5XRzJcYyZpe0/xytPbDrr3db/GdZzmwv7PjLlKLmLKHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjCV8YX3AXRzHZjVy/3NNl7Su/fTPGMO6LLmQW4bhGH1Z2fwmJ
	dNPmoHJeCTdwzhr6HhdZF9aapfPd5aa9A8Xt7743X9F31OMAdRoH
X-Gm-Gg: ASbGncsGjAYIoe6GgLzXEvBHAm0AshgG7ca/62c2pHd5i9blHmPnZ7/PgXil4HkSodz
	63rpktiv/KM9g86kZhex/UiGW4Um/DoWzQnl8GaeRT0nrJjaQhjVst10z0zLvdFjx6CAtyAT6bI
	jiz8j5/lxTBMfLGIEHdudIGxumbkYjLACK8Haz9t9AffJX9TVe1oCEYIvX0r/ox0xwvPnHq1EJ9
	nEgXs2GlNSwi5Va1v1NLj5f0Czxoubb0JTDQ7pyNDlIvWdpvtiIAV/T4ChsFWRjD6LGvb5D6YWm
	h67CO4qLfXyTR/5EJnNKZMox0qB/i42ELve1iMhsGgwpzRCs
X-Google-Smtp-Source: AGHT+IFJVniNBPju7U0+Zkvo7cT0yiY6E+Oe3yG3cuVYvnJhnTUke2U3Jt13V/c1QPsHTlV77FcZzw==
X-Received: by 2002:a05:600c:1c94:b0:439:7c0b:13f6 with SMTP id 5b1f17b1804b1-43bd2ae52d7mr27450545e9.31.1741185851384;
        Wed, 05 Mar 2025 06:44:11 -0800 (PST)
Received: from eichest-laptop.. ([178.197.169.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd435cd8csm19314375e9.40.2025.03.05.06.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:44:11 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	p.zabel@pengutronix.de,
	tharvey@gateworks.com,
	hongxing.zhu@nxp.com,
	francesco.dolcini@toradex.com
Cc: linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] phy: freescale: imx8m-pcie: assert phy reset and perst in power off
Date: Wed,  5 Mar 2025 15:43:16 +0100
Message-ID: <20250305144355.20364-3-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305144355.20364-1-eichest@gmail.com>
References: <20250305144355.20364-1-eichest@gmail.com>
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


