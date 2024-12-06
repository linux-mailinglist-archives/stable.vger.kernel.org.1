Return-Path: <stable+bounces-99062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9F19E6F07
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 14:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA4218812B3
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E3E203713;
	Fri,  6 Dec 2024 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXGCXX0v"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D46F1EE02E
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490537; cv=none; b=o7gV+xvhvwjxWRP5Fm2VUSAjhBPCh1rDDj4ospnLgWIZCrDwRSbrNNtnGekP4oECyh0uOoSTD4LOZfiBiSZm+9jf7V/Qu9khZU+64p0e6y02FUKHMabTiXSuOn4fQPzUzNx8Qajp2OUOCoJ/3sZAWRDwTYo7XrDT6Hqn0lEtc7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490537; c=relaxed/simple;
	bh=hPryPFjLQxt17wypVm7q83PWcS3S5NbIvZYrvM5jq+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drSo0ysXlqnw+C4o+f0NObWDiIPM8TnGQddOgjoeS3k1qHE6kNj77IQHUPpOKlkNSp2Jwa7EVSUCaCh/9ZEWvUUI6hw4rqpSTSjtZKVr9/JwEFzccGnmYAZ13A3u9Z4WRT5QGnEqBcRiakIJMNa8D0lvjtdRcSC8EjYeddRqsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXGCXX0v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733490534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=luQTG3HobMiLGPqsmBPNLtX1YUjWdLRxxX/mchSrWqw=;
	b=JXGCXX0vaUoWfIsD84rcANfCjAjZkDwazzT44RYlvsj4PDR54UQweDqBanzu0v01ntwJTR
	rQzJCOPyaY8iAlFP9457TW90WnuQ23duNQGC1r8bDuYCRUcAUulO5xxTJaVO8qBgisTs/Q
	bvsYBLmJUZ6x2/BoOGQt9XsMm33QuQQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-rqGSS7mhM7qy44-SY2epNA-1; Fri,
 06 Dec 2024 08:08:53 -0500
X-MC-Unique: rqGSS7mhM7qy44-SY2epNA-1
X-Mimecast-MFC-AGG-ID: rqGSS7mhM7qy44-SY2epNA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8667319560A2;
	Fri,  6 Dec 2024 13:08:51 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.103])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 368BB1955E80;
	Fri,  6 Dec 2024 13:08:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  6 Dec 2024 14:08:28 +0100 (CET)
Date: Fri, 6 Dec 2024 14:08:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: gregkh@linuxfoundation.org
Cc: frederic@kernel.org, anthony.mallet@laas.fr, tglx@linutronix.de,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] posix-timers: Target group sigqueue to
 current task only if" failed to apply to 6.12-stable tree
Message-ID: <20241206130824.GA31748@redhat.com>
References: <2024120656-jelly-gore-aa4c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <2024120656-jelly-gore-aa4c@gregkh>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

On 12/06, gregkh@linuxfoundation.org wrote:
>
> The patch below does not apply to the 6.12-stable tree.

Please see the attached patch. For v6.12 and the previous versions.

Oleg.

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-posix-timers-Target-group-sigqueue-to-current-task-o.patch~"

From 3851a6b5b7183f377bcedc98ffaecff067236ce5 Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <frederic@kernel.org>
Date: Fri, 6 Dec 2024 13:59:12 +0100
Subject: [PATCH -stable] posix-timers: Target group sigqueue to current task
 only if not exiting

From: Frederic Weisbecker <frederic@kernel.org>

commit 63dffecfba3eddcf67a8f76d80e0c141f93d44a5 upstream.

A sigqueue belonging to a posix timer, which target is not a specific
thread but a whole thread group, is preferrably targeted to the current
task if it is part of that thread group.

However nothing prevents a posix timer event from queueing such a
sigqueue from a reaped yet running task. The interruptible code space
between exit_notify() and the final call to schedule() is enough for
posix_timer_fn() hrtimer to fire.

If that happens while the current task is part of the thread group
target, it is proposed to handle it but since its sighand pointer may
have been cleared already, the sigqueue is dropped even if there are
other tasks running within the group that could handle it.

As a result posix timers with thread group wide target may miss signals
when some of their threads are exiting.

Fix this with verifying that the current task hasn't been through
exit_notify() before proposing it as a preferred target so as to ensure
that its sighand is still here and stable.

complete_signal() might still reconsider the choice and find a better
target within the group if current has passed retarget_shared_pending()
already.

Fixes: bcb7ee79029d ("posix-timers: Prefer delivery of signals to the current thread")
Reported-by: Anthony Mallet <anthony.mallet@laas.fr>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241122234811.60455-1-frederic@kernel.org
Closes: https://lore.kernel.org/all/26411.57288.238690.681680@gargle.gargle.HOWL
---
 kernel/signal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index cbabb2d05e0a..2ae45e6eb6bb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1986,14 +1986,15 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	 * into t->pending).
 	 *
 	 * Where type is not PIDTYPE_PID, signals must be delivered to the
-	 * process. In this case, prefer to deliver to current if it is in
-	 * the same thread group as the target process, which avoids
-	 * unnecessarily waking up a potentially idle task.
+	 * process. In this case, prefer to deliver to current if it is in the
+	 * same thread group as the target process and its sighand is stable,
+	 * which avoids unnecessarily waking up a potentially idle task.
 	 */
 	t = pid_task(pid, type);
 	if (!t)
 		goto ret;
-	if (type != PIDTYPE_PID && same_thread_group(t, current))
+	if (type != PIDTYPE_PID &&
+	    same_thread_group(t, current) && !current->exit_state)
 		t = current;
 	if (!likely(lock_task_sighand(t, &flags)))
 		goto ret;
-- 
2.25.1.362.g51ebf55


--4Ckj6UjgE2iN1+kY--


