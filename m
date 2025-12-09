Return-Path: <stable+bounces-200487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8638ACB11EA
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 22:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBF9530E5A64
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 21:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ABF30C354;
	Tue,  9 Dec 2025 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCc0dr+p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE2630C342;
	Tue,  9 Dec 2025 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314275; cv=none; b=qM20+RMfUhUPp57PZ9DWuwNVFNXFMdtGqCnOiQTvUghhe9smgMwjDO9HqNNiQ8JSOT3nAIDn7u+GFzjtQ5zvv/83ZSfu2PPNwtzrNKYua94dPnW/8oNkUoXPimSsYSOuBeE21ViM1MWxhvnoi0EBeQnNnoyh8oF8giYf44dHemg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314275; c=relaxed/simple;
	bh=a39aZRYG4GuuNjVKn0c9PuWXsD2hsaYYnAPxt3wMqHI=;
	h=Date:Message-ID:From:To:Cc:Subject; b=f3zGN1aUGpc4nQEY530GJ0h0tHviPqcN2h+BO124mFGy7etUB0Lz5Cg9iW/l2+ZHcatVoR0CRB1cj36evNUJ9zLx+pCzxymJMaM7YuwzBGvjOmcz2j+cMxUQM6WlAH+RgD3YJCpgQlGZn8ergu/iAW9VhdgTW6t9oKWtkcV3hno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCc0dr+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EC9C4CEF5;
	Tue,  9 Dec 2025 21:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765314274;
	bh=a39aZRYG4GuuNjVKn0c9PuWXsD2hsaYYnAPxt3wMqHI=;
	h=Date:From:To:Cc:Subject:From;
	b=fCc0dr+pvO612rC42KadLOL7coWJjNsR7Qto5AsgMYTViQMfYwoCugECEny0F1DLH
	 SSHUzINWZ/gjvZZg+9K4qyjwbAFopJuz2ho7NPPgFfyasQta9+E4ZxRa20A8OFmWoI
	 YAqMVba7ZW1o5eK+wfDhk4Gm6EUYc2BnodCEWXsSb6bJqSH7WmvJTAto7BFv/w0+Sv
	 VfhY9azJ4fBnlPJpt+goyXRUdkav6AhScM2bvKgkqbuQzmm2mD5Lj017Yyh3LG2ULI
	 VdaJwhzmDZnaeEUKOedeA7JQfZ9txZMw0SP6KleaRnyX0pgL4QYqrTltPWstvk2Mul
	 D2xYAKfQIbYKA==
Date: Tue, 09 Dec 2025 11:04:33 -1000
Message-ID: <286e6f7787a81239e1ce2989b52391ce@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Chris Mason <clm@meta.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH sched_ext/for-6.19-fixes] sched_ext: Fix bypass depth leak on
 scx_enable() failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

scx_enable() calls scx_bypass(true) to initialize in bypass mode and then
scx_bypass(false) on success to exit. If scx_enable() fails during task
initialization - e.g. scx_cgroup_init() or scx_init_task() returns an error -
it jumps to err_disable while bypass is still active. scx_disable_workfn()
then calls scx_bypass(true/false) for its own bypass, leaving the bypass depth
at 1 instead of 0. This causes the system to remain permanently in bypass mode
after a failed scx_enable().

Failures after task initialization is complete - e.g. scx_tryset_enable_state()
at the end - already call scx_bypass(false) before reaching the error path and
are not affected. This only affects a subset of failure modes.

Fix it by tracking whether scx_enable() called scx_bypass(true) in a bool and
having scx_disable_workfn() call an extra scx_bypass(false) to clear it. This
is a temporary measure as the bypass depth will be moved into the sched
instance, which will make this tracking unnecessary.

Fixes: 8c2090c504e9 ("sched_ext: Initialize in bypass mode")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -41,6 +41,13 @@ static bool scx_init_task_enabled;
 static bool scx_switching_all;
 DEFINE_STATIC_KEY_FALSE(__scx_switched_all);

+/*
+ * Tracks whether scx_enable() called scx_bypass(true). Used to balance bypass
+ * depth on enable failure. Will be removed when bypass depth is moved into the
+ * sched instance.
+ */
+static bool scx_bypassed_for_enable;
+
 static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
 static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);

@@ -4318,6 +4325,11 @@ static void scx_disable_workfn(struct kt
 	scx_dsp_max_batch = 0;
 	free_kick_syncs();

+	if (scx_bypassed_for_enable) {
+		scx_bypassed_for_enable = false;
+		scx_bypass(false);
+	}
+
 	mutex_unlock(&scx_enable_mutex);

 	WARN_ON_ONCE(scx_set_enable_state(SCX_DISABLED) != SCX_DISABLING);
@@ -4970,6 +4982,7 @@ static int scx_enable(struct sched_ext_o
 	 * Init in bypass mode to guarantee forward progress.
 	 */
 	scx_bypass(true);
+	scx_bypassed_for_enable = true;

 	for (i = SCX_OPI_NORMAL_BEGIN; i < SCX_OPI_NORMAL_END; i++)
 		if (((void (**)(void))ops)[i])
@@ -5067,6 +5080,7 @@ static int scx_enable(struct sched_ext_o
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);

+	scx_bypassed_for_enable = false;
 	scx_bypass(false);

 	if (!scx_tryset_enable_state(SCX_ENABLED, SCX_ENABLING)) {
--
tejun

