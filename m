Return-Path: <stable+bounces-181892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D1ABA9139
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537913A320B
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF2A30102F;
	Mon, 29 Sep 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O9CAYcs5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65A2571C2
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146055; cv=none; b=HvPVEVkoukL6gnw+jpnQOVq3jWPJaNMvBLxmC4t1we8uo5rLHAQv8My/UsCgq19uudvyygfRp5yA9Mol9p/gPIVWa5W0Yu8yKfvZnpJUig/WW35jDthTO8KSUyTr2HXDk7thTkzFDNcxHN1HwqHuDuhLQDllLWRM1y9YdC1AGZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146055; c=relaxed/simple;
	bh=CF6wZtkZvjo/Nd3qK67s+t4y04TgV/ASDBxt1Du14vU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KhNf3jx4+BQ29DSEZLD2G2AVG6s/fe2akuCMr405Y9HoVmlA+dFSk3ONUcadCjmSuwsFi/LpNsp5LdR9+stmFPlLWLaVUMYiXoScm6JQ/VhWtNXFzd2SLp4DPnSWd9F6QG6DQTptSqbHfBUC/8ELpseCrx6X+jnOSLzEkXpRs5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O9CAYcs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BD3C4CEF4;
	Mon, 29 Sep 2025 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759146055;
	bh=CF6wZtkZvjo/Nd3qK67s+t4y04TgV/ASDBxt1Du14vU=;
	h=Subject:To:Cc:From:Date:From;
	b=O9CAYcs5fSYKp4KSt4kXMvD4I9jT/+Xg5K0oPlJimiArxKc/T/8sOMqiyxgqb0Z51
	 a7GoSDwvdReJdGAbY40qH1QofrDqPc4orWWU2o5DSecbcGZh+ilBkwl7W7z1ik+Knc
	 3t+8+E9C+6RsOAuhWhnKUwDtaUEMd5smI3FiepIU=
Subject: FAILED: patch "[PATCH] sched_ext: idle: Handle migration-disabled tasks in BPF code" failed to apply to 6.16-stable tree
To: arighi@nvidia.com,changwoo@igalia.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Sep 2025 13:40:52 +0200
Message-ID: <2025092952-wooing-result-72e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 55ed11b181c43d81ce03b50209e4e7c4a14ba099
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092952-wooing-result-72e9@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 55ed11b181c43d81ce03b50209e4e7c4a14ba099 Mon Sep 17 00:00:00 2001
From: Andrea Righi <arighi@nvidia.com>
Date: Sat, 20 Sep 2025 15:26:21 +0200
Subject: [PATCH] sched_ext: idle: Handle migration-disabled tasks in BPF code

When scx_bpf_select_cpu_dfl()/and() kfuncs are invoked outside of
ops.select_cpu() we can't rely on @p->migration_disabled to determine if
migration is disabled for the task @p.

In fact, migration is always disabled for the current task while running
BPF code: __bpf_prog_enter() disables migration and __bpf_prog_exit()
re-enables it.

To handle this, when @p->migration_disabled == 1, check whether @p is
the current task. If so, migration was not disabled before entering the
callback, otherwise migration was disabled.

This ensures correct idle CPU selection in all cases. The behavior of
ops.select_cpu() remains unchanged, because this callback is never
invoked for the current task and migration-disabled tasks are always
excluded.

Example: without this change scx_bpf_select_cpu_and() called from
ops.enqueue() always returns -EBUSY; with this change applied, it
correctly returns idle CPUs.

Fixes: 06efc9fe0b8de ("sched_ext: idle: Handle migration-disabled tasks in idle selection")
Cc: stable@vger.kernel.org # v6.16+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Acked-by: Changwoo Min <changwoo@igalia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 7174e1c1a392..537c6992bb63 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -856,6 +856,32 @@ static bool check_builtin_idle_enabled(void)
 	return false;
 }
 
+/*
+ * Determine whether @p is a migration-disabled task in the context of BPF
+ * code.
+ *
+ * We can't simply check whether @p->migration_disabled is set in a
+ * sched_ext callback, because migration is always disabled for the current
+ * task while running BPF code.
+ *
+ * The prolog (__bpf_prog_enter) and epilog (__bpf_prog_exit) respectively
+ * disable and re-enable migration. For this reason, the current task
+ * inside a sched_ext callback is always a migration-disabled task.
+ *
+ * Therefore, when @p->migration_disabled == 1, check whether @p is the
+ * current task or not: if it is, then migration was not disabled before
+ * entering the callback, otherwise migration was disabled.
+ *
+ * Returns true if @p is migration-disabled, false otherwise.
+ */
+static bool is_bpf_migration_disabled(const struct task_struct *p)
+{
+	if (p->migration_disabled == 1)
+		return p != current;
+	else
+		return p->migration_disabled;
+}
+
 static s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 				 const struct cpumask *allowed, u64 flags)
 {
@@ -898,7 +924,7 @@ static s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_f
 	 * selection optimizations and simply check whether the previously
 	 * used CPU is idle and within the allowed cpumask.
 	 */
-	if (p->nr_cpus_allowed == 1 || is_migration_disabled(p)) {
+	if (p->nr_cpus_allowed == 1 || is_bpf_migration_disabled(p)) {
 		if (cpumask_test_cpu(prev_cpu, allowed ?: p->cpus_ptr) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu))
 			cpu = prev_cpu;


