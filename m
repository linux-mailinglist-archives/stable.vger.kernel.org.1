Return-Path: <stable+bounces-188413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BEEBF82A0
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503E43B8991
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7646234D92D;
	Tue, 21 Oct 2025 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWBjq7vw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361B334D904
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072963; cv=none; b=GSGnQDbRjGSp9VUsX/Dz51Bh//6TGG5jy96Enk5p5CYiVwaCUzpOcGaHRxcnerApJAqaYBoEmtnEnM79oExqyMMKC+qp12XSScJc1P5h6Zrv7rOcrXGdOjPIAY8UV9YeYkKu0kLB/U2mR91C+S/lM4QtN76Vd/tsRGwxMLHppRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072963; c=relaxed/simple;
	bh=o9sUZgyZC9p5lP1A1RY1k6pzqzMAewIziWsD7CDB33s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuODSbGnB2/lGKQt5Owq5X8rHTJWau96PHNe4ZM/xJSdzNrAedmanjjAgFKCmNYB5G9ap2nTAE2fcWzyTl+lRNhDF4LdhOpxm7GrG7pEd+3iq9zy+DMSrxSgepCAXtXXKwXAO1xpCGDxUIG+/i3elTDNUcBJNLwZg8Q6RlNr6G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWBjq7vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48528C4CEF5;
	Tue, 21 Oct 2025 18:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761072961;
	bh=o9sUZgyZC9p5lP1A1RY1k6pzqzMAewIziWsD7CDB33s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWBjq7vwrY+2aoISd2zYl2TNQkpwIEMj58wh3Rp+YIo27UY+ZMSVlS/j6/TUN7yEU
	 OZM82aEvMwqjEGYBJ8gwwTHARjRpUr12ItiikkK/8HZZjJl7zPNHU3VfmaznpMiF3a
	 kUb+T9NhN/vDMvFbKWH0v4O1nygfkkIz+EaIixIAIlhkb0SxBbONFQ2gXJyznjcWsY
	 OQmBk6nY8/oDgKa+lYrsqzaam+Yvflj9hrLJqgrWrvQ8Xv8BFu09XLrGlGRNe8jP12
	 Xtro/vfyWbkb6MO5/xbJwMM5XXvTZYLnZkcCfC1ofcZWo4gl0cDXN8vdeCl46+ePrR
	 6q8LifCfRwPZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhen Ni <zhen.ni@easystack.cn>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/2] memory: samsung: exynos-srom: Fix of_iomap leak in exynos_srom_probe
Date: Tue, 21 Oct 2025 14:55:58 -0400
Message-ID: <20251021185558.2643476-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021185558.2643476-1-sashal@kernel.org>
References: <2025101607-discharge-haiku-4150@gregkh>
 <20251021185558.2643476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhen Ni <zhen.ni@easystack.cn>

[ Upstream commit 6744085079e785dae5f7a2239456135407c58b25 ]

The of_platform_populate() call at the end of the function has a
possible failure path, causing a resource leak.

Replace of_iomap() with devm_platform_ioremap_resource() to ensure
automatic cleanup of srom->reg_base.

This issue was detected by smatch static analysis:
drivers/memory/samsung/exynos-srom.c:155 exynos_srom_probe()warn:
'srom->reg_base' from of_iomap() not released on lines: 155.

Fixes: 8ac2266d8831 ("memory: samsung: exynos-srom: Add support for bank configuration")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
Link: https://lore.kernel.org/r/20250806025538.306593-1-zhen.ni@easystack.cn
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/samsung/exynos-srom.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/samsung/exynos-srom.c b/drivers/memory/samsung/exynos-srom.c
index 734fe988cd287..0f182698ccc66 100644
--- a/drivers/memory/samsung/exynos-srom.c
+++ b/drivers/memory/samsung/exynos-srom.c
@@ -121,20 +121,18 @@ static int exynos_srom_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	srom->dev = dev;
-	srom->reg_base = of_iomap(np, 0);
-	if (!srom->reg_base) {
+	srom->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(srom->reg_base)) {
 		dev_err(&pdev->dev, "iomap of exynos srom controller failed\n");
-		return -ENOMEM;
+		return PTR_ERR(srom->reg_base);
 	}
 
 	platform_set_drvdata(pdev, srom);
 
 	srom->reg_offset = exynos_srom_alloc_reg_dump(exynos_srom_offsets,
 						      ARRAY_SIZE(exynos_srom_offsets));
-	if (!srom->reg_offset) {
-		iounmap(srom->reg_base);
+	if (!srom->reg_offset)
 		return -ENOMEM;
-	}
 
 	for_each_child_of_node(np, child) {
 		if (exynos_srom_configure_bank(srom, child)) {
-- 
2.51.0


