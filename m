Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6256A78AD3C
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjH1Kqw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjH1KqX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:46:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCEA130
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:46:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D19164263
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC4CC433C7;
        Mon, 28 Aug 2023 10:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219559;
        bh=NxT4VX+ju7RFKrAeSZWG3f998ftvQjEvvNjPyJuva48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebeQUDweR+OfGwIMnM4reGtdBfps7vzp6ugIxhxKeXyRQcO73HQkwVvFEbX/pArba
         fvkx/nIBnxfRlvwkv1CR/2kePV4jb0r4E8gyjISn49xluY+YDdZzxgrk63gANY1fej
         eu8+mIzAd6yrVdCn2wD0dJo/AwBX3zrs6GxsurzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Qais Yousef (Google)" <qyousef@layalina.io>
Subject: [PATCH 5.15 78/89] sched/deadline: Create DL BW alloc, free & check overflow interface
Date:   Mon, 28 Aug 2023 12:14:19 +0200
Message-ID: <20230828101152.842066987@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

commit 85989106feb734437e2d598b639991b9185a43a6 upstream.

While moving a set of tasks between exclusive cpusets,
cpuset_can_attach() -> task_can_attach() calls dl_cpu_busy(..., p) for
DL BW overflow checking and per-task DL BW allocation on the destination
root_domain for the DL tasks in this set.

This approach has the issue of not freeing already allocated DL BW in
the following error cases:

(1) The set of tasks includes multiple DL tasks and DL BW overflow
    checking fails for one of the subsequent DL tasks.

(2) Another controller next to the cpuset controller which is attached
    to the same cgroup fails in its can_attach().

To address this problem rework dl_cpu_busy():

(1) Split it into dl_bw_check_overflow() & dl_bw_alloc() and add a
    dedicated dl_bw_free().

(2) dl_bw_alloc() & dl_bw_free() take a `u64 dl_bw` parameter instead of
    a `struct task_struct *p` used in dl_cpu_busy(). This allows to
    allocate DL BW for a set of tasks too rather than only for a single
    task.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/sched.h   |    2 +
 kernel/sched/core.c     |    4 +--
 kernel/sched/deadline.c |   53 ++++++++++++++++++++++++++++++++++++------------
 kernel/sched/sched.h    |    2 -
 4 files changed, 45 insertions(+), 16 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1798,6 +1798,8 @@ current_restore_flags(unsigned long orig
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
+extern int dl_bw_alloc(int cpu, u64 dl_bw);
+extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8814,7 +8814,7 @@ int task_can_attach(struct task_struct *
 
 		if (unlikely(cpu >= nr_cpu_ids))
 			return -EINVAL;
-		ret = dl_cpu_busy(cpu, p);
+		ret = dl_bw_alloc(cpu, p->dl.dl_bw);
 	}
 
 out:
@@ -9099,7 +9099,7 @@ static void cpuset_cpu_active(void)
 static int cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		int ret = dl_cpu_busy(cpu, NULL);
+		int ret = dl_bw_check_overflow(cpu);
 
 		if (ret)
 			return ret;
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2898,26 +2898,38 @@ int dl_cpuset_cpumask_can_shrink(const s
 	return ret;
 }
 
-int dl_cpu_busy(int cpu, struct task_struct *p)
+enum dl_bw_request {
+	dl_bw_req_check_overflow = 0,
+	dl_bw_req_alloc,
+	dl_bw_req_free
+};
+
+static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 {
-	unsigned long flags, cap;
+	unsigned long flags;
 	struct dl_bw *dl_b;
-	bool overflow;
+	bool overflow = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
-	cap = dl_bw_capacity(cpu);
-	overflow = __dl_overflow(dl_b, cap, 0, p ? p->dl.dl_bw : 0);
 
-	if (!overflow && p) {
-		/*
-		 * We reserve space for this task in the destination
-		 * root_domain, as we can't fail after this point.
-		 * We will free resources in the source root_domain
-		 * later on (see set_cpus_allowed_dl()).
-		 */
-		__dl_add(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
+	if (req == dl_bw_req_free) {
+		__dl_sub(dl_b, dl_bw, dl_bw_cpus(cpu));
+	} else {
+		unsigned long cap = dl_bw_capacity(cpu);
+
+		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
+
+		if (req == dl_bw_req_alloc && !overflow) {
+			/*
+			 * We reserve space in the destination
+			 * root_domain, as we can't fail after this point.
+			 * We will free resources in the source root_domain
+			 * later on (see set_cpus_allowed_dl()).
+			 */
+			__dl_add(dl_b, dl_bw, dl_bw_cpus(cpu));
+		}
 	}
 
 	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
@@ -2925,6 +2937,21 @@ int dl_cpu_busy(int cpu, struct task_str
 
 	return overflow ? -EBUSY : 0;
 }
+
+int dl_bw_check_overflow(int cpu)
+{
+	return dl_bw_manage(dl_bw_req_check_overflow, cpu, 0);
+}
+
+int dl_bw_alloc(int cpu, u64 dl_bw)
+{
+	return dl_bw_manage(dl_bw_req_alloc, cpu, dl_bw);
+}
+
+void dl_bw_free(int cpu, u64 dl_bw)
+{
+	dl_bw_manage(dl_bw_req_free, cpu, dl_bw);
+}
 #endif
 
 #ifdef CONFIG_SCHED_DEBUG
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -349,7 +349,7 @@ extern void __getparam_dl(struct task_st
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int  dl_cpu_busy(int cpu, struct task_struct *p);
+extern int  dl_bw_check_overflow(int cpu);
 
 #ifdef CONFIG_CGROUP_SCHED
 


