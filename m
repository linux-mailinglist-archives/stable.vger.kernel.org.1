Return-Path: <stable+bounces-86537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3356D9A1259
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 21:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0153283BEE
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 19:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F30B20E00F;
	Wed, 16 Oct 2024 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuEc84Dd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E811711
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106131; cv=none; b=AoIrCZrWOwUqKAJWcMPOzAyDwDJpJzTj6qEz/2plKeXOg3scddrpSzjZLrmOCmxuHis+vfUxC2ETT+ifOm8M1VLwwacYs7hIgodr2jUJFgcsGNGzaVi6X3nb3BQG8DAd39ue6l0CLjiBwMYYp6/1MoTmePm4plCzNid0RS+/S9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106131; c=relaxed/simple;
	bh=JZMlUGylPkGtGkqukapF0RLvKOd8UZG/J8BH86A6nB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XoDZpkVIdc858sLiW1WZfBs1d4W7ahJYhzYODVcqCrAdt1Wgp2tfXaKlkCMHk5NBIBcnTLrUeNrZZAWlI3kk/DPWZZBYdrvzjQ4dXqC+RHrqqCQMD5DQPJ2YKVbUXl/LrICLyCaLTnmAIwlRjIQDUCCqAc7FaOeHxYd0XHnRK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DuEc84Dd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e63c8678so204552e87.0
        for <stable@vger.kernel.org>; Wed, 16 Oct 2024 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729106128; x=1729710928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2a7utj1us/9lnZXTawuuUKU0Cbi3LZiJV4V0TC6iOUc=;
        b=DuEc84DdVHEJTIejUIEBNZr8zyVCTyX3yIxJIgtwMbO2Lh8JjlKF/a+/Beu7lYa8gl
         JGPodMmLnObjkjaF6TPkVp/gosDfq8RSl6m+saHwBrq8EmkN08zzchzWaHUdveuPaf74
         exWQqgHCdMuQbvm8FTIjxIwlkrlJKU6AX5u/nFyimOE6k9S920L4aZteXhRQwK66RtQV
         dLrGmit/oLX2tIkZbg1ZfefUbwLRfqslwZsCxkQZEJgXqkkKOIKVQmXQzyaZpnNA35Kg
         rN8zuSTKQ36e1p8EI2R7rfKKougznATSUx/egIDetEQxxFnImjCeQqlahWFsq1yfODQH
         aSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106128; x=1729710928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2a7utj1us/9lnZXTawuuUKU0Cbi3LZiJV4V0TC6iOUc=;
        b=VIMW4uKWvurzphvI7yz8sbNqkZN1w/WJyznaKbKsAYc97fi0wB397Mji7Qfv5S6Jzh
         mnrgz7bkn1DMBSjGJvMeFW5MbtzVyHGlgBQ5dXxp57G+sQBAT4tVHvddPK7dn3r3Yqnj
         XRV+WSqtueKpXDHwLo0DOnFESrk4P1lsP76eLOLQ/Cq4E2N6sDe2zlmjnmPLXdtI+Al6
         qmv6PqAeCZGWAt4IoQ17fXBlLj5m03Dubd0ITBWAImy0OJucaoV1bURTWdaiu6kjzPeE
         FNhTBv7ti1HpBTPSZ9HJmOkipaJ+N0IFvgWL6fLKvD9IssoZG+/A/e6onYGFdS9WPXiR
         pD0g==
X-Forwarded-Encrypted: i=1; AJvYcCVP0Cj/qf2x04mcIJSLYoLKzIVhtsK3CPiPg7kuNIpep2BgZKgNpeElzlwEqoWG1iEUFzG6OQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdjpdH9u1QSItMxJXRfNLdtB5Zsgk60Hc1V3RyZ1M+g3CbK/w
	xTWI4JElK9wafHPre2yDnVKAB+NiKhRTk8gBTzr4LquI9uUoD9Fvz7xv13ntb4E=
X-Google-Smtp-Source: AGHT+IFAj8Ea2dpRo1IIuxxSfFFS234dRMcc3il1+NZTcaFoDWsZPFDJUgQLrSM/ke9sKJKEX3eFJg==
X-Received: by 2002:a05:6512:b85:b0:539:d428:fbd1 with SMTP id 2adb3069b0e04-539e5728fc9mr6738750e87.55.1729106128074;
        Wed, 16 Oct 2024 12:15:28 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00013cffsm531184e87.278.2024.10.16.12.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:15:27 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Oct 2024 21:15:21 +0200
Subject: [PATCH v2 1/2] ARM: ioremap: Sync PGDs for VMALLOC shadow
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-arm-kasan-vmalloc-crash-v2-1-0a52fd086eef@linaro.org>
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

When sync:ing the VMALLOC area to other CPUs, make sure to also
sync the KASAN shadow memory for the VMALLOC area, so that we
don't get stale entries for the shadow memory in the top level PGD.

Since we are now copying PGDs in two instances, create a helper
function named memcpy_pgd() to do the actual copying, and
create a helper to map the addresses of VMALLOC_START and
VMALLOC_END into the corresponding shadow memory.

Cc: stable@vger.kernel.org
Fixes: 565cbaad83d8 ("ARM: 9202/1: kasan: support CONFIG_KASAN_VMALLOC")
Link: https://lore.kernel.org/linux-arm-kernel/a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com/
Reported-by: Clement LE GOFFIC <clement.legoffic@foss.st.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mm/ioremap.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 794cfea9f9d4..94586015feed 100644
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
@@ -115,16 +116,32 @@ int ioremap_page(unsigned long virt, unsigned long phys,
 }
 EXPORT_SYMBOL(ioremap_page);
 
+static unsigned long arm_kasan_mem_to_shadow(unsigned long addr)
+{
+	return (unsigned long)kasan_mem_to_shadow((void *)addr);
+}
+
+static void memcpy_pgd(struct mm_struct *mm, unsigned long start,
+		       unsigned long end)
+{
+	memcpy(pgd_offset(mm, start), pgd_offset_k(start),
+	       sizeof(pgd_t) * (pgd_index(end) - pgd_index(start)));
+}
+
 void __check_vmalloc_seq(struct mm_struct *mm)
 {
 	int seq;
 
 	do {
 		seq = atomic_read(&init_mm.context.vmalloc_seq);
-		memcpy(pgd_offset(mm, VMALLOC_START),
-		       pgd_offset_k(VMALLOC_START),
-		       sizeof(pgd_t) * (pgd_index(VMALLOC_END) -
-					pgd_index(VMALLOC_START)));
+		memcpy_pgd(mm, VMALLOC_START, VMALLOC_END);
+		if (IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
+			unsigned long start =
+				arm_kasan_mem_to_shadow(VMALLOC_START);
+			unsigned long end =
+				arm_kasan_mem_to_shadow(VMALLOC_END);
+			memcpy_pgd(mm, start, end);
+		}
 		/*
 		 * Use a store-release so that other CPUs that observe the
 		 * counter's new value are guaranteed to see the results of the

-- 
2.46.2


