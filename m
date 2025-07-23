Return-Path: <stable+bounces-164488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76242B0F82E
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FECB3AA6A0
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF13F1F4285;
	Wed, 23 Jul 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcK6/yF2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61A01F09A8
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288344; cv=none; b=vAZUfzm62UJ47WP50+MKX0Gv50cIDuDfFx6GoM6ceG+rKbjggx9qYcJQnkg7w2ILwe7w6bhL0lJiPF+RtZdWW4k7UiOUwZCngKTwrdyqLvavm8vClRjoOQGl5orjdgD3bCbx4nUqPZ6OtPItnzgvQoblcUK+Td2YIRZZ6hrvvEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288344; c=relaxed/simple;
	bh=EaKpJzuPs6YSr4mdGVDzlTCiKvQC/n61CzMWnnRU31U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PcL3v+03rL8nbjL5fctvJixeYDUqnxvyoT/lQHAQRuTtRkZ7h/q7J+Z7k79pmtESNrdhz3TrzDwS3AXn6pO+s7KyKE0rrAthC9tlEaWQr5dnJ9jhrTAT2qNJe4srbobfebgEPAs5ZcupJkJw4OAPUrc+lywkfcrR2ZZwNz83nJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcK6/yF2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jtoantran.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b00e4358a34so84844a12.0
        for <stable@vger.kernel.org>; Wed, 23 Jul 2025 09:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753288342; x=1753893142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruQZvoP36NReCywP77pX33DfJaa6kHZnAi/w4Za+39U=;
        b=dcK6/yF2tGSLptX0WqfOIQ8oVDV+xkoe2kV3arH+/fPThItvn1fNNQj0NsHkP0dCtg
         sAxe1LzGoQTjHGXsdYMDhxCwuGjH7NTnqxkz4Ya1Dr1bw0uLpiCzUqak0frJeRXC/CUS
         kz2uw9o/KyqY6lr486C0ivWLZU7Ix8pGLLC7qBCmm6pxoOD9uiFdU6/AIm/fAiRSC1gx
         4Yv+1l1rDfgb8n6FjjDY36Fe1RlAxLNLgRNwErUUIg3Rl+hlK3dpcV46i62/YfvXqPir
         aQVL+CLoW1gpdX3F2G8bwvsvIMXKgIq2IsmsU1xnFGLp1f1zaYjvEK9Nna+GHooQ+npJ
         Vgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288342; x=1753893142;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ruQZvoP36NReCywP77pX33DfJaa6kHZnAi/w4Za+39U=;
        b=R8dkckHyRGUrLYbpQ5gqX6XzoKdyUgsvSmBCNZDGTDI/AMEz01WNNmgwkBP9PUnrys
         1N0XX/xBI6sm5uOkLtNAxbHjuz2ZHevdUmm1EeXJd+mR/KQq26symc0E+uO5mfm7x0SK
         T2mMayyrPGmbTf0buinfSZq7w5DXDILJH5zI+2JM4I6CavqzoZ37FUSlGTV048z+AQnD
         Gc6uqIBxM9xKaBvpWPd/9zoI473TG/QstTIL2+ecAMTH8GfOuR701IQKOZJOp3LtVT5T
         /Xs0QBGzXuNDxEY6eCEfx47Bkh79UHJnFOHLZe1eCKLBvrYjSlHyd812xtINqPlMqy63
         7hfw==
X-Gm-Message-State: AOJu0Yy3hwrN/toSPrR/hE1fEJH0ZC8x2kOuOMkcB+sXbiLXJuhmyh4U
	EsGaPQDmJfFRds1yVMMK43I+9n8dWwQ05mIc0Zje5km0c/6MPMlnYk2X83D34oXrc7T3ENom9QH
	UTfgs2ByJa1UfrSzNUIV5ds3xqXKpfQn+yK6/BJ/AlYdIil1MH8olWD0IWTQrHXfOQDd4IhZA71
	fazi3zcFh2JmmLa5R35oBS+sZ8oJu/bjZOPSNHPB7xcEQ1X1U56rtw
X-Google-Smtp-Source: AGHT+IFVzBuNk3HGezGJuZyfLi3mb1ZhT5AEI8+RIIsWyzckO6EWUvZ8VU1bCc6JwDfG4Epo4AL4diUDxMoPg1Q=
X-Received: from pga13.prod.google.com ([2002:a05:6a02:4f8d:b0:b3b:cf3d:91f])
 (user=jtoantran job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a49:b0:222:d817:2f4a with SMTP id adf61e73a8af0-23d490405f0mr5685828637.17.1753288342056;
 Wed, 23 Jul 2025 09:32:22 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:32:08 +0000
In-Reply-To: <20250723163209.1929303-1-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723163209.1929303-1-jtoantran@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250723163209.1929303-6-jtoantran@google.com>
Subject: [PATCH v1 5/6] x86: fix user address masking non-canonical
 speculation issue
From: Jimmy Tran <jtoantran@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight@aculab.com>, x86@kernel.org, 
	Andrei Vagin <avagin@gmail.com>, Jimmy Tran <jtoantran@google.com>
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
2.50.0.727.gbf7dc18ff4-goog


