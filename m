Return-Path: <stable+bounces-91192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1659BECE0
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1781C20865
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580621DF995;
	Wed,  6 Nov 2024 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BUCXERIj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151DD1D2F42;
	Wed,  6 Nov 2024 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898012; cv=none; b=QIgaI76Bta0wlelsK//5EGzwnkzFvzzf73Fin7l7SG6yBK6qz7rw/DSkbInmLXesZkCKvVDIVXo77OzQPF0V8v92HArf7AFVEyht8jZ0Cmdlgvrw8qcVpaDbTyWG6T+FJQRzErljDRPkc1Pq03Zp9xnzVGOoXCx8IjuqcHpaE9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898012; c=relaxed/simple;
	bh=1zVV/vFJEsHPe2ETR8tghE8+B9UBT4nf4F9FdLFmvd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=goL4iRUm4OPZf/Mk6nU99waB1nWsJZN+gkBihSKj/SxpsIO+wYdS2Xdc0aEGpSlN1cUzwLfnWJFL13VBC/hTAbvAyzfnldpyuPpK1a/b5IxCnclbwZZzHpAoRvIfzGz0XyClTD6ngRNHm7riNLdEjWSmjSxujNubMXEvKgNt1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BUCXERIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B32C4CECD;
	Wed,  6 Nov 2024 13:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898012;
	bh=1zVV/vFJEsHPe2ETR8tghE8+B9UBT4nf4F9FdLFmvd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUCXERIjz+zCx+SOfKZawlVqF6sR8yAE9J3z+107uwRqMjoI6kFLS3U7PmnvvkM3b
	 i/mI1Kul383o8IfyN1C8oeDdq707cnD4leRoBHYUS0xw6nGgF8BLdlodi17dCP7lzl
	 3Eq6lSL0QO6yk+6M8Osst4Dv1n+6yZsu4are3LkQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Yu <yu.c.chen@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	David Gow <davidgow@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 094/462] kthread: fix task state in kthread worker if being frozen
Date: Wed,  6 Nov 2024 12:59:47 +0100
Message-ID: <20241106120333.831042693@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Yu <yu.c.chen@intel.com>

[ Upstream commit e16c7b07784f3fb03025939c4590b9a7c64970a7 ]

When analyzing a kernel waring message, Peter pointed out that there is a
race condition when the kworker is being frozen and falls into
try_to_freeze() with TASK_INTERRUPTIBLE, which could trigger a
might_sleep() warning in try_to_freeze().  Although the root cause is not
related to freeze()[1], it is still worthy to fix this issue ahead.

One possible race scenario:

        CPU 0                                           CPU 1
        -----                                           -----

        // kthread_worker_fn
        set_current_state(TASK_INTERRUPTIBLE);
                                                       suspend_freeze_processes()
                                                         freeze_processes
                                                           static_branch_inc(&freezer_active);
                                                         freeze_kernel_threads
                                                           pm_nosig_freezing = true;
        if (work) { //false
          __set_current_state(TASK_RUNNING);

        } else if (!freezing(current)) //false, been frozen

                      freezing():
                      if (static_branch_unlikely(&freezer_active))
                        if (pm_nosig_freezing)
                          return true;
          schedule()
	}

        // state is still TASK_INTERRUPTIBLE
        try_to_freeze()
          might_sleep() <--- warning

Fix this by explicitly set the TASK_RUNNING before entering
try_to_freeze().

Link: https://lore.kernel.org/lkml/Zs2ZoAcUsZMX2B%2FI@chenyu5-mobl2/ [1]
Link: https://lkml.kernel.org/r/20240827112308.181081-1-yu.c.chen@intel.com
Fixes: b56c0d8937e6 ("kthread: implement kthread_worker")
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: David Gow <davidgow@google.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Mickaël Salaün <mic@digikod.net>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kthread.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index eb2b54ae93ee6..2423ae25b5666 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -734,8 +734,16 @@ int kthread_worker_fn(void *worker_ptr)
 		 * event only cares about the address.
 		 */
 		trace_sched_kthread_work_execute_end(work, func);
-	} else if (!freezing(current))
+	} else if (!freezing(current)) {
 		schedule();
+	} else {
+		/*
+		 * Handle the case where the current remains
+		 * TASK_INTERRUPTIBLE. try_to_freeze() expects
+		 * the current to be TASK_RUNNING.
+		 */
+		__set_current_state(TASK_RUNNING);
+	}
 
 	try_to_freeze();
 	cond_resched();
-- 
2.43.0




