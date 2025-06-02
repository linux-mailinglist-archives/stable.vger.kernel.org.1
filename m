Return-Path: <stable+bounces-149272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 868A5ACB207
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34DF18938F9
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851CF239E88;
	Mon,  2 Jun 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eUXiWbCM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38116239E75;
	Mon,  2 Jun 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873453; cv=none; b=lP2t+vFzu5bnxuveFzNEfs84fMuWu674FEmDDzzNPPCT71uchJ0YyeBCkBodB8nsP/0ESC4Lmoy2s+k+Dw49p8ZPxEPvVGSwk2W87fcTh63Xyl0KbZ8nlp9Oq5qUQ8j/QU1hcjWUMTXLDcVWBWW4Wb5VuhDCOnPQSeeDgDJfx2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873453; c=relaxed/simple;
	bh=E/CiQuYKZs23E8f42oh+KAkKLqQErbfc+36nEnDTmpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYQbqYU6UID+U3jEzrSQrfULL79JiuzNj6WRzkBxBUlq9ml41reQZHBz0WBPZngm7vaMq/AzyP/nWh53b9F1iTjpPT8n0yLYwv8zEKOQGrqBdGTf++zv7WUequa3mpNvHqnBZFVBs66yQW40qBs360SHmJOU8iQ4Ov8/1FPrcfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eUXiWbCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3759C4CEEB;
	Mon,  2 Jun 2025 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873453;
	bh=E/CiQuYKZs23E8f42oh+KAkKLqQErbfc+36nEnDTmpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUXiWbCMoofbMfHYF+0WIsIq1TapsUnNgLxnpjplPIY3j7CHRJp0PpfyB6rvTCX+M
	 XILB35w/3Z+gWM62UkNSV3yMkltfw14i2k92j15Uz506fQ35xoCp7Php6auEED9uMf
	 IJ3UtHuPmUyFkXiuABsBeuFBW+tQO9MIGS3FROTI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kyle Roeschley <kyle.roeschley@ni.com>,
	Brad Mouring <brad.mouring@ni.com>,
	Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 116/444] mmc: sdhci: Disable SD card clock before changing parameters
Date: Mon,  2 Jun 2025 15:43:00 +0200
Message-ID: <20250602134345.605400215@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 9796a3cb3ca62..f32429ff905ff 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2035,10 +2035,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
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




