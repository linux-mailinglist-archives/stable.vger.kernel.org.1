Return-Path: <stable+bounces-132961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B01A918B6
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B4D67A7CC9
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C4622838F;
	Thu, 17 Apr 2025 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fXWe5LtK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877AC1D63D6
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884276; cv=none; b=EO5paK+eL5YOcvBIck2IGeNDZM3bwimUXJMLwGQ26e6lwua0xD21lhr4HeDy0KaeM35NIeJnaH8CWQjhGcuoBcu4pMV/hTXylocfnjkuKW3KF0BcN20k3Nqp2smQLRze8w1iAA9WjudO1zIPUx2vFJcKLf225qVsRHFPf2jvakM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884276; c=relaxed/simple;
	bh=ag5MiLQIgwkbMtLRWPRTgHCfwXnORhKUIUhNWM3TjUc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rP4voSJFeiBmU9inD+9k/ye+sQtOFdhppKDxNITtR9IBUJ6Mr4zbO3PaNicEcrRofKflXOGKy5ZtdQLUDo4hP3q3eQgTHe6Wv1Wm6vF9funIO3/m3h0N+sxEaRlHefPZaqNhkvzvIevPpT+sj7anBhsK6cR6kO5RH3BTgJO6X5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fXWe5LtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF79C4CEE4;
	Thu, 17 Apr 2025 10:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744884274;
	bh=ag5MiLQIgwkbMtLRWPRTgHCfwXnORhKUIUhNWM3TjUc=;
	h=Subject:To:Cc:From:Date:From;
	b=fXWe5LtKwb7wfSwQ19666cPHBmwtL6ITAmvIaZEHT6we/5M0pRqM2/WJxwgGEKh4p
	 MLW9vFvhQR6sZgCsm2cJ6s3yzuR7br1FHPVMZpALW6+INhJtkknYYBUVtDsiFdPCIW
	 gu93EWfToc39fHwE5/T8oxaCyUJ/zg8Q80Cgg4q4=
Subject: FAILED: patch "[PATCH] PM: EM: Address RCU-related sparse warnings" failed to apply to 6.1-stable tree
To: rafael.j.wysocki@intel.com,lukasz.luba@arm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:04:23 +0200
Message-ID: <2025041723-pronounce-squishy-9d2c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3ee7be9e10dd5f79448788b899591d4bd2bf0c19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041723-pronounce-squishy-9d2c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3ee7be9e10dd5f79448788b899591d4bd2bf0c19 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Thu, 6 Mar 2025 17:49:20 +0100
Subject: [PATCH] PM: EM: Address RCU-related sparse warnings

The usage of __rcu in the Energy Model code is quite inconsistent
which causes the following sparse warnings to trigger:

kernel/power/energy_model.c:169:15: warning: incorrect type in assignment (different address spaces)
kernel/power/energy_model.c:169:15:    expected struct em_perf_table [noderef] __rcu *table
kernel/power/energy_model.c:169:15:    got struct em_perf_table *
kernel/power/energy_model.c:171:9: warning: incorrect type in argument 1 (different address spaces)
kernel/power/energy_model.c:171:9:    expected struct callback_head *head
kernel/power/energy_model.c:171:9:    got struct callback_head [noderef] __rcu *
kernel/power/energy_model.c:171:9: warning: cast removes address space '__rcu' of expression
kernel/power/energy_model.c:182:19: warning: incorrect type in argument 1 (different address spaces)
kernel/power/energy_model.c:182:19:    expected struct kref *kref
kernel/power/energy_model.c:182:19:    got struct kref [noderef] __rcu *
kernel/power/energy_model.c:200:15: warning: incorrect type in assignment (different address spaces)
kernel/power/energy_model.c:200:15:    expected struct em_perf_table [noderef] __rcu *table
kernel/power/energy_model.c:200:15:    got void *[assigned] _res
kernel/power/energy_model.c:204:20: warning: incorrect type in argument 1 (different address spaces)
kernel/power/energy_model.c:204:20:    expected struct kref *kref
kernel/power/energy_model.c:204:20:    got struct kref [noderef] __rcu *
kernel/power/energy_model.c:320:19: warning: incorrect type in argument 1 (different address spaces)
kernel/power/energy_model.c:320:19:    expected struct kref *kref
kernel/power/energy_model.c:320:19:    got struct kref [noderef] __rcu *
kernel/power/energy_model.c:325:45: warning: incorrect type in argument 2 (different address spaces)
kernel/power/energy_model.c:325:45:    expected struct em_perf_state *table
kernel/power/energy_model.c:325:45:    got struct em_perf_state [noderef] __rcu *
kernel/power/energy_model.c:425:45: warning: incorrect type in argument 3 (different address spaces)
kernel/power/energy_model.c:425:45:    expected struct em_perf_state *table
kernel/power/energy_model.c:425:45:    got struct em_perf_state [noderef] __rcu *
kernel/power/energy_model.c:442:15: warning: incorrect type in argument 1 (different address spaces)
kernel/power/energy_model.c:442:15:    expected void const *objp
kernel/power/energy_model.c:442:15:    got struct em_perf_table [noderef] __rcu *[assigned] em_table
kernel/power/energy_model.c:626:55: warning: incorrect type in argument 2 (different address spaces)
kernel/power/energy_model.c:626:55:    expected struct em_perf_state *table
kernel/power/energy_model.c:626:55:    got struct em_perf_state [noderef] __rcu *
kernel/power/energy_model.c:681:16: warning: incorrect type in assignment (different address spaces)
kernel/power/energy_model.c:681:16:    expected struct em_perf_state *new_ps
kernel/power/energy_model.c:681:16:    got struct em_perf_state [noderef] __rcu *
kernel/power/energy_model.c:699:37: warning: incorrect type in argument 2 (different address spaces)
kernel/power/energy_model.c:699:37:    expected struct em_perf_state *table
kernel/power/energy_model.c:699:37:    got struct em_perf_state [noderef] __rcu *
kernel/power/energy_model.c:733:38: warning: incorrect type in argument 3 (different address spaces)
kernel/power/energy_model.c:733:38:    expected struct em_perf_state *table
kernel/power/energy_model.c:733:38:    got struct em_perf_state [noderef] __rcu *
kernel/power/energy_model.c:855:53: warning: dereference of noderef expression
kernel/power/energy_model.c:864:32: warning: dereference of noderef expression

This is because the __rcu annotation for sparse is only applicable to
pointers that need rcu_dereference() or equivalent for protection, which
basically means pointers assigned with rcu_assign_pointer().

Make all of the above sparse warnings go away by cleaning up the usage
of __rcu and using rcu_dereference_protected() where applicable.

Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://patch.msgid.link/5885405.DvuYhMxLoT@rjwysocki.net

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index b23c8c798dac..ddd09debfc7d 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -167,13 +167,13 @@ struct em_data_callback {
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
 int em_dev_update_perf_domain(struct device *dev,
-			      struct em_perf_table __rcu *new_table);
+			      struct em_perf_table *new_table);
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				const struct em_data_callback *cb,
 				const cpumask_t *cpus, bool microwatts);
 void em_dev_unregister_perf_domain(struct device *dev);
-struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
-void em_table_free(struct em_perf_table __rcu *table);
+struct em_perf_table *em_table_alloc(struct em_perf_domain *pd);
+void em_table_free(struct em_perf_table *table);
 int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
 			 int nr_states);
 int em_dev_update_chip_binning(struct device *dev);
@@ -373,14 +373,14 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
 	return 0;
 }
 static inline
-struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd)
+struct em_perf_table *em_table_alloc(struct em_perf_domain *pd)
 {
 	return NULL;
 }
-static inline void em_table_free(struct em_perf_table __rcu *table) {}
+static inline void em_table_free(struct em_perf_table *table) {}
 static inline
 int em_dev_update_perf_domain(struct device *dev,
-			      struct em_perf_table __rcu *new_table)
+			      struct em_perf_table *new_table)
 {
 	return -EINVAL;
 }
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 1e3caa96c271..d9b7e2b38c7a 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -163,12 +163,8 @@ static void em_debug_remove_pd(struct device *dev) {}
 
 static void em_release_table_kref(struct kref *kref)
 {
-	struct em_perf_table __rcu *table;
-
 	/* It was the last owner of this table so we can free */
-	table = container_of(kref, struct em_perf_table, kref);
-
-	kfree_rcu(table, rcu);
+	kfree_rcu(container_of(kref, struct em_perf_table, kref), rcu);
 }
 
 /**
@@ -177,7 +173,7 @@ static void em_release_table_kref(struct kref *kref)
  *
  * No return values.
  */
-void em_table_free(struct em_perf_table __rcu *table)
+void em_table_free(struct em_perf_table *table)
 {
 	kref_put(&table->kref, em_release_table_kref);
 }
@@ -190,9 +186,9 @@ void em_table_free(struct em_perf_table __rcu *table)
  * has a user.
  * Returns allocated table or NULL.
  */
-struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd)
+struct em_perf_table *em_table_alloc(struct em_perf_domain *pd)
 {
-	struct em_perf_table __rcu *table;
+	struct em_perf_table *table;
 	int table_size;
 
 	table_size = sizeof(struct em_perf_state) * pd->nr_perf_states;
@@ -300,9 +296,9 @@ int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
  * Return 0 on success or an error code on failure.
  */
 int em_dev_update_perf_domain(struct device *dev,
-			      struct em_perf_table __rcu *new_table)
+			      struct em_perf_table *new_table)
 {
-	struct em_perf_table __rcu *old_table;
+	struct em_perf_table *old_table;
 	struct em_perf_domain *pd;
 
 	if (!dev)
@@ -319,7 +315,8 @@ int em_dev_update_perf_domain(struct device *dev,
 
 	kref_get(&new_table->kref);
 
-	old_table = pd->em_table;
+	old_table = rcu_dereference_protected(pd->em_table,
+					      lockdep_is_held(&em_pd_mutex));
 	rcu_assign_pointer(pd->em_table, new_table);
 
 	em_cpufreq_update_efficiencies(dev, new_table->state);
@@ -392,7 +389,7 @@ static int em_create_pd(struct device *dev, int nr_states,
 			const cpumask_t *cpus,
 			unsigned long flags)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 	struct em_perf_domain *pd;
 	struct device *cpu_dev;
 	int cpu, ret, num_cpus;
@@ -552,6 +549,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				const struct em_data_callback *cb,
 				const cpumask_t *cpus, bool microwatts)
 {
+	struct em_perf_table *em_table;
 	unsigned long cap, prev_cap = 0;
 	unsigned long flags = 0;
 	int cpu, ret;
@@ -624,7 +622,9 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 	dev->em_pd->min_perf_state = 0;
 	dev->em_pd->max_perf_state = nr_states - 1;
 
-	em_cpufreq_update_efficiencies(dev, dev->em_pd->em_table->state);
+	em_table = rcu_dereference_protected(dev->em_pd->em_table,
+					     lockdep_is_held(&em_pd_mutex));
+	em_cpufreq_update_efficiencies(dev, em_table->state);
 
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
@@ -661,7 +661,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	mutex_lock(&em_pd_mutex);
 	em_debug_remove_pd(dev);
 
-	em_table_free(dev->em_pd->em_table);
+	em_table_free(rcu_dereference_protected(dev->em_pd->em_table,
+						lockdep_is_held(&em_pd_mutex)));
 
 	kfree(dev->em_pd);
 	dev->em_pd = NULL;
@@ -669,9 +670,9 @@ void em_dev_unregister_perf_domain(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);
 
-static struct em_perf_table __rcu *em_table_dup(struct em_perf_domain *pd)
+static struct em_perf_table *em_table_dup(struct em_perf_domain *pd)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 	struct em_perf_state *ps, *new_ps;
 	int ps_size;
 
@@ -693,7 +694,7 @@ static struct em_perf_table __rcu *em_table_dup(struct em_perf_domain *pd)
 }
 
 static int em_recalc_and_update(struct device *dev, struct em_perf_domain *pd,
-				struct em_perf_table __rcu *em_table)
+				struct em_perf_table *em_table)
 {
 	int ret;
 
@@ -723,7 +724,7 @@ static int em_recalc_and_update(struct device *dev, struct em_perf_domain *pd,
 static void em_adjust_new_capacity(struct device *dev,
 				   struct em_perf_domain *pd)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 
 	em_table = em_table_dup(pd);
 	if (!em_table) {
@@ -814,7 +815,7 @@ static void em_update_workfn(struct work_struct *work)
  */
 int em_dev_update_chip_binning(struct device *dev)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 	struct em_perf_domain *pd;
 	int i, ret;
 


