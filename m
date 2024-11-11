Return-Path: <stable+bounces-92077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 131A79C39B0
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 09:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4381F20FC8
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 08:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C8A158853;
	Mon, 11 Nov 2024 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ytprFo97"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123C542A8A
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314159; cv=none; b=DEdPZtKhgJQabpsdtoLtEbflPh1XLk7r4ikLhwOmkFcJaeJqij2D4U6JLLXOXTQYntCBgquUZ2LQwIWn+zkSbcEliy/cYNBVm7AS5lYrentb757xJrHrXxus5b82jdpJcRiMu8VRl4f0+pZE9kt3miQFsIqapsWopBOz6ZZkE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314159; c=relaxed/simple;
	bh=Yskd+Xg/feqS0imQg6Nv+AnuB07Ju58lVVo7WPeN0s4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bdTMM+loRmDzBa4ty/HpX9qvOUrPzkOezCnH3pJC+eorrBzoGSElOmlaAJzhFuUphpAdeiDmdHoRu3+wVV7LAIynnTdcYRY0orPUxkjn283PgVgPbQ+6e7FIiiEhMzytFJP1Tt/LNDE9wIe6rFPK+cItA2/ASpVl3/AUnQ1hKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ytprFo97; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea7cfb6e0fso81491717b3.0
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 00:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731314157; x=1731918957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jdRnYA4Dp/HKDbLf8iEX384rtZ3sORsc5iDaybCR36k=;
        b=ytprFo97wnKrzyW6+1xjM50W1QKrPxW8N0I5rWVt7/JCWTNDUuOX4OEPbCCXJQbAal
         HBF6P0LeRZZEb/4CY6f/0MXql7JssI5a/jvj85BOQf3rjp3wu802Gq/3bHGpDUEwy/sW
         qk0o9H+zcPFL82sHKAElpI08uP5PhlocwwOG/HPojwOWu2RBrgKYJ5Rptox+jfmZfrYi
         ZhGbJavTZ/jhCcz+41TQkmPqTM4EWojQ3CIFZYeAJXq7nI9wySI8+eVLokSSTctSphK2
         TsH0akscU0kUT7+/Uihk5Ys7p9VMi4uyzD7CcGjzG6zW4k9rnuF2wOyIlzYbrPu4vTOu
         UnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731314157; x=1731918957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdRnYA4Dp/HKDbLf8iEX384rtZ3sORsc5iDaybCR36k=;
        b=CGzFh766/pQ1JihgFQb9VD7sOJx/CJeBDMZVWY60KjGjZprA0/1mt51VS/IxmnXyWC
         Pk1s4QTsVggJMZ1k+UlNESRTClDRVQnqy85PkB1/sDeAZ1GwtpHFLhG9eiqFRccKqgt1
         E4uzUXKOWsdIuXY/sMMQCA3j7SOftOHbdeo5A0wiZHFu62BdaryCAnuui6nEBif2ySnK
         LAw0NOM6B0gSO+4Ko3PH2stqhgV9LzNPLA29uD6a2frAHEUKA0E4FuCSWdLrm+E7G2em
         lZuGSM975ff1KSPxjY10iDb4V4YELzRFZu+A0yvASJDnNr5F2RfUipEem2sy/62PIw9F
         SmTw==
X-Forwarded-Encrypted: i=1; AJvYcCXqBGfxCDxlhxUBm6IccGRND+Bp4tjdPNRUvA+nHt3Et90Fz/XaZg6NEztJrDH+7Ks4bz8kA8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzbNBqdQJnhdTfxKY91v4Z9WjiNqSFbE/ODxC/I934lPGLggMg
	Xk2wfZ7r0kB/nuqmBTevAliavptYDBXmmi1qQVRzuXt8Vatf45kp+7HvRvtQD84vypKd/Q==
X-Google-Smtp-Source: AGHT+IEhAd1ZYt2KUoU4K2QDCIjo6LctpoeG1kVqzvVn0qTYE0SJcqJsrkLHh8WG4AcoXgHHmsa2YvUF
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:c7cf:0:b0:e28:fb8b:9155 with SMTP id
 3f1490d57ef6-e337f8e8d9fmr19018276.9.1731314156955; Mon, 11 Nov 2024 00:35:56
 -0800 (PST)
Date: Mon, 11 Nov 2024 09:35:45 +0100
In-Reply-To: <20241111083544.1845845-8-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111083544.1845845-8-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3161; i=ardb@kernel.org;
 h=from:subject; bh=TQ6skMuf6HwA53KOOzLH55jf3veEJQFpWOO2ik/HsBo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JId3w4MN7c/r4xb+212w9/UK9/v7xGy5zfjLLhXUusGL9v
 Ce78nhsRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI7Q0M/zPSfD9stF61bcvv
 gOLaRwocrAs92kUdV719F//36YSD+ycyMrRekNqwdgurp5Z8d5mbiXmHVsPsopc2D7Jall/YM29 OCiMA
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241111083544.1845845-9-ardb+git@google.com>
Subject: [PATCH 1/6] arm64/mm: Reduce PA space to 48 bits when LPA2 is not enabled
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Currently, LPA2 support implies support for up to 52 bits of physical
addressing, and this is reflected in global definitions such as
PHYS_MASK_SHIFT and MAX_PHYSMEM_BITS.

This is potentially problematic, given that LPA2 support is modeled as a
CPU feature which can be overridden, and with LPA2 support turned off,
attempting to map physical regions with address bits [51:48] set (which
may exist on LPA2 capable systems booting with arm64.nolva) will result
in corrupted mappings with a truncated output address and bogus
shareability attributes.

This means that the accepted physical address range in the mapping
routines should be at most 48 bits wide when LPA2 is supported but not
enabled.

Fixes: 352b0395b505 ("arm64: Enable 52-bit virtual addressing for 4k and 16k granule configs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 6 ------
 arch/arm64/include/asm/pgtable-prot.h  | 7 +++++++
 arch/arm64/include/asm/sparsemem.h     | 4 +++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index fd330c1db289..a970def932aa 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -218,12 +218,6 @@
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
2.47.0.277.g8800431eea-goog


