Return-Path: <stable+bounces-78391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB198B91D
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A49F1C21E3B
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921B3192D74;
	Tue,  1 Oct 2024 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bc/z7ZTu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353F3209
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777831; cv=none; b=lSxgH+bGvQuqsck7yPP97UY4LwDdwB2ZC+XDPq3tSRMxUielnKE+LSIzQIzRz6UFbxbOyG93R7Wz230ZuPqhAV9ylZeg0qNq/1EnAsPm+GvEUPVeRm4dtO36Vuo6P7a3yOy/+x8nmUPuw9T/nRh610BV3G9ahoOiADuTiiPBo+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777831; c=relaxed/simple;
	bh=nFyreWwkpTCitW00lAWZ7+flUOGHO06GNUZITAjg/7k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e3ojrpTToxJ6FY8ds4PTZ4sHQBT+FQHjXg1QMaxZYbkM6JNghQYpyxBgJ8vSoo2McosS2+LpcG9ACVkuP35Wtq3KY/yGyIgJTyfg537cexvHUwrHdas1yLng6cGhDVBjc4s7Gx7y/sRRQ7LY8yESMhl2I4HZLl30JZ1gDpr5aec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bc/z7ZTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8294EC4CEC6;
	Tue,  1 Oct 2024 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727777830;
	bh=nFyreWwkpTCitW00lAWZ7+flUOGHO06GNUZITAjg/7k=;
	h=Subject:To:Cc:From:Date:From;
	b=Bc/z7ZTu1dLM/x5SK/hrFuai+vVzqGRfl0CbWzRqLQ2fBIZEsl4qCXbDDWA/mF10d
	 0jXMh1mTP9BPca6saQ2ok47IzDjH0jWwnXxJrWCA8vKTq8Q/WQAHLaHW4Eo36OxvOV
	 QDEii8qNI9NhlVPJlWCcRxsRfu5NRzpc79WRHfbc=
Subject: FAILED: patch "[PATCH] powerpc/atomic: Use YZ constraints for DS-form instructions" failed to apply to 6.1-stable tree
To: mpe@ellerman.id.au,almasrymina@google.com,segher@kernel.crashing.org,sfr@canb.auug.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:17:08 +0200
Message-ID: <2024100108-entail-slicing-6f85@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 39190ac7cff1fd15135fa8e658030d9646fdb5f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100108-entail-slicing-6f85@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

39190ac7cff1 ("powerpc/atomic: Use YZ constraints for DS-form instructions")
dc5dac748af9 ("powerpc/64: Add support to build with prefixed instructions")
5017b4594672 ("powerpc/64: Option to build big-endian with ELFv2 ABI")

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


