Return-Path: <stable+bounces-98836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F97D9E5943
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 16:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7B52855A5
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD82721C9F7;
	Thu,  5 Dec 2024 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQ6Xgwjq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006C218AC2
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411002; cv=none; b=ISzDW3EOzedxUeiFsnDACmdHkShYgonzaKqQJjG4QosW7CiW+SDX5xz01FAs3TkP+S10TaVuKRXfe9SYZav486z0QPMvOmeNnrSJfQ3FWH8VjZqxcnIuuqV1Z+2WURJ4dCNPgZ1zRBC1XH1JNr6IVbERd5ioq/juJsyVKh6cjFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411002; c=relaxed/simple;
	bh=jfqh4XlrgxUx2TAlJ7fibTWDguspC5T9HF2+ujAf7J4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DMZcGoBjirPC3PCkgacgCIZAZwIbCsGSwYyX9cQrlbp7AXoo9qYiFL7pBy3VeW+Qmr4hRR+4fXx5fZk5gEn8xVNBjV9X+qv0Xfa2dm5iE3hU3TlNduZnNajHN9FNcMYwQVBK9wUGznhVmNxHL8gu0cyUukZYICL6AjoLbGfIF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQ6Xgwjq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434a0d30c06so10973015e9.1
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 07:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733410999; x=1734015799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=868ek3X6u4wRrG0oHFhQmnPTH1x/NJzHXmqaE0ZFvxc=;
        b=fQ6XgwjqMdbJYN0ExhafdYe4TLEpWU9iYzL8pZ1Sm9+mTQfBEN8eG4JDxviNv4tin9
         JaMZAVcWdwmjzZG+epdR64k+loL6Ntz7IbZv+LcUgOfulPXRtxEve2LIdHeO+hv12/Kw
         5psfZrzIDyC4I5fa/zOm2qb9ENihEfpz4TZJPeJNOKX5oLzNQsu7O61V9gF9N118ywBz
         sfT/Z5tbx+NL01Y0wnQjNmjKNwCrgkpMYCJBLq5NYLKa+7TlSvQHyKcEZvor2yZFhC9t
         8VTqUks8Sy67GUVmd+FG0luy5KWZrX+/wcYohJ79Te1CSS8sD3+4TFz0XuYvXHOtRGfw
         OUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733410999; x=1734015799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=868ek3X6u4wRrG0oHFhQmnPTH1x/NJzHXmqaE0ZFvxc=;
        b=J79oU0SWYO5aCzNG8EPKZcbkuJ6bcpbv7CG/hzgPffIvNVskAi8IB6nr3kgJ+XLvML
         JFN9Kdv7GmNUShU5cpFeiOfqWW1U8jY1RMRT0UtB6KAHRWkkpN7Qa3WdYNMLWjJ9lroE
         lhM0KXYMjEnXXsdgq3Yx7L4X+Q1U7R61AuECtFrcKhnnr80cOpCjMjQZQ9ydoMGDK9wb
         eGA/g6noS3dwfdOEuFg4CMTPV1ON4W/GvjjMx228x3rkb7S9uTIeyXzzAjTJeHf+9De+
         RCltLTRNVAraYhi1yUgJ8gbcnLFKSXTMUjuaL5bOrbD9X45QqW+4ojejAeIZSq9oHwqU
         el6w==
X-Forwarded-Encrypted: i=1; AJvYcCXLXWq/8vtDFleygo7E/IcDwe5abthop+qNYthXHT0dXilZuHWdl28u2zB0XRqGzWwY9KD2oyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG7hpJgsPEewAA9c9RPC7rX9tJR9149ovfGQSkECPAQ8L8yKOo
	x7GThObEtfROjI5AgyOpio34zhgdnVYfjeG8sKMSS88AKz+B1JvJf5dsDto5YQX/nSdQcQ==
X-Google-Smtp-Source: AGHT+IEG8OdMIDHFN7BUBJAGkuap4dQ3axovj/9FC8JwI5LK95PEfR5lpTW79KuGQFQy/XnCwcquwtPB
X-Received: from wmgp6.prod.google.com ([2002:a05:600c:2046:b0:431:4a1d:9d5a])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:45c7:b0:434:9fca:d6c3
 with SMTP id 5b1f17b1804b1-434d927b20emr27344225e9.9.1733410999429; Thu, 05
 Dec 2024 07:03:19 -0800 (PST)
Date: Thu,  5 Dec 2024 16:02:31 +0100
In-Reply-To: <20241205150229.3510177-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205150229.3510177-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3266; i=ardb@kernel.org;
 h=from:subject; bh=ho24jy35KD5ehFP+fzUCJpH+Gg46J3THWKKypOQTSx0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT3wQEfwrFkhzsd2ntqTcPtRdv+2yreNh1y+9XlrvdiSO
 y1lvqZpRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIiCDD/6wVApcSX55aF+ik
 vHSG+oEpuW8+XP+pxmdfp1H0v7HzrjojQ2dLf2C4mEjmxTXJ96+d7/p/uXi2xYGkGbEtep9bEnw v8gAA
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205150229.3510177-9-ardb+git@google.com>
Subject: [PATCH v2 1/6] arm64/mm: Reduce PA space to 48 bits when LPA2 is not enabled
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
 arch/arm64/include/asm/sparsemem.h     | 4 +++-
 3 files changed, 10 insertions(+), 7 deletions(-)

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
index 8a8acc220371..035e0ca74e88 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -5,7 +5,9 @@
 #ifndef __ASM_SPARSEMEM_H
 #define __ASM_SPARSEMEM_H
 
-#define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
+#include <asm/pgtable-prot.h>
+
+#define MAX_PHYSMEM_BITS	PHYS_MASK_SHIFT
 
 /*
  * Section size must be at least 512MB for 64K base
-- 
2.47.0.338.g60cca15819-goog


