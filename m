Return-Path: <stable+bounces-196537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D77C7AF8F
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70B154E60C7
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD68218AAB;
	Fri, 21 Nov 2025 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCRaVft+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ECA2E7F20
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744321; cv=none; b=YAHSkNVT8y/u5RNi2yb4pg18ur/83Qm1f5zCHiHg1mVHmf62B9oLK7KVN0qL1EfA2ReYC5phvjfiTdTcBhcD76MAoVj21h/2NN9CY50DEZCgKBAe/vbKJHoCYA27R0F0HyQhEpzm/hFFxPiizJZZeT1JVKu+5YcoJrxUrQxeuYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744321; c=relaxed/simple;
	bh=o9sL36guweM5ZRc75OBlOcxvCwOoZnRjnQ7TCzybzTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OD8jMEfwLd06k11AXDl5LTLtdDFWLKYVw/ImDrT3AFoZp7xlGaZJcqOXXYJIrFvc+mw4bexwtoQCo/BhjOlSj174mkJRzhgD4qnoHCjGFEb1JFBVcpW/5taMJns7nqQFCf6hlirfYwS+CB6Qm0BwsMUmKALbn1HnsNrdaO+Q1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCRaVft+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F004C4CEF1;
	Fri, 21 Nov 2025 16:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744321;
	bh=o9sL36guweM5ZRc75OBlOcxvCwOoZnRjnQ7TCzybzTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dCRaVft+jE9USrS0ulcabh31NMN6B4ZZ/GSC+irDE06Smwv7kiGMun4Ke3KpAdVfa
	 zqWQVcmkLBU6VG/GFiTG+UgpJdb0RI4v/Mgm0lkEVDU7EGFv1x82mIzg4DN1z+BcsP
	 W2G+1GnYxGLz39n7dMBLJQzsVjsqrVKIrpil3RKUNVVJKcqPnL7ArfVjr8LrYBmIvg
	 BhlvJLqKJVjYYM7DNe5/Jt4RYiDFXdw1GDoxcVdpgh7MuVqnfm8WoDRdHay1XKXDMd
	 w0mt/5/BKVmjMFL1FgzofGzFyCXZUbPbVzA0s4i3t2ol9bTErU7UzSKUFhYNX8Pp0v
	 93K9RyP092xEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] pmdomain: samsung: plug potential memleak during probe
Date: Fri, 21 Nov 2025 11:58:38 -0500
Message-ID: <20251121165838.2606571-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112033-oversold-exceeding-d133@gregkh>
References: <2025112033-oversold-exceeding-d133@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: André Draszik <andre.draszik@linaro.org>

[ Upstream commit 90c82941adf1986364e0f82c35cf59f2bf5f6a1d ]

of_genpd_add_provider_simple() could fail, in which case this code
leaks the domain name, pd->pd.name.

Use devm_kstrdup_const() to plug this leak. As a side-effect, we can
simplify existing error handling.

Fixes: c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platform driver")
Cc: stable@vger.kernel.org
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[ drivers/pmdomain/samsung/exynos-pm-domains.c -> drivers/soc/samsung/pm_domains.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/samsung/pm_domains.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index d07f3c9d69031..1091e4a0ed9d9 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -91,13 +91,14 @@ static const struct of_device_id exynos_pm_domain_of_match[] = {
 	{ },
 };
 
-static const char *exynos_get_domain_name(struct device_node *node)
+static const char *exynos_get_domain_name(struct device *dev,
+					  struct device_node *node)
 {
 	const char *name;
 
 	if (of_property_read_string(node, "label", &name) < 0)
 		name = kbasename(node->full_name);
-	return kstrdup_const(name, GFP_KERNEL);
+	return devm_kstrdup_const(dev, name, GFP_KERNEL);
 }
 
 static int exynos_pd_probe(struct platform_device *pdev)
@@ -114,15 +115,13 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (!pd)
 		return -ENOMEM;
 
-	pd->pd.name = exynos_get_domain_name(np);
+	pd->pd.name = exynos_get_domain_name(dev, np);
 	if (!pd->pd.name)
 		return -ENOMEM;
 
 	pd->base = of_iomap(np, 0);
-	if (!pd->base) {
-		kfree_const(pd->pd.name);
+	if (!pd->base)
 		return -ENODEV;
-	}
 
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;
-- 
2.51.0


