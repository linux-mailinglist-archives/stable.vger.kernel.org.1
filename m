Return-Path: <stable+bounces-86539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A20509A125D
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 21:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A90E1C219AE
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 19:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EFE2141C0;
	Wed, 16 Oct 2024 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="buEnxSVB"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5C111711
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106134; cv=none; b=ntkaIXGNsMqzqbnjkvk2hP9TTYdbdrXHTGK+FKp+D3iL3vd473pumPIOBT2W9IkvdFXBBWfk4Z9sVKL5YgacCgZWBfE1VElYKLXQHhPupzpEvoe3yc9WmCC1vFBJR2mAorLQrcDsf+pNJc9sCucTENB4SBWqFaW3qHNYmVQjho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106134; c=relaxed/simple;
	bh=33CG8bu5E88SzdMxcEVRK2ZTUlgcDbQx0byj//J2/jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zxdcc+RKt0EZ1e6SSehfhxD5rBhOegwqJfsZYD4795YVBCryGJXdkicY4r2RYSYGTHFlcB6V/IhZQjVwe607Aj+dgBOGbd/IFWQQoqpNLrSluhLc2J27mFfoTOgj5X+010OmWBTprCs0kTr9IXnAOfbTXTNNSfO8WBQh9cQBY3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=buEnxSVB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so215535e87.1
        for <stable@vger.kernel.org>; Wed, 16 Oct 2024 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729106130; x=1729710930; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TASGgpeqvDoWRp9bCNSBz84rkKz0n7oKXi0ntrW73xw=;
        b=buEnxSVBPgqmRt3GOkyqCOSP3IDhKhnuHhHGTe4arOkbiufehCjZt5PHREhlTbv2iG
         Bur+Hsi7OIUGb/8wdeeJU9+WlxWMSPbAEMS3w03g0vD85QVKiUP0DhA08cIMlcY/x4my
         1xkzXDbJKqPwYzAlvyd4EfMohnmPV1gqY82qlKKKjkTPNEmfF11kiGG3PJXYFTrp5+6B
         JhXnPJr5EMnuWLyYyMy/XZcD/Rfv9G1nL0r9ftATEuOz68cNDyatiLX4QWOMeovpmK+i
         ExWfhZZcqiAoS28zglPuOKJmBlsOx8W/d1kwvcJtnmddT3WgWD3iPSIZcvXt90ahZyt/
         bCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106130; x=1729710930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TASGgpeqvDoWRp9bCNSBz84rkKz0n7oKXi0ntrW73xw=;
        b=e7ka3FGcoj/9S9Rhj5Pbvz4Vo++FPU3KqGS11Msw2OzXlAgtTr8GWkDI8NybM7Pmf/
         D2eRyWw8pRQQ6mcpSxe6lI3zIKg03JLAhb+W4gIEDiiawR6oqPCsOVxE5MAw0AIn9tjz
         tFRYlIbNZ7E9wyWMC1mWhaV1OeRXTux0mp1fYZ8EZWwFAGjhfKdR87a+muFnv5ka/ZJI
         XzWvs+RBZ122qChmSKFxFVuKqNap7z6P4dVthb8EzuMZQf553umGhMLJr58GXxLTM4hm
         NLOhIsjzhKrErHqDoJD90hlYHIBsbMiz6RBhVG+3E9ybEn36rlxdTr3n/O6fCTsoxqS5
         jXWg==
X-Forwarded-Encrypted: i=1; AJvYcCVI/RGSFLHYhgA8Bb7KSOZ6BFG+tj2YgnakulAOZZ0n4qnPZFDG0XuvoeCfIaFJfCGOVUrx1Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR5RccpMCyRr8tpVsCEc6pMBy8RxzLd9+cGVe2ne4lASG77vce
	Jm1cspIJYHoYcbGgTGCpN10abmn2fag98bBIXq8hJrT/9dXE0ZkGdvRG3czlONU=
X-Google-Smtp-Source: AGHT+IHJIhURp5o49jHsNM2fP6AbvkviSOdVbGAki0cvkWbV9Y7hCwBSZOjEXY//vAhJFLxSwJVh/w==
X-Received: by 2002:a05:6512:3f2a:b0:539:96a1:e4cf with SMTP id 2adb3069b0e04-53a03f34f5emr3050137e87.32.1729106130458;
        Wed, 16 Oct 2024 12:15:30 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00013cffsm531184e87.278.2024.10.16.12.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:15:28 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Oct 2024 21:15:22 +0200
Subject: [PATCH v2 2/2] ARM: entry: Do a dummy read from VMAP shadow
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-arm-kasan-vmalloc-crash-v2-2-0a52fd086eef@linaro.org>
References: <20241016-arm-kasan-vmalloc-crash-v2-0-0a52fd086eef@linaro.org>
In-Reply-To: <20241016-arm-kasan-vmalloc-crash-v2-0-0a52fd086eef@linaro.org>
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


