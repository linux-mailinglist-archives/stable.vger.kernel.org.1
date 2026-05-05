Return-Path: <stable+bounces-244038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK12Kzu9+WnxCwMAu9opvQ
	(envelope-from <stable+bounces-244038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:49:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9FF4CA1E6
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D24F830022FC
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 09:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619DC2EB859;
	Tue,  5 May 2026 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufkoobD2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422118BC3B
	for <stable@vger.kernel.org>; Tue,  5 May 2026 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974585; cv=none; b=SECRpxpqD/KVM9HyWjjtBlNfaf/yb88TmyDzzXhHCMvUgpsKihdaF1zTqqeMD7shC2H5ewL5gw+0nWa/8xmKtmB6rOC95GkL+8ey0MCOccwVySYtU6FXx256WIOHw6wQOuCz+qgjXUp7cnuyrS4e8DBxnmjO1Q7QM8LOIPwTSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974585; c=relaxed/simple;
	bh=6hLQRUm4eGPOq5M4sXnZtORiqpLNVMSc4NA9wDrmxwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHR8h59myQrgrjPGYp3F/isfSkKSSOmkpMxhzWZEow+HyDDl4QbKVn8Hnub5SRS7iDpfSUfhBDgwmT6BeXsjyKyhZCPA1/bfLt6F3m0PPlzbCqWgFQYT2KdyWm27tEOvePMC5EWe6cgLFgjRRQJaFEXmrhlsC6yQsL7xINxs85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufkoobD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7265BC2BCB4;
	Tue,  5 May 2026 09:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777974584;
	bh=6hLQRUm4eGPOq5M4sXnZtORiqpLNVMSc4NA9wDrmxwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufkoobD2+nElWmHFAoGIAR6+NtgPTdEcc0ECBheWhOsyxHRQ5DzBQfHEL0XEVqdW3
	 rmYrK6j3NDEJqszI26IVfD0Lq3ShQmcDd3cE1DAw3qtRj0UvaKZBw9+U2bnVtBZ2UJ
	 R+nASrxo2nzB7jSZZt2wXMMykbKbSA1iQP11YbtNTZl8cgQjS8+TSNGBZwtUbWgWkT
	 i67gcFD27wStxbfuv8T1XX3lAjuCa2bJ8i6GJRKj/EV+GeQN56Y9Rzzj/4R8zOjBvg
	 i+i5JSWGceRERJaweoAITeP6XR5cfEe2GpwP1cJn6/MYmiYA/GI9aTzVq5tafs3gc0
	 FpSp+ZIoPVEZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] randomize_kstack: Maintain kstack_offset per task
Date: Tue,  5 May 2026 05:49:40 -0400
Message-ID: <20260505094940.506135-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050350-sensation-oink-0da0@gregkh>
References: <2026050350-sensation-oink-0da0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D9FF4CA1E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244038-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email]

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
---
 include/linux/randomize_kstack.h | 44 ++++++++++++++++++++++++++------
 include/linux/sched.h            |  4 +++
 init/main.c                      |  1 -
 kernel/fork.c                    |  2 ++
 4 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index 5d52d15faee0c..740e036199214 100644
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
diff --git a/include/linux/sched.h b/include/linux/sched.h
index cbf69d0d69521..450aacb94b8f2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1458,6 +1458,10 @@ struct task_struct {
 	unsigned long			prev_lowest_stack;
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
+	u32				kstack_offset;
+#endif
+
 #ifdef CONFIG_X86_MCE
 	void __user			*mce_vaddr;
 	__u64				mce_kflags;
diff --git a/init/main.c b/init/main.c
index 0b6071b26ccb6..4e9c76a0e5a47 100644
--- a/init/main.c
+++ b/init/main.c
@@ -882,7 +882,6 @@ static void __init mm_init(void)
 #ifdef CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 DEFINE_STATIC_KEY_MAYBE_RO(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
 			   randomize_kstack_offset);
-DEFINE_PER_CPU(u32, kstack_offset);
 
 static int __init early_randomize_kstack_offset(char *buf)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index e1b291e5e1038..56910ec56e50e 100644
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
@@ -2300,6 +2301,7 @@ static __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
+	random_kstack_task_init(p);
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
-- 
2.53.0


