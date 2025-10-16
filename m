Return-Path: <stable+bounces-186173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787C5BE466C
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 17:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D2B1A63B86
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02AC369987;
	Thu, 16 Oct 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HIY0wBqE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB143570BC
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630333; cv=none; b=Pcixhd8XCFrxw9+xxWaXe8qqJuNOt79Liu5SK0CXAFBQYqsIveFRaWnB4fMGCpy9BhHj+rMEFcQz7EFFAlhAct5tgKHZrRYzr/R4dq5r/bxvDvdJzzQ7s2r9XddFzwk80JvLlyhIPieNhTrSnYQSDW8rFghPWJPGjub2EpPaJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630333; c=relaxed/simple;
	bh=EEsquKkEeBg70sExu6NBhMPgtI1d6LaAxzWYM2RtBsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m/UpRZuf/+VcvlYD2L3fMc394wygRE33SYq5J75VOtt/8ZUl3y0Wx6GAwbtfil73CIp1+ivQeTAwkOBLe9NcoE33hCPHasa6AEkOx5IuPEtMEokZ+B4EMJrLaL6S6pwYyLqVrlU17SnHOhO64ZtkZNlrpwgpM7QbAqvxbaRouHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HIY0wBqE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so189386166b.3
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630329; x=1761235129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsw3nGMrSykhH7OS6v0fNa6J+UTT3lDdTIT4s5cDl2M=;
        b=HIY0wBqEwwRpQUgPqCzQh4gHbZg4aYsoFSsZkUzYjWH04UnkSLfywIWMsLYmDesh5e
         8xbx7RQFO+WVuQlEqnRRFQPahOPDdWlMbG6yi4IB0D9ZvK3pa+3uWxSRT67N6lg+/jud
         ypfj2ydOIjT52WdlFxb/NpRy4g9214Xo+Hvo7c9m9MurHMrJLz52Fl272vo2lkJ4psgO
         g4RGBg16rotTu9xXByMMn7W7fKl2uZpaFHdYOPsdJEaDL1t3AkDlpXHAxZnehzqh4Ap4
         9WxwnURT2q6z77rn17Dgjvp8t4XgSfgMahcGz1mUSdbej1nCIjkiWghii6m1SXWp7O9Y
         sk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630329; x=1761235129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsw3nGMrSykhH7OS6v0fNa6J+UTT3lDdTIT4s5cDl2M=;
        b=H76JP846k3OmLWz0Sq+4kDRm/h4h6H26RAW8qoEezn0jqOyAIZqugDOc2RZiSvM+mu
         SQsQRP0RuVfpZR63BubREYyGPR787uRVTh94sUKrVuoYR0/9uUdKGbvjwusTqD0b58Jn
         CMhP6VQqQqgWe20N6qUVoIgHPMbAL4xNvPYBmkYxAGmkHF2u2sExBtgt9X/yAAeQn60Y
         ble2ZQkcWv6Yq4sHCrM44pkW+B0F/GLm3kyIPxFxrfypF2dQ482Ezjo/iyORarEJKl2c
         5a8aFs9EVX8LitMtz+ewCASeCkHdmEGRLk/2FtCvMkFKe3pguMNIfMVtlGSbPPQCz6Ht
         mBrw==
X-Forwarded-Encrypted: i=1; AJvYcCVz9Dv7jaqZA+Ec7MJPux3nrNf4Iy5oV4QT9o1DDm1zt9YQJaLHcfXwZ/OdO3+THiZIJQ3/ATk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywij1jjWux7GIjGuerlGl39npQEwZUNcmLgTLujnoQrx7Prz7mD
	U12syVl3sSo/BVs0RlH+smlRcI1Ap0tkETA3Krp32+ndrAqlJ4+H9C106By5hPhIfDI=
X-Gm-Gg: ASbGncuk6pkP2cIVT7VjGDDD561q7H7we5YJWekWpzkO1OuNkLpO406qTjCmdL/gxOL
	KHvUd5GsI16YX8hmlTOFS9/UB+an5/oaXAfOzM0J/OhG/9WZk/uNVo4oVeswRDCPCiBwllFYJuD
	6OBpUJadpU27wgvm6hgt1XBVtRiKQCH2CIKfh9tDbsIqVFH8nNlfPTPlO5b501PuPvniRqPXPjW
	ThxwJhPELBgUH3IL4BK+WAGmDob160e9fahAsURt09VvTaaWNL9JDvLwYAuw0xy8jJbIr612Dm8
	1yo7Qjv8EOhWdzJxCC7TWNFlaJSqyf5/C6Www4/wXHVmReQNYXaH3h2PYTNS9+viQqPBQ+X1il/
	8JDiEdP8avY1Sj413oGVl8yy0vG5Y8yHXcdnmJ+gESZ4KUAzcIanqLYgEm9+uw1EpRezgbA2yc5
	XrmWhBBlwY0+zaLnZVNlvrEKGrXUy+I28Ve8n+d7359GZ475IHX8T0/Oe5CoXKwClicy9mr3Y=
X-Google-Smtp-Source: AGHT+IGMnDfjfOzAoSs5yqEhzRvyTEgvB4V8vlEt+WcTbrwh6jjeesT23Hol4E5oowOHUJe3KnWaFA==
X-Received: by 2002:a17:907:1b21:b0:b3f:c562:fae9 with SMTP id a640c23a62f3a-b6475703a96mr48316366b.53.1760630325277;
        Thu, 16 Oct 2025 08:58:45 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:44 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:37 +0100
Subject: [PATCH v3 04/10] pmdomain: samsung: plug potential memleak during
 probe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-4-7b30797396e7@linaro.org>
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

of_genpd_add_provider_simple() could fail, in which case this code
leaks the domain name, pd->pd.name.

Use devm_kstrdup_const() to plug this leak. As a side-effect, we can
simplify existing error handling.

Fixes: c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platform driver")
Cc: stable@vger.kernel.org
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v2:
mark as fix, as this isn't a pure simplification
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 5d478bb37ad68afc7aed7c6ae19b5fefc94a9035..f53e1bd2479807988f969774b4b7b4c5739c1aba 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
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
2.51.0.788.g6d19910ace-goog


