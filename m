Return-Path: <stable+bounces-140909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46255AAAF85
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F98165E8D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFC93C76BB;
	Mon,  5 May 2025 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSxJKWcj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF12F39B0AB;
	Mon,  5 May 2025 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486843; cv=none; b=jPjmPg3aCEE+BmaHv7d2iCjJxBmZvIYri7QNp8QY9m04DQsPowrpSPLetXP8yq4yzY0HODVnb8LTsVCumYS9INu6ds5dQBhQFNix8aR699Sa8lgqlcACWYdaMzblj8k233XN0vBIuFhRPwOnLvUBmvHXtoIcnnfK28S/XQ8GJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486843; c=relaxed/simple;
	bh=Bb3FVwCJZU1r7vkPPX0Vf8mmsX2k6QL9Zn8OJXMbrK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSava8RMunqEmBfJBBQ4Vu5MmNRI3EV8/hF6DmWPZ21F89U9Bzp+az4RgAKxBxxocYAe91yFUZL6uhwSL+xn1o0rXGvly7DqboNH6o8Yf983bWu0RpXRJQnfH66rNQ91oywxZTC7Vmy5/meJpo1IFuI9xIsNcGpnr41LpdBHQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSxJKWcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD9CC4CEEF;
	Mon,  5 May 2025 23:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486842;
	bh=Bb3FVwCJZU1r7vkPPX0Vf8mmsX2k6QL9Zn8OJXMbrK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSxJKWcjcpS//cs7LtBB7Qt4s/vlHAugz18TeKLlkAx496iVUy65wBhE3Xo/4y0mB
	 fQjwd+y0P/J2sJZZjqwnCMgvtQgpoijZf7QrACw4cMb5fWhjSiVUfkMmTv6gOL9Nim
	 XyFGK8wgmeKKzGK0JOAWiy5uWgAj6jdeyVQ8Purd7yTkRM5sJ2/4utwQsXhOCDC6jK
	 cFCgIuCAro4+m67izSKKYVzYtor6UVSP328vubQI1MBfTqyVq8usZ841vcuHU83aJC
	 8kEb7rbynaMmPmbOHh5J29DTXjukCB22+N4fA0sNMltrSe7poCR+EV7IZtoz1fE6XX
	 FBD1hR3JaXNDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 020/153] mmc: host: Wait for Vdd to settle on card power off
Date: Mon,  5 May 2025 19:11:07 -0400
Message-Id: <20250505231320.2695319-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index bdb82c1265edc..b4226ba1a1b33 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -677,8 +677,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 
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


