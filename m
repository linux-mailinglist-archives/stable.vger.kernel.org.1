Return-Path: <stable+bounces-33751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97858892338
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 19:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E185284CDA
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 18:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5F3225A8;
	Fri, 29 Mar 2024 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kQnfhws+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F03418AF8
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736320; cv=none; b=Wl7TCsB42pxptyq6xLqgkQ5lMND+0a+/xZfh240kPTU6qJSCVAm4o+s1KVF7IgUUIdA7tQRN8zb0jO5wkBJ0/ugfbd43piGFGo2fvcC4NKysCuB1HuTItptajDq/WU7unZHm27FILfZPtwdO7LW/WFCP+jqt9Y4yAqRuHFqnCFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736320; c=relaxed/simple;
	bh=cXWpQ/W46dL5q9qQBLgl8b00OXRr0ILME6EO+gmzgug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dUm3EkVpnpgujWcToSg+IBEwGwU7gJ7GzgCgQbVJ60G3CgyDrThYcH52VBBwBTzB58Hf3362bg/hoEsIFZ6fhXwTpxpjNqC52QHwQVm0Eqcdr4MTqzfgh6HE1a6GGe1F/cXC/2FQVScnRcsH8DzWDhRStz+geKBr6l5dB4YlCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kQnfhws+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0b18e52dso26927077b3.1
        for <stable@vger.kernel.org>; Fri, 29 Mar 2024 11:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711736317; x=1712341117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPDtdwPeslnDo5DJC9BTYhHtCVq9g4AjTt8rTPVZgGo=;
        b=kQnfhws+uMTvvEoEGJWKgWadsk/iEcb3DhgK8ECb7rBnTexTyQ8uwpPGwEZZv7nqdk
         WvjZl/YtMwhI8yIDF+or/lMn13M16yO3B3r826zWEd2Wx3f7w0/xZR9m2Ol8c5klU8bH
         6mowWUrOXaeMyYov8EHLICzEQTFstn+CbDD6A6gvyk6+zVRLXcvXgoiZOOYv46YqpZMZ
         jXpoFgBBEeqM4q+/QqcVMgFy7h6YX+FpinHHrjvkrW9CtnWYq9Fj5I/ksPXg0jBHGq7v
         Q8yMNT5LwVAQs7blJj8SlGl1FZybDUnR0OxeDfqRfUVjGE0FnraQuOBPZAl8f/5kdexK
         Atlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711736317; x=1712341117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPDtdwPeslnDo5DJC9BTYhHtCVq9g4AjTt8rTPVZgGo=;
        b=AOkNob44B/mNcnYttYzzT4b5WjY0K06/buBXs4BCMo2jhSYL8qA2RNtth0ukAXJRBf
         ScVwluVrg21GTGOA5MgqzZghQll2FSjDDysWpPvpFe0h68NnEf7OY2fGl456fny+9PFn
         5RH98RXCIS7w29YyQkfLI4NCbTEsUCVPBjel+wJeRRwsDkHntsAKCC6AW947sFJGMTTb
         +8kYDAm33lqllwOTrnu7gkc66Bs3a+zyaNJYqSV0rY+spHEFgX2VKcqRinAIbcsxbpYP
         BIBHg1MsN5HBeC8dY8Leu0klqkcDO6hxMBujqAS3j5WZuyBR0BwfVOWqKxNRZWiuk8/W
         Av3A==
X-Gm-Message-State: AOJu0Yzzaf0S9KEI3jXPPyh5byOaTqudfv6XYYyW1/Dvn4ohnm3sEdwl
	Py4A8ULTrzUooty7gIWEQo+csTCLZaZ8rm40wHs8+8BPeYQfyMIXDaF95Tl49wk0iK+6XXqV9lZ
	Tye8xZ4wqe3RqE3H4vI7moAzYhWIJkDrUgbiXDPJVvvC4f5HdMWG0WhJapwNjaj5S2lMq3i47gh
	kacrzc3IZhWZvOD4PrAGfnIg==
X-Google-Smtp-Source: AGHT+IEEODtyJspdrS4SKxUV9u3Tm77J6YU1DjRK7X19EGgC4u5aoz5/6dgz2fIxMjgc251+93LrDkiQ
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:b208:0:b0:611:66e0:8dd4 with SMTP id
 q8-20020a81b208000000b0061166e08dd4mr1251400ywh.5.1711736317244; Fri, 29 Mar
 2024 11:18:37 -0700 (PDT)
Date: Fri, 29 Mar 2024 19:18:04 +0100
In-Reply-To: <20240329181800.619169-5-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329181800.619169-5-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=10227; i=ardb@kernel.org;
 h=from:subject; bh=gS7+oGmNoho6LSdlCYxOj5Q5aFPlkR80CMZop0xnEvw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIY2d9c5dVYP8q796F0ZEri5mUZXJsjq7vIB9ndCvX6Jbn
 a+dnbu7o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExk5kKG/+7z+vKun22d3LDE
 fJ9Gi+ydz8s3/hef3J17etP0oxtMElQZGRr2zau4Z/rpN4tnlorD+WsnxLoy62e8v3pD7K3Ytz+ tP/gB
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329181800.619169-8-ardb+git@google.com>
Subject: [PATCH -stable-6.1 resend 4/4] x86/sev: Fix position dependent
 variable references in startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Ard Biesheuvel <ardb@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Borislav Petkov <bp@alien8.de>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit efec46b78cf062b7eab009c624cf32dfdab99aa7 upstream ]

The early startup code executes from a 1:1 mapping of memory, which
differs from the mapping that the code was linked and/or relocated to
run at. The latter mapping is not active yet at this point, and so
symbol references that rely on it will fault.

Given that the core kernel is built without -fPIC, symbol references are
typically emitted as absolute, and so any such references occuring in
the early startup code will therefore crash the kernel.

While an attempt was made to work around this for the early SEV/SME
startup code, by forcing RIP-relative addressing for certain global
SEV/SME variables via inline assembly (see snp_cpuid_get_table() for
example), RIP-relative addressing must be pervasively enforced for
SEV/SME global variables when accessed prior to page table fixups.

__startup_64() already handles this issue for select non-SEV/SME global
variables using fixup_pointer(), which adjusts the pointer relative to a
`physaddr` argument. To avoid having to pass around this `physaddr`
argument across all functions needing to apply pointer fixups, introduce
a macro RIP_RELATIVE_REF() which generates a RIP-relative reference to
a given global variable. It is used where necessary to force
RIP-relative accesses to global variables.

For backporting purposes, this patch makes no attempt at cleaning up
other occurrences of this pattern, involving either inline asm or
fixup_pointer(). Those will be addressed later.

  [ bp: Call it "rip_rel_ref" everywhere like other code shortens
    "rIP-relative reference" and make the asm wrapper __always_inline. ]

Co-developed-by: Kevin Loughlin <kevinloughlin@google.com>
Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/all/20240130220845.1978329-1-kevinloughlin@google.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/coco/core.c               |  7 +----
 arch/x86/include/asm/asm.h         | 14 ++++++++++
 arch/x86/include/asm/coco.h        |  8 +++++-
 arch/x86/include/asm/mem_encrypt.h | 15 ++++++-----
 arch/x86/kernel/sev-shared.c       | 12 ++++-----
 arch/x86/kernel/sev.c              |  4 +--
 arch/x86/mm/mem_encrypt_identity.c | 27 +++++++++-----------
 7 files changed, 51 insertions(+), 36 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 1e73254336a6..1d3ad275c366 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -14,7 +14,7 @@
 #include <asm/processor.h>
 
 enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
-static u64 cc_mask __ro_after_init;
+u64 cc_mask __ro_after_init;
 
 static bool intel_cc_platform_has(enum cc_attr attr)
 {
@@ -128,8 +128,3 @@ u64 cc_mkdec(u64 val)
 	}
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
-
-__init void cc_set_mask(u64 mask)
-{
-	cc_mask = mask;
-}
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index fbcfec4dc4cc..ca8eed1d496a 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -113,6 +113,20 @@
 
 #endif
 
+#ifndef __ASSEMBLY__
+#ifndef __pic__
+static __always_inline __pure void *rip_rel_ptr(void *p)
+{
+	asm("leaq %c1(%%rip), %0" : "=r"(p) : "i"(p));
+
+	return p;
+}
+#define RIP_REL_REF(var)	(*(typeof(&(var)))rip_rel_ptr(&(var)))
+#else
+#define RIP_REL_REF(var)	(var)
+#endif
+#endif
+
 /*
  * Macros to generate condition code outputs from inline assembly,
  * The output operand must be type "bool".
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 75a0d7b1a906..60bb26097da1 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_COCO_H
 #define _ASM_X86_COCO_H
 
+#include <asm/asm.h>
 #include <asm/types.h>
 
 enum cc_vendor {
@@ -12,9 +13,14 @@ enum cc_vendor {
 };
 
 extern enum cc_vendor cc_vendor;
+extern u64 cc_mask;
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-void cc_set_mask(u64 mask);
+static inline void cc_set_mask(u64 mask)
+{
+	RIP_REL_REF(cc_mask) = mask;
+}
+
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
 #else
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index c91326593e74..41d06822bc8c 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -15,7 +15,8 @@
 #include <linux/init.h>
 #include <linux/cc_platform.h>
 
-#include <asm/bootparam.h>
+#include <asm/asm.h>
+struct boot_params;
 
 #ifdef CONFIG_X86_MEM_ENCRYPT
 void __init mem_encrypt_init(void);
@@ -57,6 +58,11 @@ void __init mem_encrypt_free_decrypted_mem(void);
 
 void __init sev_es_init_vc_handling(void);
 
+static inline u64 sme_get_me_mask(void)
+{
+	return RIP_REL_REF(sme_me_mask);
+}
+
 #define __bss_decrypted __section(".bss..decrypted")
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
@@ -88,6 +94,8 @@ early_set_mem_enc_dec_hypercall(unsigned long vaddr, unsigned long size, bool en
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
 
+static inline u64 sme_get_me_mask(void) { return 0; }
+
 #define __bss_decrypted
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
@@ -105,11 +113,6 @@ void add_encrypt_protection_map(void);
 
 extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
 
-static inline u64 sme_get_me_mask(void)
-{
-	return sme_me_mask;
-}
-
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 71d8698702ce..271e70d5748e 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -553,9 +553,9 @@ static int snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_le
 		leaf->eax = leaf->ebx = leaf->ecx = leaf->edx = 0;
 
 		/* Skip post-processing for out-of-range zero leafs. */
-		if (!(leaf->fn <= cpuid_std_range_max ||
-		      (leaf->fn >= 0x40000000 && leaf->fn <= cpuid_hyp_range_max) ||
-		      (leaf->fn >= 0x80000000 && leaf->fn <= cpuid_ext_range_max)))
+		if (!(leaf->fn <= RIP_REL_REF(cpuid_std_range_max) ||
+		      (leaf->fn >= 0x40000000 && leaf->fn <= RIP_REL_REF(cpuid_hyp_range_max)) ||
+		      (leaf->fn >= 0x80000000 && leaf->fn <= RIP_REL_REF(cpuid_ext_range_max))))
 			return 0;
 	}
 
@@ -1060,10 +1060,10 @@ static void __init setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
 		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
 
 		if (fn->eax_in == 0x0)
-			cpuid_std_range_max = fn->eax;
+			RIP_REL_REF(cpuid_std_range_max) = fn->eax;
 		else if (fn->eax_in == 0x40000000)
-			cpuid_hyp_range_max = fn->eax;
+			RIP_REL_REF(cpuid_hyp_range_max) = fn->eax;
 		else if (fn->eax_in == 0x80000000)
-			cpuid_ext_range_max = fn->eax;
+			RIP_REL_REF(cpuid_ext_range_max) = fn->eax;
 	}
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c8dfb0fdde7f..f93ff4794e38 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -736,7 +736,7 @@ void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	 * This eliminates worries about jump tables or checking boot_cpu_data
 	 * in the cc_platform_has() function.
 	 */
-	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
 	 /*
@@ -758,7 +758,7 @@ void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr
 	 * This eliminates worries about jump tables or checking boot_cpu_data
 	 * in the cc_platform_has() function.
 	 */
-	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
 		return;
 
 	/* Invalidate the memory pages before they are marked shared in the RMP table. */
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7d96904230af..06ccbd36e8dc 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -304,7 +304,8 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
 	 * function.
 	 */
-	if (!sme_get_me_mask() || sev_status & MSR_AMD64_SEV_ENABLED)
+	if (!sme_get_me_mask() ||
+	    RIP_REL_REF(sev_status) & MSR_AMD64_SEV_ENABLED)
 		return;
 
 	/*
@@ -541,11 +542,11 @@ void __init sme_enable(struct boot_params *bp)
 	me_mask = 1UL << (ebx & 0x3f);
 
 	/* Check the SEV MSR whether SEV or SME is enabled */
-	sev_status   = __rdmsr(MSR_AMD64_SEV);
-	feature_mask = (sev_status & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
+	RIP_REL_REF(sev_status) = msr = __rdmsr(MSR_AMD64_SEV);
+	feature_mask = (msr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
 	/* The SEV-SNP CC blob should never be present unless SEV-SNP is enabled. */
-	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
+	if (snp && !(msr & MSR_AMD64_SEV_SNP_ENABLED))
 		snp_abort();
 
 	/* Check if memory encryption is enabled */
@@ -571,7 +572,6 @@ void __init sme_enable(struct boot_params *bp)
 			return;
 	} else {
 		/* SEV state cannot be controlled by a command line option */
-		sme_me_mask = me_mask;
 		goto out;
 	}
 
@@ -590,16 +590,13 @@ void __init sme_enable(struct boot_params *bp)
 	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
 				     ((u64)bp->ext_cmd_line_ptr << 32));
 
-	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
-		goto out;
-
-	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
-		sme_me_mask = me_mask;
+	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0 ||
+	    strncmp(buffer, cmdline_on, sizeof(buffer)))
+		return;
 
 out:
-	if (sme_me_mask) {
-		physical_mask &= ~sme_me_mask;
-		cc_vendor = CC_VENDOR_AMD;
-		cc_set_mask(sme_me_mask);
-	}
+	RIP_REL_REF(sme_me_mask) = me_mask;
+	physical_mask &= ~me_mask;
+	cc_vendor = CC_VENDOR_AMD;
+	cc_set_mask(me_mask);
 }
-- 
2.44.0.478.gd926399ef9-goog


