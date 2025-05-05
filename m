Return-Path: <stable+bounces-140988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61305AAB001
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AE13A4DF4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB54C302A74;
	Mon,  5 May 2025 23:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUcrfbb1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001A2F73DC;
	Mon,  5 May 2025 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487164; cv=none; b=FtR5RWJyaz8JYoSpZhdPsvHyRTvZzM8vefQCQWPiYtxp2mon/dkpNX27yqUcLesvXwDavl2NWAKws3dCsxwI480ilmxx2m9wbCdBcTZ16ZDpiKc1IsNcVmPZRO5oUBhxXnRz+2txPVWXkNuYdJOtpni0VkvRX2bGR9TNCr9URF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487164; c=relaxed/simple;
	bh=ZFIcwb0g0kDDhWsTZCB0yBqkcdUTb8VNvTcKcSfzyP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wb8XlDhXnyk8ssdhyg9EbT/hwALYcy3spD2Wi8HplbQhayd6xtjPPddcrsbwFUvgP0zTYgg2Sd1R12qzPEFGUEyB/sdkG3rStYNoXfsuRR5M75MTWpG6YgTkSPr8NGqeS2RrBsQLQl64vcUOe2DQbqj2RTqyDaymrKsl9zokbyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUcrfbb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E98CC4CEED;
	Mon,  5 May 2025 23:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487163;
	bh=ZFIcwb0g0kDDhWsTZCB0yBqkcdUTb8VNvTcKcSfzyP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aUcrfbb1QiZ4Um9P46/TOyb0OHmOsBlEjGkgmQvZJzuPHOc1uwGIB9KaCVeIeQrxU
	 qYCLG7/CadXErjYfR7pgQN5XziMTIL9YK/J4XWlDJT6VwAIwmze+b5JiszpWWJnJ5F
	 rYR2iHad5zePz3oNNEBn+glaXn0jeVOthdfEXD97/bMndrNy4q2BBkJ5QU0MORJ3XO
	 hCRkuOuFiVamw11Sch7o04pwu3JmbtVF4QfwANpTcrwy+MjVdjjm4ZWNJ7P6pkminB
	 v42BqR9fZRUmjjbH08GD5wQTAckTzIsVQCgIBgGu6KujJOXog3V+Ybs13uMwAqxnO3
	 FLmZ151OhZIQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Erick Shepherd <erick.shepherd@ni.com>,
	Kyle Roeschley <kyle.roeschley@ni.com>,
	Brad Mouring <brad.mouring@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 035/114] mmc: sdhci: Disable SD card clock before changing parameters
Date: Mon,  5 May 2025 19:16:58 -0400
Message-Id: <20250505231817.2697367-35-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Erick Shepherd <erick.shepherd@ni.com>

[ Upstream commit fb3bbc46c94f261b6156ee863c1b06c84cf157dc ]

Per the SD Host Controller Simplified Specification v4.20 §3.2.3, change
the SD card clock parameters only after first disabling the external card
clock. Doing this fixes a spurious clock pulse on Baytrail and Apollo Lake
SD controllers which otherwise breaks voltage switching with a specific
Swissbit SD card.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
Signed-off-by: Brad Mouring <brad.mouring@ni.com>
Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20250211214645.469279-1-erick.shepherd@ni.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9091930f58591..3d601a3f31c1e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2010,10 +2010,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	host->mmc->actual_clock = 0;
 
-	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if (clk & SDHCI_CLOCK_CARD_EN)
+		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
+			SDHCI_CLOCK_CONTROL);
 
-	if (clock == 0)
+	if (clock == 0) {
+		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 		return;
+	}
 
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	sdhci_enable_clk(host, clk);
-- 
2.39.5


