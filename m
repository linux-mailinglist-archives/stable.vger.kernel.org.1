Return-Path: <stable+bounces-203498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C76F9CE68C7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DFAD300FD74
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0106B30C61B;
	Mon, 29 Dec 2025 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ddjGf78Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5D92E54D1
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008205; cv=none; b=kZ+xqmNWZJhpYDq02unyODiA3444ypjNrA40dqkVsztrYc4SIMrapFVbsqAAGNdSPJB8KKA/3Cy5jcmjDShpmSv+PW2UaGC46h3Fpgqp2wJtH9JmqVpTY7XlJp43f6sXOyeWCiBZQRqwDs81W+rIeooZRhON1rzEpDjk2kfJzMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008205; c=relaxed/simple;
	bh=waFxTdao5sfG6Y/2moRkzOjlyqS/s6/59v9X6pxH1V4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MpKQ/DuYQAPPCUNFNR3abS+x+4tTNfisyyHUn5NrfhyJ2yH39muZtUifWqXwzE8+cE6gX3DdSkS1GUwK86zuPNsbavqVKerQb+Ft6X4RSg35IUSpHvkM7zjaZ+HguUQHpLjCyNAZM6xvgtYh4JDB7DBcqWZB4BIT+lMZevUnO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ddjGf78Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2999CC4CEF7;
	Mon, 29 Dec 2025 11:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767008203;
	bh=waFxTdao5sfG6Y/2moRkzOjlyqS/s6/59v9X6pxH1V4=;
	h=Subject:To:Cc:From:Date:From;
	b=ddjGf78YOll0M1a/m0OgER96fHf7IkcVzUJcYc2VJZAynl35YA7nFtm8j4FIKkahu
	 L5dQTc7uUmMSkO84LzFBbU6tiDGMlQoPrfSZfyhoS4uwdrmW/Cgvp+PLUPDm+EUDLB
	 u3ZiMSqxSPAFJn42YpDpmDplD0hJvjHcbNXkIg8c=
Subject: FAILED: patch "[PATCH] sched_ext: Fix bypass depth leak on scx_enable() failure" failed to apply to 6.12-stable tree
To: tj@kernel.org,clm@meta.com,emil@etsalapatis.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 12:36:40 +0100
Message-ID: <2025122940-sneak-unvocal-9de2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9f769637a93fac81689b80df6855f545839cf999
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122940-sneak-unvocal-9de2@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9f769637a93fac81689b80df6855f545839cf999 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 9 Dec 2025 11:04:33 -1000
Subject: [PATCH] sched_ext: Fix bypass depth leak on scx_enable() failure

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
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Link: https://lore.kernel.org/stable/286e6f7787a81239e1ce2989b52391ce%40kernel.org
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index bd74b371f52d..c4465ccefea4 100644
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
 
@@ -4318,6 +4325,11 @@ static void scx_disable_workfn(struct kthread_work *work)
 	scx_dsp_max_batch = 0;
 	free_kick_syncs();
 
+	if (scx_bypassed_for_enable) {
+		scx_bypassed_for_enable = false;
+		scx_bypass(false);
+	}
+
 	mutex_unlock(&scx_enable_mutex);
 
 	WARN_ON_ONCE(scx_set_enable_state(SCX_DISABLED) != SCX_DISABLING);
@@ -4970,6 +4982,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 * Init in bypass mode to guarantee forward progress.
 	 */
 	scx_bypass(true);
+	scx_bypassed_for_enable = true;
 
 	for (i = SCX_OPI_NORMAL_BEGIN; i < SCX_OPI_NORMAL_END; i++)
 		if (((void (**)(void))ops)[i])
@@ -5067,6 +5080,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
 
+	scx_bypassed_for_enable = false;
 	scx_bypass(false);
 
 	if (!scx_tryset_enable_state(SCX_ENABLED, SCX_ENABLING)) {


