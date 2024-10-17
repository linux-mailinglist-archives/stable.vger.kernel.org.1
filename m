Return-Path: <stable+bounces-86612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1B79A22DD
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 14:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B323287B37
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 12:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7091DDA10;
	Thu, 17 Oct 2024 12:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iewbsBix"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22441DDA15
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169954; cv=none; b=lvmg+7v0vmWVIaqjmxaOj4Mrc2js/Mu8Q0ixrzcHhjxDQ6qMyo8miQUhja2by+oDEut1ljjTriStEc/yJUut1/4ER5pNMU53AeCmwhH8Tl6ROA461mYDn3TRqr7HYPxQz0kRcsJeLLOt7ww1aYMGZkgOpBzgsBvT+jwwQtXbm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169954; c=relaxed/simple;
	bh=xfvycD5OTjuXS2sJBpDVuDQyFPLo3+qx5/UgtbvrSLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lz87vXpc6gYzs6ncCr90drjl9WwKbwSCh7HHesBGbd/sV/kJ5ltRjHAKSFMSC7wF2q+elw3qjIQgDTnMcGx9p9Vn1jvxTO2I5p1nfNyGloKomcr4rtXow2b09qD8gB3rS6Oc7b+lkov4fVtOQcNoB7xFdG/b+pip/iIVqDWwo2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iewbsBix; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fb49c64aso1315587e87.0
        for <stable@vger.kernel.org>; Thu, 17 Oct 2024 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729169949; x=1729774749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BFCDJ7qVhDMxaXJRJGY9SIIhLehUaVssxlnvsh+LOk=;
        b=iewbsBixx88sAqLuIavtO+KBotgEqLthm2cJwwelVpWGH2aC96FmViWwkJlYdVKk4N
         +Ptrd9qolqndcvzYXbEEbegBgRvBK9GwkFj3blwZlcNYsyRoqwbKnSBVdjqHVZba2xTT
         FuUMIimuHxHhHyOb28YxBDwS84/m/az5M1HZVA5gSmimIvm5tbkmCcaoKRdyvE+AY7m4
         TxoqT0d5HKA8MNoLnHIrJZ5fK406UCxlp7p15/rkSo0SGRDsTJU/yHI+CTtX/oyyILSN
         kj8+yWVxa/LSlkGrFiSzD6yOzC92zyIv3vlmhfm3Q4h7Tcq3rxjBHYs5bp5XOu5lJpeA
         r/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729169949; x=1729774749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BFCDJ7qVhDMxaXJRJGY9SIIhLehUaVssxlnvsh+LOk=;
        b=TyYAGT2D/QSmNlEMzgwBadY6toqSUemg1hu5LJDHwqPWhLaZaOkLnVriQiNMKbwBPL
         2Asd2aeSq4eYgGH2VikuwklqtDhbctGI2tqUYgNd+QZ58lg2upem6+IgoUdvQw8NH5OV
         DObrWlsyXpJnka+iOsJSBq6ufyZNwIG7yGvVV8Z/muestdZXZViHikhOrAtoe6dDHD6A
         ko+nNVEsjz9ryZ8qBGnZfLh8E4cJSQ/c4nb55Rsl2/ecCdqLEZBHc8bgH7mUgeLbkpmL
         0VnutRCEsec7jLACSYwZoq/FqCj+M1KwlFMQMlKpLiZhTlD70h4nlpM1kbAdL6T7xSbu
         OIyw==
X-Forwarded-Encrypted: i=1; AJvYcCW6sixMEfMyRnSY1WLEEpvbhVG2GoehzTWhQ9g9zOB3BJFyBixkOqa65rluGlFhm85Z6THof9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR7EnxjpnXI1wujjw1E5cTJVk57eUTcrlD7OkBE5uOPBHtOGkV
	VVL5mNkl/lgMOA6wXFXd++1FPyAD2tGiyemG0InuURIW759CPo0tdCQU5wNGApg=
X-Google-Smtp-Source: AGHT+IF0wuz7DTtzD28aNSx7raxRcYA1A8KJuM3dHXxpuquyQIHiAKRrTmrvQ2MEJoBWVhM3GQONJw==
X-Received: by 2002:ac2:4e07:0:b0:539:9767:903d with SMTP id 2adb3069b0e04-539e572fbdcmr10356406e87.60.1729169948899;
        Thu, 17 Oct 2024 05:59:08 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00013c21sm763349e87.270.2024.10.17.05.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:59:08 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 17 Oct 2024 14:59:05 +0200
Subject: [PATCH v3 1/2] ARM: ioremap: Sync PGDs for VMALLOC shadow
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-arm-kasan-vmalloc-crash-v3-1-d2a34cd5b663@linaro.org>
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
Acked-by: Mark Rutland <mark.rutland@arm.com>
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


