Return-Path: <stable+bounces-87559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D19B9A69A8
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEE0283B67
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 13:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1B61F4285;
	Mon, 21 Oct 2024 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xNLymNph"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A4F1F7094
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515788; cv=none; b=hgKTsS9+pxJOzbSDhA1/Ry3cMFt1j/10+yiRtwf0g9cASOqGxhHLPatb9raAaYuMLYyR460irnBq7xjhY74YumqoPAx0z/hSRuiRDQGhNUUwVS3ulEpHArBn5q8m3Sic5T9t5+wDbolTH5CYtN51j+ldEpbVtZYKXK5r9RS2dRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515788; c=relaxed/simple;
	bh=r4qhLAR0mFL9DLTElWYipOIkEnIgzbNhJaYFeciUgZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MBu3D2XLRBjY11Fc8VaQRhdIYt3LqMRUJq2SNILMc9HPUZgpjnLPofktjDsg43cVbIszslJNMGEQiXxIn+QINM7yeFS6Dmq03umNrfkU+ZC4a43th4EZ9w6X5bBFcdaRClzealpcLWJNAL+SG/mHldDex4JSdjZ4Wy4vDKHGvt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xNLymNph; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5111747cso49407711fa.2
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 06:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729515784; x=1730120584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4FvxagpzjxZSStnbXoR4/Vp7sTpyCwQgUO0IG3vegk=;
        b=xNLymNphnu7HXGeLU4/WRkklZBAYDOU2sGGcFlcSY2WTffdsJtTZlDsWze/ycIIeF9
         NHMvF7WL87p70KnVWBLOtkcpYa/MkK7XCh2EhecvdmaafvIAnCC13SKNVKORI8K1Rm/b
         cbxjQDylRH5hBrr5MvIgfPMwpZxsEiZhiRLZMI0jC3tEBega/6aOasC9Eoc2oWxh33Kd
         0xYzNZ5B1SKDTNPu3Et0/lBfnCQKeu+PsgOW/rXCT6MCCbIvqXBu+QQlJ04jzK1eL58J
         BmD8VTme5nmw44KbBYKknRpzsH6JP5L8VDMuv25Yavsbk6ZABfZ826ueMJ1shKEO7lLu
         6Bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515784; x=1730120584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4FvxagpzjxZSStnbXoR4/Vp7sTpyCwQgUO0IG3vegk=;
        b=M181QDLqU8lQPPeUsp7A+ehRCl17fGhdvRV3foJCbLPYchmRmlpn8aTs/qbBYTYPhp
         1hbiGOlNx2sBRD1/AAc0W7pJqH84zgp9eBEGxw+KxIWy+f4t5G5dCwhHrsVvWpdxLefO
         VkFgzq0JEf/7WWfd4uvnYucAcOgnoEmQx3ic85wIgcmX0eXjQQE72rkXsd3pOrfq9CWU
         H3P7118j7JVI6lxJ4pEa7+9Ts6bmTM3yo58JBPtiJuaQKT74qtOgoIyrUJ1r16X8yrGm
         QRdh037vBE2qnguZD3mxcDZo/UKsOukuUiZUkcfk1rVqtawJ78LwXQO1BkQnQP6xpRGm
         QzYg==
X-Forwarded-Encrypted: i=1; AJvYcCWQiohjK2J4OE4knjgheUYD17BcWGLVIr8UbzbnTJrT98MLvbW+woQMWvFH9hc2z3bmszH9uxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWN2aH1yxsF9s+UXW6WP6q5tav7s4LfgmZguJ/DfjhRDWhUnOK
	BV5CPAHx40ZTTOrva698uFa1d4pqZnSYh/ksWwwIYW71TD25RdHxiUJEcGu8y0g=
X-Google-Smtp-Source: AGHT+IFl2tqDkCWdClLbm+iio4vewFwLEcLXVPL3QhXNtJlFjMyJiepzyeePilHFMrPomCUvBO3Mgw==
X-Received: by 2002:a2e:a585:0:b0:2fb:5014:f093 with SMTP id 38308e7fff4ca-2fb83226829mr47866501fa.44.1729515784392;
        Mon, 21 Oct 2024 06:03:04 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ae24d51sm4808351fa.130.2024.10.21.06.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:03:03 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 21 Oct 2024 15:02:59 +0200
Subject: [PATCH v4 2/3] ARM: entry: Do a dummy read from VMAP shadow
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-arm-kasan-vmalloc-crash-v4-2-837d1294344f@linaro.org>
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


