Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395877611E3
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjGYK5T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjGYK45 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:56:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB384211
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:54:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C85261689
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DA1C433C7;
        Tue, 25 Jul 2023 10:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282465;
        bh=mRviHDbdKNgAwBtIsZOfWDMl4mbtjm6dYMlZ8lj33oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnhVgdrqv8ztDD744EweHiXPACZ563mQGm/AXYkZA45a0qe8LqQHCvwkQf7y5BEVE
         E4J7IF1vD34N5rBdRU/nxOHRcfGip1nB74y59xY4/SxfYaqaIVQKOWia7fq08k/s1a
         X+Y9/Thvd6996g1qfZ9zGodcaTXNOGwrpbT7wvFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lu Jialin <lujialin4@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 140/227] sched/psi: use kernfs polling functions for PSI trigger polling
Date:   Tue, 25 Jul 2023 12:45:07 +0200
Message-ID: <20230725104520.661598633@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Suren Baghdasaryan <surenb@google.com>

[ Upstream commit aff037078ecaecf34a7c2afab1341815f90fba5e ]

Destroying psi trigger in cgroup_file_release causes UAF issues when
a cgroup is removed from under a polling process. This is happening
because cgroup removal causes a call to cgroup_file_release while the
actual file is still alive. Destroying the trigger at this point would
also destroy its waitqueue head and if there is still a polling process
on that file accessing the waitqueue, it will step on the freed pointer:

do_select
  vfs_poll
                           do_rmdir
                             cgroup_rmdir
                               kernfs_drain_open_files
                                 cgroup_file_release
                                   cgroup_pressure_release
                                     psi_trigger_destroy
                                       wake_up_pollfree(&t->event_wait)
// vfs_poll is unblocked
                                       synchronize_rcu
                                       kfree(t)
  poll_freewait -> UAF access to the trigger's waitqueue head

Patch [1] fixed this issue for epoll() case using wake_up_pollfree(),
however the same issue exists for synchronous poll() case.
The root cause of this issue is that the lifecycles of the psi trigger's
waitqueue and of the file associated with the trigger are different. Fix
this by using kernfs_generic_poll function when polling on cgroup-specific
psi triggers. It internally uses kernfs_open_node->poll waitqueue head
with its lifecycle tied to the file's lifecycle. This also renders the
fix in [1] obsolete, so revert it.

[1] commit c2dbe32d5db5 ("sched/psi: Fix use-after-free in ep_remove_wait_queue()")

Fixes: 0e94682b73bf ("psi: introduce psi monitor")
Closes: https://lore.kernel.org/all/20230613062306.101831-1-lujialin4@huawei.com/
Reported-by: Lu Jialin <lujialin4@huawei.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230630005612.1014540-1-surenb@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/psi.h       |  5 +++--
 include/linux/psi_types.h |  3 +++
 kernel/cgroup/cgroup.c    |  2 +-
 kernel/sched/psi.c        | 29 +++++++++++++++++++++--------
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index ab26200c28033..e0745873e3f26 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -23,8 +23,9 @@ void psi_memstall_enter(unsigned long *flags);
 void psi_memstall_leave(unsigned long *flags);
 
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
-struct psi_trigger *psi_trigger_create(struct psi_group *group,
-			char *buf, enum psi_res res, struct file *file);
+struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
+				       enum psi_res res, struct file *file,
+				       struct kernfs_open_file *of);
 void psi_trigger_destroy(struct psi_trigger *t);
 
 __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 040c089581c6c..f1fd3a8044e0e 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -137,6 +137,9 @@ struct psi_trigger {
 	/* Wait queue for polling */
 	wait_queue_head_t event_wait;
 
+	/* Kernfs file for cgroup triggers */
+	struct kernfs_open_file *of;
+
 	/* Pending event flag */
 	int event;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4d42f0cbc11ea..3299ec69ce0d1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3785,7 +3785,7 @@ static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
 	}
 
 	psi = cgroup_psi(cgrp);
-	new = psi_trigger_create(psi, buf, res, of->file);
+	new = psi_trigger_create(psi, buf, res, of->file, of);
 	if (IS_ERR(new)) {
 		cgroup_put(cgrp);
 		return PTR_ERR(new);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index e072f6b31bf30..80d8c10e93638 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -494,8 +494,12 @@ static u64 update_triggers(struct psi_group *group, u64 now, bool *update_total,
 			continue;
 
 		/* Generate an event */
-		if (cmpxchg(&t->event, 0, 1) == 0)
-			wake_up_interruptible(&t->event_wait);
+		if (cmpxchg(&t->event, 0, 1) == 0) {
+			if (t->of)
+				kernfs_notify(t->of->kn);
+			else
+				wake_up_interruptible(&t->event_wait);
+		}
 		t->last_event_time = now;
 		/* Reset threshold breach flag once event got generated */
 		t->pending_event = false;
@@ -1272,8 +1276,9 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 	return 0;
 }
 
-struct psi_trigger *psi_trigger_create(struct psi_group *group,
-			char *buf, enum psi_res res, struct file *file)
+struct psi_trigger *psi_trigger_create(struct psi_group *group, char *buf,
+				       enum psi_res res, struct file *file,
+				       struct kernfs_open_file *of)
 {
 	struct psi_trigger *t;
 	enum psi_states state;
@@ -1333,7 +1338,9 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 
 	t->event = 0;
 	t->last_event_time = 0;
-	init_waitqueue_head(&t->event_wait);
+	t->of = of;
+	if (!of)
+		init_waitqueue_head(&t->event_wait);
 	t->pending_event = false;
 	t->aggregator = privileged ? PSI_POLL : PSI_AVGS;
 
@@ -1390,7 +1397,10 @@ void psi_trigger_destroy(struct psi_trigger *t)
 	 * being accessed later. Can happen if cgroup is deleted from under a
 	 * polling process.
 	 */
-	wake_up_pollfree(&t->event_wait);
+	if (t->of)
+		kernfs_notify(t->of->kn);
+	else
+		wake_up_interruptible(&t->event_wait);
 
 	if (t->aggregator == PSI_AVGS) {
 		mutex_lock(&group->avgs_lock);
@@ -1462,7 +1472,10 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
 	if (!t)
 		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
 
-	poll_wait(file, &t->event_wait, wait);
+	if (t->of)
+		kernfs_generic_poll(t->of, wait);
+	else
+		poll_wait(file, &t->event_wait, wait);
 
 	if (cmpxchg(&t->event, 1, 0) == 1)
 		ret |= EPOLLPRI;
@@ -1532,7 +1545,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 		return -EBUSY;
 	}
 
-	new = psi_trigger_create(&psi_system, buf, res, file);
+	new = psi_trigger_create(&psi_system, buf, res, file, NULL);
 	if (IS_ERR(new)) {
 		mutex_unlock(&seq->lock);
 		return PTR_ERR(new);
-- 
2.39.2



