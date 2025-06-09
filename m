Return-Path: <stable+bounces-152176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE23BAD2346
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 18:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C421611C3
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 16:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03F921883C;
	Mon,  9 Jun 2025 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LoDOPAmZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AoXuzGaO"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36C21772D;
	Mon,  9 Jun 2025 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485140; cv=none; b=N4LNQx1Rg355JfANKUBsM+BapNNC/7ldqjPupeGYNXGO0JOBBCqwv4usUepVKV0b6ATzgJ4XiGkr4AUWs1vFRYTRBsxu6Rn1rFy9IyUxoUR+9ZEcr5qWrEH8sh6gsxZnxsvsl70hkz7kgdlZwgLRiX2spozPdxwvn2wj8hGAHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485140; c=relaxed/simple;
	bh=EbXs/sTXohTOmm5TviWh0AY2Db3a+7Ly6XibFjFL/uw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=L5PD8mKNZSRrJOvhQLprqX42h6s0zd9dYHZPArzhUGpgwkLJTscNKdTnhIp85sAQ4Q4fBoK6r54FWEP8xsHvPHOj2BjuPISAVDmS9DyW9Nqmqpf4Q5SZGsa9dpIlqnEeaMs585nLKxrne7TGcK5lmzohGYOjm/lkPs/hnXkuE1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LoDOPAmZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AoXuzGaO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Jun 2025 16:05:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749485135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tEEOXCCi+Lv4AkHLOs5bdAb1O3Dv/w8kQoflgn+qaMg=;
	b=LoDOPAmZYpW6VAuBKNNTWydycSdx1aD3hlyIm0LSfHVE1jOjNJ3LAOPquwXTbwQYDAinAB
	nTnFBybszbs/9xdN7U00lq3Ey9qJLHOrox4fbujgj/Ofh9QEKgB2hcKwQdsHGpQVn2iGzs
	5zL5tZ0zjoYMhJi+9QkhGydGVYrqLkmHbG8l/S4OgVcjIHHcj/2Fs2w/6IF9jtMgffcL5C
	pzFUcp+UuKEPpLGz0xTg/nm6cwFEZHxUdLz4pUngterItu08Ncvakb0c5jvLjsWI/f7eaV
	a+KB0fCQMqK8OqcOe1V+OChMhym2tHNa214vi8kMK/8Vb+56CG9DhU2YaiwEpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749485135;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tEEOXCCi+Lv4AkHLOs5bdAb1O3Dv/w8kQoflgn+qaMg=;
	b=AoXuzGaORYPmwMsKNIoUGGCH9o1yJhK51101CDZgFg8tWsEhqObNkW7PZn1CNhG9MEadcI
	a2q5HKLls8Ze63BA==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] selftests/x86: Add a test to detect infinite
 SIGTRAP handler loop
Cc: "Xin Li (Intel)" <xin@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174948513461.406.11127170666315270934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f287822688eeb44ae1cf6ac45701d965efc33218
Gitweb:        https://git.kernel.org/tip/f287822688eeb44ae1cf6ac45701d965efc=
33218
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Mon, 09 Jun 2025 01:40:54 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 09 Jun 2025 08:52:06 -07:00

selftests/x86: Add a test to detect infinite SIGTRAP handler loop

When FRED is enabled, if the Trap Flag (TF) is set without an external
debugger attached, it can lead to an infinite loop in the SIGTRAP
handler.  To avoid this, the software event flag in the augmented SS
must be cleared, ensuring that no single-step trap remains pending when
ERETU completes.

This test checks for that specific scenario=E2=80=94verifying whether the ker=
nel
correctly prevents an infinite SIGTRAP loop in this edge case when FRED
is enabled.

The test should _always_ pass with IDT event delivery, thus no need to
disable the test even when FRED is not enabled.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250609084054.2083189-3-xin%40zytor.com
---
 tools/testing/selftests/x86/Makefile       |   2 +-
 tools/testing/selftests/x86/sigtrap_loop.c | 101 ++++++++++++++++++++-
 2 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/sigtrap_loop.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x=
86/Makefile
index f703fcf..8314887 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -12,7 +12,7 @@ CAN_BUILD_WITH_NOPIE :=3D $(shell ./check_cc.sh "$(CC)" tri=
vial_program.c -no-pie)
=20
 TARGETS_C_BOTHBITS :=3D single_step_syscall sysret_ss_attrs syscall_nt test_=
mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
-			test_vsyscall mov_ss_trap \
+			test_vsyscall mov_ss_trap sigtrap_loop \
 			syscall_arg_fault fsgsbase_restore sigaltstack
 TARGETS_C_BOTHBITS +=3D nx_stack
 TARGETS_C_32BIT_ONLY :=3D entry_from_vm86 test_syscall_vdso unwind_vdso \
diff --git a/tools/testing/selftests/x86/sigtrap_loop.c b/tools/testing/selft=
ests/x86/sigtrap_loop.c
new file mode 100644
index 0000000..9d06547
--- /dev/null
+++ b/tools/testing/selftests/x86/sigtrap_loop.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Intel Corporation
+ */
+#define _GNU_SOURCE
+
+#include <err.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ucontext.h>
+
+#ifdef __x86_64__
+# define REG_IP REG_RIP
+#else
+# define REG_IP REG_EIP
+#endif
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *), i=
nt flags)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction =3D handler;
+	sa.sa_flags =3D SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+
+	return;
+}
+
+static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
+{
+	ucontext_t *ctx =3D (ucontext_t *)ctx_void;
+	static unsigned int loop_count_on_same_ip;
+	static unsigned long last_trap_ip;
+
+	if (last_trap_ip =3D=3D ctx->uc_mcontext.gregs[REG_IP]) {
+		printf("\tTrapped at %016lx\n", last_trap_ip);
+
+		/*
+		 * If the same IP is hit more than 10 times in a row, it is
+		 * _considered_ an infinite loop.
+		 */
+		if (++loop_count_on_same_ip > 10) {
+			printf("[FAIL]\tDetected SIGTRAP infinite loop\n");
+			exit(1);
+		}
+
+		return;
+	}
+
+	loop_count_on_same_ip =3D 0;
+	last_trap_ip =3D ctx->uc_mcontext.gregs[REG_IP];
+	printf("\tTrapped at %016lx\n", last_trap_ip);
+}
+
+int main(int argc, char *argv[])
+{
+	sethandler(SIGTRAP, sigtrap, 0);
+
+	/*
+	 * Set the Trap Flag (TF) to single-step the test code, therefore to
+	 * trigger a SIGTRAP signal after each instruction until the TF is
+	 * cleared.
+	 *
+	 * Because the arithmetic flags are not significant here, the TF is
+	 * set by pushing 0x302 onto the stack and then popping it into the
+	 * flags register.
+	 *
+	 * Four instructions in the following asm code are executed with the
+	 * TF set, thus the SIGTRAP handler is expected to run four times.
+	 */
+	printf("[RUN]\tSIGTRAP infinite loop detection\n");
+	asm volatile(
+#ifdef __x86_64__
+		/*
+		 * Avoid clobbering the redzone
+		 *
+		 * Equivalent to "sub $128, %rsp", however -128 can be encoded
+		 * in a single byte immediate while 128 uses 4 bytes.
+		 */
+		"add $-128, %rsp\n\t"
+#endif
+		"push $0x302\n\t"
+		"popf\n\t"
+		"nop\n\t"
+		"nop\n\t"
+		"push $0x202\n\t"
+		"popf\n\t"
+#ifdef __x86_64__
+		"sub $-128, %rsp\n\t"
+#endif
+	);
+
+	printf("[OK]\tNo SIGTRAP infinite loop detected\n");
+	return 0;
+}

