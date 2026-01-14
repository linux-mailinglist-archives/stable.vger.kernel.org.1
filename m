Return-Path: <stable+bounces-208364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DFCD1F8A4
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 15:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF55030042A6
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27F930C63C;
	Wed, 14 Jan 2026 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljd1EdfI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0984E3064AA
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402380; cv=none; b=Q2R8VcYlCaOcrJR9oLkRdd8TaEpIwwN2eS3uRvbExVyPPjRl1gKwHqRj/ia8KLrLxzMKsCGnvWt2wjDRsoTQrPmtXYb7yChKAYuPsclny+6lCzHr7l3933+e3K4oO9kVexg5y63SziCNvR1hFq9Le44Jw2LMHICDb+OUIUKY3aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402380; c=relaxed/simple;
	bh=6EcsH4NJZuMHhhsCJiB1QN03+YEdExhWKAvJd5QzkRw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tSVehiq4u169HsrDC/Y3HLZ/TAvFX5aHbVjf/tOGnUOCiEWdzRwJyrn+g93W+OO5DGMSzTBJu5a+XNFTryWyRKlGMN6xxbNln6IQmsx5oqjGlgfC244xrCV7KtS6GlY8Zf3NeB67maZkVfeTmf09EoQvm21yPJvjva/4eS9g4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lucaswei.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ljd1EdfI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lucaswei.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c52ab75d57cso3990147a12.1
        for <stable@vger.kernel.org>; Wed, 14 Jan 2026 06:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768402378; x=1769007178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qY8ISVuzSMYysF5FVAjGM0hrJi0sARJDavcxZKDaL/Y=;
        b=ljd1EdfInOQ6cmyDkbPMVXO7M5zh/5B7c7M1ti12ttZBC8YOmIkJNKTvB/lH9ubxgD
         7U6uvIMTLb3LkA/2eh3Ha3/LZelYVmRYbBoiC9eXrsxLPAd/UUX1g17Sgi5rq0Ov+Onm
         cIjtsaBXh5SqvTz3615sN0PaWeT+FakD/rmJGfZENxOcU9VAzuGJe4ilXylF3P//bOMX
         P90pc3T//aHjXxklZqXmmNIE7oy4KGvrgjA0FH3vwRN5mSQ2+0x6CW88Z5CLOUoPvVao
         bpTNyVh7yOOAH2vjEf9Rp6pGGNKMA4RuwyIA8Y/PBalXoh0bGbxxpu8iJeUi8zm5E3w7
         iGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768402378; x=1769007178;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qY8ISVuzSMYysF5FVAjGM0hrJi0sARJDavcxZKDaL/Y=;
        b=skB+Lp6wVDwlaKz2TUXSbvEFJ2D60Kv6HUju/IPCDBX4jklwj2ZjCTQYewYYnaeBud
         vDe1qge0HqNnsS6P9i/eZ0YSJ+Eg4a/9lgsjyZtaY9YlmAVu42bWkBRp/WqzgAQ78Fq+
         edtSamrDMW12LryK6goXmdsa0JU7LD9F/Q0/GQXRtql+LGYEvbgfbR1raXR4gHhJehPw
         Lr83bKq8LNnD4LLipWjMn0NLdjALdMyzj//cPW+cImak9JsPYmDB+JZbrt6Btf/O4KPs
         PvdXS3dk1JYuKXEhM8QvrkzRo3LdDmk3FN2yM6uATgl8CSwTkaOfyZd2hYXDxxJ7br/q
         ht9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuvnmV3ik8T6pOE0hNoewkIBagVNd6O3q+fyN+G5noYUkT8rMTZQZJk13uoz/CSQb1gqAow44=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMmBE9oiHXEjHGhM5jKIK1pzqfy2GV3u/HLmyfW0Y8uQ1PYcXh
	EEdYqlPYihnktQOjU7XmspPdFBmUKCAVqZjS7BCnIl/hGDbfXEeNbm9QVcboye/qm7uTke1tW7n
	s8jkIrmIeXilj/Q==
X-Received: from pfgs36.prod.google.com ([2002:a05:6a00:17a4:b0:7e8:a188:d95e])
 (user=lucaswei job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:998a:b0:33f:4e3d:afff with SMTP id adf61e73a8af0-38bed0b4ad5mr2928565637.14.1768402378210;
 Wed, 14 Jan 2026 06:52:58 -0800 (PST)
Date: Wed, 14 Jan 2026 14:52:41 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260114145243.3458315-1-lucaswei@google.com>
Subject: [PATCH v3] arm64: errata: Workaround for SI L1 downstream coherency issue
From: Lucas Wei <lucaswei@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Cc: sjadavani@google.com, Lucas Wei <lucaswei@google.com>, stable@vger.kernel.org, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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
    a clean or clean&invalidate by virtual address (DC CVAC or DC
    CIVAC), that hits on unique dirty data in the CPU or DSU cache.
    This results in a combined CopyBack and CMO being issued to the
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
cache data be cleaned to PoC. This way of implementation mitigates
performance penalty compared to purely duplicate original CMO.

Cc: stable@vger.kernel.org # 6.12.x
Signed-off-by: Lucas Wei <lucaswei@google.com>
---

Changes in v3:

 1. Fix typos
 2. Remove 'lkp@intel.com' from commit message
 3. Keep ARM within a single section
 4. Remove workaround of #4311569 from `cache_inval_poc()`

Changes in v2:

 1. Fixed warning from kernel test robot by changing
    arm_si_l1_workaround_4311569 to static
    [Reported-by: kernel test robot <lkp@intel.com>]

---
 Documentation/arch/arm64/silicon-errata.rst |  1 +
 arch/arm64/Kconfig                          | 19 +++++++++++++
 arch/arm64/include/asm/assembler.h          | 10 +++++++
 arch/arm64/kernel/cpu_errata.c              | 31 +++++++++++++++++++++
 arch/arm64/tools/cpucaps                    |  1 +
 5 files changed, 62 insertions(+)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index a7ec57060f64..4c300caad901 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -212,6 +212,7 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | GIC-700         | #2941627        | ARM64_ERRATUM_2941627       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | SI L1           | #4311569        | ARM64_ERRATUM_4311569       |
 +----------------+-----------------+-----------------+-----------------------------+
 | Broadcom       | Brahma-B53      | N/A             | ARM64_ERRATUM_845719        |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 93173f0a09c7..89326bb26f48 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1155,6 +1155,25 @@ config ARM64_ERRATUM_3194386
 
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
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 0fac75f01534..856b6cf6e71e 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -103,6 +103,7 @@ WORKAROUND_2077057
 WORKAROUND_2457168
 WORKAROUND_2645198
 WORKAROUND_2658417
+WORKAROUND_4311569
 WORKAROUND_AMPERE_AC03_CPU_38
 WORKAROUND_AMPERE_AC04_CPU_23
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE

base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
-- 
2.52.0.457.g6b5491de43-goog


