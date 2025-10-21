Return-Path: <stable+bounces-188412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F39DBF829A
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F583B55B9
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA07934C82F;
	Tue, 21 Oct 2025 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFVbUDnL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C5234D92D
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072961; cv=none; b=tYEyrPyUb1X/kMfRkrshxbo0NvogVtW89mkvG+e3e0Ez3oqtl5mJ9q0A1faEiz46CWWSDRRiLerYDGaaCWUhFbw5DNPkFRlkalRYFmiMFl4BmmOgcqDnlKOGGCrR/f8X+y3XsvGMeO50N73X8Y/dGPrJkNtr9DEGToF/XcqDz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072961; c=relaxed/simple;
	bh=meYJS5QIcvO65u6L4M6f+0i/AHD3lhicEaIQFPi2Vog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aX+AEiSG1pYe1/Y8f+xIwwcPj8zvd/Mh2ejtD9ooHSG7pPchVmbAIFvQfc8WUQw+3OV6fSDhkt9rkJUWo4NgJ3YaWex6NoqTLJ2AYnU4K3khtdUqCmFH2ggcoXduSQ79jaatHUqywx4n3/66ZOfFjAiQjzKvRNLfD82h4PPHLD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFVbUDnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C71FC4CEF1;
	Tue, 21 Oct 2025 18:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761072961;
	bh=meYJS5QIcvO65u6L4M6f+0i/AHD3lhicEaIQFPi2Vog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFVbUDnL7W9DMZPUolmhMGE8FIAWKLsyzglhY7zvg4SvTEJUyppZ8A5SaEDtM2hlh
	 O7MUkZrvIjXTr/zscDf9Pcp8dpXZbeEg701Arc2tMKi29P5cKCu3D6+svS90BNdzx2
	 6Yc56iqqCWxmDLkE7WkuLO3ZgeoP4xP7+gli27HOvI5NcSmW/qxJymuoaVWQM+zdzH
	 PH0iXXomSxjOAl4OX+kPlQVpITwvjKKSwEO6qDC1Kro3s5k0Wi1jm2V/bXEmNiMD2y
	 f7uZQzGjsiAqHRNR2nehatOi8SU5dsPwC92W8B1mKoRBzoufwlWMAp6M6hwazUODpz
	 /EFpLlqQqxX0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 1/2] memory: samsung: exynos-srom: Correct alignment
Date: Tue, 21 Oct 2025 14:55:57 -0400
Message-ID: <20251021185558.2643476-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101607-discharge-haiku-4150@gregkh>
References: <2025101607-discharge-haiku-4150@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit 90de1c75d8acd83e9a699b93153307a1e411ef3a ]

Align indentation with open parenthesis (or fix existing alignment).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Stable-dep-of: 6744085079e7 ("memory: samsung: exynos-srom: Fix of_iomap leak in exynos_srom_probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/samsung/exynos-srom.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/memory/samsung/exynos-srom.c b/drivers/memory/samsung/exynos-srom.c
index c27c6105c66d8..734fe988cd287 100644
--- a/drivers/memory/samsung/exynos-srom.c
+++ b/drivers/memory/samsung/exynos-srom.c
@@ -47,9 +47,9 @@ struct exynos_srom {
 	struct exynos_srom_reg_dump *reg_offset;
 };
 
-static struct exynos_srom_reg_dump *exynos_srom_alloc_reg_dump(
-		const unsigned long *rdump,
-		unsigned long nr_rdump)
+static struct exynos_srom_reg_dump *
+exynos_srom_alloc_reg_dump(const unsigned long *rdump,
+			   unsigned long nr_rdump)
 {
 	struct exynos_srom_reg_dump *rd;
 	unsigned int i;
@@ -116,7 +116,7 @@ static int exynos_srom_probe(struct platform_device *pdev)
 	}
 
 	srom = devm_kzalloc(&pdev->dev,
-			sizeof(struct exynos_srom), GFP_KERNEL);
+			    sizeof(struct exynos_srom), GFP_KERNEL);
 	if (!srom)
 		return -ENOMEM;
 
@@ -130,7 +130,7 @@ static int exynos_srom_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, srom);
 
 	srom->reg_offset = exynos_srom_alloc_reg_dump(exynos_srom_offsets,
-			ARRAY_SIZE(exynos_srom_offsets));
+						      ARRAY_SIZE(exynos_srom_offsets));
 	if (!srom->reg_offset) {
 		iounmap(srom->reg_base);
 		return -ENOMEM;
@@ -157,16 +157,16 @@ static int exynos_srom_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_PM_SLEEP
 static void exynos_srom_save(void __iomem *base,
-				    struct exynos_srom_reg_dump *rd,
-				    unsigned int num_regs)
+			     struct exynos_srom_reg_dump *rd,
+			     unsigned int num_regs)
 {
 	for (; num_regs > 0; --num_regs, ++rd)
 		rd->value = readl(base + rd->offset);
 }
 
 static void exynos_srom_restore(void __iomem *base,
-				      const struct exynos_srom_reg_dump *rd,
-				      unsigned int num_regs)
+				const struct exynos_srom_reg_dump *rd,
+				unsigned int num_regs)
 {
 	for (; num_regs > 0; --num_regs, ++rd)
 		writel(rd->value, base + rd->offset);
@@ -177,7 +177,7 @@ static int exynos_srom_suspend(struct device *dev)
 	struct exynos_srom *srom = dev_get_drvdata(dev);
 
 	exynos_srom_save(srom->reg_base, srom->reg_offset,
-				ARRAY_SIZE(exynos_srom_offsets));
+			 ARRAY_SIZE(exynos_srom_offsets));
 	return 0;
 }
 
@@ -186,7 +186,7 @@ static int exynos_srom_resume(struct device *dev)
 	struct exynos_srom *srom = dev_get_drvdata(dev);
 
 	exynos_srom_restore(srom->reg_base, srom->reg_offset,
-				ARRAY_SIZE(exynos_srom_offsets));
+			    ARRAY_SIZE(exynos_srom_offsets));
 	return 0;
 }
 #endif
-- 
2.51.0


