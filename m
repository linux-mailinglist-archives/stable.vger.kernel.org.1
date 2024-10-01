Return-Path: <stable+bounces-78393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7FA98B920
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A3AB23D24
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF8C1A01CD;
	Tue,  1 Oct 2024 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZQSZLBSD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9BF19CC2D
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777837; cv=none; b=gbkpp9TUQoTt8/ZKBmqGLUOU5W6np9H8w5QfIIpL9FcrUhVOJvBniGZ70UNygj1+QByo07Oimr3Tbu3JQutnfhtVmRv/Bz+G9hJmJyPj/zfgV8CDQ7QEDdLiVHrYd0DnSfw6Hj0I4/YaTJKpeZZw0ojmIZLEoshzWSyY1XOffXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777837; c=relaxed/simple;
	bh=OApO0Wb3Qfl1AUn7/5D4DbPK6EMCo+i1jelYJNNsOok=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GjGryyLZDc8BfxqGsG/X+gxeEXTuswfNJGV5db46yyWsYwgEw0fP0axhy9bvCcM2l2oiLnMvoZnM3sY0oPAHiYwZ3YHnAHsYHGpWbEs+HBuTWoTBIutdQJn/P777j2vE+ym2li4IgXtIJY+ZD8irW4YyDJS4I+b1KWfL3e3UCCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZQSZLBSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63B8C4CEC6;
	Tue,  1 Oct 2024 10:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727777837;
	bh=OApO0Wb3Qfl1AUn7/5D4DbPK6EMCo+i1jelYJNNsOok=;
	h=Subject:To:Cc:From:Date:From;
	b=ZQSZLBSDf0hdjIc7ZtQ+HpxQtO7NEr14MjNr4QWZNuKZH9czfNRH9CMaDNFGFaQ6i
	 zXGtuP34GF5xyFc8dMoeKt906vJ+44bKYaeLJVXXHEkbtnS1CIjdbnuAzgeZ6A32HF
	 8sJvLZ9tctg5HXaHa4ojC7W6ZySyaPjNEIK7QEpU=
Subject: FAILED: patch "[PATCH] powerpc/atomic: Use YZ constraints for DS-form instructions" failed to apply to 5.10-stable tree
To: mpe@ellerman.id.au,almasrymina@google.com,segher@kernel.crashing.org,sfr@canb.auug.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:17:10 +0200
Message-ID: <2024100110-reselect-handpick-cfd6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 39190ac7cff1fd15135fa8e658030d9646fdb5f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100110-reselect-handpick-cfd6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

39190ac7cff1 ("powerpc/atomic: Use YZ constraints for DS-form instructions")
dc5dac748af9 ("powerpc/64: Add support to build with prefixed instructions")
5017b4594672 ("powerpc/64: Option to build big-endian with ELFv2 ABI")
4b2a9315f20d ("powerpc/64s: POWER10 CPU Kconfig build option")
ff27d9200a98 ("powerpc/405: Fix build failure with GCC 12 (unrecognized opcode: `wrteei')")
446cda1b21d9 ("powerpc/32: Don't always pass -mcpu=powerpc to the compiler")
661aa880398a ("powerpc: Add CONFIG_PPC64_ELF_ABI_V1 and CONFIG_PPC64_ELF_ABI_V2")
dede19be5163 ("powerpc: Remove CONFIG_PPC_HAVE_KUAP and CONFIG_PPC_HAVE_KUEP")
fcf9bb6d32f8 ("powerpc/kuap: Wire-up KUAP on 40x")
25ae981fafaa ("powerpc/nohash: Move setup_kuap out of 8xx.c")
6754862249d3 ("powerpc/kuep: Remove 'nosmep' boot time parameter except for book3s/64")
70428da94c7a ("powerpc/32s: Save content of sr0 to avoid 'mfsr'")
526d4a4c77ae ("powerpc/32s: Do kuep_lock() and kuep_unlock() in assembly")
df415cd75826 ("powerpc/32s: Remove capability to disable KUEP at boottime")
dc3a0e5b83a8 ("powerpc/book3e: Activate KUEP at all time")
ee2631603fdb ("powerpc/44x: Activate KUEP at all time")
13dac4e31e75 ("powerpc/8xx: Activate KUEP at all time")
6c1fa60d368e ("Revert "powerpc: Inline setup_kup()"")
c28573744b74 ("powerpc/64s: Make hash MMU support configurable")
7ebc49031d04 ("powerpc: Rename PPC_NATIVE to PPC_HASH_MMU_NATIVE")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 39190ac7cff1fd15135fa8e658030d9646fdb5f2 Mon Sep 17 00:00:00 2001
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 16 Sep 2024 22:05:10 +1000
Subject: [PATCH] powerpc/atomic: Use YZ constraints for DS-form instructions

The 'ld' and 'std' instructions require a 4-byte aligned displacement
because they are DS-form instructions. But the "m" asm constraint
doesn't enforce that.

That can lead to build errors if the compiler chooses a non-aligned
displacement, as seen with GCC 14:

  /tmp/ccuSzwiR.s: Assembler messages:
  /tmp/ccuSzwiR.s:2579: Error: operand out of domain (39 is not a multiple of 4)
  make[5]: *** [scripts/Makefile.build:229: net/core/page_pool.o] Error 1

Dumping the generated assembler shows:

  ld 8,39(8)       # MEM[(const struct atomic64_t *)_29].counter, t

Use the YZ constraints to tell the compiler either to generate a DS-form
displacement, or use an X-form instruction, either of which prevents the
build error.

See commit 2d43cc701b96 ("powerpc/uaccess: Fix build errors seen with
GCC 13/14") for more details on the constraint letters.

Fixes: 9f0cbea0d8cc ("[POWERPC] Implement atomic{, 64}_{read, write}() without volatile")
Cc: stable@vger.kernel.org # v2.6.24+
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20240913125302.0a06b4c7@canb.auug.org.au
Tested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240916120510.2017749-1-mpe@ellerman.id.au

diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index b0b209c1df50..f48e644900a2 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -37,6 +37,12 @@
 #define STDX_BE	stringify_in_c(stdbrx)
 #endif
 
+#ifdef CONFIG_CC_IS_CLANG
+#define DS_FORM_CONSTRAINT "Z<>"
+#else
+#define DS_FORM_CONSTRAINT "YZ<>"
+#endif
+
 #else /* 32-bit */
 
 /* operations for longs and pointers */
diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 5bf6a4d49268..d1ea554c33ed 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -11,6 +11,7 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 #include <asm/asm-const.h>
+#include <asm/asm-compat.h>
 
 /*
  * Since *_return_relaxed and {cmp}xchg_relaxed are implemented with
@@ -197,7 +198,7 @@ static __inline__ s64 arch_atomic64_read(const atomic64_t *v)
 	if (IS_ENABLED(CONFIG_PPC_KERNEL_PREFIXED))
 		__asm__ __volatile__("ld %0,0(%1)" : "=r"(t) : "b"(&v->counter));
 	else
-		__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : "m<>"(v->counter));
+		__asm__ __volatile__("ld%U1%X1 %0,%1" : "=r"(t) : DS_FORM_CONSTRAINT (v->counter));
 
 	return t;
 }
@@ -208,7 +209,7 @@ static __inline__ void arch_atomic64_set(atomic64_t *v, s64 i)
 	if (IS_ENABLED(CONFIG_PPC_KERNEL_PREFIXED))
 		__asm__ __volatile__("std %1,0(%2)" : "=m"(v->counter) : "r"(i), "b"(&v->counter));
 	else
-		__asm__ __volatile__("std%U0%X0 %1,%0" : "=m<>"(v->counter) : "r"(i));
+		__asm__ __volatile__("std%U0%X0 %1,%0" : "=" DS_FORM_CONSTRAINT (v->counter) : "r"(i));
 }
 
 #define ATOMIC64_OP(op, asm_op)						\
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index fd594bf6c6a9..4f5a46a77fa2 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -6,6 +6,7 @@
 #include <asm/page.h>
 #include <asm/extable.h>
 #include <asm/kup.h>
+#include <asm/asm-compat.h>
 
 #ifdef __powerpc64__
 /* We use TASK_SIZE_USER64 as TASK_SIZE is not constant */
@@ -92,12 +93,6 @@ __pu_failed:							\
 		: label)
 #endif
 
-#ifdef CONFIG_CC_IS_CLANG
-#define DS_FORM_CONSTRAINT "Z<>"
-#else
-#define DS_FORM_CONSTRAINT "YZ<>"
-#endif
-
 #ifdef __powerpc64__
 #ifdef CONFIG_PPC_KERNEL_PREFIXED
 #define __put_user_asm2_goto(x, ptr, label)			\


