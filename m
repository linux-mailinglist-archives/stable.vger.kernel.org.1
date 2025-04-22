Return-Path: <stable+bounces-135159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995BCA97331
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 18:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D653A44047B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FD929617F;
	Tue, 22 Apr 2025 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="1G+LzJE+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E782949EF
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745341149; cv=none; b=EPl9U4ce1AxEHgF0Hsxo7VmP8gULXtwlqYvY/9nBF0NlwlD4mS9IrW0pW651NGyQxsKlOmBZtEfM1eBiW3H7fjq7a9q+Jt9fsDsolgduhIjjP46KQ+0jzIvAFPe9Zal2oB8FvZqNnZENRESma2AlyAKKLdUl8PgzJFOFnIr7I2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745341149; c=relaxed/simple;
	bh=tuwxbP9RN9SP3A+9vhjvf7PCeO/qOtZtQ684UIJPITA=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=WjNX977fvKP7yRaMNn63PGZBIQA8ySJJI1TsI01rza2nEHUl6z8MDiqea/SDFlCC+kPGaLsKHlLl8+HR+ERsE+6EFTY5T/5op6J1Xk5m7nCOUjsi1q7Vuk7zix7gZS8U0hGXaL8Vhqwrczn1eSQOV5rT/ICn3io0t9bGXphr5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=1G+LzJE+; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6feab7c5f96so46901017b3.3
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745341144; x=1745945944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZzUSI4mEMyGt6SkByBpGIIwklkgKtnxtAe1nq9VEyI=;
        b=1G+LzJE+z+iNvgCVQy67hWki/+khKsU/wm4YZcoP6N1TMw7flBoByRR0jq9ASjLvYx
         EADKAw6fDxIP2FUTm4l2e2sggcPw5UJd4yE7j/gf0CEtyJOViTsJEki1grM+kZNoqHjR
         GEeM95zamNGSg2bkSUh/kPkyABpSRYtw3fMgOIiYCauq33Btj1svaBo7M2i+YIBvuwC2
         3C/FREpSxD9qTitxhYI0H1iq2PoA+2+FzTfF3N8+cVXFAw0NGwAgRxDf4g6HG6OPbDjx
         C6WmUhXSiPLqcG/d2I+Bp+jSnMYmuLMrFResn/wBOPXh3XvudA3Nre2BAUgwR1pQqSSv
         oopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745341144; x=1745945944;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZzUSI4mEMyGt6SkByBpGIIwklkgKtnxtAe1nq9VEyI=;
        b=Sz2sJX8RXnjTYGx27GpT4MQ1XyrIZdsVwPKaVTGdlydoesv9DZvJB5TH/Bw/kOvKne
         DLDRumLpFRHlFc0sUyPP7vLdhxCOIkLSUfo5q3GfBguDWqjsqD9CW8uuQXKwWRFPl7m1
         wOmM5gzSILMTPFDPVwW054q6mefbVNJXkIc7zryETSoiIh8RZWIfIwWZOMWFEcTA7nIT
         q0Xw8UQP6zxi8aG5wELNITEEwziua46RNLUYs1ZGocjZx4ILdIQUCzvbVdIWCqJWsJuy
         gUOTAxahE9N961p58FQ84/U7JuRcJ12bOARLVFN4AFQndS11V32PzQS4GG1mCwtAMbbQ
         WcPw==
X-Forwarded-Encrypted: i=1; AJvYcCUogwMvb8PCaNh9UHN6Gm3uQZtO0VleAzQuDxONVfzfs8kIjyRRIJjLqzavuQ4CXgBq5ZKon5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzASjzxrJNe4ZJdion6qPxbIbBkl7Wdxm4U9zgqGbc4pzak2NHG
	+R+svDLm9eSyVZnTIQswYiIuXzyvNPrGfL2PL6A2hYXAUX/Uwwe47/ijoG+l1xWx/MPLEGPnO09
	7sjAbYvDkyD44Sh0lv7NFEtzx7PWYuLbF+mkOOA==
X-Gm-Gg: ASbGncu3cRnWDklbnv1+O9yJbKySZ/seUZvAlonBXgnQbzJTgl/Kx+sVm106yPLNSQn
	rAQnTKQH3T4mZc3BNWJrbLQmjuRh2uNMdw7Y/TZFk8QHI7MvXpmlzuKZMEKtJ6KApYPNrQvjR2v
	y2frJIqlBmNn9WsE3BwYcf
X-Google-Smtp-Source: AGHT+IGvBZkWlxyxotZ/vX4PM7jd1gSy94awqLY1nUj2IQ//D2aA77ksC39w09uCTD3jqKLxLIZefT9A4ilD6m9yejY=
X-Received: by 2002:a05:690c:4d06:b0:706:b3c1:3d00 with SMTP id
 00721157ae682-706cce12192mr258876677b3.37.1745341144344; Tue, 22 Apr 2025
 09:59:04 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Apr 2025 09:59:03 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Apr 2025 09:59:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 22 Apr 2025 09:59:03 -0700
X-Gm-Features: ATxdqUHedel756eMCBcuh7hIDTVttFnjA828CEaDrzoSyyZXRq5wCqZrhyQdc5A
Message-ID: <CACo-S-1nuLDeBy6UEnTQKyjJz6Yv=hgiw4m+mmSNd5jS9HeLzw@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) use of undeclared
 identifier 'SDHCI_CLOCK_BASE_SHIFT' in drivers/m...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 use of undeclared identifier 'SDHCI_CLOCK_BASE_SHIFT' in
drivers/mmc/host/sdhci-brcmstb.o (drivers/mmc/host/sdhci-brcmstb.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:1bbba9215f3aa3d5c2158789a2b0557774ea7ac1
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  09fe25955000ce514339e542e9a99a4159a45021


Log excerpt:
=====================================================
drivers/mmc/host/sdhci-brcmstb.c:358:37: error: use of undeclared
identifier 'SDHCI_CLOCK_BASE_SHIFT'
  358 |         host->caps |= (actual_clock_mhz << SDHCI_CLOCK_BASE_SHIFT);
      |                                            ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig on (arm64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:6807ad7343948caad94dced6

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:6807ad6f43948caad94dced3

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:6807ad7643948caad94dced9


#kernelci issue maestro:1bbba9215f3aa3d5c2158789a2b0557774ea7ac1

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

