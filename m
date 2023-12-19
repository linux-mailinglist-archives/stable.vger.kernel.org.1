Return-Path: <stable+bounces-7882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DE18183D8
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 09:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FDF1F2521A
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 08:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2134F134B2;
	Tue, 19 Dec 2023 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLqzZXj0"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A813AFA
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-58dd3528497so3068434eaf.3
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 00:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702975694; x=1703580494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/3GxElqX/Cixd4cbTNKhd4RfEv//iGjawD/TDRhGPnI=;
        b=pLqzZXj00VEfD+QwhPq9GpBEDv9+ZWoSHnnEfV8YncGX9mKBz6WNM20NmILSs6F0zq
         5zc02b/94WW4l0XYvqYg4wQv3AlW+lECgEIuqvondlKrKJbbNhXUWCnGJyV7Z312HbMO
         cdbApKky2Q+vH68t7gIJzJuQeoZ/C8Y/nkNZe/HSKqHrhoorQeAWPDmWD697jETXzU8Q
         3uU9GwDryVz+J9O+UDABcBUqBLS86k9zgc+KtS+hAVWmXmDc/1FlLYTAIyARKqyszyL+
         9ud9KQhK6wQnGBbLamVy4U0FCXIlj2oLMmOGwceI3fxpYJ73MEy8Ffg3p9Dd09uzUSoi
         +1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975694; x=1703580494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3GxElqX/Cixd4cbTNKhd4RfEv//iGjawD/TDRhGPnI=;
        b=nBMIZHKG+h7zKK1JwyjVQqitWb1Eu/hHR0WVq9IpaEVp/IOVtEL11Ef/bEFPqQJlOY
         vQ1Od86vEyvk8awYqSfQygKzhOD1b168IDfewJhQxOvX2H5zolIlVtfE3V3DdsUv/V2A
         56XUYnKP1axpywhF1giSSOt42Wmt2N7fUzr9ZAYKAkGPzCLd+27ELntfIA8gQPYPFTX7
         gdacChddONtG9BeSgT75O1fNIelKlknSpEA8oA88TH48CyZ+jf6+1H3nwZK0yLAcTssG
         aIxIHbh3fujp7EHmG1g6s2+4iKBanMcDOE4VSwVAilUkFvOqeqJ8lv7QMFPblyGSNFmc
         JhtQ==
X-Gm-Message-State: AOJu0YxYiY8X4RMXfyk3J/Y9KVj+SwHHsCZi0WEQApDo3S1l9pnYyy6H
	raGjhZtApq5BrjKQkKZDsVOE8A==
X-Google-Smtp-Source: AGHT+IEJU2OwhJn3eEe/C0mQLl+hvUz+Zp2JbOZiWaSI5/lkluVutVjxjxh3fh/iQWJfgoJohb9JqA==
X-Received: by 2002:a05:6358:a084:b0:172:e3f6:12c0 with SMTP id u4-20020a056358a08400b00172e3f612c0mr1839599rwn.46.1702975693738;
        Tue, 19 Dec 2023 00:48:13 -0800 (PST)
Received: from x-wing.lan ([2406:7400:50:3c7b:46:38b7:91ad:fb4a])
        by smtp.gmail.com with ESMTPSA id t188-20020a625fc5000000b006d93789402bsm721891pfb.69.2023.12.19.00.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:48:13 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Stable <stable@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Haibo Li <haibo.li@mediatek.com>,
	Kees Cook <keescook@chromium.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH for-5.15.y+] kasan: disable kasan_non_canonical_hook() for HW tags
Date: Tue, 19 Dec 2023 14:18:07 +0530
Message-Id: <20231219084807.963746-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 17c17567fe510857b18fe01b7a88027600e76ac6 ]

On arm64, building with CONFIG_KASAN_HW_TAGS now causes a compile-time
error:

mm/kasan/report.c: In function 'kasan_non_canonical_hook':
mm/kasan/report.c:637:20: error: 'KASAN_SHADOW_OFFSET' undeclared (first use in this function)
  637 |         if (addr < KASAN_SHADOW_OFFSET)
      |                    ^~~~~~~~~~~~~~~~~~~
mm/kasan/report.c:637:20: note: each undeclared identifier is reported only once for each function it appears in
mm/kasan/report.c:640:77: error: expected expression before ';' token
  640 |         orig_addr = (addr - KASAN_SHADOW_OFFSET) << KASAN_SHADOW_SCALE_SHIFT;

This was caused by removing the dependency on CONFIG_KASAN_INLINE that
used to prevent this from happening. Use the more specific dependency
on KASAN_SW_TAGS || KASAN_GENERIC to only ignore the function for hwasan
mode.

Link: https://lkml.kernel.org/r/20231016200925.984439-1-arnd@kernel.org
Fixes: 12ec6a919b0f ("kasan: print the original fault addr when access invalid shadow")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Haibo Li <haibo.li@mediatek.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
Needed on v6.1.y as well.

 include/linux/kasan.h | 6 +++---
 mm/kasan/report.c     | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 00cbe31c8748..056ca8e563aa 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -471,10 +471,10 @@ static inline void kasan_free_shadow(const struct vm_struct *vm) {}
 
 #endif /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN_VMALLOC */
 
-#ifdef CONFIG_KASAN
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 void kasan_non_canonical_hook(unsigned long addr);
-#else /* CONFIG_KASAN */
+#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 static inline void kasan_non_canonical_hook(unsigned long addr) { }
-#endif /* CONFIG_KASAN */
+#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
 #endif /* LINUX_KASAN_H */
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 1c929d964dde..8786cdfeaa91 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -457,8 +457,9 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	return ret;
 }
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 /*
- * With CONFIG_KASAN, accesses to bogus pointers (outside the high
+ * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
  * canonical half of the address space) cause out-of-bounds shadow memory reads
  * before the actual access. For addresses in the low canonical half of the
  * address space, as well as most non-canonical addresses, that out-of-bounds
@@ -494,3 +495,4 @@ void kasan_non_canonical_hook(unsigned long addr)
 	pr_alert("KASAN: %s in range [0x%016lx-0x%016lx]\n", bug_type,
 		 orig_addr, orig_addr + KASAN_GRANULE_SIZE - 1);
 }
+#endif
-- 
2.25.1


