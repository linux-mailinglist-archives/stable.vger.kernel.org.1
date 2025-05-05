Return-Path: <stable+bounces-141717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F47AAB7AE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5654C7B47DA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3154AB338;
	Tue,  6 May 2025 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbVgAOcA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE337F956;
	Mon,  5 May 2025 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487335; cv=none; b=SZtyc8jEJas37ZrlXNE7mci6TBZHPR2Gdivu50j8+VKgD+hF8FA7trcKq42bzB/mZXr6UAxHBsrbw4IDY1eyvs6w3ohIyK20rTQmTrn37uJrxDLf5cTP9+mBz+DhO7a8qkcX30vK1g4GBvbnABNcdV35FgH0tEqjA0sPjoAePxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487335; c=relaxed/simple;
	bh=deWMExZlTsov2QDeAFquKoWOnR4Wsp9FplU2CGgtVOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DDj3AVrguEkgzhdf721cHFusC2xQyWXyY4OZOSeCGGI1XoVXgDO/7rn4Cy29DYfSrjpH42mxg+Af+CHd7VQK+df6DmnbW94mJBAi0/leFStNtifncZEzIMcf5bZaxSsiPJ9LmXgC77EIMaESQhhKMpTagQV5uzVg3fAV5xj5zyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbVgAOcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589D4C4CEF4;
	Mon,  5 May 2025 23:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487334;
	bh=deWMExZlTsov2QDeAFquKoWOnR4Wsp9FplU2CGgtVOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbVgAOcAUaQAX2BR0i2HcoRIxSIc4qUUkNCMrTHsNjDyZdx96fP5NN6QYRWAW1LlP
	 7dAGqFO6hYdc+WDVsuduxzL01krqbEApftWWnh2delQxCzU14eYTkPkSiV98ABdtdR
	 wPd2RDDVaCFZolp6UvGcNMJ/G55md1wXthhcGsybUY/EQ3fp6A3bLF6UNkm6nKX7RC
	 aslYgQGJZKXLbirq8HVr5YFQfkTVF6hykon9wwX+/xGAhj/Nkz9S0dPb30HHIokSsA
	 eRLCBOgojRfuaFq3p3oSECGrqfFMbO6MKhnGFqeEjUfkzpuV1BVrB+tyZBUIdOdFpI
	 7tkMJYjp9T/JA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 12/79] mmc: host: Wait for Vdd to settle on card power off
Date: Mon,  5 May 2025 19:20:44 -0400
Message-Id: <20250505232151.2698893-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Erick Shepherd <erick.shepherd@ni.com>

[ Upstream commit 31e75ed964582257f59156ce6a42860e1ae4cc39 ]

The SD spec version 6.0 section 6.4.1.5 requires that Vdd must be
lowered to less than 0.5V for a minimum of 1 ms when powering off a
card. Increase wait to 15 ms so that voltage has time to drain down
to 0.5V and cards can power off correctly. Issues with voltage drain
time were only observed on Apollo Lake and Bay Trail host controllers
so this fix is limited to those devices.

Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250314195021.1588090-1-erick.shepherd@ni.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-pci-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 390caef1bdabc..22978057b94a1 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -669,8 +669,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 
 	sdhci_set_power(host, mode, vdd);
 
-	if (mode == MMC_POWER_OFF)
+	if (mode == MMC_POWER_OFF) {
+		if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
+		    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BYT_SD)
+			usleep_range(15000, 17500);
 		return;
+	}
 
 	/*
 	 * Bus power might not enable after D3 -> D0 transition due to the
-- 
2.39.5


