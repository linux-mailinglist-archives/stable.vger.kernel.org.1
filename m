Return-Path: <stable+bounces-140667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D47DAAAAA9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8145A2D6D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148BA37A8A2;
	Mon,  5 May 2025 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9iXGVV2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1A36EF37;
	Mon,  5 May 2025 22:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485864; cv=none; b=R5Auj0vidVvaO/0zOnxxuPl134uPh5yb6QbOCCS28ysc9HQ3p+xLftiEdHCHe8bK8Arj3rYBmHhjuvk9+TPSUHlsDlvRVrKzE35urXklhw3ojNuk9CIgqlPDtB5agODQ1QBmogPJY4Hk2X1y6o4xITes3pM6FyMMcgEgdSMtk70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485864; c=relaxed/simple;
	bh=W1KoIUb4JGXXwoEaGriyWSvSgIDLHl3lD+Np+7AzArM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i5Hc7gDuc8wHPkj/o76/CJCQhBzbz8/Occ+1cRISppr7jWuUJw5mCCd4KL1hz8W27SstI0spGowyzcvuNrAb6jjKXJ6eI9wMr+lnHRZN48H8p8yYQE2Enm6Ahbb4xS7yMagpJdVIhSBm7xKPaV55imkAlmYNv6z3OUBNPRoSkU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9iXGVV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA064C4CEEE;
	Mon,  5 May 2025 22:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485864;
	bh=W1KoIUb4JGXXwoEaGriyWSvSgIDLHl3lD+Np+7AzArM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X9iXGVV2ehc3i2u5ZfSMjyOf+MDp2k8U4gxobnyxctYU/PZF7WP9Ip4//IeeZjOXW
	 IoTUdXsf/5XuC7P/VmpXhPD4ne7hDylO681/bD4kZ3YWHjH1QNI4Jz8WLU8ZyHrpNM
	 I14HufLH5tvLh2ZXMDXYB5dneHGiEZKgD8nkxWll9U91ascHi5+89dw5Mlas5bMOOi
	 o83CxUp/qp6XX3VRgHvODIPwNzpQV2B33pweH6dPoRFIXS/MIslIoWiJgy5wTHCffE
	 T89jo0/VoHwd/Pidfm7lmtOQzyOhkjVE3MNEjZezpHrr177JQOOpz7Dakn+AGaWsll
	 lzWAlATM8O8PA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 037/294] mmc: host: Wait for Vdd to settle on card power off
Date: Mon,  5 May 2025 18:52:17 -0400
Message-Id: <20250505225634.2688578-37-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 6b351810a301c..dbfe0a5324eaf 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -608,8 +608,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 
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


