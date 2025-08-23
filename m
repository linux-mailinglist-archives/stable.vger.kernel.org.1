Return-Path: <stable+bounces-172615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E924B32974
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9B41BC5F5D
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53F91DF756;
	Sat, 23 Aug 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJbGJIqg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754731C6FE1
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755961360; cv=none; b=Y/9LGZl+n6PG8u4Kk4wo+lXVTX90mjSCBh15V63zeeWx51SVeBR7FOc2ZMng+lT9BL1KOCm8iCZhsX91oklIXqceQVey6gZnZaUemWtWpIjzPlqbr7wzN3Kn8alBX3hqlmDYewrplVBnx9V/cRmrMcXo0sWPCI6PnhDrn1FnXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755961360; c=relaxed/simple;
	bh=vs3hoit2yYaIXbF5BpE5BOJDJL+eGX2ZloJP431FLtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpmfNyrLNIEe36SyQFfYMEAwwYRIZUzxcuUiwY39Q7qxhcI7E9XMpI02m77ATntXExlLBUcSoWFPo2+/nBxKFSjZTeI5ck73LF58lksw1CSqZfjlJUtdsrk4J2f9+elxRdgnDLIXKqevD9GUSQINv/GOT8p8W12OhwCh/ClSgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJbGJIqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C6AC4CEF4;
	Sat, 23 Aug 2025 15:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755961359;
	bh=vs3hoit2yYaIXbF5BpE5BOJDJL+eGX2ZloJP431FLtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJbGJIqgaEi/CPxu7/EsZ3XiNZKYYVwAH2nkBd8xxG99v02fDw34vIjVgUWP86ozw
	 RpvPeB5EKUd7Rwo3aQq9MiwMbPuaFhSIdZlkpZ1xQXYjLdFDBePacmcZ3DNoMRf40e
	 kmhJkkMJWRR0buB/it7PZlgW9LOxEizcEJhtK1O3HFsb2d8IQw4Z1fNjvR6xh9E4Pc
	 ivYQKqkCvyMY9cERy/Tm+NKFFMQBo4/JLGrYbKyY7mmLv4iAXsEVFdV6GaRzD0waLK
	 OHZAm96dLOKezSW7bENFZHhC1Ixf+SJRO+oATsqrb0jbN7VCodgyvF+x01aSFf5D5x
	 NSvn70K2W8kdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Judith Mendez <jm@ti.com>,
	Andrew Davis <afd@ti.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mmc: sdhci_am654: Disable HS400 for AM62P SR1.0 and SR1.1
Date: Sat, 23 Aug 2025 11:02:37 -0400
Message-ID: <20250823150237.2265649-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082207-defog-stunned-9396@gregkh>
References: <2025082207-defog-stunned-9396@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Judith Mendez <jm@ti.com>

[ Upstream commit d2d7a96b29ea6ab093973a1a37d26126db70c79f ]

This adds SDHCI_AM654_QUIRK_DISABLE_HS400 quirk which shall be used
to disable HS400 support. AM62P SR1.0 and SR1.1 do not support HS400
due to errata i2458 [0] so disable HS400 for these SoC revisions.

[0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
Fixes: 37f28165518f ("arm64: dts: ti: k3-am62p: Add ITAP/OTAP values for MMC")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Andrew Davis <afd@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250820193047.4064142-1-jm@ti.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[ adapted quirk bit assignment from BIT(2) to BIT(1) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci_am654.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 8e0eb0acf442..47344e29a4c9 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -155,6 +155,7 @@ struct sdhci_am654_data {
 	u32 tuning_loop;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
+#define SDHCI_AM654_QUIRK_DISABLE_HS400 BIT(1)
 };
 
 struct window {
@@ -734,6 +735,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = mmc_dev(host->mmc);
 	u32 ctl_cfg_2 = 0;
 	u32 mask;
 	u32 val;
@@ -789,6 +791,12 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	if (ret)
 		goto err_cleanup_host;
 
+	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_DISABLE_HS400 &&
+	    host->mmc->caps2 & (MMC_CAP2_HS400 | MMC_CAP2_HS400_ES)) {
+		dev_info(dev, "HS400 mode not supported on this silicon revision, disabling it\n");
+		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+	}
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -852,6 +860,12 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	return 0;
 }
 
+static const struct soc_device_attribute sdhci_am654_descope_hs400[] = {
+	{ .family = "AM62PX", .revision = "SR1.0" },
+	{ .family = "AM62PX", .revision = "SR1.1" },
+	{ /* sentinel */ }
+};
+
 static const struct of_device_id sdhci_am654_of_match[] = {
 	{
 		.compatible = "ti,am654-sdhci-5.1",
@@ -943,6 +957,10 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	soc = soc_device_match(sdhci_am654_descope_hs400);
+	if (soc)
+		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_DISABLE_HS400;
+
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 
 	pm_runtime_get_noresume(dev);
-- 
2.50.1


