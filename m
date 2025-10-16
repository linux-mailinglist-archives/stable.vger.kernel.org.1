Return-Path: <stable+bounces-186172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF3EBE4636
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 17:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EF55813EF
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F234F495;
	Thu, 16 Oct 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qecl9sbA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D4634AB04
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630327; cv=none; b=pt8NCT3X6OrTaj08Mg2dfFXCTQfSRfCev/v13Ws4R/UmQZ1U1xfSyZpZ05bmgx9Vzcg/bnOr4185V7KRlc4rBmssUEzjrBfXlNNO0r/F13g0H8aZmInaPgDEheDkJ3Yx/wgBeJjbER9yejkJkQP5i0M+oKg7pL2epobhYIClOJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630327; c=relaxed/simple;
	bh=4jQ+EIyiQVXkIlbc6gRNRqq+XDNXLeO4UR1HNWzVZhQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XujsPtvsG/VqqQ0hzcny+y4vJkOGYavqmD0nLIY6xqZ6/UgadXjYZMu6BNlPMA5CS6/ioywG0ZiX6gepLKhvExIikBiFEypL9n2tKX4TrAluxGu6y3Y+sYjLWDfsF2dJY47RlGo8IOoDCEJ9kc1Gl3OW5rtXHfA11Kt97hUtlHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qecl9sbA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b48d8deaef9so177652466b.2
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630323; x=1761235123; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZIFtHvs7F/q+BdnxOwwAZugPQcTpk+W4nyCeOYTpMg=;
        b=Qecl9sbAF7PEhnB4tbgezfl0cYLkccGIhHhzUERCkFfP0gSCIhadvI10qcpJUTYTS0
         d4XjWv5ZgzxObokPn0mELPzzknYsiCvUGti5AWq8wwSMXJAkF2IiC848q/8yVRNsiFip
         3QiRpPAGmfE7DO/E1+MNDFEoAQ1tjPIucrL3NHsOFppHDdkDuhcX45x88JUIFbNwD6/Y
         CT1IpZZ5FD7z30eewDE+zBg7ZmVRK2ctaN6VOTjYQmShJcai8+yJp1Zs4242/NwYXc5E
         654UK6FNL2dRiPUR9IDUEuu/FyV0cOl7FRjRcW05KoN78MmZK6QrsX55IQu/YlCbo9F5
         nEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630323; x=1761235123;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZIFtHvs7F/q+BdnxOwwAZugPQcTpk+W4nyCeOYTpMg=;
        b=Q7faPs1ZASrKXNHQor9RMFoOKN34Ldc9sYk92PW+/ZQ85o5IxbTdIZXXeulMVT8gEq
         oyggAGBhkoMzbEJlaCrv55NUg6YkjV57EWccanVEPWrHf1bZR6s4ohMUeeewYoA98W+b
         32Di6feJTSR04cEV5geNegcHx8ZrgAIcVtYHAnPyjLOnk875Wc3OjDDeVYTsX5PdZ8jj
         199bCeftKt9VYLmvi3vBg59uSo1Nio8sG10FlEv/sfd8a9ZBRxaiMHMHsDPf1bVkDLoP
         rNsTWonl1/Tqj4Gd+CCMh2l9MQI+Wxu3U50TLlzMoEvdE/3o4jZJE+JOTXjQvGm4oto+
         KTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtavjgSSIbsimYUIAMZDBouV4KUOTu7WZScT5mWolbWUq3mxWdIQyKMe5Il4OxUfXYG1b78KY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8FVtdqvCT0d+EiVtHgC9D142ZTa742I8ucxNmPvu6HKZYvEtc
	X3YozjpMQ5PuA8GaqwghJGehnlLJFo47Fuzj+Wrp9S6Ko2RKvWNFC+FfrbtMOwauFEM=
X-Gm-Gg: ASbGncuKrFcNtWM0AyszFmE6GwbSTS9T+4ooT0y+q1Qc5q6Mcb0fYIhBbiAvBBGuCiL
	lD+UWANqVx3kODn+ulsWzr4n5oWp0gHR2jlS7ApWDx1EhgZgsGApsbjdslH1kTREG/BpRLTD2uL
	g4eAqPR6zP0HIeNJrtHkdA5ipUx8MnAofOfb1dmNV6ssIn0lflbpMBDf2MkZtpAXzHbdl2di+g1
	jtF8t3jaYMVbsM6fzVT9ofzi6/53VJvzA14bg4ormcCyKpPatuVCXeDecMPm0mVgZl3skpkI+gB
	qi6K+exsCUwfsHfMhAY6gelClqXz85SFHGveIb85CbCoE1IDxDZrAUqc72XFC0cb4U6QSbnMP2t
	ZkbMonMNllzRgg2Rbux/5Avflgkgwkts8Ore+ht6qtxpBS4lGf5zxuIRxTg0s6A4kw+oFbBV7Vo
	RVvRebwNW0igmpzBApDnsKmRDR/KuCMEMs6blPWKKJldaLfGs+bs/lBoAP/s1jg+LtjnrJIb4=
X-Google-Smtp-Source: AGHT+IG4HRaUmyVAr/Y8mfqN8pN0d3XueS9onISZHfbE+N4+RTdShVGlTthizBkJnoAWjpKCiPeqBQ==
X-Received: by 2002:a17:906:f589:b0:b04:61aa:6adc with SMTP id a640c23a62f3a-b647195b6c9mr48758066b.7.1760630323195;
        Thu, 16 Oct 2025 08:58:43 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:42 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v3 00/10] pmdomain: samsung: add supoort for Google GS101
Date: Thu, 16 Oct 2025 16:58:33 +0100
Message-Id: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACkW8WgC/1WMzQrCMBAGX6Xs2cgmja315HuIhzR/XZCmJBKU0
 nc3LYj1sjDLNzNDspFsgks1Q7SZEoWxQH2oQA9q9JaRKQwCxYkjcuYTL3cyzEiju9a0qM4Syny
 K1tFrS93uhQdKzxDfWznz9fuNNL9I5gyZQ92jRm5V218fNKoYjiF6WCtZ7M1uZ4pi1k6qxvRCu
 br7M5dl+QCIJ7682wAAAA==
X-Change-ID: 20251001-gs101-pd-d4dc97d70a84
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

Hi,

This series adds support for the power domains on Google GS101. It's
fairly similar to SoCs already supported by this driver, except that
register acces does not work via plain ioremap() / readl() / writel().
Instead, the regmap created by the PMU driver must be used (which uses
Arm SMCC calls under the hood).

The DT update to add the new required properties on gs101 will be
posted separately.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v3:
- use additionalProperties, not unevaluatedProperties in patch 2
- fix path in $id in patch 2 (Rob)
- drop comment around 'select' in patch 2 (Rob)
- collect tags
- Link to v2: https://lore.kernel.org/r/20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org

Changes in v2:
- Krzysztof:
  - move google,gs101-pmu binding into separate file
  - mark devm_kstrdup_const() patch as fix
  - use bool for need_early_sync_state
  - merge patches 8 and 10 from v1 series into one patch
- collect tags
- Link to v1: https://lore.kernel.org/r/20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org

---
André Draszik (10):
      dt-bindings: power: samsung: add google,gs101-pd
      dt-bindings: soc: samsung: exynos-pmu: move gs101-pmu into separate binding
      dt-bindings: soc: samsung: gs101-pmu: allow power domains as children
      pmdomain: samsung: plug potential memleak during probe
      pmdomain: samsung: convert to using regmap
      pmdomain: samsung: convert to regmap_read_poll_timeout()
      pmdomain: samsung: don't hardcode offset for registers to 0 and 4
      pmdomain: samsung: selectively handle enforced sync_state
      pmdomain: samsung: add support for google,gs101-pd
      pmdomain: samsung: use dev_err() instead of pr_err()

 .../devicetree/bindings/power/pd-samsung.yaml      |   1 +
 .../bindings/soc/google/google,gs101-pmu.yaml      | 106 +++++++++++++++++
 .../bindings/soc/samsung/exynos-pmu.yaml           |  20 ----
 MAINTAINERS                                        |   1 +
 drivers/pmdomain/samsung/exynos-pm-domains.c       | 126 +++++++++++++++------
 5 files changed, 200 insertions(+), 54 deletions(-)
---
base-commit: 58e817956925fdc12c61f1cb86915b82ae1603c1
change-id: 20251001-gs101-pd-d4dc97d70a84

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


