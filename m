Return-Path: <stable+bounces-119928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59077A49799
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 11:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E920C7A6BBD
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 10:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E961260360;
	Fri, 28 Feb 2025 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnpLZRJC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C4C25F7A6;
	Fri, 28 Feb 2025 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739211; cv=none; b=pgvvOr/QJTLDmvS4MpkAUUWk0xmd08GTGUT+OTfToxg6d9bqRFZEzL0YTOhtYBMA+mXyM2zBD+5YUxM2yaSm91FpoJZni3Zy7zOagf5Wm4H6iX+jvbXAFDFD9xygKnAbw00oPzV3dLpb2w6XandKABP4AhsBiUGouBukf9DI5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739211; c=relaxed/simple;
	bh=BtzMxTsiUBKKfohLqHJJpcoRDbN/5OcsFVC/lglePDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuCIRNuNdjdeBxj4x8EcIn5BqN66qOC+LFDyfW/OsJrVf5om0EHu6+TXRJrNXyooKQ+/19f6f3tU2qPxhcx9kWIUnlfvUieTJb+JHsIoDOwurKHV3QeHwbh+FP0vkPKkUtYB8PRLw47lYxTHjGN05DNnus2Txw+yTYhVJdmZ0KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnpLZRJC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso13639895e9.1;
        Fri, 28 Feb 2025 02:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740739207; x=1741344007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNQfrx2+Y7l3TBgRs2HYeEusAxTadJTrsHyF6Qzg2L4=;
        b=nnpLZRJCF1qKbfV9HQUddiiMlj+lZRDLYASG+6yFlbFpWNsJ96PeVhghKTQa0Y/SGo
         WWigE6GuH60MQqMUPAMkFAEC1KZN4FmwjdkMSMv+AULSx5lU4TqiIAXHcygC/LIRswvP
         P6nAFARjEk42yBUkolK4Gs02dMy8LoyJCrnybg3TIDsmHicbq0KprKJyjsKxwwdenQrf
         UBQ7nPctS7r7OYELIqiqXf9UGof0Pzb78B/+KVqtmKkpVc0rGR+v9CYa1WeFmF8Up+sZ
         TSS3XiWzyrlUlbdQ4bdjTdd1DWjE7CkDdM2lrFqrHmycdImvqDbSy6GCyIn55H2OgopC
         HaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740739207; x=1741344007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNQfrx2+Y7l3TBgRs2HYeEusAxTadJTrsHyF6Qzg2L4=;
        b=a1J4MN3lZEAmpaT1ZxhDRQ6HJhUY6cGJcyJXsvdgGyywiL0Igsjl1IQ+mb/RYx7rWg
         n/j5BBSFEoGFgSuNAwqTBQ8BMP/EDgde+oH8S0/Bkomrg1ldJi5/eOibS3/sbfdUDP44
         lsCrWPakhomNLa7YX8fxff8A1FMIcWeV+9DGfNUn4302x/w9QB4tTY7xAaQO9UueafZx
         ujmEPfRIE+gzK+9f+CDgGEAol3GED7ui/UPwUUo6II+tP7+NeejLI47s0qLSNJNmgrP+
         R0gxkkdaHmfMh+jhUpeitI7ue7U/33RZksvrQ80rdVLlUkRUFU0GMgIcXvMcCATkGzZ2
         jIqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+aE52KxdWAvxCPpwhvxmyFfagOIYTRPrlRUhHoatO0fci8fkbqTEryrtxCT9RzMB3yUQMblT/@vger.kernel.org, AJvYcCW2fuVJfNJVv1ma4z90+9DaFIf2+qeDy96ho/HARdFctbUIf0yZfPqCQte7+5sHbY2PjzhE0izE9iZ3e6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEsOn6MyCpj0SBklFzdIfDqTilV+VQkoQDwPBMSjBTUUKdFqX
	CfWaRin+VjNF5P1w8dSAmj0TVBLRQDXUJpKQBXV/SJfnXAVbfJ+l
X-Gm-Gg: ASbGnctvflhkKNJlkHCQGbOG5fzj3rh7/AE+inHmuWb3kc83YxHH3vOdW7hsdw8Ld1N
	AXGtEqPmRmgy4ovj9cDz3axrvJTHrT72c20JP1gZuRxVSdcAR+DR0UrjC/PgNluOjyoBjod2SYT
	f2U/EGD+YtpYxjHWlQAceQiWgWHWBQv4hZ6iJmqvHm9Hoaqt8/bycqEi5f6oKFaAzf4394sU9lK
	flxDxLIph4nYxdn1sTdBXpO53V0oOhKTF5xvVC3byZbWfIQWPHiAtiPKNkB/o7gCCiSN9DbPy89
	ysCGPxWzWOfwnnkIPMWzlPW5ZVkQdM6EFwibT5CWpg==
X-Google-Smtp-Source: AGHT+IHwAKMkbQkKZji2hIl2kLJahCHtsGvhDRkHSsHi5xjEjBT4SBZNdGXhe19X/KZFU+W8IlL/xQ==
X-Received: by 2002:a05:600c:1c95:b0:439:8bb3:cf8e with SMTP id 5b1f17b1804b1-43ba67606abmr21106225e9.20.1740739207395;
        Fri, 28 Feb 2025 02:40:07 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:31d5:4145:8035:cb68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73703caesm52078855e9.12.2025.02.28.02.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:40:06 -0800 (PST)
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
Subject: [PATCH v1 2/2] phy: freescale: imx8m-pcie: assert phy reset and perst in power off
Date: Fri, 28 Feb 2025 11:38:34 +0100
Message-ID: <20250228103959.47419-3-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250228103959.47419-1-eichest@gmail.com>
References: <20250228103959.47419-1-eichest@gmail.com>
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
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index 00f957a42d9dc..36bef416618de 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -158,6 +158,17 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 	return ret;
 }
 
+static int imx8_pcie_phy_power_off(struct phy *phy)
+{
+	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
+
+	reset_control_assert(imx8_phy->reset);
+	if (imx8_phy->perst)
+		reset_control_assert(imx8_phy->perst);
+
+	return 0;
+}
+
 static int imx8_pcie_phy_init(struct phy *phy)
 {
 	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
@@ -178,6 +189,7 @@ static const struct phy_ops imx8_pcie_phy_ops = {
 	.init		= imx8_pcie_phy_init,
 	.exit		= imx8_pcie_phy_exit,
 	.power_on	= imx8_pcie_phy_power_on,
+	.power_off	= imx8_pcie_phy_power_off,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.45.2


