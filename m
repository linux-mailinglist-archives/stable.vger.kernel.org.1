Return-Path: <stable+bounces-86389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E10F99FA44
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 23:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD8F1C23A6B
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 21:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20E62076B7;
	Tue, 15 Oct 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="we4oFP2G"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F05204033
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028255; cv=none; b=UqG+pSVCfq/7AH2iklke6rmIIN6p8Ijxg1Se3K+p8yqCHOQG+A3hWpxXrOEqUOWTm1/QWo+GHTSejcaCIGlkJ+xMY5raFSIEHvU+4T3gOMWxiYlfUWktr9nnrp/tROxNmuoLHKAuRpGk/saeQWRFuCkbUJ2+PmRC/u/pWvrepoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028255; c=relaxed/simple;
	bh=PpyjePQaryGFs/0P4Zc2W5MJ3kh4HE2vDOXLbZepvDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pBjQ6jMlKcql0FpcnCfDiDWtSaLhRO+aptZGRPn4BYrlLEAm/tONvio6eh+9mH6t4rDCHOCEua3crCN4JP4lVZ12U+DEQRIp/IsHheqPfxU5JH8SRk6aXQ7cLzbYQoP/AFSMFsTBoojU1pgSXoIW5xbJopBRNkygjzAVU2Mfr1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=we4oFP2G; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso3446039e87.2
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729028251; x=1729633051; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2pXRgO8fhNg4XGW5m2nJjv5HrSsOwaVBlg5djifbog=;
        b=we4oFP2GDSpMgD1+vzQ9Gh5OOOj5fs1eJngkbGH48AZLSfmiimIYXGtYv4oGeWtIwn
         7n7ezMlnNZoGoO4c2CQwd91cJZQ1WQ4i+GAAfDatIyr3bsGmd4rgCx0uBUdQlvAT40sk
         LQubrX8rrpDeOr3fv7m0B0axmJltyRe1PRyMyBoMDGaYgDQidhCEuwlUvF7IRGKgygZy
         vDy0ka1ZKkOdI8k7MmzPKXXmRFonnl4Ynwr6rKi3dFnetRfNV2TiwxLW/Qmjxqiu9OdG
         tuaLJKayjoSx98PpwvoUXJenMp4nGCXufi5yLEJcVp+bIk84npaAD7jK0IYZPIPXpmQT
         eUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729028251; x=1729633051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2pXRgO8fhNg4XGW5m2nJjv5HrSsOwaVBlg5djifbog=;
        b=ZLOiaM7hlgDcfOxBjWxJ7f49k5huw5XEeSOPi3MuGLE8UtThyqQKmesvE1WyGrUYFs
         KEw0M4bbC/iAsiLAnLLkyI9ice/OhwZYe00G1Wi9RD2rTnXnysm7+32Y33tljwm4lDta
         WM9NyA3W6Mx8tpxHUwfwuDFH4XIOjawkZrgXzPNKMq48OWAYKhet1g95Xl/zO5mJD7fi
         PDc2Ch0FjuF6Rr/x8G03/5xQLjxwI/HoeS/BwpeivnszrZIt9YzaRMIHJr13ZU9MYmxp
         jFvDQEntN97YFOQfuRJSCuH4oeCoVdvi13zHzEfCMrU/2ZIqUpDZS4ASfETxfZJnJgHv
         kqgw==
X-Forwarded-Encrypted: i=1; AJvYcCV3HEwS2tA6ZNPV5l5E4PFyxWDTcwFKdBZHDTMtEbDZgEwFoeO1V3nvfyxVfOeMBFyY/a09EUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr16SNENDJHaJgbrlYL6GNMd9fz9i/Ry0Gk8cOJdgySOySfnQY
	dTsMIqo6fgwNbeMclklWKRByrs3HqWuQ4juCxctvSmTJPJcANW+RGQTeKFCl1kQ=
X-Google-Smtp-Source: AGHT+IEWIT/h1YDLyXIK/uWAg+XHk5SwWVG2mIHyvZZnZ6PuVu/Ke0dGl4gM0oL/AKlYmONEWEBKVg==
X-Received: by 2002:a05:6512:3402:b0:536:a68e:86f0 with SMTP id 2adb3069b0e04-539e55142c8mr5922358e87.27.1729028251515;
        Tue, 15 Oct 2024 14:37:31 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539ffff39a7sm258959e87.164.2024.10.15.14.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 14:37:31 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 23:37:14 +0200
Subject: [PATCH 1/2] ARM: ioremap: Flush PGDs for VMALLOC shadow
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-arm-kasan-vmalloc-crash-v1-1-dbb23592ca83@linaro.org>
References: <20241015-arm-kasan-vmalloc-crash-v1-0-dbb23592ca83@linaro.org>
In-Reply-To: <20241015-arm-kasan-vmalloc-crash-v1-0-dbb23592ca83@linaro.org>
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>, Kees Cook <kees@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Ard Biesheuvel <ardb@kernel.org>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.0

When sync:ing the VMALLOC area to other CPUs, make sure to also
sync the KASAN shadow memory for the VMALLOC area, so that we
don't get stale entries for the shadow memory in the top level PGD.

Cc: stable@vger.kernel.org
Fixes: 565cbaad83d8 ("ARM: 9202/1: kasan: support CONFIG_KASAN_VMALLOC")
Link: https://lore.kernel.org/linux-arm-kernel/a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com/
Reported-by: Clement LE GOFFIC <clement.legoffic@foss.st.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mm/ioremap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 794cfea9f9d4..449f1f04814c 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -23,6 +23,7 @@
  */
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/kasan.h>
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/io.h>
@@ -125,6 +126,12 @@ void __check_vmalloc_seq(struct mm_struct *mm)
 		       pgd_offset_k(VMALLOC_START),
 		       sizeof(pgd_t) * (pgd_index(VMALLOC_END) -
 					pgd_index(VMALLOC_START)));
+		if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
+			memcpy(pgd_offset(mm, (unsigned long)kasan_mem_to_shadow((void *)VMALLOC_START)),
+			       pgd_offset_k((unsigned long)kasan_mem_to_shadow((void *)VMALLOC_START)),
+			       sizeof(pgd_t) * (pgd_index((unsigned long)kasan_mem_to_shadow((void *)VMALLOC_END)) -
+						pgd_index((unsigned long)kasan_mem_to_shadow((void *)VMALLOC_START))));
+		}
 		/*
 		 * Use a store-release so that other CPUs that observe the
 		 * counter's new value are guaranteed to see the results of the

-- 
2.46.2


