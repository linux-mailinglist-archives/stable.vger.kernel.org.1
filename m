Return-Path: <stable+bounces-43022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7AE8BB153
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 19:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFC11C215E2
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3C9157A54;
	Fri,  3 May 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzWyu3uo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987C78276
	for <stable@vger.kernel.org>; Fri,  3 May 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755621; cv=none; b=CtjOHOnyPuaasnyPqiDRD6Xrh3d6CQ+sRz+A0QRNQ5iEUKqCr69Os7zG0VVWBMH16IGU6OvQNGiBeYY7sQh1U5lptBhs2LPfwbAOc6M7pJbjlA1htYjcEuUdykBz0SdPgE+l1Ajy4R7nR6fHcAEtU16RrZYt/23BIomkUzkDOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755621; c=relaxed/simple;
	bh=SXVk3YU4Szrz0k1TJPo0YtZVQHT+wYYG6i3bMtp6UbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmPgOF1XRjzZzoQDrGzxzXR+ZZjyOn7WVOlxEEtjHhV/KS5j1BIc62Gzc0q089bdfLU7U0JOBtWp7t4zK9rsEXQ/x2WXR0aujU4Kc/S1YjBWbUezcGczGMl0FWL3OZ9UaVVfLjOuzHbE7ipW0b+TOA5682fSDa1rwWSY2ni7B1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzWyu3uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45D1C116B1;
	Fri,  3 May 2024 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714755621;
	bh=SXVk3YU4Szrz0k1TJPo0YtZVQHT+wYYG6i3bMtp6UbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=pzWyu3uoHOgEPRnhAXAH49s8rncihc0f0WUQ6e+j+6gus2zDGb+zVfE4Cnbqiqwzr
	 cwnFFSFRE4SVSKCwwodIcK5eVRDhJvO1VbgC5jgh10GTTDpynSY2RFMzkOx+8Lkojx
	 cNGsyMqjGZIYYmjJUXgNTRHd5vP9yS7o93KvEkJUaw0WKPPpygL31lNanRixChY/d9
	 jBJJd9etBrbgZuLKdlO+Fr8is/YTkujfk6VYHE8PeUHT5d5tgd6fu966XBO/mlSw5+
	 tuK1pTt0URt3paQJxU2B6N6nobMz1uLc/Zdx7nA/3kBPgfse260y8sQrdype659vOd
	 aou62Vu3Vt+sg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: NeilBrown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5.15.y] nfsd: don't allow nfsd threads to be signalled.
Date: Fri,  3 May 2024 13:00:00 -0400
Message-ID: <20240503170000.752108-1-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

[ Upstream commit 3903902401451b1cd9d797a8c79769eb26ac7fe5 ]

The original implementation of nfsd used signals to stop threads during
shutdown.
In Linux 2.3.46pre5 nfsd gained the ability to shutdown threads
internally it if was asked to run "0" threads.  After this user-space
transitioned to using "rpc.nfsd 0" to stop nfsd and sending signals to
threads was no longer an important part of the API.

In commit 3ebdbe5203a8 ("SUNRPC: discard svo_setup and rename
svc_set_num_threads_sync()") (v5.17-rc1~75^2~41) we finally removed the
use of signals for stopping threads, using kthread_stop() instead.

This patch makes the "obvious" next step and removes the ability to
signal nfsd threads - or any svc threads.  nfsd stops allowing signals
and we don't check for their delivery any more.

This will allow for some simplification in later patches.

A change worth noting is in nfsd4_ssc_setup_dul().  There was previously
a signal_pending() check which would only succeed when the thread was
being shut down.  It should really have tested kthread_should_stop() as
well.  Now it just does the latter, not the former.

Signed-off-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback.c     |  9 +--------
 fs/nfsd/nfs4proc.c    |  5 ++---
 fs/nfsd/nfssvc.c      | 12 ------------
 net/sunrpc/svc_xprt.c | 16 ++++++----------
 4 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 456af7d230cf..46a0a2d6962e 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -80,9 +80,6 @@ nfs4_callback_svc(void *vrqstp)
 	set_freezable();
 
 	while (!kthread_freezable_should_stop(NULL)) {
-
-		if (signal_pending(current))
-			flush_signals(current);
 		/*
 		 * Listen for a request on the socket
 		 */
@@ -112,11 +109,7 @@ nfs41_callback_svc(void *vrqstp)
 	set_freezable();
 
 	while (!kthread_freezable_should_stop(NULL)) {
-
-		if (signal_pending(current))
-			flush_signals(current);
-
-		prepare_to_wait(&serv->sv_cb_waitq, &wq, TASK_INTERRUPTIBLE);
+		prepare_to_wait(&serv->sv_cb_waitq, &wq, TASK_IDLE);
 		spin_lock_bh(&serv->sv_cb_lock);
 		if (!list_empty(&serv->sv_cb_list)) {
 			req = list_first_entry(&serv->sv_cb_list,
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index c14f5ac1484c..6779291efca9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1317,12 +1317,11 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 		/* found a match */
 		if (ni->nsui_busy) {
 			/*  wait - and try again */
-			prepare_to_wait(&nn->nfsd_ssc_waitq, &wait,
-				TASK_INTERRUPTIBLE);
+			prepare_to_wait(&nn->nfsd_ssc_waitq, &wait, TASK_IDLE);
 			spin_unlock(&nn->nfsd_ssc_lock);
 
 			/* allow 20secs for mount/unmount for now - revisit */
-			if (signal_pending(current) ||
+			if (kthread_should_stop() ||
 					(schedule_timeout(20*HZ) == 0)) {
 				finish_wait(&nn->nfsd_ssc_waitq, &wait);
 				kfree(work);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 4c1a0a1623e5..3d4fd40c987b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -938,15 +938,6 @@ nfsd(void *vrqstp)
 
 	current->fs->umask = 0;
 
-	/*
-	 * thread is spawned with all signals set to SIG_IGN, re-enable
-	 * the ones that will bring down the thread
-	 */
-	allow_signal(SIGKILL);
-	allow_signal(SIGHUP);
-	allow_signal(SIGINT);
-	allow_signal(SIGQUIT);
-
 	atomic_inc(&nfsdstats.th_cnt);
 
 	set_freezable();
@@ -971,9 +962,6 @@ nfsd(void *vrqstp)
 		validate_process_creds();
 	}
 
-	/* Clear signals before calling svc_exit_thread() */
-	flush_signals(current);
-
 	atomic_dec(&nfsdstats.th_cnt);
 
 out:
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 67ccf1a6459a..b19592673eef 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -700,8 +700,8 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 			/* Made progress, don't sleep yet */
 			continue;
 
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (signalled() || kthread_should_stop()) {
+		set_current_state(TASK_IDLE);
+		if (kthread_should_stop()) {
 			set_current_state(TASK_RUNNING);
 			return -EINTR;
 		}
@@ -736,7 +736,7 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 		return false;
 
 	/* are we shutting down? */
-	if (signalled() || kthread_should_stop())
+	if (kthread_should_stop())
 		return false;
 
 	/* are we freezing? */
@@ -758,11 +758,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 	if (rqstp->rq_xprt)
 		goto out_found;
 
-	/*
-	 * We have to be able to interrupt this wait
-	 * to bring down the daemons ...
-	 */
-	set_current_state(TASK_INTERRUPTIBLE);
+	set_current_state(TASK_IDLE);
 	smp_mb__before_atomic();
 	clear_bit(SP_CONGESTED, &pool->sp_flags);
 	clear_bit(RQ_BUSY, &rqstp->rq_flags);
@@ -784,7 +780,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 	if (!time_left)
 		atomic_long_inc(&pool->sp_stats.threads_timedout);
 
-	if (signalled() || kthread_should_stop())
+	if (kthread_should_stop())
 		return ERR_PTR(-EINTR);
 	return ERR_PTR(-EAGAIN);
 out_found:
@@ -882,7 +878,7 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 	try_to_freeze();
 	cond_resched();
 	err = -EINTR;
-	if (signalled() || kthread_should_stop())
+	if (kthread_should_stop())
 		goto out;
 
 	xprt = svc_get_next_xprt(rqstp, timeout);

base-commit: b925f60c6ee7ec871d2d48575d0fde3872129c20
-- 
2.44.0


