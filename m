Return-Path: <stable+bounces-183719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3250FBC9C33
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 17:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B830919E86B4
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 15:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F0F2206B1;
	Thu,  9 Oct 2025 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txHzJWNF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451C1F09A5
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023512; cv=none; b=OAKkpQ8WCtgYVRhHt3xdArvKl4DWLeFDFLbD02nFFEVuWmVdmheFGUrCickgWr3XYE/qHh0sadIdYYGRbQEIFwsn4A0ljZQ9++oljZo28Me0opyuWXcvHmT2VF0Oy7LGJ8HWHq1wc33K9IR7g+HS+Y8de0aq49K007pMmv7He6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023512; c=relaxed/simple;
	bh=8Ji8C7SpUzRnr4uMcWokKZW8lUvYX6JJLUSo4lu5Nb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dyiK7nXASpfTAzlG31YJcpsPfSgAGv4Sf75fD/zoeoAQEZhJTw6KjQUlTHoY/WQ7p953J9yrU42LkuvirWGxgeim73TSSM/Z0XDnIxTU3ax6yYEx0/sIN5QXVhonCI3RQZOluw6B11k5ffn32JvwRL9OVtDdLInLYmodT/hhZAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=txHzJWNF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so166674266b.3
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023507; x=1760628307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ousPsrsRzOuJ9D//mwlWhy/3PCTfUESlugicNK8z87Q=;
        b=txHzJWNFiTE2JcnC5bG/2BCoGJAALc13E+ze6lvCIdC1ko4/4SY5l9qMQr+GBNDgxN
         OiS3lN1EMVH7eWdRPwPz221avsGZuWhF3rSzIOa3r0h+y1MB9O8572mwfHkSHosz8g6L
         aG7MIrvX1bqhP993pyHFq7zAm1Ied0ThMOpJixADrCRzhlvfXpBumRVYeq6N4p6gkVZm
         W8Ug8Q6nnSeqe5yTT2EI+/MvO/dYrkS4muRChBf0FcPXauk4yQRCDxiz05BzBOe0MUgG
         ucdD2Y9lj+pnpDeE6GDhA6ZoSZ6+RUYAWEx3rSfsh/28C1VwAsAOLXHprOGCj78ERZDU
         F0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023507; x=1760628307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ousPsrsRzOuJ9D//mwlWhy/3PCTfUESlugicNK8z87Q=;
        b=jf8mj8RU6uM7Kvy+hVUOooM3UBJFgr0cG0l4hOlHgm0xlhvkVa2J+YUxqsRYQz081Q
         2hG2/QQakcnr0YgxPLNev6NAVzCOcGjgT0sN4LC5eY4RqJ+jNxjJba6Dru9SypyjPCu5
         AI3IdJMWEe0FjJVskVUTZWZGmHiP1dYyhVXf9XpubF3Q+Vx6ingsBpKH9Pwo5US9BIo5
         h9t5b4vGjlZgv4eglyQQc0km0cyGwiM2qV7U22G/JrxC7yUiOO9Li7vxHqZW7Gbw91eP
         rwiFq/ciezwyEIgvOVePYfw4JWFPEqxi+XEuVcIQrtZMKuMjH92xHhiTJeuyA8ZhlUNL
         q2Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVDOd+FCV3XawzMO8NXW8Gy6z9yo8tNnB+fCiIRAahBTjaiF1jGwpEEz4t6UxVI7jFDk+ZQ+BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyujJ/lZPG+qp9jH5E9tyQ9gzD58Nn81q+4algtgsZzh2dBRXZn
	T2p2TAGOL0nccgnTq1K9IFPz0a9sTv/kOJnSNK379ju3vRHbP7czzL7rBLgJcfm8jWc=
X-Gm-Gg: ASbGncsUTUhCg1/lrhGVJmPkOMCDpok7VUfsTr0X415/EV7BfVvk7W/y47CeK3qax5l
	NXP4JK03hjwtX1ZktHpRrYIaWp//JeWMhZKAXU1gYGRBTQuTGF8uVECsD8Q5km68UubO7KhzUko
	1Kr5hqeKzrlZN6a/CV4PEe2g9WmRLsejkVbuqtRUAbKjIaYOajd+ttkk15IHMnmi8G7YjISO8+y
	OSz0eLaCXtoeiSaDjeglozlYRfpv9KX5QVmWJRqdE4tCFv2gnOnTgJd4F1VZZQWNrZKdACiLYjr
	pPx7kxklkJoNiMv0IPeW929ZALaG32TE9/Vcu6FxnOldYGSJZHY/i14U3k4088cwmUiOeBrJa66
	kF73jE7vVSauNSVHFaAHkYLyCLgjmt4q+apg1OVXY2QtHs/f6W7LLmgGIOogChS3UtWLfnGzO35
	88MUm+Awr3ehN7ZavCakOvTgjGMwV4eG48uXenO8BTSuVultPvXzw=
X-Google-Smtp-Source: AGHT+IGU5YJiQEOLDla4H1yxJNOxda/6iu+/j1tDENPR+jWfagJHuOHAMVeCVTX+CKrhpEHAyCcJqQ==
X-Received: by 2002:a17:907:934a:b0:b48:730:dbb3 with SMTP id a640c23a62f3a-b50ac1cc3eemr881096366b.32.1760023507336;
        Thu, 09 Oct 2025 08:25:07 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:06 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 16:25:06 +0100
Subject: [PATCH v2 04/10] pmdomain: samsung: plug potential memleak during
 probe
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pd-v2-4-3f4a6db2af39@linaro.org>
References: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
In-Reply-To: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
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
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

of_genpd_add_provider_simple() could fail, in which case this code
leaks the domain name, pd->pd.name.

Use devm_kstrdup_const() to plug this leak. As a side-effect, we can
simplify existing error handling.

Fixes: c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platform driver")
Cc: stable@vger.kernel.org
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
reword commit message, as this isn't a pure simplification
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
2.51.0.710.ga91ca5db03-goog


