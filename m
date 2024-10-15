Return-Path: <stable+bounces-86390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2182C99FA4D
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 23:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17461F215D9
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 21:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3588A2076C5;
	Tue, 15 Oct 2024 21:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YG/9LhJ0"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E584F2076BC
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028258; cv=none; b=Ds8g1vqjTUpGWFzOaDfAXxw3ttht4Qgsa+11bH0TXjr5lZyxLeekTsUDy/uppeckur5wXGaQ19eOfoSPxcqOJ9iV4F36pK+ypITIquh8zcL/niE8H0ol541PRf2mtPHxMa4z4dQ3evprSXkCiXn8Qh2MXpyhPsr5jB9W82roDEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028258; c=relaxed/simple;
	bh=33CG8bu5E88SzdMxcEVRK2ZTUlgcDbQx0byj//J2/jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3lG2VVQCdmOW1sODCrkCLmz4RB1VTKjL4/ndESxNqJH78IvLIwcmPEOk3bW9yz74Q1j/jKMzK6zj2t8eoq6FhBqLtAsc1CzczjlhsumYW+I8F4apZ3aaWIfCksEs7JrxSzB/YhUJsh5xqMB5zWu6BwGwhlBYC27KWbKF8OvOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YG/9LhJ0; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb443746b8so23956071fa.0
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 14:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729028254; x=1729633054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TASGgpeqvDoWRp9bCNSBz84rkKz0n7oKXi0ntrW73xw=;
        b=YG/9LhJ05fVGJLgqII875HG0lg8RYPHBT1QfCP0bfs2aJTZXfwMou9AVsv6ZM4FgVD
         W+0qF858H1rd8OreUgxcxKjvOOZWXmKVvfCs/IeLQw1gTh438pt6q9UyQYvtyLS+bhV6
         Wv0OBCjuPFX0vSWkmk3RjHVb/T9vHGdw3VsSwwoXQMPXFFjbtd+PhWRagXJy+pel0ial
         up0r3HCePYw4B10ppfJxGxo45a0AxvdGGNY3AKha0A61DLsqlbgczFi9D1AabZh2xtm/
         JB+9wZzJ0v2TVWhv5HVwVEuj12tIV8GbU/Ze9vFIwT/IaCD8aEU/+spOmXasM2TrSnwD
         P4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729028254; x=1729633054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TASGgpeqvDoWRp9bCNSBz84rkKz0n7oKXi0ntrW73xw=;
        b=UpPrr04WSB9Kgp8jHbatc1ESajaW8ck329QpmI05//1+5rFXzbsh+wbkj/Ja+vYoEq
         rNg5Ify62uRmxs9y6uMsOCL4z+s9RSgj4z0bbL0I43zEAfw8Fz+GxvHE4EyTJHZ7fGSd
         QisWMzNTFHmSL1pt8GzTO1kz607WF4bBd5eToqZN+79ndwemapa6NTXBMUcnSIZFUqUe
         8fhV+oZQ4IPJPNWPvwvyXpwUJjFcXSfTNyfhliVRKCAzLMiArY4BVYrrezkRmCTQdudB
         pf8BpeSi5vUF+o4a0o0aiZFVPpb+dk6eLUCtWXhxF2EUotI1bRLW/qoZd1UTQifheeNp
         3muA==
X-Forwarded-Encrypted: i=1; AJvYcCW3jBkCwPB2xpXMYx/gvIYGemLCG1XpPkWZmUReidttxOnFrYwIfLWSMsH8bcZTPdHXCuIgxes=@vger.kernel.org
X-Gm-Message-State: AOJu0YweW/19wEGSfiDMLce9BX+vs6hsGnrZJrSmRA/N3Rv2jdGYtxvn
	Jzv92FMR5ujN2PXcdlzeeaqxi3GzM+TuP198bzDdl+rBiPgnjQLUBfhEitfAqQI=
X-Google-Smtp-Source: AGHT+IF341ab+sZLcMDbnxZTwN4quvfyU4PR7oSIdCyM9Ps18PkqToqxvjilXFBFRaDjIYv2qHNpnw==
X-Received: by 2002:a05:6512:3e14:b0:539:f26f:d280 with SMTP id 2adb3069b0e04-53a03f0bdc9mr1252333e87.5.1729028253987;
        Tue, 15 Oct 2024 14:37:33 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539ffff39a7sm258959e87.164.2024.10.15.14.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 14:37:31 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Oct 2024 23:37:15 +0200
Subject: [PATCH 2/2] ARM: entry: Do a dummy read from VMAP shadow
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-arm-kasan-vmalloc-crash-v1-2-dbb23592ca83@linaro.org>
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
index 1dfae1af8e31..12a4040a04ff 100644
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
+	add	r2, ip, lsr #KASAN_SHADOW_SCALE_SHIFT
+	ldr	r2, [r2]
+#endif
 #endif
 
 	@ When CONFIG_THREAD_INFO_IN_TASK=n, the update of SP itself is what

-- 
2.46.2


