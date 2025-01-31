Return-Path: <stable+bounces-111794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E12A23C6B
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 11:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174A73A7378
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 10:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A861BC061;
	Fri, 31 Jan 2025 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b="Y+/onOgT"
X-Original-To: stable@vger.kernel.org
Received: from minute.unseen.parts (minute.unseen.parts [139.162.151.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457F1A08A8;
	Fri, 31 Jan 2025 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.151.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320107; cv=none; b=RNNNeOfEHtcK9+YOSXdC8KivIN0kHNWEAOVTZSwkdENY6KpVV6M7pVaoGxcgmjWAgd7RZKColW802QVs5z8RZxCBJH+UxcSbauiaOk/VzSEYrevAEs4+7ggOXiSOyL9t6G+uzoNlo1ucALO7z9JcWFnvR0DC70hVoxPJUhoicaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320107; c=relaxed/simple;
	bh=FvUcElkzZxWemXu8o2v6yzMjy18Dz06KV1AZW2e9Wwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n1BhOTvJNPZXQVetC5i9RjjPqjEYj2PBEMBLiHPBtyvYKVw47CKAds5BmqHzjr2jF8qxSHf3p0XbPhwBQvXQEuA1ypcogfNj0i5YX9qJKc9xFDAvWMHqHPbVObjPLoQnmeos5ihfhw9i2em6oyZHJhUgj+cs1GvgMOudDJA+luQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts; spf=pass smtp.mailfrom=unseen.parts; dkim=pass (2048-bit key) header.d=unseen.parts header.i=@unseen.parts header.b=Y+/onOgT; arc=none smtp.client-ip=139.162.151.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unseen.parts
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unseen.parts
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=unseen.parts; s=sig; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x70ymYXNjFz5gwuDFcplwidgQVEhIt9St3oi8cLdKS0=; b=Y+/onOgTePPnhq0d1ZoX7xg49r
	BmWhJVU0LlAs8CztfnHrBhnenCVVhCqYUGk8se899njn4d9i7V31kNpeQYtQjuKO/wPR9DgtL5u9h
	8tXatmafHh7RBtI2cF8a1OZJ9c0J4msowp8IQWkOSvF9SlEt0YJdhsusF8KeT5pMAwgsGSjT+ch9Q
	mLjSgbC6WaS7lFgbSdt7Qt7iT9XDKX/eWRCn5FsVIErPMM04XrXyETmkBZu3ebHCMn7FFz5kpJuaK
	orNwqWdtvE1vj1PiA/LqED9jtMoClJPA4Uwx0cK/p1K1KNctkkKzPvx3L/4SM6bZBvA9mathxRm0h
	U93Mybgg==;
Received: from ink by minute.unseen.parts with local (Exim 4.96)
	(envelope-from <ink@unseen.parts>)
	id 1tdoSo-0002sT-01;
	Fri, 31 Jan 2025 11:41:30 +0100
From: Ivan Kokshaysky <ink@unseen.parts>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Magnus Lindholm <linmag7@gmail.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] alpha/uapi: do not expose kernel-only stack frame structures
Date: Fri, 31 Jan 2025 11:41:26 +0100
Message-Id: <20250131104129.11052-2-ink@unseen.parts>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250131104129.11052-1-ink@unseen.parts>
References: <20250131104129.11052-1-ink@unseen.parts>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parts of asm/ptrace.h went into UAPI with commit 96433f6ee490
("UAPI: (Scripted) Disintegrate arch/alpha/include/asm") back in 2012.
At first glance it looked correct, as many other architectures expose
'struct pt_regs' for ptrace(2) PTRACE_GETREGS/PTRACE_SETREGS requests
and bpf(2) BPF_PROG_TYPE_KPROBE/BPF_PROG_TYPE_PERF_EVENT program
types.

On Alpha, however, these requests have never been implemented;
'struct pt_regs' describes internal kernel stack frame which has
nothing to do with userspace. Same applies to 'struct switch_stack',
as PTRACE_GETFPREG/PTRACE_SETFPREG are not implemented either.

Move this stuff back into internal asm, where we can ajust it
without causing a lot of confusion about possible UAPI breakage.

Cc: stable@vger.kernel.org
Fixes: 96433f6ee490 ("UAPI: (Scripted) Disintegrate arch/alpha/include/asm")
Signed-off-by: Ivan Kokshaysky <ink@unseen.parts>
---
 arch/alpha/include/asm/ptrace.h      | 62 +++++++++++++++++++++++++-
 arch/alpha/include/uapi/asm/ptrace.h | 65 ++--------------------------
 2 files changed, 64 insertions(+), 63 deletions(-)

diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptrace.h
index 3557ce64ed21..693d4c5b4dc7 100644
--- a/arch/alpha/include/asm/ptrace.h
+++ b/arch/alpha/include/asm/ptrace.h
@@ -2,8 +2,68 @@
 #ifndef _ASMAXP_PTRACE_H
 #define _ASMAXP_PTRACE_H
 
-#include <uapi/asm/ptrace.h>
+/*
+ * This struct defines the way the registers are stored on the
+ * kernel stack during a system call or other kernel entry
+ *
+ * NOTE! I want to minimize the overhead of system calls, so this
+ * struct has as little information as possible. It does not have
+ *
+ *  - floating point regs: the kernel doesn't change those
+ *  - r9-15: saved by the C compiler
+ *
+ * This makes "fork()" and "exec()" a bit more complex, but should
+ * give us low system call latency.
+ */
 
+struct pt_regs {
+	unsigned long r0;
+	unsigned long r1;
+	unsigned long r2;
+	unsigned long r3;
+	unsigned long r4;
+	unsigned long r5;
+	unsigned long r6;
+	unsigned long r7;
+	unsigned long r8;
+	unsigned long r19;
+	unsigned long r20;
+	unsigned long r21;
+	unsigned long r22;
+	unsigned long r23;
+	unsigned long r24;
+	unsigned long r25;
+	unsigned long r26;
+	unsigned long r27;
+	unsigned long r28;
+	unsigned long hae;
+/* JRP - These are the values provided to a0-a2 by PALcode */
+	unsigned long trap_a0;
+	unsigned long trap_a1;
+	unsigned long trap_a2;
+/* These are saved by PAL-code: */
+	unsigned long ps;
+	unsigned long pc;
+	unsigned long gp;
+	unsigned long r16;
+	unsigned long r17;
+	unsigned long r18;
+};
+
+/*
+ * This is the extended stack used by signal handlers and the context
+ * switcher: it's pushed after the normal "struct pt_regs".
+ */
+struct switch_stack {
+	unsigned long r9;
+	unsigned long r10;
+	unsigned long r11;
+	unsigned long r12;
+	unsigned long r13;
+	unsigned long r14;
+	unsigned long r15;
+	unsigned long r26;
+};
 
 #define arch_has_single_step()		(1)
 #define user_mode(regs) (((regs)->ps & 8) != 0)
diff --git a/arch/alpha/include/uapi/asm/ptrace.h b/arch/alpha/include/uapi/asm/ptrace.h
index 5ca45934fcbb..ad55dc283d8d 100644
--- a/arch/alpha/include/uapi/asm/ptrace.h
+++ b/arch/alpha/include/uapi/asm/ptrace.h
@@ -2,72 +2,13 @@
 #ifndef _UAPI_ASMAXP_PTRACE_H
 #define _UAPI_ASMAXP_PTRACE_H
 
-
 /*
- * This struct defines the way the registers are stored on the
- * kernel stack during a system call or other kernel entry
- *
- * NOTE! I want to minimize the overhead of system calls, so this
- * struct has as little information as possible. It does not have
- *
- *  - floating point regs: the kernel doesn't change those
- *  - r9-15: saved by the C compiler
+ * We don't HAVE_REGS_AND_STACK_ACCESS_API.
  *
- * This makes "fork()" and "exec()" a bit more complex, but should
- * give us low system call latency.
+ * Provide empty pt_regs structure for libbpf and the likes
+ * to avoid breaking the compilation.
  */
-
 struct pt_regs {
-	unsigned long r0;
-	unsigned long r1;
-	unsigned long r2;
-	unsigned long r3;
-	unsigned long r4;
-	unsigned long r5;
-	unsigned long r6;
-	unsigned long r7;
-	unsigned long r8;
-	unsigned long r19;
-	unsigned long r20;
-	unsigned long r21;
-	unsigned long r22;
-	unsigned long r23;
-	unsigned long r24;
-	unsigned long r25;
-	unsigned long r26;
-	unsigned long r27;
-	unsigned long r28;
-	unsigned long hae;
-/* JRP - These are the values provided to a0-a2 by PALcode */
-	unsigned long trap_a0;
-	unsigned long trap_a1;
-	unsigned long trap_a2;
-/* These are saved by PAL-code: */
-	unsigned long ps;
-	unsigned long pc;
-	unsigned long gp;
-	unsigned long r16;
-	unsigned long r17;
-	unsigned long r18;
 };
 
-/*
- * This is the extended stack used by signal handlers and the context
- * switcher: it's pushed after the normal "struct pt_regs".
- */
-struct switch_stack {
-	unsigned long r9;
-	unsigned long r10;
-	unsigned long r11;
-	unsigned long r12;
-	unsigned long r13;
-	unsigned long r14;
-	unsigned long r15;
-	unsigned long r26;
-#ifndef __KERNEL__
-	unsigned long fp[32];	/* fp[31] is fpcr */
-#endif
-};
-
-
 #endif /* _UAPI_ASMAXP_PTRACE_H */
-- 
2.39.5


