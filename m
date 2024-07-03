Return-Path: <stable+bounces-57597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5D5925D28
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BEC1C21405
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE9C17BB0E;
	Wed,  3 Jul 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qMysGY9C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844CC17BB04;
	Wed,  3 Jul 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005364; cv=none; b=IZxgFAyTERhbY7HxZFeONH3u/FnvsoLN7YkjEhnU/SaMd5G16jThuIQYvIFHWBGlhocX6qAAeD8f5wc5Kspn/NZCeSnbCgNz1FgboT50O9lbLab8i80sB+igvAn9oL2H3MbyrOm7dX40fY1wLdcUFi4FLPdIF5wRdvg42QbvxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005364; c=relaxed/simple;
	bh=0jg3Q0tC/ZQF0B8kfAYxPSrTs2snOWNjWVq0ZsIUwk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpmLPP3QoC62HdmaOGvXMlfKNJAW16fGKpS+h3UDcoxInoMw+iwXNvSdIfOguHRn1i7hcMcHsYsxnho5r8dOEq3MB/CKTMAB93vj8AL6ypvKxFRMJ0OmOEVj6YAmgZxnDR3YNjMnz0FDPkyvFDouEgdJzSQTTCD8vXboJidbLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qMysGY9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C42C2BD10;
	Wed,  3 Jul 2024 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005364;
	bh=0jg3Q0tC/ZQF0B8kfAYxPSrTs2snOWNjWVq0ZsIUwk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMysGY9C75awxw6uRIBLDLtnDmVBpDVyfXQgr3j7wyPcJyVlEO0WJLCwouxmuWtlT
	 CoK8wnohpGQCZl4ni5IexZBbE2hzttEp4tcyzla5aRYywDoHfbuuBhqNymUvAeo31t
	 nJJSs1Ls2TxeHtCTo0dkubCb3rNqiLJ3kGH+JU2E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 057/356] x86/ibt,ftrace: Search for __fentry__ location
Date: Wed,  3 Jul 2024 12:36:33 +0200
Message-ID: <20240703102915.252024365@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit aebfd12521d9c7d0b502cf6d06314cfbcdccfe3b ]

Currently a lot of ftrace code assumes __fentry__ is at sym+0. However
with Intel IBT enabled the first instruction of a function will most
likely be ENDBR.

Change ftrace_location() to not only return the __fentry__ location
when called for the __fentry__ location, but also when called for the
sym+0 location.

Then audit/update all callsites of this function to consistently use
these new semantics.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.227581603@infradead.org
Stable-dep-of: e60b613df8b6 ("ftrace: Fix possible use-after-free issue in ftrace_location()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 11 ++------
 kernel/bpf/trampoline.c        | 20 +++-----------
 kernel/kprobes.c               |  8 ++----
 kernel/trace/ftrace.c          | 48 ++++++++++++++++++++++++++++------
 4 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 893f040b97b7d..99dd504307fdc 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -194,17 +194,10 @@ static unsigned long
 __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
 {
 	struct kprobe *kp;
-	unsigned long faddr;
+	bool faddr;
 
 	kp = get_kprobe((void *)addr);
-	faddr = ftrace_location(addr);
-	/*
-	 * Addresses inside the ftrace location are refused by
-	 * arch_check_ftrace_location(). Something went terribly wrong
-	 * if such an address is checked here.
-	 */
-	if (WARN_ON(faddr && faddr != addr))
-		return 0UL;
+	faddr = ftrace_location(addr) == addr;
 	/*
 	 * Use the current code if it is not modified by Kprobe
 	 * and it cannot be modified by ftrace.
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 4fa75791b45e2..1bffee0458863 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -108,18 +108,6 @@ static void bpf_trampoline_module_put(struct bpf_trampoline *tr)
 	tr->mod = NULL;
 }
 
-static int is_ftrace_location(void *ip)
-{
-	long addr;
-
-	addr = ftrace_location((long)ip);
-	if (!addr)
-		return 0;
-	if (WARN_ON_ONCE(addr != (long)ip))
-		return -EFAULT;
-	return 1;
-}
-
 static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 {
 	void *ip = tr->func.addr;
@@ -151,12 +139,12 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 {
 	void *ip = tr->func.addr;
+	unsigned long faddr;
 	int ret;
 
-	ret = is_ftrace_location(ip);
-	if (ret < 0)
-		return ret;
-	tr->func.ftrace_managed = ret;
+	faddr = ftrace_location((unsigned long)ip);
+	if (faddr)
+		tr->func.ftrace_managed = true;
 
 	if (bpf_trampoline_module_get(tr))
 		return -ENOENT;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index af57705e1fef3..258d425b2c4a5 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1526,14 +1526,10 @@ static inline int warn_kprobe_rereg(struct kprobe *p)
 
 int __weak arch_check_ftrace_location(struct kprobe *p)
 {
-	unsigned long ftrace_addr;
+	unsigned long addr = (unsigned long)p->addr;
 
-	ftrace_addr = ftrace_location((unsigned long)p->addr);
-	if (ftrace_addr) {
+	if (ftrace_location(addr) == addr) {
 #ifdef CONFIG_KPROBES_ON_FTRACE
-		/* Given address is not on the instruction boundary */
-		if ((unsigned long)p->addr != ftrace_addr)
-			return -EILSEQ;
 		p->flags |= KPROBE_FLAG_FTRACE;
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
 		return -EINVAL;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 157a1d2d9802f..3dce1a107a7c7 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1575,17 +1575,34 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 }
 
 /**
- * ftrace_location - return true if the ip giving is a traced location
+ * ftrace_location - return the ftrace location
  * @ip: the instruction pointer to check
  *
- * Returns rec->ip if @ip given is a pointer to a ftrace location.
- * That is, the instruction that is either a NOP or call to
- * the function tracer. It checks the ftrace internal tables to
- * determine if the address belongs or not.
+ * If @ip matches the ftrace location, return @ip.
+ * If @ip matches sym+0, return sym's ftrace location.
+ * Otherwise, return 0.
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	return ftrace_location_range(ip, ip);
+	struct dyn_ftrace *rec;
+	unsigned long offset;
+	unsigned long size;
+
+	rec = lookup_rec(ip, ip);
+	if (!rec) {
+		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
+			goto out;
+
+		/* map sym+0 to __fentry__ */
+		if (!offset)
+			rec = lookup_rec(ip, ip + size - 1);
+	}
+
+	if (rec)
+		return rec->ip;
+
+out:
+	return 0;
 }
 
 /**
@@ -4942,7 +4959,8 @@ ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 {
 	struct ftrace_func_entry *entry;
 
-	if (!ftrace_location(ip))
+	ip = ftrace_location(ip);
+	if (!ip)
 		return -EINVAL;
 
 	if (remove) {
@@ -5090,11 +5108,16 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *free_hash = NULL;
 	struct dyn_ftrace *rec;
-	int ret = -EBUSY;
+	int ret = -ENODEV;
 
 	mutex_lock(&direct_mutex);
 
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	/* See if there's a direct function at @ip already */
+	ret = -EBUSY;
 	if (ftrace_find_rec_direct(ip))
 		goto out_unlock;
 
@@ -5223,6 +5246,10 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 
 	mutex_lock(&direct_mutex);
 
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	entry = find_direct_entry(&ip, NULL);
 	if (!entry)
 		goto out_unlock;
@@ -5354,6 +5381,11 @@ int modify_ftrace_direct(unsigned long ip,
 	mutex_lock(&direct_mutex);
 
 	mutex_lock(&ftrace_lock);
+
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	entry = find_direct_entry(&ip, &rec);
 	if (!entry)
 		goto out_unlock;
-- 
2.43.0




