Return-Path: <stable+bounces-210210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79344D397C3
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 17:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29824300A286
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF072206A7;
	Sun, 18 Jan 2026 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d45pHRQE"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD9E2144C7
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768752990; cv=none; b=Jb+2ZRjQgBsQ0/mSiJ+tXTasHqvM5fzgf31TGIULmxYM0P7xrxIfw5NZ7injN3YiN7IS1UAtN3IW7u0rqKpawk9nbWBTVfV8KLbJsWLl3oOvRdmO7/A0Kv7mlMAGlcAxkqfTQxD5KsxKn5ah9K7bQKr5GhdcDOEmwCYULhj59D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768752990; c=relaxed/simple;
	bh=5M8+PnOkLtsD+OxYNuVjmuhn7pOypAI779/sOab/aEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iNjylHhHML/2F4aTOJlu1MJ6A1yvhkBB1kWgAqdYaxX/rYZA5slX7IYqZVP674oPgF7HbObVaSaTUV6mgBgtMvYJh+zXrXxuByTCIYBGZBO4GhfJZM4uvEpdElR9Z0dNG6ny7+jA78r4bZxuKMvh3Z2Fqvjot9qBDtt0Sls+ywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d45pHRQE; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768752986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EFttAqFki6nqWJoMTJuJeWJm16rSKpHxYccKyXV1eEI=;
	b=d45pHRQEqtNM+ayLFrByYehKmfirsDRyDRXLYHK8CBeCHC72xOyZH+2PiJmJO5YzoyvGCe
	VPjbUDZXfAc4uRnVyg9yLgqBC4EHv5Zeq2I8obJ6y3uKSvXZuNShyQP3zwjeT4N9aes5tX
	vsM4z3G8twkWI7rTuIKFKpOhLpZJEGk=
From: wen.yang@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.6 2/3] net: Remove conditional threaded-NAPI wakeup based on task state.
Date: Mon, 19 Jan 2026 00:15:45 +0800
Message-Id: <e2e05047bca5eedd98eca0afefafe0802abf0e05.1768751557.git.wen.yang@linux.dev>
In-Reply-To: <cover.1768751557.git.wen.yang@linux.dev>
References: <cover.1768751557.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 56364c910691f6d10ba88c964c9041b9ab777bd6 upstream.

A NAPI thread is scheduled by first setting NAPI_STATE_SCHED bit. If
successful (the bit was not yet set) then the NAPI_STATE_SCHED_THREADED
is set but only if thread's state is not TASK_INTERRUPTIBLE (is
TASK_RUNNING) followed by task wakeup.

If the task is idle (TASK_INTERRUPTIBLE) then the
NAPI_STATE_SCHED_THREADED bit is not set. The thread is no relying on
the bit but always leaving the wait-loop after returning from schedule()
because there must have been a wakeup.

The smpboot-threads implementation for per-CPU threads requires an
explicit condition and does not support "if we get out of schedule()
then there must be something to do".

Removing this optimisation simplifies the following integration.

Set NAPI_STATE_SCHED_THREADED unconditionally on wakeup and rely on it
in the wait path by removing the `woken' condition.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/core/dev.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e35f41e75bdd..83475b8b3e9d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4447,13 +4447,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 		 */
 		thread = READ_ONCE(napi->thread);
 		if (thread) {
-			/* Avoid doing set_bit() if the thread is in
-			 * INTERRUPTIBLE state, cause napi_thread_wait()
-			 * makes sure to proceed with napi polling
-			 * if the thread is explicitly woken from here.
-			 */
-			if (READ_ONCE(thread->__state) != TASK_INTERRUPTIBLE)
-				set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
+			set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
 			wake_up_process(thread);
 			return;
 		}
@@ -6672,8 +6666,6 @@ static int napi_poll(struct napi_struct *n, struct list_head *repoll)
 
 static int napi_thread_wait(struct napi_struct *napi)
 {
-	bool woken = false;
-
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	while (!kthread_should_stop()) {
@@ -6682,15 +6674,13 @@ static int napi_thread_wait(struct napi_struct *napi)
 		 * Testing SCHED bit is not enough because SCHED bit might be
 		 * set by some other busy poll thread or by napi_disable().
 		 */
-		if (test_bit(NAPI_STATE_SCHED_THREADED, &napi->state) || woken) {
+		if (test_bit(NAPI_STATE_SCHED_THREADED, &napi->state)) {
 			WARN_ON(!list_empty(&napi->poll_list));
 			__set_current_state(TASK_RUNNING);
 			return 0;
 		}
 
 		schedule();
-		/* woken being true indicates this thread owns this napi. */
-		woken = true;
 		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.25.1


