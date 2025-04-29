Return-Path: <stable+bounces-137920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A888AA15AD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E9F4A3DD6
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699792517A4;
	Tue, 29 Apr 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qgY0pUHg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277962459EA;
	Tue, 29 Apr 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947537; cv=none; b=B6OlURQO7I1U0BbZL0CAn2ONvZI7pzAJb/fDOfDCbDMwhQQCXiFRhepXJoSq+SO1XIq1Bfr6Y99A73r07qxwY9UtINHXYY0aEZavKSNtXo1vLqEAq32PeiBeKy2vwTkHXsqaPEfcAr055urXHT3iZt5s5Qv06eBpmFovCQ68k+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947537; c=relaxed/simple;
	bh=ALDOSqg7qjL3cKMUdnUmk9h2LKwvRWRqKkiX3PrYrvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqOEkGZgnPZlDK0Jyjtu7sZvQwxFH/LxIN2XF/J0O1s+mXF6emDBkOAesBr5ikg1PUCeV7SX+j4qq9bjh740y8FmubmcXCIlTGdUu/cEH0sOW0RDtnefv+frsnSZzSIqDMsW00PLRoxF9MAjziZpJx9KF6kDJQwRXp1eXiCdbjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qgY0pUHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A513C4CEE3;
	Tue, 29 Apr 2025 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947537;
	bh=ALDOSqg7qjL3cKMUdnUmk9h2LKwvRWRqKkiX3PrYrvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgY0pUHgTXhLNtf4YKHBHrTuc0tfPhM78jw3NqOoQ+wy2Jgh6Wea4gXA2aEyjzww4
	 QYImBHxDeZUk/IeF6alsJa0m1Y+kTqjeGh6HQ+44tII8To4lza9o4Zs/AdyiN31Zuo
	 RlC3B5JluXyZm3sqMGgNcvnIBoQDksPi8FDMl9tk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 008/280] PM: EM: Address RCU-related sparse warnings
Date: Tue, 29 Apr 2025 18:39:09 +0200
Message-ID: <20250429161115.418366973@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 3ee7be9e10dd5f79448788b899591d4bd2bf0c19 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/energy_model.h | 12 +++++------
 kernel/power/energy_model.c  | 39 ++++++++++++++++++------------------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 1ff52020cf757..34498652f7802 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -163,13 +163,13 @@ struct em_data_callback {
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
 int em_dev_update_perf_domain(struct device *dev,
-			      struct em_perf_table __rcu *new_table);
+			      struct em_perf_table *new_table);
 int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				struct em_data_callback *cb, cpumask_t *span,
 				bool microwatts);
 void em_dev_unregister_perf_domain(struct device *dev);
-struct em_perf_table __rcu *em_table_alloc(struct em_perf_domain *pd);
-void em_table_free(struct em_perf_table __rcu *table);
+struct em_perf_table *em_table_alloc(struct em_perf_domain *pd);
+void em_table_free(struct em_perf_table *table);
 int em_dev_compute_costs(struct device *dev, struct em_perf_state *table,
 			 int nr_states);
 int em_dev_update_chip_binning(struct device *dev);
@@ -365,14 +365,14 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
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
index e303d938637f1..4e1778071d704 100644
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
@@ -391,7 +388,7 @@ static int em_create_pd(struct device *dev, int nr_states,
 			struct em_data_callback *cb, cpumask_t *cpus,
 			unsigned long flags)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 	struct em_perf_domain *pd;
 	struct device *cpu_dev;
 	int cpu, ret, num_cpus;
@@ -551,6 +548,7 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 				struct em_data_callback *cb, cpumask_t *cpus,
 				bool microwatts)
 {
+	struct em_perf_table *em_table;
 	unsigned long cap, prev_cap = 0;
 	unsigned long flags = 0;
 	int cpu, ret;
@@ -621,7 +619,9 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 
 	dev->em_pd->flags |= flags;
 
-	em_cpufreq_update_efficiencies(dev, dev->em_pd->em_table->state);
+	em_table = rcu_dereference_protected(dev->em_pd->em_table,
+					     lockdep_is_held(&em_pd_mutex));
+	em_cpufreq_update_efficiencies(dev, em_table->state);
 
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
@@ -658,7 +658,8 @@ void em_dev_unregister_perf_domain(struct device *dev)
 	mutex_lock(&em_pd_mutex);
 	em_debug_remove_pd(dev);
 
-	em_table_free(dev->em_pd->em_table);
+	em_table_free(rcu_dereference_protected(dev->em_pd->em_table,
+						lockdep_is_held(&em_pd_mutex)));
 
 	kfree(dev->em_pd);
 	dev->em_pd = NULL;
@@ -666,9 +667,9 @@ void em_dev_unregister_perf_domain(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(em_dev_unregister_perf_domain);
 
-static struct em_perf_table __rcu *em_table_dup(struct em_perf_domain *pd)
+static struct em_perf_table *em_table_dup(struct em_perf_domain *pd)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 	struct em_perf_state *ps, *new_ps;
 	int ps_size;
 
@@ -690,7 +691,7 @@ static struct em_perf_table __rcu *em_table_dup(struct em_perf_domain *pd)
 }
 
 static int em_recalc_and_update(struct device *dev, struct em_perf_domain *pd,
-				struct em_perf_table __rcu *em_table)
+				struct em_perf_table *em_table)
 {
 	int ret;
 
@@ -721,7 +722,7 @@ static void em_adjust_new_capacity(struct device *dev,
 				   struct em_perf_domain *pd,
 				   u64 max_cap)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 
 	em_table = em_table_dup(pd);
 	if (!em_table) {
@@ -812,7 +813,7 @@ static void em_update_workfn(struct work_struct *work)
  */
 int em_dev_update_chip_binning(struct device *dev)
 {
-	struct em_perf_table __rcu *em_table;
+	struct em_perf_table *em_table;
 	struct em_perf_domain *pd;
 	int i, ret;
 
-- 
2.39.5




