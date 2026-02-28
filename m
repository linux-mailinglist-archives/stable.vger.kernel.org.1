Return-Path: <stable+bounces-220167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Cn0Hm0so2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:57:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8FE1C5404
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 899A530B1E0B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD0B4A1397;
	Sat, 28 Feb 2026 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtpWgWSr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDA94A1383;
	Sat, 28 Feb 2026 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300075; cv=none; b=XAp8kOiDJw2YXIdKXmMqgdWalMzprPsEMq0Mv9H0QZcRZFcrh7kEO0XkzhkvxWI7W/B+K/0dgRnNXHuys9W3rUCf+zI4Vdj7cGx4ln8EDz/yBeJEW3Jzy7yrDXaVPKSh8kOK1m/qmsEVk8oYFUE3Bjqnm89c71QX8ozyKsVQ064=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300075; c=relaxed/simple;
	bh=5FWSGWoP1DeTrBtFBKNXyNxpZ0WVhV/7ov6m7oEI/PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQCeugz8IPchsnwTKN1hozUhoEHPjvvJCMUd+KjOjzY2eu7XbGjrXqYNpvKuW+cbL8zpfvLMMHrD82wjx73GP2uxahK7BJUQ92dlnn92yLiEADcbYLEMFPUQl2Km+rkHPfPz85Bk4KDysvLnqK93kUgvhULzx6LMvVFeXycP2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtpWgWSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232E8C19423;
	Sat, 28 Feb 2026 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300074;
	bh=5FWSGWoP1DeTrBtFBKNXyNxpZ0WVhV/7ov6m7oEI/PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtpWgWSr6yl5C8MaL+Y0GozAOzHWUPazYeQv9cexMkVL8ud2TtsJrnR5emVe6/acx
	 CfiB1dGTR5L69PpgLkZ0N920VfWXCS1YNlh4gMdVVggMY2hNHqHmlkPP+1bAe1bqYR
	 9OlaJlwnSQhiZYOfpuU92BEqzyf7Nf0f6vBiklU4ZkZ10esFayGGyzKVEPnFgH5C8e
	 nKmx5H5fVlitrOrRjRY6JFFyNtG2d54Vry/wm3t7cULIe4Stg+eQqb0JATEVh79yvm
	 BqRtcOCHMfGi9q5jkyQmXP2CO1Loxq4XG6FavXBkuYthfzDHgUUDVvR+HvveG3TQue
	 ZZ8LVQfzVpFug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>,
	Ludwig Rydberg <ludwig.rydberg@gaisler.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 089/844] sparc: Synchronize user stack on fork and clone
Date: Sat, 28 Feb 2026 12:20:02 -0500
Message-ID: <20260228173244.1509663-90-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-220167-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sourceware.org:url,fu-berlin.de:email,gaisler.com:email]
X-Rspamd-Queue-Id: 1B8FE1C5404
X-Rspamd-Action: no action

From: Andreas Larsson <andreas@gaisler.com>

[ Upstream commit e38eba3b77878ada327a572a41596a3b0b44e522 ]

Flush all uncommitted user windows before calling the generic syscall
handlers for clone, fork, and vfork.

Prior to entering the arch common handlers sparc_{clone|fork|vfork}, the
arch-specific syscall wrappers for these syscalls will attempt to flush
all windows (including user windows).

In the window overflow trap handlers on both SPARC{32|64},
if the window can't be stored (i.e due to MMU related faults) the routine
backups the user window and increments a thread counter (wsaved).

By adding a synchronization point after the flush attempt, when fault
handling is enabled, any uncommitted user windows will be flushed.

Link: https://sourceware.org/bugzilla/show_bug.cgi?id=31394
Closes: https://lore.kernel.org/sparclinux/fe5cc47167430007560501aabb28ba154985b661.camel@physik.fu-berlin.de/
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Link: https://lore.kernel.org/r/20260119144753.27945-2-ludwig.rydberg@gaisler.com
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/kernel/process.c | 38 +++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
index 0442ab00518d3..7d69877511fac 100644
--- a/arch/sparc/kernel/process.c
+++ b/arch/sparc/kernel/process.c
@@ -17,14 +17,18 @@
 
 asmlinkage long sparc_fork(struct pt_regs *regs)
 {
-	unsigned long orig_i1 = regs->u_regs[UREG_I1];
+	unsigned long orig_i1;
 	long ret;
 	struct kernel_clone_args args = {
 		.exit_signal	= SIGCHLD,
-		/* Reuse the parent's stack for the child. */
-		.stack		= regs->u_regs[UREG_FP],
 	};
 
+	synchronize_user_stack();
+
+	orig_i1 = regs->u_regs[UREG_I1];
+	/* Reuse the parent's stack for the child. */
+	args.stack = regs->u_regs[UREG_FP];
+
 	ret = kernel_clone(&args);
 
 	/* If we get an error and potentially restart the system
@@ -40,16 +44,19 @@ asmlinkage long sparc_fork(struct pt_regs *regs)
 
 asmlinkage long sparc_vfork(struct pt_regs *regs)
 {
-	unsigned long orig_i1 = regs->u_regs[UREG_I1];
+	unsigned long orig_i1;
 	long ret;
-
 	struct kernel_clone_args args = {
 		.flags		= CLONE_VFORK | CLONE_VM,
 		.exit_signal	= SIGCHLD,
-		/* Reuse the parent's stack for the child. */
-		.stack		= regs->u_regs[UREG_FP],
 	};
 
+	synchronize_user_stack();
+
+	orig_i1 = regs->u_regs[UREG_I1];
+	/* Reuse the parent's stack for the child. */
+	args.stack = regs->u_regs[UREG_FP];
+
 	ret = kernel_clone(&args);
 
 	/* If we get an error and potentially restart the system
@@ -65,15 +72,18 @@ asmlinkage long sparc_vfork(struct pt_regs *regs)
 
 asmlinkage long sparc_clone(struct pt_regs *regs)
 {
-	unsigned long orig_i1 = regs->u_regs[UREG_I1];
-	unsigned int flags = lower_32_bits(regs->u_regs[UREG_I0]);
+	unsigned long orig_i1;
+	unsigned int flags;
 	long ret;
+	struct kernel_clone_args args = {0};
 
-	struct kernel_clone_args args = {
-		.flags		= (flags & ~CSIGNAL),
-		.exit_signal	= (flags & CSIGNAL),
-		.tls		= regs->u_regs[UREG_I3],
-	};
+	synchronize_user_stack();
+
+	orig_i1 = regs->u_regs[UREG_I1];
+	flags = lower_32_bits(regs->u_regs[UREG_I0]);
+	args.flags		= (flags & ~CSIGNAL);
+	args.exit_signal	= (flags & CSIGNAL);
+	args.tls		= regs->u_regs[UREG_I3];
 
 #ifdef CONFIG_COMPAT
 	if (test_thread_flag(TIF_32BIT)) {
-- 
2.51.0


