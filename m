Return-Path: <stable+bounces-165007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BC0B141B1
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 20:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5AA7B29EE
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED6A276048;
	Mon, 28 Jul 2025 17:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zOmHUxxF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91362798EB
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725454; cv=none; b=kuHXSx1FBMbBAqC4fo1LXXffB3Di2BpO8/dcp/O3b82Iqiqob4KUBQpoTUr47yb+zlKpEQJio5qV+fZngNlCATDAkI3K7nvH3o9y9C7J3uIfWi15UuEe4jQFjoRog7Yi5VY3mUJlAzg8miNr9pGlNg8AgcQ+A8oQFwodFbn9140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725454; c=relaxed/simple;
	bh=TSEnEl0+QhDhfaFEWzROPKcCxPx7IOub08n0hr3zb5o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hG5KXn8Dz8omb9fgrLwS7iVYLFvtLHq+xb1CNnNVySewe8hg407QowYN7UJZE/LGYpQmD6j9ODfywwHE04BGt0IaM5YzekUVjfe0mQ7WrJwMLGvWZzNpVQxxqI4AItPM2JturymSJs1AKSCg259oo4lk9URB80mahZgPO+mloI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zOmHUxxF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748f3613e6aso2844193b3a.0
        for <stable@vger.kernel.org>; Mon, 28 Jul 2025 10:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725452; x=1754330252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFFr0a5a6JVcSFFcNMO2C+sdF/Ncp3EFEZuTVp1RzBQ=;
        b=zOmHUxxF61cRIOkdRf7goe51u21x/M1XyPqK9CsvsIqzDWyZsVjI/Dk+zeIRDgEYrc
         Zcqrz1JcyCdb2hlcsrbX0lLDki1fdk8m2a5Cp5+m6BrDEWDXh7JPUPql5Cj+YSQEO795
         qbEIXRqUEOMhN0t8LmiSnk+JjU0s0SsYmz894RJyqOEzCLdXsb8OLfPFJtbUcPSwNbYZ
         pEu7enSZQVzjFAaRGe/X/mNx4uxMA07tBwcY/JzXCl526NPOMKBjPwtUfSpqoJky3vxf
         I8UhL39VHwWylUdgIxCGdxZP2f+XmdndCqPVyfXcXPWowRC/tzeMwWhSVtnGyTLgHDD0
         lSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725452; x=1754330252;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nFFr0a5a6JVcSFFcNMO2C+sdF/Ncp3EFEZuTVp1RzBQ=;
        b=sAavdXV3UWLYv3Vbu0FPWSnGzsLbtSsXMwYoJ7a8wlC14O9831EycLGWOmp3sO+QBI
         2JXFBocCVdd0xMrtOnHTwd9GwDS15k72pWvfZSXMMm58lFrsJWvBOydo34aVd7WyYmVI
         HRO1kQu39WSIqG8H8eOJbg0+so+hY0XrniGhXTq0S5alXacC4kuwQdehOnHyk5jRoPP3
         jBgLry7CoDfsycV4XlsNIPiYwR8VHLndAqzU5SXaCYx/IqL0wwMsYLb1KTdsYRXaugyC
         s7PqueeIxQx0+cx0Fg+dV+19pHQyWXVDxvv3spMTjuMzpa7KckZ0QmHQnnQlhNjcFqfH
         0chw==
X-Gm-Message-State: AOJu0Yyi6FQEE21DJVWF5vM34AwnfPgPyZ/tczdDPAFTs2FHf7EP9J8h
	DdyloFEVsZwZFME4cieibAo7HImT+yxyZ8F8iJT23gqhT59cS5a5r15Libicn/TmIuMB8gJnTy2
	TjCAeXvqboJOCb+mHxPywTnyjM7D//yNU4gWpsVH8GDyH0tRydvEuGrgwsnj5yAPEs/rvCnKI0x
	axUs2hpsqoEt1/I4WwLBu+eLnvX0ZP/M9BxsHcp46+cGgNAs/sGZH8
X-Google-Smtp-Source: AGHT+IHYSpOHPE+9CRJorizXj3AOsW46V54Gxu47bg/9WXkJwfAm8rzAynjD0Aaoh3VAHel3eivZH1h41DQg5LE=
X-Received: from pggg19.prod.google.com ([2002:a63:2013:0:b0:b2f:64d0:993e])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7488:b0:215:eafc:abd9 with SMTP id adf61e73a8af0-23d700e9754mr22446878637.14.1753725452032;
 Mon, 28 Jul 2025 10:57:32 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:56:58 +0000
In-Reply-To: <20250728175701.3286764-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com> <20250728175701.3286764-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175701.3286764-6-jtoantran@google.com>
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


