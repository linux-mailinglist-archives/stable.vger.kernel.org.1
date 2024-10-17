Return-Path: <stable+bounces-86613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF6F9A22DE
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 14:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6EC287CA9
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9E51DDA15;
	Thu, 17 Oct 2024 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFXiNzpf"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAAC1DB346
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169956; cv=none; b=TP9zoTEyt0Aolkj90Z2LLaxCAbeX2VKgru10poG9ozl4PUwD/4epQbgtkHu7nVaFG/EuSugHaSuNE6PeyZQffiSUuPxXpJEkqBf4rW93VZQDv1+md7Ic44VpHg9kXZDsNwkjRJg/OvGjq9ivWoyUnuZ4ydo46WnXukoCt7F8lHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169956; c=relaxed/simple;
	bh=r4qhLAR0mFL9DLTElWYipOIkEnIgzbNhJaYFeciUgZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FGdLSzIMLwxUsf+9ZrCXxbdEkMZxkLnfPJuSAlwFHAxlJBM+mRZ40EwiOdP6SI0yuoqWVuzOkzhvfaX3N63XdN1zqifqopyFUhTwT7gBgPFFNLTRK7JIbDKr6A8s3jyAbnXt2SIeB1jRbR5nek7CcanhjJcYS5ps7e6/nbemdFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XFXiNzpf; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f7606199so1100555e87.0
        for <stable@vger.kernel.org>; Thu, 17 Oct 2024 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729169951; x=1729774751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4FvxagpzjxZSStnbXoR4/Vp7sTpyCwQgUO0IG3vegk=;
        b=XFXiNzpf+dEFNRDf3W1w+1AiP75srJr46Gbe05xi/WfeJXLRD7k8nlxt2Ck4uyul3F
         pELWROcNtwj0dR6lMtsd8j7xnThTK91aN7NVtiK9oWFxr+EKEVeK3muwRwmReGIbUwVj
         xxMTiwOBTci1mPXTRR4p0lE2JQ3XhbdICrldY5zrk1K/Y0595GfbwurcrO4xG8IMHwOR
         vC54rNyKdOSFnOTRjPy13zxz9kgcMg1NP9zodlGoswOHL/KZNznKsDYRGIlqLewC4OPK
         6N9uxO9MbbnmqGHGK+uiLVYqMmAzUpSNYya1vrlhxTPjYpsDgWrkJYnmAtBLOw8PcL4D
         n1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729169951; x=1729774751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4FvxagpzjxZSStnbXoR4/Vp7sTpyCwQgUO0IG3vegk=;
        b=C/Z7VPBH5s6Bu8pRIPzjha/I5Tg+GS7jkLdQ1KUiafYwpjSuRlKV9Ku8sZVD5PPBty
         Lh9nUbOXsVj8Chp9HyfkPXL+TRKX0Utq74C5LYPeiMV12CaeMyvfNJwWAn5VMb+ieDRH
         Ly++xb3eo9R9OExurt33UhNbH14TYAYJBA0MD8dpVWamzfY2D4m0h/vLDT1rOGnmKLL/
         4ZQ1huldh0hPaWLff0hZrT7s2B+mgdindm+y1uHa7WbTtbI8vNOs2nkhP0Zi9ZjH5mM3
         RrjUrqvZ/5BSwV5hSf4diRpUVzPRNNqD0kodpnEu+TPqqS59RFcvn4VTRxh9Zug7LM1Z
         idTA==
X-Forwarded-Encrypted: i=1; AJvYcCWXQ4hdW09UZU+KZGb31w48HcQWFmPuGcqsIaf4fx+qhg/vvTlvUQfVBWV5ryhjE3y6PuJXTPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXrOrdXOlinwWhE8YV1OarZl4NseeaZKNHknl0qMrFqa3xRwaw
	jL8XsfIXScyLqMbRu8QkuT435n+uwCFDqP+2uwH471WWmTGwdE+gQ1kC5fuGZBo=
X-Google-Smtp-Source: AGHT+IHksrS7dvOIDDGppfbJwtTEWzde9JRlEqQc3/BUDREnjrOEyYKmsLetBYGEXTlb5TlTBzfCXg==
X-Received: by 2002:a05:6512:31cb:b0:539:fbf7:38d1 with SMTP id 2adb3069b0e04-539fbf73b9emr7534245e87.2.1729169951111;
        Thu, 17 Oct 2024 05:59:11 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00013c21sm763349e87.270.2024.10.17.05.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:59:09 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 17 Oct 2024 14:59:06 +0200
Subject: [PATCH v3 2/2] ARM: entry: Do a dummy read from VMAP shadow
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-arm-kasan-vmalloc-crash-v3-2-d2a34cd5b663@linaro.org>
References: <20241017-arm-kasan-vmalloc-crash-v3-0-d2a34cd5b663@linaro.org>
In-Reply-To: <20241017-arm-kasan-vmalloc-crash-v3-0-d2a34cd5b663@linaro.org>
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

When switching task, in addition to a dummy read from the new
VMAP stack, also do a dummy read from the VMAP stack's
corresponding KASAN shadow memory to sync things up in
the new MM context.

Cc: stable@vger.kernel.org
Fixes: a1c510d0adc6 ("ARM: implement support for vmap'ed stacks")
Link: https://lore.kernel.org/linux-arm-kernel/a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com/
Reported-by: Clement LE GOFFIC <clement.legoffic@foss.st.com>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/entry-armv.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 1dfae1af8e31..ef6a657c8d13 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -25,6 +25,7 @@
 #include <asm/tls.h>
 #include <asm/system_info.h>
 #include <asm/uaccess-asm.h>
+#include <asm/kasan_def.h>
 
 #include "entry-header.S"
 #include <asm/probes.h>
@@ -561,6 +562,13 @@ ENTRY(__switch_to)
 	@ entries covering the vmalloc region.
 	@
 	ldr	r2, [ip]
+#ifdef CONFIG_KASAN_VMALLOC
+	@ Also dummy read from the KASAN shadow memory for the new stack if we
+	@ are using KASAN
+	mov_l	r2, KASAN_SHADOW_OFFSET
+	add	r2, r2, ip, lsr #KASAN_SHADOW_SCALE_SHIFT
+	ldr	r2, [r2]
+#endif
 #endif
 
 	@ When CONFIG_THREAD_INFO_IN_TASK=n, the update of SP itself is what

-- 
2.46.2


