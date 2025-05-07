Return-Path: <stable+bounces-142292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ED5AAEA06
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E995213B4
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774C628AAE9;
	Wed,  7 May 2025 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z6UxsIxh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BFB28BAA1;
	Wed,  7 May 2025 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643804; cv=none; b=ZCLXyCSlKA7Ub55as/fWbMU4NIqN5km6guIMThOGN7M2DmiKKggi2UWln4BAsYlS0fpEEaZQ7vP39Wxk5fmWVFGcaaxY6Md7QDt7/kgALEeQoDaJU3UmXhXUuInEfcDdnxy31aEjnwnUcg2bSVkxLia/AoErHG5aw1rA9rM/Cqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643804; c=relaxed/simple;
	bh=dRmjhrZhx1PoepoMCynZdPpU6in9C9KF9ZHslpwJQNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjwTL0Mp4hOhzAzGIhzMb1Ngb9K7/UK/OHAF8/1pJK3rJ8YDDICELacT5Okto2jNof8DYKqauTfA8/e9R1DCV3KHJYuIP90b859isSjdEWeP67LxYvkyuwpvOnsdh7FC2gFY+OFrmVzpKO54F27Bs1Hei3diMgO5WQ2S3A1yQCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z6UxsIxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8416C4CEE2;
	Wed,  7 May 2025 18:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643804;
	bh=dRmjhrZhx1PoepoMCynZdPpU6in9C9KF9ZHslpwJQNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z6UxsIxh8xuVMmLivlgB3LiacDST/VxiQjk9AG3ZyWW/y+yE/OID27VRyRH9PQnF1
	 DQTy7iGTtgriwZmkaEej8OPnLrSim9b153tKWOjDfrvmTAVPW6HRRNLzoZOCAtkVer
	 0DL2YeiG4p2ggzPUNDu4A5dAHiM2ZwC4SC+3Vta0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ihar Salauyou <salauyou.ihar@gmail.com>,
	Ruslan Piasetskyi <ruslan.piasetskyi@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.14 023/183] mmc: renesas_sdhi: Fix error handling in renesas_sdhi_probe
Date: Wed,  7 May 2025 20:37:48 +0200
Message-ID: <20250507183825.627687023@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruslan Piasetskyi <ruslan.piasetskyi@gmail.com>

commit 649b50a82f09fa44c2f7a65618e4584072145ab7 upstream.

After moving tmio_mmc_host_probe down, error handling has to be
adjusted.

Fixes: 74f45de394d9 ("mmc: renesas_sdhi: register irqs before registering controller")
Reviewed-by: Ihar Salauyou <salauyou.ihar@gmail.com>
Signed-off-by: Ruslan Piasetskyi <ruslan.piasetskyi@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250326220638.460083-1-ruslan.piasetskyi@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/renesas_sdhi_core.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1112,26 +1112,26 @@ int renesas_sdhi_probe(struct platform_d
 	num_irqs = platform_irq_count(pdev);
 	if (num_irqs < 0) {
 		ret = num_irqs;
-		goto eirq;
+		goto edisclk;
 	}
 
 	/* There must be at least one IRQ source */
 	if (!num_irqs) {
 		ret = -ENXIO;
-		goto eirq;
+		goto edisclk;
 	}
 
 	for (i = 0; i < num_irqs; i++) {
 		irq = platform_get_irq(pdev, i);
 		if (irq < 0) {
 			ret = irq;
-			goto eirq;
+			goto edisclk;
 		}
 
 		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
 				       dev_name(&pdev->dev), host);
 		if (ret)
-			goto eirq;
+			goto edisclk;
 	}
 
 	ret = tmio_mmc_host_probe(host);
@@ -1143,8 +1143,6 @@ int renesas_sdhi_probe(struct platform_d
 
 	return ret;
 
-eirq:
-	tmio_mmc_host_remove(host);
 edisclk:
 	renesas_sdhi_clk_disable(host);
 efree:



