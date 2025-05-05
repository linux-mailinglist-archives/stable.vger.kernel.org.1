Return-Path: <stable+bounces-140448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04231AAA909
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7A29A2008
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC15C354E1C;
	Mon,  5 May 2025 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnZAKVJi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75498354E14;
	Mon,  5 May 2025 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484871; cv=none; b=kOtsVSD2eY1l+vZqXQQiFPAQG7gOHwAnch/PcsEy92RTNZ/upPCpGi75v0T/CmZ05KzHNmYf0GiScd00KoKRFa+A2QSOlONS0gnEfg+dHjsq5gFq3+RDXftXhUEntzr0gVDCnvs2WhRRXANU3ntsOG1c3j95Hx2vv+hSkTytV+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484871; c=relaxed/simple;
	bh=YQbanL5tVIfNBre4w8zLIlK4O0sLtJwS5iiuwFtPeck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDM62HOmycqHguh0KZOHLB3iu28WRBq3W9OQ/go6KGBqh2cHmumCg7LXmtmm1uYA59f9uYqdTeg9yXGcgbLxL2/NAF6ALuJQXhQi9q+dv/KJZqB/4Y6Qkc8IAGjbFZWZhexmbEAJ13UQqs/8SU9T/YkNhWhvJlMn7fW3W4hpvrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnZAKVJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C011C4CEE4;
	Mon,  5 May 2025 22:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484871;
	bh=YQbanL5tVIfNBre4w8zLIlK4O0sLtJwS5iiuwFtPeck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnZAKVJi3rZL/3Som0sCww651BJyO+A7GvSJHmV7W7Y5qfJ7Jtx/6s66RtsxO/3HU
	 jzoiAnbFLmYqQhCI4rwE8DEZ/hiZbUFCcK+BvpFG8WeX+pY5cXAp1Q6F1VaBcL6DDx
	 8alazfII5s0OBPflxNugi7A/yAEdS45AZfYIZ6XyqPRJeKh9/oGuF+ko7CGnkJP5U0
	 pAFSomnb3tc1RMRpRKWTlwH/JgugvQHKq3aSEq5VGFvvHJCr0KR2Je7aCPp2HqCCbD
	 Dh23QXE4GtAWiVHBgdM+tcbILHsUi1pfkr8B1Yg0iXommPu9kyZ1qB93Di9QQQBCsL
	 7hv3hWkzof+EQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 057/486] mmc: host: Wait for Vdd to settle on card power off
Date: Mon,  5 May 2025 18:32:13 -0400
Message-Id: <20250505223922.2682012-57-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 2e2e15e2d8fb8..b0b1d403f3527 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -609,8 +609,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 
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


