Return-Path: <stable+bounces-140832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1743BAAABE2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DB8189E873
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141602F94E5;
	Mon,  5 May 2025 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTRLamoN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E42ED078;
	Mon,  5 May 2025 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486516; cv=none; b=puuNSKnID895JuQ9qm/+8LPf5UbkjXaj1wG5l05eL8ZgCHFtimmxuEJm8CswBkFNoXhVcEsJ6mPIptLUGcawlS6hjjq3SgXMcQ0+6/lJrllgZoq2YiWKK183W22uZYUcLeV7imqpVq2/nNg/WUu4jJsWr91MALynbhgksC+qnAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486516; c=relaxed/simple;
	bh=1WsI8n4+95dOJdFDkqS8MZsGrpgVCwj3w39FA24wZDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbGWRymLyY1US7BTJ3Q60ZsLHIvN8LXJnixUL7/t3JHzFWIF6xcP/eE7ry3fXBlj1Xlw43fGghwt27sqHTuuPTw4dnTF+GbEwAdqK5ppAMELtdboF9QyDYyBd1x2C8dulFbvkX5AiRAxG4YiHhtYVYnM3yWJ8KeFuoY2fQ9F4MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTRLamoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC58AC4CEEE;
	Mon,  5 May 2025 23:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486514;
	bh=1WsI8n4+95dOJdFDkqS8MZsGrpgVCwj3w39FA24wZDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTRLamoNmlgjh/p3jY+5KWmjgQVCDl/s8belYcz5qHI3FpV79jqZgtwzkzVTd8yXW
	 DC5xSPK+eR8sllYeQhJlJmsrR8/kynJBla9zQtYWcRiHXPLu4zz+7mzM3EA/i3kSMv
	 YkSXexQtWP1D4dgeRNv/eMGSKzZ9nEAX2y54IFrcubM18yJMOsrWtvn6+w9Zxyoo8m
	 AplZVwtt9euq327hjPfPQts8CazfOtbyBE2WS0GS2gRFrM4kw22j77Cv66e1yl/cGk
	 lj/BWq0mxhsfHnw4nNM7LYpvkQcUCArRtXyxcy5KnKsKXzGSobWExbRk4fppZtFA7/
	 1VseoIkSzsXXg==
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
Subject: [PATCH AUTOSEL 6.1 070/212] mmc: sdhci: Disable SD card clock before changing parameters
Date: Mon,  5 May 2025 19:04:02 -0400
Message-Id: <20250505230624.2692522-70-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 536d21028a116..6822a3249286c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2049,10 +2049,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
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


