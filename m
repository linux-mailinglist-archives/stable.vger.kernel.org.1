Return-Path: <stable+bounces-35853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0758089779C
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 19:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0455283339
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F0F29427;
	Wed,  3 Apr 2024 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jK7XBnyN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85314E2F9;
	Wed,  3 Apr 2024 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167019; cv=none; b=QfHV80N6Q5iR1n4rXc0XVfA0rGDWm2cpqWm/GMisEAYRpH9y6xwmGRhvDqlKUj/qQDA/hGTFbafCbRqoHd+SNRPK3tDhZ+LW3bq2HfH9Iu9BMCvLbU6s3yxmNiCZzWccKyqSLeFPbQB9SWL1Xi1OOud3IClKQr7dIWfP0h/7HXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167019; c=relaxed/simple;
	bh=opMUIsWsjOFYIkbK3hmZl6XeAIkDLapkdLZyeQnHttY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzSmK5eLhu27eSrJJk6aKrc4P3/QeKc1NAdnpKZfmrz/1I84gW+heFrUxUblD0Xhixcz133VKdv8e3BSjRFgQ5Rl1d0ghGnIarO5dvMD0aYvYajy2b2HwZtptqpMXBm1yGxSasuZ1nHtSbuA23MTnfXFMnsU6kN65kglX6FxwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jK7XBnyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1CFC433C7;
	Wed,  3 Apr 2024 17:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712167019;
	bh=opMUIsWsjOFYIkbK3hmZl6XeAIkDLapkdLZyeQnHttY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jK7XBnyN0cLerJMYnoYzTqIZ/u4ZrjFBCLOqoFg9TIfWt4RWssKv14M0u+SFdioH8
	 cl0dvsaUijOBVg+3VpV65k6QKy93iKcUvQcIefOFBB3RtxJOQCwissNxIvgr0uhmoo
	 YA+76vluLmeDSuwcdPO8U5NWRnfBFY86ACRN0xy4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Tejun Heo <tj@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Audra Mitchell <audra@redhat.com>
Subject: [PATCH 6.6 05/11] Revert "workqueue: RCU protect wq->dfl_pwq and implement accessors for it"
Date: Wed,  3 Apr 2024 19:55:54 +0200
Message-ID: <20240403175127.016413378@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403175126.839589571@linuxfoundation.org>
References: <20240403175126.839589571@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit bd31fb926dfa02d2ccfb4b79389168b1d16f36b1 which is
commit 9f66cff212bb3c1cd25996aaa0dfd0c9e9d8baab upstream.

The workqueue patches backported to 6.6.y caused some reported
regressions, so revert them for now.

Reported-by: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Tejun Heo <tj@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Audra Mitchell <audra@redhat.com>
Link: https://lore.kernel.org/all/ce4c2f67-c298-48a0-87a3-f933d646c73b@leemhuis.info/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/workqueue.c |   64 +++++++++++++++++++----------------------------------
 1 file changed, 24 insertions(+), 40 deletions(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -304,7 +304,7 @@ struct workqueue_struct {
 	int			saved_max_active; /* WQ: saved max_active */
 
 	struct workqueue_attrs	*unbound_attrs;	/* PW: only for unbound wqs */
-	struct pool_workqueue __rcu *dfl_pwq;   /* PW: only for unbound wqs */
+	struct pool_workqueue	*dfl_pwq;	/* PW: only for unbound wqs */
 
 #ifdef CONFIG_SYSFS
 	struct wq_device	*wq_dev;	/* I: for sysfs interface */
@@ -629,23 +629,6 @@ static int worker_pool_assign_id(struct
 	return ret;
 }
 
-static struct pool_workqueue __rcu **
-unbound_pwq_slot(struct workqueue_struct *wq, int cpu)
-{
-       if (cpu >= 0)
-               return per_cpu_ptr(wq->cpu_pwq, cpu);
-       else
-               return &wq->dfl_pwq;
-}
-
-/* @cpu < 0 for dfl_pwq */
-static struct pool_workqueue *unbound_pwq(struct workqueue_struct *wq, int cpu)
-{
-	return rcu_dereference_check(*unbound_pwq_slot(wq, cpu),
-				     lockdep_is_held(&wq_pool_mutex) ||
-				     lockdep_is_held(&wq->mutex));
-}
-
 static unsigned int work_color_to_flags(int color)
 {
 	return color << WORK_STRUCT_COLOR_SHIFT;
@@ -4335,11 +4318,10 @@ static void wq_calc_pod_cpumask(struct w
 				"possible intersect\n");
 }
 
-/* install @pwq into @wq and return the old pwq, @cpu < 0 for dfl_pwq */
+/* install @pwq into @wq's cpu_pwq and return the old pwq */
 static struct pool_workqueue *install_unbound_pwq(struct workqueue_struct *wq,
 					int cpu, struct pool_workqueue *pwq)
 {
-	struct pool_workqueue __rcu **slot = unbound_pwq_slot(wq, cpu);
 	struct pool_workqueue *old_pwq;
 
 	lockdep_assert_held(&wq_pool_mutex);
@@ -4348,8 +4330,8 @@ static struct pool_workqueue *install_un
 	/* link_pwq() can handle duplicate calls */
 	link_pwq(pwq);
 
-	old_pwq = rcu_access_pointer(*slot);
-	rcu_assign_pointer(*slot, pwq);
+	old_pwq = rcu_access_pointer(*per_cpu_ptr(wq->cpu_pwq, cpu));
+	rcu_assign_pointer(*per_cpu_ptr(wq->cpu_pwq, cpu), pwq);
 	return old_pwq;
 }
 
@@ -4449,11 +4431,14 @@ static void apply_wqattrs_commit(struct
 
 	copy_workqueue_attrs(ctx->wq->unbound_attrs, ctx->attrs);
 
-	/* save the previous pwqs and install the new ones */
+	/* save the previous pwq and install the new one */
 	for_each_possible_cpu(cpu)
 		ctx->pwq_tbl[cpu] = install_unbound_pwq(ctx->wq, cpu,
 							ctx->pwq_tbl[cpu]);
-	ctx->dfl_pwq = install_unbound_pwq(ctx->wq, -1, ctx->dfl_pwq);
+
+	/* @dfl_pwq might not have been used, ensure it's linked */
+	link_pwq(ctx->dfl_pwq);
+	swap(ctx->wq->dfl_pwq, ctx->dfl_pwq);
 
 	mutex_unlock(&ctx->wq->mutex);
 }
@@ -4576,7 +4561,9 @@ static void wq_update_pod(struct workque
 
 	/* nothing to do if the target cpumask matches the current pwq */
 	wq_calc_pod_cpumask(target_attrs, cpu, off_cpu);
-	if (wqattrs_equal(target_attrs, unbound_pwq(wq, cpu)->pool->attrs))
+	pwq = rcu_dereference_protected(*per_cpu_ptr(wq->cpu_pwq, cpu),
+					lockdep_is_held(&wq_pool_mutex));
+	if (wqattrs_equal(target_attrs, pwq->pool->attrs))
 		return;
 
 	/* create a new pwq */
@@ -4594,11 +4581,10 @@ static void wq_update_pod(struct workque
 
 use_dfl_pwq:
 	mutex_lock(&wq->mutex);
-	pwq = unbound_pwq(wq, -1);
-	raw_spin_lock_irq(&pwq->pool->lock);
-	get_pwq(pwq);
-	raw_spin_unlock_irq(&pwq->pool->lock);
-	old_pwq = install_unbound_pwq(wq, cpu, pwq);
+	raw_spin_lock_irq(&wq->dfl_pwq->pool->lock);
+	get_pwq(wq->dfl_pwq);
+	raw_spin_unlock_irq(&wq->dfl_pwq->pool->lock);
+	old_pwq = install_unbound_pwq(wq, cpu, wq->dfl_pwq);
 out_unlock:
 	mutex_unlock(&wq->mutex);
 	put_pwq_unlocked(old_pwq);
@@ -4636,13 +4622,10 @@ static int alloc_and_link_pwqs(struct wo
 
 	cpus_read_lock();
 	if (wq->flags & __WQ_ORDERED) {
-		struct pool_workqueue *dfl_pwq;
-
 		ret = apply_workqueue_attrs(wq, ordered_wq_attrs[highpri]);
 		/* there should only be single pwq for ordering guarantee */
-		dfl_pwq = rcu_access_pointer(wq->dfl_pwq);
-		WARN(!ret && (wq->pwqs.next != &dfl_pwq->pwqs_node ||
-			      wq->pwqs.prev != &dfl_pwq->pwqs_node),
+		WARN(!ret && (wq->pwqs.next != &wq->dfl_pwq->pwqs_node ||
+			      wq->pwqs.prev != &wq->dfl_pwq->pwqs_node),
 		     "ordering guarantee broken for workqueue %s\n", wq->name);
 	} else {
 		ret = apply_workqueue_attrs(wq, unbound_std_wq_attrs[highpri]);
@@ -4873,7 +4856,7 @@ static bool pwq_busy(struct pool_workque
 		if (pwq->nr_in_flight[i])
 			return true;
 
-	if ((pwq != rcu_access_pointer(pwq->wq->dfl_pwq)) && (pwq->refcnt > 1))
+	if ((pwq != pwq->wq->dfl_pwq) && (pwq->refcnt > 1))
 		return true;
 	if (!pwq_is_empty(pwq))
 		return true;
@@ -4957,12 +4940,13 @@ void destroy_workqueue(struct workqueue_
 	rcu_read_lock();
 
 	for_each_possible_cpu(cpu) {
-		put_pwq_unlocked(unbound_pwq(wq, cpu));
-		RCU_INIT_POINTER(*unbound_pwq_slot(wq, cpu), NULL);
+		pwq = rcu_access_pointer(*per_cpu_ptr(wq->cpu_pwq, cpu));
+		RCU_INIT_POINTER(*per_cpu_ptr(wq->cpu_pwq, cpu), NULL);
+		put_pwq_unlocked(pwq);
 	}
 
-	put_pwq_unlocked(unbound_pwq(wq, -1));
-	RCU_INIT_POINTER(*unbound_pwq_slot(wq, -1), NULL);
+	put_pwq_unlocked(wq->dfl_pwq);
+	wq->dfl_pwq = NULL;
 
 	rcu_read_unlock();
 }



