Return-Path: <stable+bounces-141620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A175AAB4FD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE4B1BA29C5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E639C487B9B;
	Tue,  6 May 2025 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gASA5d93"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFA283FCD;
	Mon,  5 May 2025 23:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486897; cv=none; b=YZIGk7PUEpy67JoONGlQD8JHoqP0CXb+1c1rBIghgrxxgyuB6LiwtOYXOUXXO8206O3VHfgJOvDnPRmWbHmFMB3jeMYIOMnOEbHWqTDHeor4DYSl83FxEfJ+AUkgzcBHzSb3k0MGAYxebaKq3g1lt+7S8vUmrrZpkenPo/LapxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486897; c=relaxed/simple;
	bh=wZrL33Y2UhmB/joSQfwWeseTnQl7iGXHm9sKMmzLLcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvkw8MQcrHv2hGrFZJt9UgoR3yc9ZyKHen8yGhr1kmPCYm4XVYcbtmwg0UpdxNe0KPErKue/MnMUZ8UwHUyUXY01DLKhuubnApvH2/WX8JAy4AAgq7gUfr1nXiwr4tQ4Jc+Tjzel39NrD+B8VWgJN58JuqtAY0gxJG5GhXbzTck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gASA5d93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03691C4CEEF;
	Mon,  5 May 2025 23:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486897;
	bh=wZrL33Y2UhmB/joSQfwWeseTnQl7iGXHm9sKMmzLLcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gASA5d93/gEjIe0t7pa4f1ZVLLzJnjuS7W49FZqHHKR8y5hBj7hDKGDOnVBl94e1M
	 5daNH7It0uV5nH7tK+l7bb5SUIhqLqTxw1UmmdCYjhkbQ+YUepI9i7Cm0ioobQ0WJt
	 3Fcl/WrCieZCiBc+XpZSYTQl0UljWQwLAck0Ym7AgR4DGwGc4DsRbiD4+3/bv0RwAH
	 Yx9pKL0Pz+qbK0FTCP1Df/OpY2rJiYzJUh/wFfv3By62S96/NCgaOi5bj9PGkCldJ+
	 2rzSvaMDO41bGy9XPieWbrWy7yNKo0rJtUEIcDKTS7Lk9TY/scPsmzSFrA3YfFhm5i
	 KCWBKYwT1eOfQ==
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
Subject: [PATCH AUTOSEL 5.15 050/153] mmc: sdhci: Disable SD card clock before changing parameters
Date: Mon,  5 May 2025 19:11:37 -0400
Message-Id: <20250505231320.2695319-50-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index c0900b2f7b5c8..97eeb0c61baec 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2009,10 +2009,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
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


