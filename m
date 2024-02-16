Return-Path: <stable+bounces-20344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF081857A3B
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 11:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FCF21F23B75
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 10:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DC125551;
	Fri, 16 Feb 2024 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wyQ9a418"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93573249ED
	for <stable@vger.kernel.org>; Fri, 16 Feb 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079103; cv=none; b=Ffe0BR9kHcIfAcfUATll9ybZbw3eKuAIWsLqTVlp0Cx8m5KownthHi22tygKe9yVCR2KKT1bbnrKJKs+q+96kvLSgiqzYbQO+qPIUmIeRZhZv3mExbXSVG+vIPDmFmF2E3CXiKe9emMcjexJSzJa/7oPeFVL2AJWmA5Qi0cEaO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079103; c=relaxed/simple;
	bh=RdNpeE3d+oW3k9ivrv9Mt8CvCnEdyMVqc1Bql/ZN4PY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eZglw1tBSUvqs6ZfLjazJePdb6dBFUovU1WTpaDBbwX2xjIgn3Bpa4/P91km3zzyaH2niE9TAvTsOcLKlsdQP22NV3GIU611zhM/AvVFxPoit4PULtFml6DjZPaXWboEeQudYQGJ336nGzhSo4UGSUi21AIlMDmBFWjsQx3o6+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wyQ9a418; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d208d0b282so20611671fa.0
        for <stable@vger.kernel.org>; Fri, 16 Feb 2024 02:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708079099; x=1708683899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9uwpxzD7wxs4tMFhIUi84X6jUwWhqp/NQm+0nfPH8IA=;
        b=wyQ9a418g3CohbFDjygafaUoTgmJDWSDeV9qgCfE9x8+oSyXJcZf7m1g91Nn8ch1Ip
         X6stMmSo+9/0PHIpU38v2l3eqb6BAmwIzuNfgN1Mc/VGYVLaoDkbP3fHXEaEW/G9xTzo
         eY9F17RgD1c/lBqLjkhO6UOwHwWzuy27RIQR7VP8KuRrb1mibLf2T7Oqbo+cz9Rkmcec
         cXhHMfub5KbnnVdWEtB+2zanjTE5d0L+urEL1Ejuy6uflW4LA20bbosBBdtOFYFx3WUz
         lWZPTKlUmx47/2UhgXonq2cTPiB4nwFFywf1kIQxSWTUxlYh4Mi/cQq1hmC977T4G9uq
         tlDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708079099; x=1708683899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uwpxzD7wxs4tMFhIUi84X6jUwWhqp/NQm+0nfPH8IA=;
        b=kc/AQ1PigmfuqXnelWbQSkRowzOdYe9JTnqCgsPYmvMoC2IK1dgXp73uMfuwaYHRou
         75fTO0oH9eCfUUeG1bJw+8CRt5E56fgNEYUoL8/n+qKE8vou2zRjiWXR643CSreZ672K
         xaApv33lfa5Ec7uWsoMe11R7LqWbcfc8xO8vnVoHXFcCEWqolOfpon64zBPag//ILvK5
         BUu6s+2Zcdr8mQ1StzmnRzcjsQWhlucanwcBb1cJWSBD+Urk5gf5Jbv1tLfddB2NvcRo
         nmijxKr67hHa7l749n6WqvuxiNTB/M3hU4l6Bah/NbmBXq/2sDLbl1CMNcSqvTntdErG
         zd4w==
X-Gm-Message-State: AOJu0Yy84QzMg5JngUZIJ8fnRuNpYs53v0licrIVWjkpR+zlFFLXstKN
	ME5uZiD+1YN9wozf/+Am9RqLxg5N86Egz676dsaMUkXMdC8hF/qfQNR6F8OtBvASjgvv1R3U7rE
	+
X-Google-Smtp-Source: AGHT+IGoZm/xp1G/OD/8Sl4FoiC95cUmkntuMFrDr7Qmfp/kfCwUeNUTxLGICD5tmQBANj3SLO1Z1Q==
X-Received: by 2002:a17:906:7196:b0:a3c:7fcc:3967 with SMTP id h22-20020a170906719600b00a3c7fcc3967mr3430139ejk.40.1708079078897;
        Fri, 16 Feb 2024 02:24:38 -0800 (PST)
Received: from krzk-bin.. ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id hw12-20020a170907a0cc00b00a3d5d8ff745sm1438580ejc.144.2024.02.16.02.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 02:24:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: sm8650-lpass-lpi: correct Kconfig name
Date: Fri, 16 Feb 2024 11:24:35 +0100
Message-Id: <20240216102435.89867-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use proper model name in SM8650 LPASS pin controller Kconfig entry.

Cc: <stable@vger.kernel.org>
Fixes: c4e47673853f ("pinctrl: qcom: sm8650-lpass-lpi: add SM8650 LPASS")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index e0f2829c15d6..24619e80b2cc 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -125,7 +125,7 @@ config PINCTRL_SM8550_LPASS_LPI
 	  platform.
 
 config PINCTRL_SM8650_LPASS_LPI
-	tristate "Qualcomm Technologies Inc SM8550 LPASS LPI pin controller driver"
+	tristate "Qualcomm Technologies Inc SM8650 LPASS LPI pin controller driver"
 	depends on ARM64 || COMPILE_TEST
 	depends on PINCTRL_LPASS_LPI
 	help
-- 
2.34.1


