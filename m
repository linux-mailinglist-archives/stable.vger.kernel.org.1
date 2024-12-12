Return-Path: <stable+bounces-100849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A38629EE11B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EA918859BF
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECE920DD62;
	Thu, 12 Dec 2024 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0/04cR4F"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498420C485
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991544; cv=none; b=eSuiR7AHDFIj0W7mZeAOoADgmYdYpcrncGOVG7w+EuSZbdv9Ebt81zImT6ySiQ8qDWk2rBsModhPG6UICcHmrzZQgKLlCLzFAfPvJ0CgTbbDWmHbiloQ0XZmy7pLBZ2/d/6r+s1bjui3IeS819pGns1nZl36gAGjaAOLvkurCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991544; c=relaxed/simple;
	bh=9+QLuCvgFOP32pIRaIn85zZ8715Ha5/MHwje3j6rLlU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d0FJfXZZhr5ClzLvsdio/kpWOwxlt0vESH8tgtYuC4XoUWm0jCkAx4hMSs1Bub0COHiJqVKK9/bt+TIsg1FP76pkLbPFDRAfV75tkCFbeaxfniGBHVCRDkT4Af+iMHkCOqoBvu8PXFTVe00Khz8bIMD3U6hZInOK201tE+FPlNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0/04cR4F; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4361efc9d1fso2866755e9.2
        for <stable@vger.kernel.org>; Thu, 12 Dec 2024 00:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733991539; x=1734596339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o1eR/nZYWDy7JnUFA+IXxK3QIAKZs/ki75z6WryhmEE=;
        b=0/04cR4FF3/0GE2XiQKT42rlJgw6nwb608HzWPNaonG2GU5GOcUFXI/dnq29dJJJi2
         oCTtp+cr0AIPf8RmnWx6C7wQIhALCna4K2KaL99YjSaAN3vxCa9DX5GqJybXNLvfqXGw
         Xc+0YTXsUp96KF3ZyBp55GldSNk9x5u98O7YOkS2kWLpvEungMmeELZ9J4SaQAlZN9O9
         YBmdKOltt1WJfE+TH+D6kTAprxbb6O+a7609rtLMNNAx3elotsizd27NUxThjX9BCqMT
         Yg1yg1yfUZC6U04R+E5yEkmHMrOFjspXCKaUcM2tiFdLCn6wMJzf5cYdx+zmIGUv8qlm
         E9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733991539; x=1734596339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1eR/nZYWDy7JnUFA+IXxK3QIAKZs/ki75z6WryhmEE=;
        b=qwKMWtyKiea+7FwKD8DwVVaP173kQRhND8qqCpbE4Vipd2PkuBrWhok+WXZKvDecaS
         yVBYceXoyfBfFUi+7X83WsF5bfFUeMFpinVWrIvg+wCv4w0pfwHd6brjFrtlISNggj8e
         hxlG6LWZiWgwDIlxA8i87wb/9kHRyALfyhVfJaoXrPA+hV1AG9zGLEk0Ta4TJgjmj+R6
         N43L4wvu2QCJKl3oAzH8J6Z73F9qYZELA93fkWp5fjdO8795F0sP/jWi4OYvMpJmCQUL
         DjKf0fe8AaeZPXqoC8Y0vjtQBK3V5lWHDn+j03Kq6a66Z8V4rFjIS7JkeUpFCrxXETcD
         aCsA==
X-Forwarded-Encrypted: i=1; AJvYcCX8rQ2YQHzTMuahechl+wo38uxSAhgwSiBoVPOz4yettKXa4XwXpSygd+890wrLhnchCRaMguM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65M0flHMXPiRbl8drEuRKyFi5wjuF9Sv+2yp3KV9qznV57isu
	4xH19wWNGj4hnrBNv8yfcpdn7v6JPkb5JhyfwRB+i4O8k2uATCbCcK1CbtSKuSeT+/b5Xw==
X-Google-Smtp-Source: AGHT+IGFCr+ILtDVl2I89l402u827GSiQNpyuMXKvIlTJVWCnPRqtE/rGoww4lT3RPPpvSl62IgYuB0T
X-Received: from wmbjl17.prod.google.com ([2002:a05:600c:6a91:b0:434:f1d0:7dc9])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3acf:b0:434:f8a0:9dd8
 with SMTP id 5b1f17b1804b1-4361c345006mr43908945e9.1.1733991539243; Thu, 12
 Dec 2024 00:18:59 -0800 (PST)
Date: Thu, 12 Dec 2024 09:18:43 +0100
In-Reply-To: <20241212081841.2168124-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212081841.2168124-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3310; i=ardb@kernel.org;
 h=from:subject; bh=6f63k+zdnDPwoV97pZOXKmLYrRvOc+ffRW8gf6CiYQc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT1qTrKo0a3oN1wHTtdf0f30szBTp23N+v4dx//IP2pct
 76saO2UjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjAR0Q+MDPfPvVh+Tmqatu21
 lEWKL1c0BX40+O93iFvmyIV32WHP6nkZGeYtYw8WiPs7dbfhv+4oo5aJWVEfv7yODYy2tFBMnl5 RwgsA
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212081841.2168124-9-ardb+git@google.com>
Subject: [PATCH v3 1/6] arm64/mm: Reduce PA space to 48 bits when LPA2 is not enabled
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kees Cook <keescook@chromium.org>, 
	Quentin Perret <qperret@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Currently, LPA2 kernel support implies support for up to 52 bits of
physical addressing, and this is reflected in global definitions such as
PHYS_MASK_SHIFT and MAX_PHYSMEM_BITS.

This is potentially problematic, given that LPA2 hardware support is
modeled as a CPU feature which can be overridden, and with LPA2 hardware
support turned off, attempting to map physical regions with address bits
[51:48] set (which may exist on LPA2 capable systems booting with
arm64.nolva) will result in corrupted mappings with a truncated output
address and bogus shareability attributes.

This means that the accepted physical address range in the mapping
routines should be at most 48 bits wide when LPA2 support is configured
but not enabled at runtime.

Fixes: 352b0395b505 ("arm64: Enable 52-bit virtual addressing for 4k and 16k granule configs")
Cc: <stable@vger.kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 6 ------
 arch/arm64/include/asm/pgtable-prot.h  | 7 +++++++
 arch/arm64/include/asm/sparsemem.h     | 5 ++++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index c78a988cca93..a9136cc551cc 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -222,12 +222,6 @@
  */
 #define S1_TABLE_AP		(_AT(pmdval_t, 3) << 61)
 
-/*
- * Highest possible physical address supported.
- */
-#define PHYS_MASK_SHIFT		(CONFIG_ARM64_PA_BITS)
-#define PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
-
 #define TTBR_CNP_BIT		(UL(1) << 0)
 
 /*
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 9f9cf13bbd95..a95f1f77bb39 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -81,6 +81,7 @@ extern unsigned long prot_ns_shared;
 #define lpa2_is_enabled()	false
 #define PTE_MAYBE_SHARED	PTE_SHARED
 #define PMD_MAYBE_SHARED	PMD_SECT_S
+#define PHYS_MASK_SHIFT		(CONFIG_ARM64_PA_BITS)
 #else
 static inline bool __pure lpa2_is_enabled(void)
 {
@@ -89,8 +90,14 @@ static inline bool __pure lpa2_is_enabled(void)
 
 #define PTE_MAYBE_SHARED	(lpa2_is_enabled() ? 0 : PTE_SHARED)
 #define PMD_MAYBE_SHARED	(lpa2_is_enabled() ? 0 : PMD_SECT_S)
+#define PHYS_MASK_SHIFT		(lpa2_is_enabled() ? CONFIG_ARM64_PA_BITS : 48)
 #endif
 
+/*
+ * Highest possible physical address supported.
+ */
+#define PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
+
 /*
  * If we have userspace only BTI we don't want to mark kernel pages
  * guarded even if the system does support BTI.
diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 8a8acc220371..84783efdc9d1 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -5,7 +5,10 @@
 #ifndef __ASM_SPARSEMEM_H
 #define __ASM_SPARSEMEM_H
 
-#define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
+#include <asm/pgtable-prot.h>
+
+#define MAX_PHYSMEM_BITS		PHYS_MASK_SHIFT
+#define MAX_POSSIBLE_PHYSMEM_BITS	(52)
 
 /*
  * Section size must be at least 512MB for 64K base
-- 
2.47.1.613.gc27f4b7a9f-goog


