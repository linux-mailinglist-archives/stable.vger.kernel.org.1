Return-Path: <stable+bounces-196543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B090C7B079
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22693A2634
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712C733F395;
	Fri, 21 Nov 2025 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN2ipnaf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE582D249B
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745390; cv=none; b=E65eCskZuXYqCulc83vASYPWhgpW32SYjPZ+4Jb9+LN+aUCCyIt6FUfBCCpUTSRUXdj+Aiho0HKahsrsaFpeeEHqhBaoOpOsqZPK7uWPcHRtzMmmLvH/ayINaxBEF2h72lfe5AsQIHzhsQy1SU2h0Iij8wZxObFW0lpKa5WeXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745390; c=relaxed/simple;
	bh=MNZwiyo2vLFre4BWenHVc8FCKAW3AC0N91n8FpwrOV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWQZHyiBP7qO264hpEXsMki5Zm1hPeSc5891eDvfm/vJg400jkeigsT5ySxCpktXkhRA/C0FTzzeFdyg25smtQLTQXib6eqEXW96EUPMgM4LVHVsniTNkN7UFYhu9CxKnfbUKh19Bx35yQfwwvGf8ujHI4E5NltwOPWUjF/xECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN2ipnaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33738C4CEF1;
	Fri, 21 Nov 2025 17:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763745390;
	bh=MNZwiyo2vLFre4BWenHVc8FCKAW3AC0N91n8FpwrOV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KN2ipnafQ0Q6K47BH+cTSa+f8OC4mcP8yRDUPwhR89cDS1FMNLv1lBrJzamPaFnNH
	 aSzc0yklB1iHOmNZ7iVOrk3y5+pbDigAoWjVNnJKVgxXH+e31cTpq/38ELf4Y/9/K0
	 eJZMclUhE6qhw/gxU90lODZdbMBks4RIL3POuieONXRKaKw6/fyHrDnTSNUvRADtqI
	 6MGv7l//A/peUcEuytO5UEiJgw3iELEWKjDTCQtQTAbCgDfo0FXZ8veCRNRbiqk7qj
	 21fRQSbjJ3lzlmWthXFtlidOlYAyyxVFPHd9fzd84swWXdxYQj34EkRDfsol5oxBQx
	 vuhCjUcuGSanw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] pmdomain: samsung: plug potential memleak during probe
Date: Fri, 21 Nov 2025 12:16:26 -0500
Message-ID: <20251121171626.2611968-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112034-headgear-rug-fcf9@gregkh>
References: <2025112034-headgear-rug-fcf9@gregkh>
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
index 5ec0c13f0aafd..aec7a13a9b767 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -92,13 +92,14 @@ static const struct of_device_id exynos_pm_domain_of_match[] = {
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
@@ -115,15 +116,13 @@ static int exynos_pd_probe(struct platform_device *pdev)
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


