Return-Path: <stable+bounces-87560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5076D9A69A9
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0C8283FF2
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77941F80AE;
	Mon, 21 Oct 2024 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L25bhQM7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2111FB3DD
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515791; cv=none; b=D7ufaT1299pM4TEV0HH64P7T8RSoA7C1PsBi5YwMRLr+PBDn1J7YQRaKwy1eqKZQ3R7/UpWq+/vHfHwspPn148c3AXZjF1FIZOdZ0l43yGfUt7pl6fKeKwIgJqdZjQIAJsCTE17a4jQ39MzZ1WTOAwCj4WNfNcb1Ii2ra28CoFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515791; c=relaxed/simple;
	bh=ysvqgWEP+B8HQQLopH/WTZRhsWUsWfr9HPvn8xo27F0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mdwaxYTL/lbeSerU3JIDiBUMpQI2dxv8gTC/zap6AZ9iOSdQw95peMal/kNACqUtiHQn7uGiRPb+NCpehiZgfTGIOJNgWyceb3+Xz1Es8E41PTg4CPDzEIqs2hkGJDj1VNs+ysKquVWnH0JmAfGzVjGHvwZIEw4MWE8ax6xbV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L25bhQM7; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso41658711fa.3
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 06:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729515787; x=1730120587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPZW3o9O8KMd2l9bsdly639M9ayrVvVJPmPDhVzCI64=;
        b=L25bhQM7xmtjwVGj07CRKdbxoJEDpddc35A7tg45OZ+G3yaG9bAsBpO+uCDOJXWH90
         VHrExnkZUnQdTgFtR6yvwot4tRG0frocFD/cF7gBK8erkOO6KKeS+R/MTLf34LIXeD6z
         oDyRbEdr3uqJP7BbQXZPm7reEM5b3GDV//R9F8ilL4/RZ1HI3KziiVxk24/rxeAilWI/
         1l2F4AlLtjh+zBG5Kj518XjSEAfg5/4ZNRiSVtPe+Oo73BiB8UHkgEDQxneja6C2gQ+D
         GKpSxxD6gRfF9f8S3gD3p3QdangdxJSvqHKTv+0pP1un5KNIcHNt6mwYMMn9iWEmDox9
         IYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515787; x=1730120587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPZW3o9O8KMd2l9bsdly639M9ayrVvVJPmPDhVzCI64=;
        b=CgNZ72EuhgfmgtbiUIYKzHuwlWGfEMSJdlzbuZZorJ+hFhXWoDPLkxgjs3NG8e16ai
         khlmg/7yqFJtYitHYrHSAXrSQeWLWzOXRiPC1Na9vfU6kaQ8kggBqLFmAybCpfDGASn1
         D/Yjr1NRIREsyypPrMGYlQ8xCj2T1rQyulRaMB5twXYL6gxnvQvmpAriDlQHtGorCJpI
         NJqv8iG9I/Lia4ZxCP2jbhV5x6GcMxBimpuOLxNJf0vIE9HiGHl3WrWQuCu+pT4zlDgO
         ZrFdgsU2b4MmciGS5Myv9yKwHxPHQCJBRh2JkuKkprzFw5cr3+MF0LDGDCJEhZuVDEA7
         wWSg==
X-Forwarded-Encrypted: i=1; AJvYcCVULBqa6ZAX37QjcL6NmWFBiKsuYIpXRncKmKRF20TU4GtImBcPYaw9K2axbrf535XcgWwQwRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3UlKqX7yriJQOGgBd8B7br7cc7qJmgTTwTjU/SZ5FtFzVmma+
	E0NR7w0GDTpqP2/tf9zd63DleA5oKSt11s8k8VmlaBc2r1paiZ9rias+HY+a/ZM=
X-Google-Smtp-Source: AGHT+IE4bNxBuZiSo/LWHqIIi8XGiP3WfZqN2gNbTogSdqcLj7y34HS7yjaWiYcbIZDL3xkyYyjdIw==
X-Received: by 2002:a2e:e0a:0:b0:2fa:cdac:8723 with SMTP id 38308e7fff4ca-2fb83208b7cmr38383041fa.29.1729515787337;
        Mon, 21 Oct 2024 06:03:07 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ae24d51sm4808351fa.130.2024.10.21.06.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:03:06 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 Oct 2024 15:03:00 +0200
Subject: [PATCH v4 3/3] mm: Pair atomic_set_release() with _read_acquire()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-arm-kasan-vmalloc-crash-v4-3-837d1294344f@linaro.org>
References: <20241021-arm-kasan-vmalloc-crash-v4-0-837d1294344f@linaro.org>
In-Reply-To: <20241021-arm-kasan-vmalloc-crash-v4-0-837d1294344f@linaro.org>
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>, Melon Liu <melon1335@163.com>, 
 Kees Cook <kees@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Ard Biesheuvel <ardb@kernel.org>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.0

The code for syncing vmalloc memory PGD pointers is using
atomic_read() in pair with atomic_set_release() but the
proper pairing is atomic_read_acquire() paired with
atomic_set_release().

This is done to clearly instruct the compiler to not
reorder the memcpy() or similar calls inside the section
so that we do not observe changes to init_mm. memcpy()
calls should be identified by the compiler as having
unpredictable side effects, but let's try to be on the
safe side.

Cc: stable@vger.kernel.org
Fixes: d31e23aff011 ("ARM: mm: make vmalloc_seq handling SMP safe")
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mm/ioremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ff555823cceb..89f1c97f3079 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -141,7 +141,7 @@ void __check_vmalloc_seq(struct mm_struct *mm)
 	int seq;
 
 	do {
-		seq = atomic_read(&init_mm.context.vmalloc_seq);
+		seq = atomic_read_acquire(&init_mm.context.vmalloc_seq);
 		memcpy_pgd(mm, VMALLOC_START, VMALLOC_END);
 		if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
 			unsigned long start =

-- 
2.46.2


