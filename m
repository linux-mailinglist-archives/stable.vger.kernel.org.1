Return-Path: <stable+bounces-58737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 043CF92B8AD
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD86C1F230F7
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431091662E7;
	Tue,  9 Jul 2024 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hs1S2Lot";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9dS7BaTD"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0603215E5AE;
	Tue,  9 Jul 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525325; cv=none; b=loZIPrkFp2Iy0xO6oBXUuxdwA8Ec3R+LzD3sf5a+OdeG4o8XtxdBBp1aoT+wq54CUk/V53UpsVvp5T97MWJrxkwGvXwFrl6IXtIbT/8obXRCWJxI+gR/znTrHnLE2ScDRXywahHV89fZ4Q0dHoEuDwZDt32sKRt5XHRHa7vk9m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525325; c=relaxed/simple;
	bh=mAuv51EdZ4x10AGFyzQfUsBgS1aRE0aRnqdZSA59MVQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QZE7M/tWR8/fgicKcnzIHow2pnq8ZXQ9qJFz6gh4P0+tKxa3DHKBcNXBRUlWCez5Ylg83wrofwS2HzIxvzfjkMxJNZwr7vFqkz4gL5v5K+JPu4Oq0C7O0P2K9MJwAkEYay0/ZmtRZDxNghVRNzmb5vR/diKD707SGaNg/3ITolI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hs1S2Lot; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9dS7BaTD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jul 2024 11:42:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720525321;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fup+0ds+SZktOpgb+1kYRRNpUXazryrF/Hu0Ht1LGtM=;
	b=Hs1S2LotZbYO+nT7M4lz9aMSL3jDEX0QR2g1AHbLKav4jLPueSEfIWgP/h/I05LYUB67Ut
	K3bSLST/Ts9IQix6wuZyjQKrnKojt9KWFgHNXcFqWKQWHAqbwYonGXbErp7O9U1y2wNIGz
	oUanbY5qS5uxJ7VMnWP8WpIiDI6x+sqDlQuialSbBbtNnSgp8EKweziae8nAERJIz3fsG4
	i6YKuaKD8UdqDdN5R+/tpbRAvwnxi6YTNY0sK30KJO8oLewFuuWiKZ18G3d6PUxUIRDdDk
	DYuPyYIhac/5gi02tH5FomQsnPnxUYftdbMa1maVaggo1mCjXqrFC9m6M7/WpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525321;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fup+0ds+SZktOpgb+1kYRRNpUXazryrF/Hu0Ht1LGtM=;
	b=9dS7BaTDiHtoQj9bRzeArNBC/TUYSvhuiQgAet5+m+qJ2OVXYtIZKUm77s05mcBEQ4Z9n4
	cf7+LQHGWbbnNIAA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] task_work: s/task_work_cancel()/task_work_cancel_func()/
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240621091601.18227-2-frederic@kernel.org>
References: <20240621091601.18227-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052532100.2215.4983382735479784974.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     68cbd415dd4b9c5b9df69f0f091879e56bf5907a
Gitweb:        https://git.kernel.org/tip/68cbd415dd4b9c5b9df69f0f091879e56bf5907a
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 21 Jun 2024 11:15:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:31 +02:00

task_work: s/task_work_cancel()/task_work_cancel_func()/

A proper task_work_cancel() API that actually cancels a callback and not
*any* callback pointing to a given function is going to be needed for
perf events event freeing. Do the appropriate rename to prepare for
that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240621091601.18227-2-frederic@kernel.org
---
 include/linux/task_work.h |  2 +-
 kernel/irq/manage.c       |  2 +-
 kernel/task_work.c        | 10 +++++-----
 security/keys/keyctl.c    |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 795ef5a..23ab01a 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -30,7 +30,7 @@ int task_work_add(struct task_struct *task, struct callback_head *twork,
 
 struct callback_head *task_work_cancel_match(struct task_struct *task,
 	bool (*match)(struct callback_head *, void *data), void *data);
-struct callback_head *task_work_cancel(struct task_struct *, task_work_func_t);
+struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
 void task_work_run(void);
 
 static inline void exit_task_work(struct task_struct *task)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 71b0fc2..dd53298 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1337,7 +1337,7 @@ static int irq_thread(void *data)
 	 * synchronize_hardirq(). So neither IRQTF_RUNTHREAD nor the
 	 * oneshot mask bit can be set.
 	 */
-	task_work_cancel(current, irq_thread_dtor);
+	task_work_cancel_func(current, irq_thread_dtor);
 	return 0;
 }
 
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 95a7e1b..54ac240 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -120,9 +120,9 @@ static bool task_work_func_match(struct callback_head *cb, void *data)
 }
 
 /**
- * task_work_cancel - cancel a pending work added by task_work_add()
- * @task: the task which should execute the work
- * @func: identifies the work to remove
+ * task_work_cancel_func - cancel a pending work matching a function added by task_work_add()
+ * @task: the task which should execute the func's work
+ * @func: identifies the func to match with a work to remove
  *
  * Find the last queued pending work with ->func == @func and remove
  * it from queue.
@@ -131,7 +131,7 @@ static bool task_work_func_match(struct callback_head *cb, void *data)
  * The found work or NULL if not found.
  */
 struct callback_head *
-task_work_cancel(struct task_struct *task, task_work_func_t func)
+task_work_cancel_func(struct task_struct *task, task_work_func_t func)
 {
 	return task_work_cancel_match(task, task_work_func_match, func);
 }
@@ -168,7 +168,7 @@ void task_work_run(void)
 		if (!work)
 			break;
 		/*
-		 * Synchronize with task_work_cancel(). It can not remove
+		 * Synchronize with task_work_cancel_match(). It can not remove
 		 * the first entry == work, cmpxchg(task_works) must fail.
 		 * But it can remove another entry from the ->next list.
 		 */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 4bc3e93..ab927a1 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1694,7 +1694,7 @@ long keyctl_session_to_parent(void)
 		goto unlock;
 
 	/* cancel an already pending keyring replacement */
-	oldwork = task_work_cancel(parent, key_change_session_keyring);
+	oldwork = task_work_cancel_func(parent, key_change_session_keyring);
 
 	/* the replacement session keyring is applied just prior to userspace
 	 * restarting */

