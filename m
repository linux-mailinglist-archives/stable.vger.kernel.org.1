Return-Path: <stable+bounces-58746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D786B92BA31
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 15:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AAB2B27811
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1026315B999;
	Tue,  9 Jul 2024 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uTm4SFy6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96B14884D
	for <stable@vger.kernel.org>; Tue,  9 Jul 2024 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529997; cv=none; b=dA6NgWcG3YwDg5+PERnvFBZeKY2OnjUPM/VoO/Cdhg1KZmF1NcHaO5lf4Lo+z4TL/ZHttPdD9MQp3rZJZzVlH8ghi31rZoxiGExxE226Dn1JVwA1M3O0JWcFyhu4sRMcGMCW5cVVzrHK+UgYJJAcu7PJzjzGD9NPWP8osiCImbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529997; c=relaxed/simple;
	bh=kgvsfjbzeej3OYxVir+9/eTJEO88akNuKkqf+hwCQrw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HWa6S5+ctdB6EpYOF1okXB4p9FzkJUZbR0urp5oZ1j17/RtyoIF9SqAveDNNzUtpCqsKQh3U3qpKZ6n7Guburyai1xQC0mw0A4rpbdXhE48StJWUoiSe2LP6O4lY/h15k0jXg56YDlVVKwdwS/2BgYqEKP7FG3d3EGeSsaa54p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uTm4SFy6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77b550128dso640420266b.0
        for <stable@vger.kernel.org>; Tue, 09 Jul 2024 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720529994; x=1721134794; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zyMaA2ktAP79nx6/5Mxk0l1yWWoFwZUP+h8kjbjB7+c=;
        b=uTm4SFy6sa9uTMVYxlAwCiBQcZo77gWsDTEBzMpgkJaCEXBGsBzdaxBm4ixUz2BnCR
         evgky1j8im6ys4APFa5JQEcqVjwmXHpzCek7FnN3Iv8IaOiDqDzqzZIHboqae35b1zvX
         LWL9dmlCMrmNJHNp+FK1x4S4UddqbUPJpCLYVpcMQZJLVdoz0aSXVPQo5iOCHXZTblYr
         +CQ0IMWTMAevUPlEQ4TjVVL8g2ysdJU3O2Y2NwKb1LznX4txF1zMvZURC23HJSq0Yy7b
         jKdZmeP7D05wWfQppX/+gM8s30QoKkiCbj6V8zBe7lEDH43qziOUrrpHHwX/n3w2mxgI
         8Ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720529994; x=1721134794;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyMaA2ktAP79nx6/5Mxk0l1yWWoFwZUP+h8kjbjB7+c=;
        b=LZsEq70dV1E1pOIisVj8hctsnb3M6gGr8DPwVYVmkeu0Y4p6ybELZ2q7hLYW5dQ9/o
         akdobKX/VTg0g51dIg+CTACerRPxk0u33ZApZY3hPLd3S6B9V8LJx8M+0meiiZ12ecdr
         CmKGTLavmrg3IpZ7Dy0gxr/ZEjhHHkHuikv/pM3ed0DLVoPEtL/O2Qs/8s+rbReGP8Ak
         PW2IIi0+oISW1g9hWsL39KDahZm0k/YEch1EioRl+o4gywkQ0NZJhU2jmQQ19KACxDjR
         ZCDjqbxSorIve7vtHxrR/bXPCZoaC5aKV9F5Xtm3GodiRli7j5kIDyl5zzoQAt4TFK13
         crVw==
X-Forwarded-Encrypted: i=1; AJvYcCW90QNGSEmm6tTbkTcE0LAvm7dtVPgzQ28SAu778hpjGqTm9qWhFdkqVB/ze0pFGQbHbrty9uZBfGOXT0xd0vJu9Zg7zHW3
X-Gm-Message-State: AOJu0YwByabCQv6Qhe/zCc/dHSNl6i1hQvUXP7ezkd3p71jH81fInlRd
	lTLVdhHvXuS3FcwxgowV4S1lLyvfPD7GbG+qBUUkBhgPqo/Y0xBrZ41cL020vwo=
X-Google-Smtp-Source: AGHT+IFQIeObXuWwjzPQ5P94Pal4hLbHGTYuZ6cJpzJB5yZLLI58o/F8sFx6F5zODpmX82oPOJ7QOQ==
X-Received: by 2002:a17:906:68c9:b0:a77:e48d:bb2 with SMTP id a640c23a62f3a-a780b6b17cfmr198118866b.17.1720529993825;
        Tue, 09 Jul 2024 05:59:53 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e157bsm76643166b.80.2024.07.09.05.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:59:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/12] thermal/drivers: simplify probe()
Date: Tue, 09 Jul 2024 14:59:30 +0200
Message-Id: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADI0jWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwNL3ZKM1KLcxBzdgqL8pFTdRHMTcwND49QUI4sUJaCegqLUtMwKsHn
 RsbW1AIrkdShfAAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=kgvsfjbzeej3OYxVir+9/eTJEO88akNuKkqf+hwCQrw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmjTQ5RRSnjbiXlLPhl5LMO5ohaeNBNwWB8vx7W
 nTbN1nTmLCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZo00OQAKCRDBN2bmhouD
 1wRbD/4zSxySS/s259DEhJkaDdc25d/x90eolV0xLjn69nZ8s0mzMdnlWQ4MIZZBUVetoXQq0rA
 UAhaAB2ZuzW4bnol7GTHITMuTSEE3ACJ0Vx0cae5TvQ4uK5LItk9N8xvQRsH/z9GBIyfWs55B7E
 8z+yRBcm/B79zJPKMNLikxQs3y1GZy7Tip8LpRaQCvJ/X/tpx4ZffAMMcklbUBaA4PvNczr31MM
 j278W4BnIuJsg32T8+FAHLXVz0XTc34BzqYcgdFlC8eCsN6usty2kRrgmwNI1AElEdK/PIf9L5w
 +uMCWChYVNtW0Rrq+eF95VI0hXgdgGynF3417buGiRaYhLr3WP3zPc/tm/Qby+d4SvYXya6d1ii
 WX+ytupuXnatXPeMuUFJs1pZ78ZcVzED7NAILN+09KyXdgnzeuq9Py7V7F0T4yH3VQQM69N4Z6S
 RKGJ+b1wlcFwfnAMjZqYV9MZOJbKtp+VQZD/bESWhBq+NVECBwdnKQM/Ty8SkW7cKQ1GG5LvLfo
 fFiNLDcQEoMyRaF0Mor1lZYcGGKO+GUFafTA92oL6eUjBIKtWNJd99xa0a7i6WnA9za/aF1Jhor
 IwQOu/FpEkFjyMZZYlJjLlr5d2DMIC4TlAlVp9d3KrB1XxeAoJoeHeIu8Y7wPXNL0wVd7Foetw8
 MrCiqIxYJ4hW7eA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simplify error handling in probe() and also fix one possible issue in
remove().

Best regards,
Krzysztof

---
Krzysztof Kozlowski (12):
      thermal/drivers/broadcom: fix race between removal and clock disable
      thermal/drivers/broadcom: simplify probe() with local dev variable
      thermal/drivers/broadcom: simplify with dev_err_probe()
      thermal/drivers/exynos: simplify probe() with local dev variable
      thermal/drivers/exynos: simplify with dev_err_probe()
      thermal/drivers/hisi: simplify with dev_err_probe()
      thermal/drivers/imx: simplify probe() with local dev variable
      thermal/drivers/imx: simplify with dev_err_probe()
      thermal/drivers/qcom-spmi-adc-tm5: simplify with dev_err_probe()
      thermal/drivers/qcom-tsens: simplify with dev_err_probe()
      thermal/drivers/generic-adc: simplify probe() with local dev variable
      thermal/drivers/generic-adc: simplify with dev_err_probe()

 drivers/thermal/broadcom/bcm2835_thermal.c | 49 +++++++--------------------
 drivers/thermal/hisi_thermal.c             |  9 ++---
 drivers/thermal/imx_thermal.c              | 42 +++++++++++------------
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c   |  9 ++---
 drivers/thermal/qcom/tsens.c               |  8 ++---
 drivers/thermal/samsung/exynos_tmu.c       | 54 +++++++++++++-----------------
 drivers/thermal/thermal-generic-adc.c      | 27 +++++++--------
 7 files changed, 76 insertions(+), 122 deletions(-)
---
base-commit: 2e0171396caa83c9d908ba2676ba59bce333b550
change-id: 20240709-thermal-probe-a747013ed28d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


