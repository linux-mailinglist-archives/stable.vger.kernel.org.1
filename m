Return-Path: <stable+bounces-124182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2617FA5E6E4
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 23:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2573F3BBA4E
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 21:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1B31EFFB2;
	Wed, 12 Mar 2025 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HC5qg4Kz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626FD1EFFAC
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816774; cv=none; b=fJ/M7PjZI2Cb8RvjIwT9g1l/GDUSyN3ua0alXOKA5lK/loCS8Uv42wx85AEqqo8n/Nhb2Iv1jmGum7JTny2pgKAZnk8eMKtj5n5PKuqOcvFYq3hS2oPj3MxZaAsmroIcmxPTOmYrM7gmyOZ1e0gPPv5zsesClPi4o28PSFJbCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816774; c=relaxed/simple;
	bh=l0UozGtl+Y+uEkNpfTzqCasIsn47QmX6u7sMKC5KqlE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L7t4VuZ44g/zVdUlWWgLS2pCNnhWDWeaOTIFeadaqkXyu3pa4g5gaPc8feaUlLWUtA7mQmmHoOqeumRcMYZLdtab5goiMEpN+sC7tZF9InO/S9qmsYT71Z8+kM4ja0KwpOmYE/Xr5wZEro/c5Chh09B2WQRroKLeDjglMb4S93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HC5qg4Kz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso1766095e9.0
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 14:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741816768; x=1742421568; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Wfs7R8D9QwSoSk4j4eeFcrD9eVi/Rvc6fZx70N29Eo=;
        b=HC5qg4KzWjJRgsXRJb0NGhEQh83K5kUydG0PL1b0oZCj6dVQltlsuSoSoyDjwg6Vnx
         Bq4TZ0PkjdAV/Qy/CqWkVcYKf+9XpYWtmDbWvY9DnMexOtOoW17YrFGsZCWFK3bMnWCh
         k6VLyzf76jieoDBTG0Rd2VnYoLBAIh6ArUMR9uM6zD2ckIm4+9BZifWFjkDU+uxmC8Bh
         8MSPo5l5zuJEJzqTCW9T14G7qNfxI/xoYUmTcxlNCn+hHoea/xLBFwEOxhrLv5ym1qLO
         OhPrGxfhLiO7/gv6mYC33LuIYS+0DfPIiNtfXD+WVHL2nGqYgOejXynfLEYZ8rb1LpOY
         0LAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741816768; x=1742421568;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Wfs7R8D9QwSoSk4j4eeFcrD9eVi/Rvc6fZx70N29Eo=;
        b=QTItx9uBQ7d30gszFjlhVgx63N6PBcy65FGSinYPJg/kbsIbZIpcDnsmS4ApQrF0Ij
         W9p825jB1I0JROhDlXXuV76XQ47yN0ZtuA9/LebYf4sqO6mnLGYiTLI/lW6KLwcforsw
         XaoMjU2qFbZeESlnpBufXX/JG79hehkaV0ygl29ZheZ8ASnxOJ4iyv3dl1m2MOLYGg58
         Y/qTl00TwSn1ZEdw98dX3Ac5dP4Zm/v873E70WBssRP5n2Ei030ueW35w8b+/pOOegbj
         doTWCm7koVJhKr2SwYCFZbB405+XBir+iK/LbpDhFImfQk2wG2zGxrWDKzy70BNceHy+
         eDLA==
X-Forwarded-Encrypted: i=1; AJvYcCX+TeUV0fFwBc6+khhTSGDAA7F+TtNr0oAShxdW82irIIhMoc9F4FFR8x86FRqQp5BsVKJ8iCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa6HLSQUwVfG2JoJqJGfBJCMR36Ma2cRraiLHy5Az6tmo1VVbV
	NungS7UP1gee+NbRjL0tEPw3mK0+KIuni8Kr/sPwOvs0pBlc/HlKuQ+mciWfP0Y=
X-Gm-Gg: ASbGncun3ibwOElIkUQsW1UsKpZTBHHpdNrrajIzFi/senZvtERJp8TPoinnufqLUyt
	YSEImeYnWxW/uQFkrSxngaDh4CnsSZ3Z1nzH1V7R2X/ZD5e90qU+bls1xaByT6ai5+SeNNlmhqX
	7P/7iq6vpop63TeBbfIV1VEzR6QBe2EWdpxR9mZxk5aDAy51JJ3mhhXVhPZF3xMXV7lXezNDh7G
	+rnTyMWsAJrukp1udcQ2zxQFriveZcIhPlQ4FUqso79RpJSww+oB+fgnIKleqyuL/Nd/xzARS6a
	CEIP18Z7HbAVuyUSQsC0/MBhZxKri5njX1L7awPs59o9fr8XBrhzgY7+mLnU/wdPor5CqRLyzf7
	U
X-Google-Smtp-Source: AGHT+IHAdfL/zWlkbA6vqBpxrWhT3/HDlChD0NizAlv3E0v+/+eyD0+OyUlagna7bf9tFfu5RFzWbQ==
X-Received: by 2002:a05:600c:45c9:b0:43d:abd:ad0e with SMTP id 5b1f17b1804b1-43d0abdafa4mr32832175e9.18.1741816768649;
        Wed, 12 Mar 2025 14:59:28 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([209.198.129.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d188bb34asm110175e9.18.2025.03.12.14.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:59:27 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v5 0/5] samsung: pinctrl: Add support for
 eint_fltcon_offset and filter selection on gs101
Date: Wed, 12 Mar 2025 21:58:57 +0000
Message-Id: <20250312-pinctrl-fltcon-suspend-v5-0-d98d5b271242@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKED0mcC/4XNQWrDMBCF4asErasizYytOKvco2Qh2aNEYCQjO
 aYh+O5VsmlKMF3+D+abuyicAxdx2N1F5iWUkGKN5mMn+ouNZ5ZhqC1AQaM0KDmF2M95lH6c+xR
 luZaJ4yABEa1G09NAoh5PmX34fsJfp9qXUOaUb88/i36s/5KLlkqyMZ1SDuy+oeMYos3pM+Wze
 JgL/Dqo9KYD1bGG2XfOEaF7c/DVaTcdrI7vrCPvWwvEbw69OmbToerAYEzDtG8Vtn+cdV1/AMv
 6PyCVAQAA
X-Change-ID: 20250120-pinctrl-fltcon-suspend-2333a137c4d4
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 andre.draszik@linaro.org, tudor.ambarus@linaro.org, willmcvicker@google.com, 
 semen.protsenko@linaro.org, kernel-team@android.com, 
 jaewon02.kim@samsung.com, Peter Griffin <peter.griffin@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3740;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=l0UozGtl+Y+uEkNpfTzqCasIsn47QmX6u7sMKC5KqlE=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBn0gO8OgG6r0K8vQpb5SkN9jCJ09+opexOXK13y
 eXGSmxgaZ6JAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ9IDvAAKCRDO6LjWAjRy
 utxED/9ySKmxy2469Mykx3Pzb3Ich58sN6sTBJEkGOFk7oaPe5s8v8klrqp+3KiLDqwx1/JJLwC
 rCUcoVPd+CWHs/EcP9EF0cOp9BD0mImqZyJesQISJM/fibQj8DulO7IRikwfuErffh4jswvIdXS
 ql5Wx9KlIXuwlbErExZlrY7slNsQeqoQMGt8Jozq4rTqWyxMJgjVSXFsuwS0f/fgyN/pim3sIxj
 Flazsv5hdVkILIEZKrsXcidYxhrKBY5+56oSPLTVnQDkHxekyG6tEEsXO6ca/fL6zvDTnLnHwig
 j7YeqvnQcc5AqWuj1LVAXfRO3PXNilBP2e2ACz2QaNQBMtAF9GGIzLfAMBMN1QIA/fQQ5OJa1Id
 Bf+PWlZDesDmog81g6xNslh0Cu3jiZyxH28wvyTBDZnq6G++ToO+q2rKbmeSudeDZr+XCFFeJgw
 5lMG+sHDot+gnBLGKmwCe22xYt+LpvL3tuS0JT5g6qSkRm/x+TCx3M5N0vY68BsDu9alCrueW5+
 zeg12YtJECaAYeBK1n3ZbhcbAPk+qTCrrSYmKVoPWxdnb6kQrSB7yakij27BZyefSsJZEzugui7
 Ne2DOjLnV2pclrnUyV6scx31wur2M37sNP0pAvHhQZXsLImbw8NlvrIELMAL0FamSybTTCoLFSA
 CzX23yLN1tqVtmw==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Hi folks,

This series fixes support for correctly saving and restoring fltcon0
and fltcon1 registers on gs101 for non-alive banks where the fltcon
register offset is not at a fixed offset (unlike previous SoCs).
This is done by adding a eint_fltcon_offset and providing GS101
specific pin macros that take an additional parameter (similar to
how exynosautov920 handles it's eint_con_offset).

Additionally the SoC specific suspend and resume callbacks are
re-factored so that each SoC variant has it's own callback containing
the peculiarities for that SoC.

Finally support for filter selection on alive banks is added, this is
currently only enabled for gs101. The code path can be excercised using
`echo mem > /sys/power/state`

regards,

Peter

To: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: Alim Akhtar <alim.akhtar@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: andre.draszik@linaro.org
Cc: tudor.ambarus@linaro.org
Cc: willmcvicker@google.com
Cc: semen.protsenko@linaro.org
Cc: kernel-team@android.com
Cc: jaewon02.kim@samsung.com

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes in v5:
- Split drvdata suspend & resume callbacks into a dedicated patch (Krzysztof)
- Add comment about stable dependency (Krzysztof)
- Add back in {} braces (Krzysztof)
- Link to v4: https://lore.kernel.org/r/20250307-pinctrl-fltcon-suspend-v4-0-2d775e486036@linaro.org

Changes in v4:
- save->eint_fltcon1 is an argument to pr_debug(), not readl() change alignment accordingly (Andre)
- Link to v3: https://lore.kernel.org/r/20250306-pinctrl-fltcon-suspend-v3-0-f9ab4ff6a24e@linaro.org

Changes in v3:
- Ensure EXYNOS_FLTCON_DIGITAL bit is cleared (Andre)
- Make it obvious that exynos_eint_set_filter() is conditional on bank type (Andre)
- Make it obvious exynos_set_wakeup() is conditional on bank type (Andre)
- Align style where the '+' is placed first (Andre)
- Remove unnecessary braces (Andre)
- Link to v2: https://lore.kernel.org/r/20250301-pinctrl-fltcon-suspend-v2-0-a7eef9bb443b@linaro.org

Changes in v2:
- Remove eint_flt_selectable bool as it can be deduced from EINT_TYPE_WKUP (Peter)
- Move filter config register comment to header file (Andre)
- Rename EXYNOS_FLTCON_DELAY to EXYNOS_FLTCON_ANALOG (Andre)
- Remove misleading old comment (Andre)
- Refactor exynos_eint_update_flt_reg() into a loop (Andre)
- Split refactor of suspend/resume callbacks & gs101 parts into separate patches (Andre)
- Link to v1: https://lore.kernel.org/r/20250120-pinctrl-fltcon-suspend-v1-0-e77900b2a854@linaro.org

---
Peter Griffin (5):
      pinctrl: samsung: add support for eint_fltcon_offset
      pinctrl: samsung: refactor drvdata suspend & resume callbacks
      pinctrl: samsung: add dedicated SoC eint suspend/resume callbacks
      pinctrl: samsung: add gs101 specific eint suspend/resume callbacks
      pinctrl: samsung: Add filter selection support for alive bank on gs101

 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 150 ++++++-------
 drivers/pinctrl/samsung/pinctrl-exynos.c       | 294 +++++++++++++++----------
 drivers/pinctrl/samsung/pinctrl-exynos.h       |  50 ++++-
 drivers/pinctrl/samsung/pinctrl-samsung.c      |  12 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h      |  12 +-
 5 files changed, 319 insertions(+), 199 deletions(-)
---
base-commit: 0761652a3b3b607787aebc386d412b1d0ae8008c
change-id: 20250120-pinctrl-fltcon-suspend-2333a137c4d4

Best regards,
-- 
Peter Griffin <peter.griffin@linaro.org>


