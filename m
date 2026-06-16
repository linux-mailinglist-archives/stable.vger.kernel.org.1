Return-Path: <stable+bounces-266074-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BFuNOvWVMWrznQUAu9opvQ
	(envelope-from <stable+bounces-266074-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:29:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 866616942B7
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:29:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=z1zcHoyl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266074-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266074-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69962309E76C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF621466B5E;
	Tue, 16 Jun 2026 18:28:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D847A0D4;
	Tue, 16 Jun 2026 18:28:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634523; cv=none; b=mWmTg+v2WyeCZcvgA9tCsLJl53SVWc5C2r+4fq+MUoNRKMX0/06OqXGGjZIN22GCugMLMFVJifiqYLZmInvUPL/pnZsNbkoFyicmtnQrQhBzXbomBXXjJ1rk1fs89/+UkuAU/Zp8tP3fUeRa6d/aGUwKiRKBBpcAYFGLunuSHmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634523; c=relaxed/simple;
	bh=4r3o1CTV3Mqq3NyKVTafoQUvlEEbcUD6pf/+wVAIkk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbC8mZ5p+1Lpky88VTTipPcbsvJ9kwvgC8viL7YG9gR4/5/BkjExUIvZedu6SBxPXZ3mFOqW2TaYXvmm0uN8slsxZ2EjjABjLuSy46zrJpzIv2s+jFRsmldAyue2UCWZ6Fz6oyUPZViE/nW40oz10IZYGaJj0aVGtEwfjTxl3pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z1zcHoyl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE1B1F000E9;
	Tue, 16 Jun 2026 18:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634522;
	bh=uyZPzpr+FkyGubVmzrtPl/QZf12N1ZmLm86dvvwVDAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=z1zcHoylRo/fHn+QcITb1iu47mKJb2ldud0CNdtOV+1EPWR9VFYhaxrfBDfONtJKp
	 l0waLq9R3s8QXDH7F6OhepYezGK/tENKzB7maOlkJ6Ke0wU9IEwcwfLagOadnSl3h+
	 uwS1oPSbYFM9q3qr4RxCKlXig1vpCSNCI6Lx/glk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 281/411] randomize_kstack: Maintain kstack_offset per task
Date: Tue, 16 Jun 2026 20:28:39 +0530
Message-ID: <20260616145116.083461501@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266074-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mark.rutland@arm.com,m:ryan.roberts@arm.com,m:kees@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,arm.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 866616942B7

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryan Roberts <ryan.roberts@arm.com>

[ Upstream commit 37beb42560165869838e7d91724f3e629db64129 ]

kstack_offset was previously maintained per-cpu, but this caused a
couple of issues. So let's instead make it per-task.

Issue 1: add_random_kstack_offset() and choose_random_kstack_offset()
expected and required to be called with interrupts and preemption
disabled so that it could manipulate per-cpu state. But arm64, loongarch
and risc-v are calling them with interrupts and preemption enabled. I
don't _think_ this causes any functional issues, but it's certainly
unexpected and could lead to manipulating the wrong cpu's state, which
could cause a minor performance degradation due to bouncing the cache
lines. By maintaining the state per-task those functions can safely be
called in preemptible context.

Issue 2: add_random_kstack_offset() is called before executing the
syscall and expands the stack using a previously chosen random offset.
choose_random_kstack_offset() is called after executing the syscall and
chooses and stores a new random offset for the next syscall. With
per-cpu storage for this offset, an attacker could force cpu migration
during the execution of the syscall and prevent the offset from being
updated for the original cpu such that it is predictable for the next
syscall on that cpu. By maintaining the state per-task, this problem
goes away because the per-task random offset is updated after the
syscall regardless of which cpu it is executing on.

Fixes: 39218ff4c625 ("stack: Optionally randomize kernel stack offset each syscall")
Closes: https://lore.kernel.org/all/dd8c37bc-795f-4c7a-9086-69e584d8ab24@arm.com/
Cc: stable@vger.kernel.org
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Link: https://patch.msgid.link/20260303150840.3789438-2-ryan.roberts@arm.com
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/randomize_kstack.h |   44 +++++++++++++++++++++++++++++++--------
 include/linux/sched.h            |    4 +++
 init/main.c                      |    1 
 kernel/fork.c                    |    2 +
 4 files changed, 42 insertions(+), 9 deletions(-)

--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -8,7 +8,6 @@
 
 DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
 			 randomize_kstack_offset);
-DECLARE_PER_CPU(u32, kstack_offset);
 
 /*
  * Do not use this anywhere else in the kernel. This is used here because
@@ -39,28 +38,57 @@ DECLARE_PER_CPU(u32, kstack_offset);
  */
 #define KSTACK_OFFSET_MAX(x)	((x) & 0x3FF)
 
-/*
- * These macros must be used during syscall entry when interrupts and
- * preempt are disabled, and after user registers have been stored to
- * the stack.
+/**
+ * add_random_kstack_offset - Increase stack utilization by previously
+ *			      chosen random offset
+ *
+ * This should be used in the syscall entry path after user registers have been
+ * stored to the stack. Preemption may be enabled. For testing the resulting
+ * entropy, please see: tools/testing/selftests/lkdtm/stack-entropy.sh
  */
 #define add_random_kstack_offset() do {					\
 	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
 				&randomize_kstack_offset)) {		\
-		u32 offset = raw_cpu_read(kstack_offset);		\
+		u32 offset = current->kstack_offset;			\
 		u8 *ptr = __kstack_alloca(KSTACK_OFFSET_MAX(offset));	\
 		/* Keep allocation even after "ptr" loses scope. */	\
 		asm volatile("" :: "r"(ptr) : "memory");		\
 	}								\
 } while (0)
 
+/**
+ * choose_random_kstack_offset - Choose the random offset for the next
+ *				 add_random_kstack_offset()
+ *
+ * This should only be used during syscall exit. Preemption may be enabled. This
+ * position in the syscall flow is done to frustrate attacks from userspace
+ * attempting to learn the next offset:
+ * - Maximize the timing uncertainty visible from userspace: if the
+ *   offset is chosen at syscall entry, userspace has much more control
+ *   over the timing between choosing offsets. "How long will we be in
+ *   kernel mode?" tends to be more difficult to predict than "how long
+ *   will we be in user mode?"
+ * - Reduce the lifetime of the new offset sitting in memory during
+ *   kernel mode execution. Exposure of "thread-local" memory content
+ *   (e.g. current, percpu, etc) tends to be easier than arbitrary
+ *   location memory exposure.
+ */
 #define choose_random_kstack_offset(rand) do {				\
 	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
 				&randomize_kstack_offset)) {		\
-		u32 offset = raw_cpu_read(kstack_offset);		\
+		u32 offset = current->kstack_offset;			\
 		offset = ror32(offset, 5) ^ (rand);			\
-		raw_cpu_write(kstack_offset, offset);			\
+		current->kstack_offset = offset;			\
 	}								\
 } while (0)
 
+#ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
+static inline void random_kstack_task_init(struct task_struct *tsk)
+{
+	tsk->kstack_offset = 0;
+}
+#else
+#define random_kstack_task_init(tsk)		do { } while (0)
+#endif
+
 #endif
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1461,6 +1461,10 @@ struct task_struct {
 	unsigned long			prev_lowest_stack;
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
+	u32				kstack_offset;
+#endif
+
 #ifdef CONFIG_X86_MCE
 	void __user			*mce_vaddr;
 	__u64				mce_kflags;
--- a/init/main.c
+++ b/init/main.c
@@ -882,7 +882,6 @@ static void __init mm_init(void)
 #ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
 			   randomize_kstack_offset);
-DEFINE_PER_CPU(u32, kstack_offset);
 
 static int __init early_randomize_kstack_offset(char *buf)
 {
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -94,6 +94,7 @@
 #include <linux/thread_info.h>
 #include <linux/stackleak.h>
 #include <linux/kasan.h>
+#include <linux/randomize_kstack.h>
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
@@ -2300,6 +2301,7 @@ static __latent_entropy struct task_stru
 	if (retval)
 		goto bad_fork_cleanup_io;
 
+	random_kstack_task_init(p);
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {



