Return-Path: <stable+bounces-140978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDDEAAAFCB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8AF17F902
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0339A302025;
	Mon,  5 May 2025 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqyvnmex"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9367D3ABCED;
	Mon,  5 May 2025 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487133; cv=none; b=mWd+tt4KXwsLfLgxOM9XiFkkCnP5PNJiGfwhPEir9RELGAIZSbVxOt1hHvMksetka0d8u3QZhw2PnlSZI2rjnLE706IoXvWVhUl11ys2P6TKAdbz914uq7MxxYzFJ+gvAzygYpR0rJal90COfesDSk5+4o6zntfSBiTOuNcI4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487133; c=relaxed/simple;
	bh=nIX6dAu7nHokct7Zpqf++O3ihvA03NDTXHAFE7Cw9OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lbp6+gzwk+rsw6hVFYUV5kNJn/2wz33Y8get74A2c8cikDm51go1Xdq6cKsD0GZjEHzSYm6NTZHFzjoyOCFO7myrQXRAKMMvUhOZPEaNhKD8WDMrE7IgWq7SHpFBTKjpQMVSwwBv1Gg5RSAneZ8MvVWxKFrk3iCyOYh2wHzAXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqyvnmex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03B4C4CEED;
	Mon,  5 May 2025 23:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487133;
	bh=nIX6dAu7nHokct7Zpqf++O3ihvA03NDTXHAFE7Cw9OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tqyvnmex8g7oJanCw2CdyTSEqei2pnQqxOFykV7JDUIU9iMG3VssJL0LXRv4ardqL
	 WGuk+D4Wz+MBSioyWSp6xApVpdXdY9XuBDBMdLx01nbryFC3YsJzzHWJ/vCro/XP4c
	 xLs0cuCk9K/E4mF2yzkn1hMTxxIuNSS0wdZKpCwS6jAsa67CAf5k7ogiZGjZyeawPm
	 9i82iaq04uXuKmiaRDacslO84v3kU6jHsXNDw3haAS4lG+qnJdtoYBo3JUIP3Um0JJ
	 zZ045ZYzf76cPQELQb6Ocj3MC1PQZIb5fkoOHwdpkRwy2fzW68JX+rDvrJrPQJG7VN
	 ilVfkLp5CMsag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 016/114] mmc: host: Wait for Vdd to settle on card power off
Date: Mon,  5 May 2025 19:16:39 -0400
Message-Id: <20250505231817.2697367-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 67d9dd2165ec7..3769595693531 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -666,8 +666,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 
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


