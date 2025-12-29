Return-Path: <stable+bounces-203466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBECCE5DF7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 04:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 524C93007955
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 03:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAE426CE1E;
	Mon, 29 Dec 2025 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9pIOnCw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B312264A9
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 03:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766979402; cv=none; b=J7piFaPI7L3JaBcKREvNdaw4DKw4DXAXdK1QHjpbq3HJ7YWW365Pax1mDDqC6+VMeRiajrLtWmwU8tqlvq4ISn0HGkAFLBTGg/gb7FxG/XKa5tPFkR3eQ/NNDeGVIlq3+0g4zP7Docu0ELWkEgIiMOUTXoeq3kHl2oLupvSdGX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766979402; c=relaxed/simple;
	bh=SwFi47220NhM2jT+6v2eoVvt8M1LxXGA37HBJu3RwRQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=May4roLpjDg3q4CCqMaiLacJ9CCNCz/4H9hc1EHhPY9gYXMLbtOXje/GqvtQTHxdrj+CspyLHfcEUhO7nl+QsZvYqNx+qBloucLBJo62UQ8+emX+AwHBNceBZyeSvvYy+jStU79ZkjdgaYIls8tE4J1E33bLNLRT5HzRNfK0SRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lucaswei.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9pIOnCw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lucaswei.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0a0bad5dfso184449635ad.0
        for <stable@vger.kernel.org>; Sun, 28 Dec 2025 19:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766979400; x=1767584200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tlgzro7FncjNJuzBeVV+gMjPrzzsyNIqE/qYSbMjGMc=;
        b=P9pIOnCwsi8AYWux9yb1sJN0pSE4YxSRO7kfLIxj/uESeDlLITPipyxchHaxEAyXSc
         Pk3BwwPJd7BPIhQXGDgmLuJz/exwEuJHkf6bAC1fie6jMyGazD1+q4B5asDmSZPQM47R
         S29NpYa7jPNsKPp5reziFQRI75RXpWw7hCq44wsCdnSHuV3qnPAFqcGpViRfpMe7bTF4
         ECZK3PvD0gVROhjsMjgMwbYhHWzWUXmLaEdXEVS+hedyCdRJ/1Bzy58PMmNL4knRO4Lr
         5SUFws5OPPHBK+HubnW6XnH2ehTnmjSAeTpaMTO4JnOgB5mljgA+bpSVOptYwervqTjC
         Rr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766979400; x=1767584200;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlgzro7FncjNJuzBeVV+gMjPrzzsyNIqE/qYSbMjGMc=;
        b=AiVCg/aE1z7n0Sr/PBYXBerbUABjykA4gu+xj7KS8REDEcZYG9x2dyBfnAPEC4HX5/
         o+5X2Wmqw8Ay0mzOlkU6bWtPzZ7bxeZfnzcAbKH7XJ8QKw8bsatrNOkhv+J4iV7fzj1B
         TZErTszrl9tPybET6EERapRwoU6z9sOvAxWxEV8CDX4opXmnQCYEx4iJyqnsozekO5QS
         7+yy0zwLLDDSvY1OCE295VsIaXnA8qhKBToq62E3lOt64xvZbyPEUzrHoldlrSLOMmZi
         O+CIjsP7bogAjf8NGtoxl8YviPe+mFxPwlNnv9lncTywK0cYd01+8DIIh2STB1npRozp
         TRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCULIUN+0/Re3J6JtKBM6LChmCsQAp/rztjQTPh5UgKpzJKh2tJoWp9S39NzM2zfLml9XF6Yfr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6sirTbkXMtkr8ziWd8EOo3wFR0eXbY2m0bjaX3muEwKtiip86
	VjeNovk4qIPoneJWDsEk2v0yVpmpr6guCK5Klqbh9zi3D33xYlUzr+TOgSHy9i2crBeLoKzAXjq
	IeBVPXv+4WA3aUQ==
X-Google-Smtp-Source: AGHT+IEi02veFKPSaH8rSwZrrtPejgrT+aWN21tWglweLgCEKAGkZvcU4SKqoS1kr3Pi2TTzu5lhwViTWhZE1g==
X-Received: from pltj6.prod.google.com ([2002:a17:902:76c6:b0:29f:1480:6153])
 (user=lucaswei job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:32cd:b0:2a0:ad09:750b with SMTP id d9443c01a7336-2a2f222aef2mr216742645ad.9.1766979399578;
 Sun, 28 Dec 2025 19:36:39 -0800 (PST)
Date: Mon, 29 Dec 2025 03:36:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
Message-ID: <20251229033621.996546-1-lucaswei@google.com>
Subject: [PATCH v2] arm64: errata: Workaround for SI L1 downstream coherency issue
From: Lucas Wei <lucaswei@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Cc: sjadavani@google.com, Lucas Wei <lucaswei@google.com>, 
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When software issues a Cache Maintenance Operation (CMO) targeting a
dirty cache line, the CPU and DSU cluster may optimize the operation by
combining the CopyBack Write and CMO into a single combined CopyBack
Write plus CMO transaction presented to the interconnect (MCN).
For these combined transactions, the MCN splits the operation into two
separate transactions, one Write and one CMO, and then propagates the
write and optionally the CMO to the downstream memory system or external
Point of Serialization (PoS).
However, the MCN may return an early CompCMO response to the DSU cluster
before the corresponding Write and CMO transactions have completed at
the external PoS or downstream memory. As a result, stale data may be
observed by external observers that are directly connected to the
external PoS or downstream memory.

This erratum affects any system topology in which the following
conditions apply:
 - The Point of Serialization (PoS) is located downstream of the
   interconnect.
 - A downstream observer accesses memory directly, bypassing the
   interconnect.

Conditions:
This erratum occurs only when all of the following conditions are met:
 1. Software executes a data cache maintenance operation, specifically,
    a clean or invalidate by virtual address (DC CVAC, DC CIVAC, or DC
    IVAC), that hits on unique dirty data in the CPU or DSU cache. This
    results in a combined CopyBack and CMO being issued to the
    interconnect.
 2. The interconnect splits the combined transaction into separate Write
    and CMO transactions and returns an early completion response to the
    CPU or DSU before the write has completed at the downstream memory
    or PoS.
 3. A downstream observer accesses the affected memory address after the
    early completion response is issued but before the actual memory
    write has completed. This allows the observer to read stale data
    that has not yet been updated at the PoS or downstream memory.

The implementation of workaround put a second loop of CMOs at the same
virtual address whose operation meet erratum conditions to wait until
cache data be cleaned to PoC.. This way of implementation mitigates
performance panalty compared to purly duplicate orignial CMO.

Reported-by: kernel test robot <lkp@intel.com>
Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Lucas Wei <lucaswei@google.com>
---

Changes in v2:

 1. Fixed warning from kernel test robot by changing
    arm_si_l1_workaround_4311569 to static 
    [Reported-by: kernel test robot <lkp@intel.com>]

---
 Documentation/arch/arm64/silicon-errata.rst |  3 ++
 arch/arm64/Kconfig                          | 19 +++++++++++++
 arch/arm64/include/asm/assembler.h          | 10 +++++++
 arch/arm64/kernel/cpu_errata.c              | 31 +++++++++++++++++++++
 arch/arm64/mm/cache.S                       | 13 ++++++++-
 arch/arm64/tools/cpucaps                    |  1 +
 6 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index a7ec57060f64..98efdf528719 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -213,6 +213,9 @@ stable kernels.
 | ARM            | GIC-700         | #2941627        | ARM64_ERRATUM_2941627       |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | SI L1           | #4311569        | ARM64_ERRATUM_4311569       |
++----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_843419        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 65db12f66b8f..a834d30859cc 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1153,6 +1153,25 @@ config ARM64_ERRATUM_3194386
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_4311569
+	bool "SI L1: 4311569: workaround for premature CMO completion erratum"
+	default y
+	help
+	  This option adds the workaround for ARM SI L1 erratum 4311569.
+
+	  The erratum of SI L1 can cause an early response to a combined write
+	  and cache maintenance operation (WR+CMO) before the operation is fully
+	  completed to the Point of Serialization (POS).
+	  This can result in a non-I/O coherent agent observing stale data,
+	  potentially leading to system instability or incorrect behavior.
+
+	  Enabling this option implements a software workaround by inserting a
+	  second loop of Cache Maintenance Operation (CMO) immediately following the
+	  end of function to do CMOs. This ensures that the data is correctly serialized
+	  before the buffer is handed off to a non-coherent agent.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index f0ca7196f6fa..d3d46e5f7188 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -381,6 +381,9 @@ alternative_endif
 	.macro dcache_by_myline_op op, domain, start, end, linesz, tmp, fixup
 	sub	\tmp, \linesz, #1
 	bic	\start, \start, \tmp
+alternative_if ARM64_WORKAROUND_4311569
+	mov	\tmp, \start
+alternative_else_nop_endif
 .Ldcache_op\@:
 	.ifc	\op, cvau
 	__dcache_op_workaround_clean_cache \op, \start
@@ -402,6 +405,13 @@ alternative_endif
 	add	\start, \start, \linesz
 	cmp	\start, \end
 	b.lo	.Ldcache_op\@
+alternative_if ARM64_WORKAROUND_4311569
+	.ifnc	\op, cvau
+	mov	\start, \tmp
+	mov	\tmp, xzr
+	cbnz	\start, .Ldcache_op\@
+	.endif
+alternative_else_nop_endif
 	dsb	\domain
 
 	_cond_uaccess_extable .Ldcache_op\@, \fixup
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 8cb3b575a031..5c0ab6bfd44a 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -141,6 +141,30 @@ has_mismatched_cache_type(const struct arm64_cpu_capabilities *entry,
 	return (ctr_real != sys) && (ctr_raw != sys);
 }
 
+#ifdef CONFIG_ARM64_ERRATUM_4311569
+static DEFINE_STATIC_KEY_FALSE(arm_si_l1_workaround_4311569);
+static int __init early_arm_si_l1_workaround_4311569_cfg(char *arg)
+{
+	static_branch_enable(&arm_si_l1_workaround_4311569);
+	pr_info("Enabling cache maintenance workaround for ARM SI-L1 erratum 4311569\n");
+
+	return 0;
+}
+early_param("arm_si_l1_workaround_4311569", early_arm_si_l1_workaround_4311569_cfg);
+
+/*
+ * We have some earlier use cases to call cache maintenance operation functions, for example,
+ * dcache_inval_poc() and dcache_clean_poc() in head.S, before making decision to turn on this
+ * workaround. Since the scope of this workaround is limited to non-coherent DMA agents, its
+ * safe to have the workaround off by default.
+ */
+static bool
+need_arm_si_l1_workaround_4311569(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	return static_branch_unlikely(&arm_si_l1_workaround_4311569);
+}
+#endif
+
 static void
 cpu_enable_trap_ctr_access(const struct arm64_cpu_capabilities *cap)
 {
@@ -870,6 +894,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		ERRATA_MIDR_RANGE_LIST(erratum_spec_ssbs_list),
 	},
 #endif
+#ifdef CONFIG_ARM64_ERRATUM_4311569
+	{
+		.capability = ARM64_WORKAROUND_4311569,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = need_arm_si_l1_workaround_4311569,
+	},
+#endif
 #ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
 	{
 		.desc = "ARM errata 2966298, 3117295",
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 503567c864fd..ddf0097624ed 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -143,9 +143,14 @@ SYM_FUNC_END(dcache_clean_pou)
  *	- end     - kernel end address of region
  */
 SYM_FUNC_START(__pi_dcache_inval_poc)
+alternative_if ARM64_WORKAROUND_4311569
+	mov	x4, x0
+	mov	x5, x1
+	mov	x6, #1
+alternative_else_nop_endif
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
-	tst	x1, x3				// end cache line aligned?
+again:	tst	x1, x3				// end cache line aligned?
 	bic	x1, x1, x3
 	b.eq	1f
 	dc	civac, x1			// clean & invalidate D / U line
@@ -158,6 +163,12 @@ SYM_FUNC_START(__pi_dcache_inval_poc)
 3:	add	x0, x0, x2
 	cmp	x0, x1
 	b.lo	2b
+alternative_if ARM64_WORKAROUND_4311569
+	mov	x0, x4
+	mov	x1, x5
+	sub	x6, x6, #1
+	cbz	x6, again
+alternative_else_nop_endif
 	dsb	sy
 	ret
 SYM_FUNC_END(__pi_dcache_inval_poc)
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 1b32c1232d28..3b18734f9744 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -101,6 +101,7 @@ WORKAROUND_2077057
 WORKAROUND_2457168
 WORKAROUND_2645198
 WORKAROUND_2658417
+WORKAROUND_4311569
 WORKAROUND_AMPERE_AC03_CPU_38
 WORKAROUND_AMPERE_AC04_CPU_23
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE

base-commit: edde060637b92607f3522252c03d64ad06369933
-- 
2.52.0.358.g0dd7633a29-goog


