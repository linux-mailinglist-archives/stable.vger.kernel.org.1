Return-Path: <stable+bounces-124151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF3DA5DC71
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 13:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3BD177120
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 12:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1343242920;
	Wed, 12 Mar 2025 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLhzbbYI"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBF01DE4CD
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781853; cv=none; b=KdSnUUm89kjWNbilFpH723DPA4H65V39Tfjs5i3jfSVTv99bvWp3Q3SUNvfe+vZIwYtdqCcnhNXEdKj073HeIAebSN5r3QMdHYOxNVABZIeHW53uKULxGkKH4VrQuz02J8MjH+ll/CjFQUonVHOhbNPpE6QuHFvY/vbNP9I1F8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781853; c=relaxed/simple;
	bh=rdXkNKeXWew4xzAG4PBwkY6uv6kSEtbnc7+M+xTZvM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BImVGCXcawAyIz0kRitj2zGEV9ds0xb8oUXcYjaVFLptwNE5bwq2kNdThHPdKOO0ihUx5nSOtokPAtvGqzEqJz1BCvLuAMpwihydUXaFj1mvL3v+tH13Hzb+f59N6xFsMrXrIb16XKKZZ+vt/2jPsigVxuAhVEBC7T+9Zfmka/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sLhzbbYI; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-307325f2436so66271341fa.0
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 05:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741781849; x=1742386649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=++pmmtfiHftyIXzbe5IYh4I8mfHiSJ9y8MZc6wxAQdI=;
        b=sLhzbbYIK8Jc9gW52WOYfpfaQvCXkQ9NOebS41of+TlLpKOd5NBfBnfOpX1rZOzNFr
         mty0bYN8PG393RfAo/n0qukvRTDIPsD3kjudRUB9B7mP4E38iT0kvNNLjiRBOlf/j90F
         myw+YKrg9qQeZbfIZ4Zpp4Kb3WqozAewElCa+SmqsHOFHYCwgb+pVTUqW8cXuU2V2ZI/
         6hcrO9iXTadlk8B3MfZXc9i1Xg9qZqn2j5WUiybnrhFwSYrT8ted0c6svbpki6R46r5O
         VRM1qJkUvFeLVOP3nKl3zvmDWs7uZKYFRqkUNJ/Z7vva87ah09dIZjzgjWhFRmZU12yO
         5HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781849; x=1742386649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++pmmtfiHftyIXzbe5IYh4I8mfHiSJ9y8MZc6wxAQdI=;
        b=ZqCzclpw316q8+fBgHMICWPpTnUa0T55wwXp1vUr1VuAEsDbtHtHKJEYMuc7tDMBKK
         lLjr9O9CYPWcrp6l40FwNj5wEqn2OnXOzVkAupDZHxkWCegLmlSl4tjBfpFbAx+6rLPg
         k3Vb5PLF2v6DuuhuY5rs1qMdEn2ZsXRdz0FFmnS52iwcZKV+bdYawiJWL2RL2iK/dgat
         6W1nK8LaZz7hhzM6US3dqrv6+Gj4H5BUQtCAflVhNwvjfEIKTYj7nDsLDTqBfcCKm+DI
         U22zeFh8PDc5tdLm6U4b+4gox2/xvrDnHoJxc/i7CUya+UXOrEZphVOCu5oWMF3jFsid
         sQUA==
X-Forwarded-Encrypted: i=1; AJvYcCWYkFlDQ32LPq5GgQx7rsJDhAl5MX4UDm6THNUwf86HhvtFcSeamvD4pAr7CB9ZUDiwU9Ybbh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5DN8lVh0kso9GX1iLQYAu3pc6B84x5be9UfMxE5nLTn6zCXdk
	gk/Sa1DGSfcfV25hvwGiMLqyNDumsdCeareqaK7NGiGw4kqQTip7vdWor9gcbw4=
X-Gm-Gg: ASbGncvFPNkSD1XzU/IuaxBRAkWh8VTfPzKvjrHHMTLgmr0xn7GMIRm751VdT7oct1E
	3lmDO/uKZg4liyB/LI/OsZsQsovXLhC6P7IJ57ieGEF8BYle2onQzawK+ZcN1wi+xi8lkRfla6d
	Rhn4W/ndpLQAyr0jzN+te0hN0kABZVGQ2WAhc3H3m4Q/mOxsJpjBjrkJ8VDe+x4cj5SgtnWiUp0
	NE4qvfY4Ob+qpwgeqBFT68txrzRicnoV2EREMgbOl5FzHFq+EdEw/kd9OcDaQ+v79p88FtBfEj7
	IggxaLv1j5gIuK2vqrPvyMjomxrnV3XSGv6J2DRHWIB0aGhPd7bxnt2HID2JPB0beoJFt2cnwJK
	N/CA4pxHsst0S81ntbd4=
X-Google-Smtp-Source: AGHT+IGnwuT9UHbasvv/nBdAIly8F0nWcdTRH3MqDpJZ5s98EGwTiAiir5kSAZQLl8Y3LblOfs03WQ==
X-Received: by 2002:a05:6512:1255:b0:549:38d2:f630 with SMTP id 2adb3069b0e04-54990e66e97mr8347422e87.24.1741781849005;
        Wed, 12 Mar 2025 05:17:29 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae46261sm2102082e87.27.2025.03.12.05.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:17:27 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>,
	David Owens <daowens01@gmail.com>,
	Robert Nelson <robertcnelson@gmail.com>,
	Romain Naour <romain.naour@smile.fr>,
	Andrei Aldea <andrei@ti.com>,
	Judith Mendez <jm@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mmc: sdhci-omap: Disable MMC_CAP_AGGRESSIVE_PM for eMMC/SD
Date: Wed, 12 Mar 2025 13:17:12 +0100
Message-ID: <20250312121712.1168007-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have received reports about cards can become corrupt related to the
aggressive PM support. Let's make a partial revert of the change that
enabled the feature.

Reported-by: David Owens <daowens01@gmail.com>
Reported-by: Romain Naour <romain.naour@smile.fr>
Reported-by: Robert Nelson <robertcnelson@gmail.com>
Tested-by: Robert Nelson <robertcnelson@gmail.com>
Fixes: 3edf588e7fe0 ("mmc: sdhci-omap: Allow SDIO card power off and enable aggressive PM")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 54d795205fb4..26a9a8b5682a 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1339,8 +1339,8 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	/* R1B responses is required to properly manage HW busy detection. */
 	mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
 
-	/* Allow card power off and runtime PM for eMMC/SD card devices */
-	mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_AGGRESSIVE_PM;
+	/*  Enable SDIO card power off. */
+	mmc->caps |= MMC_CAP_POWER_OFF_CARD;
 
 	ret = sdhci_setup_host(host);
 	if (ret)
-- 
2.43.0


