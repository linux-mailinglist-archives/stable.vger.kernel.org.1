Return-Path: <stable+bounces-89133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220569B3DE9
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 23:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E56282B1E
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 22:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9D41D88D7;
	Mon, 28 Oct 2024 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CTFUC60K"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FAF1DE3D2
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155204; cv=none; b=kCev3bSj2ISPUKpPCs4tXwC7U6Wmi/Z3dP+8hQnI2G4PvAlkX4aSf/PRQxJxw+4VyxCSlT1uM/MdCBd2L1dm0P4vUiaE52XjBhxo3UKuf31YhEKd4tysaML5IDsaAeFLCbQ4WAgSf+cG8JoZlq7n02sQCO8xavME2YB2nZ6r0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155204; c=relaxed/simple;
	bh=r4qhLAR0mFL9DLTElWYipOIkEnIgzbNhJaYFeciUgZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sVdCGwrKuinBLr00QdIKhWc4kAuhtkeyg62XjTnZffh0ftVH+J8fFofnKUC8GwpA7Ktc3qNzjiMJRdhmePVbAs7wPLFJCzi0bEn9QxsFeVrLgHLdKvSNm/avPKpgkUdvvGoGmvYSWKPtely239xo6Q8jdiKBZ9uSIIdEiwTFfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CTFUC60K; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso64715861fa.2
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 15:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730155200; x=1730760000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4FvxagpzjxZSStnbXoR4/Vp7sTpyCwQgUO0IG3vegk=;
        b=CTFUC60Kieq8mcY8UeNAzJdOKGKpmLyCVt8gQ2pW574TUoA8A4b/qMNfjBqXkxkCkQ
         qzF6XuA0Qm+5VmA1tIZtKE1bRIX8aeHlTm7/w51SHR0v+z653DBx1gGY3JTVug1kMll+
         OHRZett+cd7fCeWrl4zxRCeFl2PTlS7/GdhAY5m9lUt2wk7lKk7xoDK0LveQSK1YisPM
         4/5EXzXsKHPN0NxR6fHujKnRtFDQvEDE5VJg9E+v6KemhSZdTvRoyYPQpfm2OtO97NeB
         xMH2MdkwsTfaPKcGnQzkOETAWQ1LcCsC4BCM98O2FHcUALrAK/UOalHJ78Qkx4aZaKhI
         5oBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730155200; x=1730760000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4FvxagpzjxZSStnbXoR4/Vp7sTpyCwQgUO0IG3vegk=;
        b=lQL+rdrAbOoPUdfMvS1dHhB/xGL1kXu5NNyn3ozu3gHGoS8Afro0MBMHDzmaGxE5uM
         jOxNC2BebKnPMyTVOiOwKsc1V9pMGaZ9VudLRT65mbQmUTpb9e9UGfK5F7amif4tyrrt
         erGjq5+XPVpugaEFJH4qKC4KZR4+fF/G/GnmQKSPGUvlAOjULYy7GwOBXfHFPUewWOO5
         Szt5ni2iJp4c4HcFmauhE6xCdxLT8UY8j+wIX5egWG/tg14SERAEn/43pbzw174HR3aK
         9qATwLCSM87662jopUb4epRF2Vvp8gEJ3gX67YtZ0Wzs7UMQGShsZ33KBEPQmdtAUUBN
         mLcA==
X-Forwarded-Encrypted: i=1; AJvYcCUiB657JBpS46PCN55R0ZhquLlrbQNNQp+XfHIIJAFoSuKhkrYBFm4D1DzH4c8RrY2p5UPFCTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbhgJe8GCc2AP4kpAFxq5hCq8k+LT8f01WTqdin87ouHDd488
	goN9xwH6RD38NbnmqihqLU5APLG4Jmp2pfSwajO/pDk5DZ4auiNEg92zGu8NGGo=
X-Google-Smtp-Source: AGHT+IEqkiyR2pvRELICkbistcdpZC3pulGLc6gT6MbaAKcOnjYY7LJUVhv1Cjw5G5zRZ1aSLbUo9A==
X-Received: by 2002:a2e:4609:0:b0:2fc:9674:60b5 with SMTP id 38308e7fff4ca-2fcbdfc9295mr56280631fa.25.1730155200002;
        Mon, 28 Oct 2024 15:40:00 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb451caa2sm12648561fa.36.2024.10.28.15.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 15:39:59 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 23:39:58 +0100
Subject: [PATCH 1/2] ARM: entry: Do a dummy read from VMAP shadow
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-comments-in-switch-to-v1-1-7280d09671a8@linaro.org>
References: <20241028-comments-in-switch-to-v1-0-7280d09671a8@linaro.org>
In-Reply-To: <20241028-comments-in-switch-to-v1-0-7280d09671a8@linaro.org>
To: Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org, 
 Clement LE GOFFIC <clement.legoffic@foss.st.com>
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


