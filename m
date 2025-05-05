Return-Path: <stable+bounces-141379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46361AAB31F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 831E23A396E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F045E44D48B;
	Tue,  6 May 2025 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hweJKF+K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B72DAF9C;
	Mon,  5 May 2025 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485961; cv=none; b=YqnDDwtuMl39JHWh29LN1owvi8xq8qVaudas9BKvOtZq1cgXVn2w1t31gDMMr1zrE3NIX7yyYQiF/Z3QbcG7bB3GHmhetIVZxNPFK1A9FtVegHTvgKcJrgRZDXZiR+CproF+CQBZlCU/IjdusNhsbrRwisURtkPbHA8WJss8qAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485961; c=relaxed/simple;
	bh=I4mmtZS7oQaOkP9zUMPZmkH9iP7ipojAwNds0yRWv34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPKYIIjuQYlbjqH+NdvFR4ZQaGXiR7Ey0m67TYmDzAnY6jL7Nkep/tsqzV6p9CjyQYAdXICzdQEmeaWTzr50s/lf/jkVOQvhogL8wLl/1rSUrXfIZvpr9/z4HqU8ToHStL6fnTCTeeRjEOmrq/ahbPcCCQqwAJIaWe1dmQ76AZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hweJKF+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AA9C4CEED;
	Mon,  5 May 2025 22:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485961;
	bh=I4mmtZS7oQaOkP9zUMPZmkH9iP7ipojAwNds0yRWv34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hweJKF+KZXeF+OMZyhIVv+ZpAcBDYTnneVt2d+OX12RIBty5mZz5f044gBtrfgrg1
	 RDYTaHOwm9HznDxf7JadJjB1DVEfKAzGzmZvKQuP+ZnnkAdHMxKCXDUcTZLs+tWxEh
	 nGt0wDF7eo2kCK6YhIrB/p4fc27JLvgWnnaUvt1gCcVV6xUtBk7d+KoWz/5evz4yyM
	 nD1rpVWdNv3uqtfz1pHtxCo8ge1ABfqdUtjucGDMIIEfn+RUoIHjBcCN3qrhLWFuZs
	 /5R3l5idPFYKcZUP8LFVnC4gTHanBEnlGqpmRz77y3y9ELY25Zn1H2RVGphnr3BGDW
	 Uibykhx2dogqw==
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
Subject: [PATCH AUTOSEL 6.6 087/294] mmc: sdhci: Disable SD card clock before changing parameters
Date: Mon,  5 May 2025 18:53:07 -0400
Message-Id: <20250505225634.2688578-87-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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


