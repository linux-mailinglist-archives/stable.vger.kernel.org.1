Return-Path: <stable+bounces-166724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4B2B1C9AC
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAD318C243B
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0863A22F767;
	Wed,  6 Aug 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAOm5j8C"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3614A289369
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497219; cv=none; b=AyE8ukk2ENuNPuI/HPFzFdXOeQ4WnV2kJj61Z6HNYTkQ/SWVmR93EuQ3uQ3rcmH9WJOkMbW/uIseyVlW+uWcKzC/Apo6mc3nWLGLsA5EsevmlCOQY63R9GYrTlAXXSiZ3hM1VSfBw3T0wO6lvzPblH1Zrd/m3lz36fIAKVIDYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497219; c=relaxed/simple;
	bh=TSEnEl0+QhDhfaFEWzROPKcCxPx7IOub08n0hr3zb5o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mPrEIEtAiF0KvgYTXIeSDmEE+hrJYjiuGskqj3G0Km0TWV2H/7vg266g5lfVmzasCwznyMmc9wJzGi+jSlfQviwOJJKrzRlH1wpyRjM8BcqHxuDKMGN2vwqVr5EDW2aV72N5pAuiQ38RiZoctzf6/fi+rTyRW0bjDpGG2DqSb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAOm5j8C; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f74a64da9so115118a91.2
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754497216; x=1755102016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFFr0a5a6JVcSFFcNMO2C+sdF/Ncp3EFEZuTVp1RzBQ=;
        b=eAOm5j8CuX/j7HWttTn2vnyBck5VBqJCcAK49IHgu1Gf0i7M3PKXeJ5/Twuc8tm82B
         xdx9wC0pEKSsGlLPlDAMYb+cWeJDGwW85A3Ohhlg1LOGZNusbgk2SGgFZR8Wlph9lNrJ
         IDcXv+JMpDSr4O6HAhPIA+b4dYw2uEMTr6vyZgsDRSt5gq8bOyvmlXX7oZb7TAeEOAIB
         qcue1GFQ8TakbCqJ/Me+7ZWe/b1CMa0BaaRj3PW5EcUYE100KxT6YRT75APBF3lFS9FL
         +Mp+WyuRqQ8E/WoDu8fq8pACumuL7JtSPP0SyYBaLes5ENVNLIkii/WDr64FicdL/LJq
         YypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754497216; x=1755102016;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nFFr0a5a6JVcSFFcNMO2C+sdF/Ncp3EFEZuTVp1RzBQ=;
        b=o5WMMtrndvLAQv8pLCu/BzgHqjIiLGW2HDkrEWDwI2GUGJ3EjlNpBvLVyLLeWT1Alw
         mqpJdN05Co5LQr0i4VvEEoi3XvwOdkZ3rm3Gs1SROe3dM+vtKT2qWTlkIX/R2+CaDgJ+
         TOcJl/ipOoy49vDrfeAssYY9jSG7HO/gczGjURcP4pdB0VtNIUzCuoRbDzEeVpud02WR
         gn24no4NPeBB6HumdntXfgN88dHcFKtYiMZNGWO5LvJeEmoyxbgxSdta6g0VfcAMn+bq
         iQKnKfPZIgJzBuB6gYQx7BBxs+3l6N1CMRcSoN1qgMrEp7+ygNwl6n+a9n+J1zN/Yph9
         EzwQ==
X-Gm-Message-State: AOJu0YwebgWrN2MvFeCiYIRzAl8hVUzDDxA+snSQD2BG6jQqdWf6btjT
	Qf3lH2C0HYHMB4U/rMJ8kScBoRozQk5iJu2nPhyzFgcEmXEBTXqU4YXDQWiXi2MWrFGEo/rHbXs
	zbwPWyGynaICFEiiERWTmGSTuVQ/GE5hGnUyyGS9gtfNMQJn4/fob41T05+ghoFIH4X/oNbyRoJ
	Wf5PrCvyP3YNZ2WXMDtgzvzIa468iy6skoQAQmInSSZZYkAUA1LCu5
X-Google-Smtp-Source: AGHT+IEXex2wD/m88zQaxl3Qeelw4Pvp3EpaXcPKJ45uXIX5qIYvf/bprgElBB8QxRstfEtRbBEMbOAtPyA14aQ=
X-Received: from pjzd15.prod.google.com ([2002:a17:90a:e28f:b0:312:151d:c818])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1dca:b0:312:26d9:d5a7 with SMTP id 98e67ed59e1d1-32166c97b07mr4062803a91.20.1754497216395;
 Wed, 06 Aug 2025 09:20:16 -0700 (PDT)
Date: Wed,  6 Aug 2025 16:20:01 +0000
In-Reply-To: <20250806162003.1134886-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806162003.1134886-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806162003.1134886-6-jtoantran@google.com>
Subject: [PATCH v2 5/7] x86: fix user address masking non-canonical
 speculation issue
From: Jimmy Tran <jtoantran@google.com>
To: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	David Laight <david.laight@aculab.com>, Andrei Vagin <avagin@gmail.com>, 
	Jimmy Tran <jtoantran@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 86e6b1547b3d013bc392adf775b89318441403c2 upstream.

It turns out that AMD has a "Meltdown Lite(tm)" issue with non-canonical
accesses in kernel space.  And so using just the high bit to decide
whether an access is in user space or kernel space ends up with the good
old "leak speculative data" if you have the right gadget using the
result:

  CVE-2020-12965 =E2=80=9CTransient Execution of Non-Canonical Accesses=E2=
=80=9C

Now, the kernel surrounds the access with a STAC/CLAC pair, and those
instructions end up serializing execution on older Zen architectures,
which closes the speculation window.

But that was true only up until Zen 5, which renames the AC bit [1].
That improves performance of STAC/CLAC a lot, but also means that the
speculation window is now open.

Note that this affects not just the new address masking, but also the
regular valid_user_address() check used by access_ok(), and the asm
version of the sign bit check in the get_user() helpers.

It does not affect put_user() or clear_user() variants, since there's no
speculative result to be used in a gadget for those operations.

Link: https://lore.kernel.org/all/80d94591-1297-4afb-b510-c665efd37f10@citr=
ix.com/
Link: https://lore.kernel.org/all/20241023094448.GAZxjFkEOOF_DM83TQ@fat_cra=
te.local/ [1]
Link: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-101=
0.html
Link: https://arxiv.org/pdf/2108.10771
Cc: <stable@vger.kernel.org> # 6.10.x: e60cc61: vfs: dcache: move hashlen_h=
ash() from callers into d_hash()
Cc: <stable@vger.kernel.org> # 6.10.x: e782985: runtime constants:=C2=A0add=
 default dummy infrastructure
Cc: <stable@vger.kernel.org> # 6.10.x: e3c92e8: runtime constants: add x86 =
architecture support
Fixes: 2865baf54077 ("x86: support user address masking instead of non-spec=
ulative conditional")
Fixes: 6014bc27561f ("x86-64: make access_ok() independent of LAM")
Fixes: b19b74bc99b1 ("x86/mm: Rework address range check in get_user() and =
put_user()")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jimmy Tran <jtoantran@google.com>
---
 arch/x86/include/asm/uaccess_64.h | 45 ++++++++++++++++++++-----------
 arch/x86/kernel/cpu/common.c      | 10 +++++++
 arch/x86/kernel/vmlinux.lds.S     |  1 +
 arch/x86/lib/getuser.S            |  9 +++++--
 4 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uacce=
ss_64.h
index f2c02e4469ccc..e68eded5ee490 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -11,6 +11,13 @@
 #include <asm/alternative.h>
 #include <asm/cpufeatures.h>
 #include <asm/page.h>
+#include <asm/runtime-const.h>
+
+/*
+ * Virtual variable: there's no actual backing store for this,
+ * it can purely be used as 'runtime_const_ptr(USER_PTR_MAX)'
+ */
+extern unsigned long USER_PTR_MAX;
=20
 #ifdef CONFIG_ADDRESS_MASKING
 /*
@@ -49,35 +56,41 @@ static inline unsigned long __untagged_addr_remote(stru=
ct mm_struct *mm,
=20
 #endif
=20
+#define valid_user_address(x) \
+	((__force unsigned long)(x) <=3D runtime_const_ptr(USER_PTR_MAX))
+
 /*
- * The virtual address space space is logically divided into a kernel
- * half and a user half.  When cast to a signed type, user pointers
- * are positive and kernel pointers are negative.
+ * Masking the user address is an alternative to a conditional
+ * user_access_begin that can avoid the fencing. This only works
+ * for dense accesses starting at the address.
  */
-#define valid_user_address(x) ((long)(x) >=3D 0)
+static inline void __user *mask_user_address(const void __user *ptr)
+{
+	unsigned long mask;
+
+	asm("cmp %1,%0\n\t"
+	    "sbb %0,%0"
+		 : "=3Dr" (mask)
+		 : "r" (ptr),
+		 "0" (runtime_const_ptr(USER_PTR_MAX)));
+	return (__force void __user *)(mask | (__force unsigned long)ptr);
+}
=20
 /*
  * User pointers can have tag bits on x86-64.  This scheme tolerates
  * arbitrary values in those bits rather then masking them off.
  *
  * Enforce two rules:
- * 1. 'ptr' must be in the user half of the address space
+ * 1. 'ptr' must be in the user part of the address space
  * 2. 'ptr+size' must not overflow into kernel addresses
  *
- * Note that addresses around the sign change are not valid addresses,
- * and will GP-fault even with LAM enabled if the sign bit is set (see
- * "CR3.LAM_SUP" that can narrow the canonicality check if we ever
- * enable it, but not remove it entirely).
- *
- * So the "overflow into kernel addresses" does not imply some sudden
- * exact boundary at the sign bit, and we can allow a lot of slop on the
- * size check.
+ * Note that we always have at least one guard page between the
+ * max user address and the non-canonical gap, allowing us to
+ * ignore small sizes entirely.
  *
  * In fact, we could probably remove the size check entirely, since
  * any kernel accesses will be in increasing address order starting
- * at 'ptr', and even if the end might be in kernel space, we'll
- * hit the GP faults for non-canonical accesses before we ever get
- * there.
+ * at 'ptr'.
  *
  * That's a separate optimization, for now just handle the small
  * constant case.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f66c71bffa6d9..2369e85055c0e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -65,6 +65,7 @@
 #include <asm/set_memory.h>
 #include <asm/traps.h>
 #include <asm/sev.h>
+#include <asm/runtime-const.h>
=20
 #include "cpu.h"
=20
@@ -2490,6 +2491,15 @@ void __init arch_cpu_finalize_init(void)
 	alternative_instructions();
=20
 	if (IS_ENABLED(CONFIG_X86_64)) {
+		unsigned long USER_PTR_MAX =3D TASK_SIZE_MAX-1;
+
+		/*
+		 * Enable this when LAM is gated on LASS support
+		if (cpu_feature_enabled(X86_FEATURE_LAM))
+			USER_PTR_MAX =3D (1ul << 63) - PAGE_SIZE - 1;
+		 */
+		runtime_const_init(ptr, USER_PTR_MAX);
+
 		/*
 		 * Make sure the first 2MB area is not mapped by huge pages
 		 * There are typically fixed size MTRRs in there and overlapping
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index cb5b41480a848..a698819fd5d5f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -373,6 +373,7 @@ SECTIONS
=20
 	RUNTIME_CONST(shift, d_hash_shift)
 	RUNTIME_CONST(ptr, dentry_hashtable)
+	RUNTIME_CONST(ptr, USER_PTR_MAX)
=20
 	. =3D ALIGN(PAGE_SIZE);
=20
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 6913fbce6544f..ffa3fff259578 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -39,8 +39,13 @@
=20
 .macro check_range size:req
 .if IS_ENABLED(CONFIG_X86_64)
-	mov %rax, %rdx
-	sar $63, %rdx
+	movq $0x0123456789abcdef,%rdx
+  1:
+  .pushsection runtime_ptr_USER_PTR_MAX,"a"
+	.long 1b - 8 - .
+  .popsection
+	cmp %rax, %rdx
+	sbb %rdx, %rdx
 	or %rdx, %rax
 .else
 	cmp $TASK_SIZE_MAX-\size+1, %eax
--=20
2.50.1.470.g6ba607880d-goog


