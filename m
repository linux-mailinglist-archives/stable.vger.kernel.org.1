Return-Path: <stable+bounces-117567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86397A3B773
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E47A3BBDE7
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F711E0E16;
	Wed, 19 Feb 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d86g/KxH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571661E0E0F;
	Wed, 19 Feb 2025 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955686; cv=none; b=dW62NG+iEYYWzN8P+mXwx3xOTlV9ZwNA7Y8g+oMglEjd61+uUuc/WoYmGgD2rH1J29jdae5eTtztmEcRjceqJbzrlB8J6X3U+lxG/FcbBb+eEP9IhWdLR0MOd+qHiTYVGzdhA4ZfA9ocEhOLWFf3ig/2Ivg7WohzpRSakbCfICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955686; c=relaxed/simple;
	bh=+Yuqq0XsKT4iHrWEjxyl1e2awTCsG4/ck21lhmmyizI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCLHprOu//bMP0VAQ65Iguz3NVNMYXBXNWp1py9LmZvaBbkbFDybQFLWdSi1k4IM1J3bY7duiQ1dYV5pzpo+ST8xNkSw1sn4t3gXwXSRHX7nxE/sAJrtMBB6uEY/HJMDRdb7j0S/IHQUrOQU9QzOaC10AUjhjPPqhTnbQq6Lxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d86g/KxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D11C4CED1;
	Wed, 19 Feb 2025 09:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955685;
	bh=+Yuqq0XsKT4iHrWEjxyl1e2awTCsG4/ck21lhmmyizI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d86g/KxHMTIk+MwW10Pr2gEzVBJCRCeRboQxHiMsK5vYrnonDkdrIkSJlIYj+2bWA
	 RHWqIZ0STdX6ouWGcB8pWU++0VrEGgpCHmQFzTM/jGZBldZuyYRQeOYGQhinDOa3Zq
	 slr+r9SIs45loEUEXusoauL3ljoXtujvXYJ1ylOI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH 6.6 082/152] cgroup: fix race between fork and cgroup.kill
Date: Wed, 19 Feb 2025 09:28:15 +0100
Message-ID: <20250219082553.292682735@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082550.014812078@linuxfoundation.org>
References: <20250219082550.014812078@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shakeel Butt <shakeel.butt@linux.dev>

commit b69bb476dee99d564d65d418e9a20acca6f32c3f upstream.

Tejun reported the following race between fork() and cgroup.kill at [1].

Tejun:
  I was looking at cgroup.kill implementation and wondering whether there
  could be a race window. So, __cgroup_kill() does the following:

   k1. Set CGRP_KILL.
   k2. Iterate tasks and deliver SIGKILL.
   k3. Clear CGRP_KILL.

  The copy_process() does the following:

   c1. Copy a bunch of stuff.
   c2. Grab siglock.
   c3. Check fatal_signal_pending().
   c4. Commit to forking.
   c5. Release siglock.
   c6. Call cgroup_post_fork() which puts the task on the css_set and tests
       CGRP_KILL.

  The intention seems to be that either a forking task gets SIGKILL and
  terminates on c3 or it sees CGRP_KILL on c6 and kills the child. However, I
  don't see what guarantees that k3 can't happen before c6. ie. After a
  forking task passes c5, k2 can take place and then before the forking task
  reaches c6, k3 can happen. Then, nobody would send SIGKILL to the child.
  What am I missing?

This is indeed a race. One way to fix this race is by taking
cgroup_threadgroup_rwsem in write mode in __cgroup_kill() as the fork()
side takes cgroup_threadgroup_rwsem in read mode from cgroup_can_fork()
to cgroup_post_fork(). However that would be heavy handed as this adds
one more potential stall scenario for cgroup.kill which is usually
called under extreme situation like memory pressure.

To fix this race, let's maintain a sequence number per cgroup which gets
incremented on __cgroup_kill() call. On the fork() side, the
cgroup_can_fork() will cache the sequence number locally and recheck it
against the cgroup's sequence number at cgroup_post_fork() site. If the
sequence numbers mismatch, it means __cgroup_kill() can been called and
we should send SIGKILL to the newly created task.

Reported-by: Tejun Heo <tj@kernel.org>
Closes: https://lore.kernel.org/all/Z5QHE2Qn-QZ6M-KW@slm.duckdns.org/ [1]
Fixes: 661ee6280931 ("cgroup: introduce cgroup.kill")
Cc: stable@vger.kernel.org # v5.14+
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/cgroup-defs.h |    6 +++---
 include/linux/sched/task.h  |    1 +
 kernel/cgroup/cgroup.c      |   20 ++++++++++++--------
 3 files changed, 16 insertions(+), 11 deletions(-)

--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -71,9 +71,6 @@ enum {
 
 	/* Cgroup is frozen. */
 	CGRP_FROZEN,
-
-	/* Control group has to be killed. */
-	CGRP_KILL,
 };
 
 /* cgroup_root->flags */
@@ -438,6 +435,9 @@ struct cgroup {
 
 	int nr_threaded_children;	/* # of live threaded child cgroups */
 
+	/* sequence number for cgroup.kill, serialized by css_set_lock. */
+	unsigned int kill_seq;
+
 	struct kernfs_node *kn;		/* cgroup kernfs entry */
 	struct cgroup_file procs_file;	/* handle for "cgroup.procs" */
 	struct cgroup_file events_file;	/* handle for "cgroup.events" */
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -41,6 +41,7 @@ struct kernel_clone_args {
 	void *fn_arg;
 	struct cgroup *cgrp;
 	struct css_set *cset;
+	unsigned int kill_seq;
 };
 
 /*
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3941,7 +3941,7 @@ static void __cgroup_kill(struct cgroup
 	lockdep_assert_held(&cgroup_mutex);
 
 	spin_lock_irq(&css_set_lock);
-	set_bit(CGRP_KILL, &cgrp->flags);
+	cgrp->kill_seq++;
 	spin_unlock_irq(&css_set_lock);
 
 	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
@@ -3957,10 +3957,6 @@ static void __cgroup_kill(struct cgroup
 		send_sig(SIGKILL, task, 0);
 	}
 	css_task_iter_end(&it);
-
-	spin_lock_irq(&css_set_lock);
-	clear_bit(CGRP_KILL, &cgrp->flags);
-	spin_unlock_irq(&css_set_lock);
 }
 
 static void cgroup_kill(struct cgroup *cgrp)
@@ -6399,6 +6395,10 @@ static int cgroup_css_set_fork(struct ke
 	spin_lock_irq(&css_set_lock);
 	cset = task_css_set(current);
 	get_css_set(cset);
+	if (kargs->cgrp)
+		kargs->kill_seq = kargs->cgrp->kill_seq;
+	else
+		kargs->kill_seq = cset->dfl_cgrp->kill_seq;
 	spin_unlock_irq(&css_set_lock);
 
 	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
@@ -6582,6 +6582,7 @@ void cgroup_post_fork(struct task_struct
 		      struct kernel_clone_args *kargs)
 	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
 {
+	unsigned int cgrp_kill_seq = 0;
 	unsigned long cgrp_flags = 0;
 	bool kill = false;
 	struct cgroup_subsys *ss;
@@ -6595,10 +6596,13 @@ void cgroup_post_fork(struct task_struct
 
 	/* init tasks are special, only link regular threads */
 	if (likely(child->pid)) {
-		if (kargs->cgrp)
+		if (kargs->cgrp) {
 			cgrp_flags = kargs->cgrp->flags;
-		else
+			cgrp_kill_seq = kargs->cgrp->kill_seq;
+		} else {
 			cgrp_flags = cset->dfl_cgrp->flags;
+			cgrp_kill_seq = cset->dfl_cgrp->kill_seq;
+		}
 
 		WARN_ON_ONCE(!list_empty(&child->cg_list));
 		cset->nr_tasks++;
@@ -6633,7 +6637,7 @@ void cgroup_post_fork(struct task_struct
 		 * child down right after we finished preparing it for
 		 * userspace.
 		 */
-		kill = test_bit(CGRP_KILL, &cgrp_flags);
+		kill = kargs->kill_seq != cgrp_kill_seq;
 	}
 
 	spin_unlock_irq(&css_set_lock);



