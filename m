Return-Path: <stable+bounces-139816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C883EAAA022
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4EA1888720
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41D828E60F;
	Mon,  5 May 2025 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFT+DFEe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E028E606;
	Mon,  5 May 2025 22:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483406; cv=none; b=MNX38oBejCvWg75FLeLFeF4XDPFZmm3Sc/imr+B0vnyTM/Czo+D5XxxBljK9xT39h7IiwtjlfZD7XEX6AKoZXRdU7Zg0njx//YcNbaq8qDKeVhEAVs4nUeGTeeQuFpvlJzlEANShVlwsAuOJCdCr28gzKgZaVOjqapXJqXBvYjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483406; c=relaxed/simple;
	bh=aAb85P1HkGPM0yzjzVI5BzT9D7o6zbZ36bAGp7LWHbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fTaP6VEEZ3wWD+R0vRVYTkVETBjxSmsA8rMKl4DOEbhup7PmaWhTKi11on4aolSWp5B+1nP3I8pdArve4GDSb0t40wBKHWFkhKRzCveG5kwQK4yKQ4n81HDEU425eo4u7n4pIf7nzzyMdhVZEfEmL5CVqG7Ciw/8Gaie4nthC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFT+DFEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3507BC4CEED;
	Mon,  5 May 2025 22:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483405;
	bh=aAb85P1HkGPM0yzjzVI5BzT9D7o6zbZ36bAGp7LWHbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tFT+DFEe/shEE9lKy/NDOSCF0/K4nbsgFy9Ez3c5R+CD1owbxT8dRa+LzjJZbYBxD
	 JP75xHoUxlQXZAy5/xRREtyoe+TRPJjIUeiE9UZJ4ZyBROrFfUFNwj4GXf1KDhkiit
	 K8y/WVuQyhq9Afh3ZqquzMMjtbW588p4xQumK1+oKz1xOAtg0CL6Lgxc/WPv9W/DrQ
	 JJiCrYfJF7JOZXg9zPP6kYP7V0O4YIZ7KXPDChG7l6uvdXXjeFC8G8sTgOnoV0P0yM
	 4Ve9zbniKZ0BEq61aq7Cv6lonTD5Uc99H9XsdxS/516SGPnPOzeM1MLYunbk3GTq6j
	 LYpRlxoG4NzmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 069/642] mmc: host: Wait for Vdd to settle on card power off
Date: Mon,  5 May 2025 18:04:45 -0400
Message-Id: <20250505221419.2672473-69-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 1f0bd723f0112..13a84b9309e06 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -610,8 +610,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 
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


