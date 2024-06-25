Return-Path: <stable+bounces-55257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 329479162CD
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883C5289690
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BE91494CB;
	Tue, 25 Jun 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VeaS6iqU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020813D62A;
	Tue, 25 Jun 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308374; cv=none; b=HZPy9kbN6KSMBadLlms9kfM77jwaumRm6tHnRLNG3edhMuJp6ImRM0alMtVbnyfcMCfMmgdUJyHz8Bdyv9yy+JS3IzwQcbxG71eEx+I6D8mFwAyq5xWfr2tv0psLaSMDymeZASMiv02y5YSIpLP3pYri0AR0eJ8CUfaH6xyTi4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308374; c=relaxed/simple;
	bh=cnM/5CF2pkNNiQoxknq8K7ujfZDt44ECPLrmm1PyE6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYpgUyY8gYwoVg1MF8CKjWvbi7jqmZh+I+jmm7Uj5Vebrshw76WWMOte5yXmgy9I7T/19bmpqnPnwPjXP0kEk+c4OiBvMLGnW3p/TQaNJjMlGyA6PzWTd3FTOdGB2hA0Z60MzGrWJTk47h4AmLTILBJ74oO104Kj+VQwMRIiJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VeaS6iqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA90C32781;
	Tue, 25 Jun 2024 09:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308374;
	bh=cnM/5CF2pkNNiQoxknq8K7ujfZDt44ECPLrmm1PyE6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VeaS6iqUQ2lfGQMPRH+K9UL6ztzE8w8fTXAqpHhHadVPXdQiWCtVfwu/+uqL1nZTu
	 fhCZqNzxVzJW2v7w7UnFbS1xad9brccBSwGkKJmweE/fWb0F+eshu5OETZ0B0ZPmrC
	 OCTMzof0TJE8ULQs07BwqZ4iqR9W4SENtjdXyryM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 069/250] kprobe/ftrace: bail out if ftrace was killed
Date: Tue, 25 Jun 2024 11:30:27 +0200
Message-ID: <20240625085550.714146132@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Brennan <stephen.s.brennan@oracle.com>

[ Upstream commit 1a7d0890dd4a502a202aaec792a6c04e6e049547 ]

If an error happens in ftrace, ftrace_kill() will prevent disarming
kprobes. Eventually, the ftrace_ops associated with the kprobes will be
freed, yet the kprobes will still be active, and when triggered, they
will use the freed memory, likely resulting in a page fault and panic.

This behavior can be reproduced quite easily, by creating a kprobe and
then triggering a ftrace_kill(). For simplicity, we can simulate an
ftrace error with a kernel module like [1]:

[1]: https://github.com/brenns10/kernel_stuff/tree/master/ftrace_killer

  sudo perf probe --add commit_creds
  sudo perf trace -e probe:commit_creds
  # In another terminal
  make
  sudo insmod ftrace_killer.ko  # calls ftrace_kill(), simulating bug
  # Back to perf terminal
  # ctrl-c
  sudo perf probe --del commit_creds

After a short period, a page fault and panic would occur as the kprobe
continues to execute and uses the freed ftrace_ops. While ftrace_kill()
is supposed to be used only in extreme circumstances, it is invoked in
FTRACE_WARN_ON() and so there are many places where an unexpected bug
could be triggered, yet the system may continue operating, possibly
without the administrator noticing. If ftrace_kill() does not panic the
system, then we should do everything we can to continue operating,
rather than leave a ticking time bomb.

Link: https://lore.kernel.org/all/20240501162956.229427-1-stephen.s.brennan@oracle.com/

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/kernel/probes/ftrace.c     | 3 +++
 arch/loongarch/kernel/ftrace_dyn.c   | 3 +++
 arch/parisc/kernel/ftrace.c          | 3 +++
 arch/powerpc/kernel/kprobes-ftrace.c | 3 +++
 arch/riscv/kernel/probes/ftrace.c    | 3 +++
 arch/s390/kernel/ftrace.c            | 3 +++
 arch/x86/kernel/kprobes/ftrace.c     | 3 +++
 include/linux/kprobes.h              | 7 +++++++
 kernel/kprobes.c                     | 6 ++++++
 kernel/trace/ftrace.c                | 1 +
 10 files changed, 35 insertions(+)

diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
index 834cffcfbce32..7ba4b98076de1 100644
--- a/arch/csky/kernel/probes/ftrace.c
+++ b/arch/csky/kernel/probes/ftrace.c
@@ -12,6 +12,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe_ctlblk *kcb;
 	struct pt_regs *regs;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 73858c9029cc9..bff058317062e 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -287,6 +287,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe *p;
 	struct kprobe_ctlblk *kcb;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index 621a4b386ae4f..c91f9c2e61ed2 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -206,6 +206,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe *p;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
index 072ebe7f290ba..f8208c027148f 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -21,6 +21,9 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 	struct pt_regs *regs;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(nip, parent_nip);
 	if (bit < 0)
 		return;
diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes/ftrace.c
index 7142ec42e889f..a69dfa610aa85 100644
--- a/arch/riscv/kernel/probes/ftrace.c
+++ b/arch/riscv/kernel/probes/ftrace.c
@@ -11,6 +11,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe_ctlblk *kcb;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index c46381ea04ecb..7f6f8c438c265 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -296,6 +296,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe *p;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index dd2ec14adb77b..15af7e98e161a 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -21,6 +21,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe_ctlblk *kcb;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 0ff44d6633e33..5fcbc254d1864 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -378,11 +378,15 @@ static inline void wait_for_kprobe_optimizer(void) { }
 extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 				  struct ftrace_ops *ops, struct ftrace_regs *fregs);
 extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
+/* Set when ftrace has been killed: kprobes on ftrace must be disabled for safety */
+extern bool kprobe_ftrace_disabled __read_mostly;
+extern void kprobe_ftrace_kill(void);
 #else
 static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
 {
 	return -EINVAL;
 }
+static inline void kprobe_ftrace_kill(void) {}
 #endif /* CONFIG_KPROBES_ON_FTRACE */
 
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
@@ -495,6 +499,9 @@ static inline void kprobe_flush_task(struct task_struct *tk)
 static inline void kprobe_free_init_mem(void)
 {
 }
+static inline void kprobe_ftrace_kill(void)
+{
+}
 static inline int disable_kprobe(struct kprobe *kp)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 65adc815fc6e6..166ebf81dc450 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1068,6 +1068,7 @@ static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
 
 static int kprobe_ipmodify_enabled;
 static int kprobe_ftrace_enabled;
+bool kprobe_ftrace_disabled;
 
 static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 			       int *cnt)
@@ -1136,6 +1137,11 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
 		ipmodify ? &kprobe_ipmodify_ops : &kprobe_ftrace_ops,
 		ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
 }
+
+void kprobe_ftrace_kill()
+{
+	kprobe_ftrace_disabled = true;
+}
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
 static inline int arm_kprobe_ftrace(struct kprobe *p)
 {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1e12df9bb531b..2e11236722366 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7902,6 +7902,7 @@ void ftrace_kill(void)
 	ftrace_disabled = 1;
 	ftrace_enabled = 0;
 	ftrace_trace_function = ftrace_stub;
+	kprobe_ftrace_kill();
 }
 
 /**
-- 
2.43.0




