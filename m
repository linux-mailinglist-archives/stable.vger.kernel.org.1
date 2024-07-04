Return-Path: <stable+bounces-58086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB5E927D1F
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 20:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A401C22289
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A86813D275;
	Thu,  4 Jul 2024 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gB4MQvpy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="itv0aFP4"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEBA13958F;
	Thu,  4 Jul 2024 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117980; cv=none; b=HVj4MCmXru+kHBskx2udumPTcerxhhv9amBogKCe9ELdM0jFFgnV1MZQmSUGo4ZLPkaIVHaTV90y/cLpGUuDR5qfHYYFNo69jmZjEESWnewaGHlmxUjIyiG/tKmOjf6Ze+SREuvtIW6IGKjH9wawaZ1/xVs2J4Xu0AzikHd8eVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117980; c=relaxed/simple;
	bh=LU8OO4xPT29KtBXSfqwcub91KRiIu1ayJaM+zjUNre0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J7BOoZs2msqoPV9jQGWjFtNa5f76/uLTYjyhjSNPoKG7CtaMInj9O5coNCK1zoZao4Zt5x87TbiqgA5sleOnoq8zj+YhYusPUXymeSxCCukP8ugabfkDjTMSSipB6XqGwo8nRYSoRxDSEn8o2hF4sYDDuxFw45OFbeqdEOXIYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gB4MQvpy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=itv0aFP4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Jul 2024 18:32:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720117975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDcV8kEzPAf/A/MzIBvdOOaPrERcXFgecsubSLplmmE=;
	b=gB4MQvpyIM5gJ5rkfZeNpOKirD0K2l2oqcXINO4m1oDp+oNunCqIHV4fQfqU6w6csOPudZ
	LAwNo8Oh1dRgsqpsDVCb69yKBau3O7eK849ajr5xsF4vZyDZL61ihByODwcvlqw918h+CS
	uwd6uy1ih5xscy5XQqK1l2pFppACabGQGc/3IVQ17Uc48XTsTyvXspN0UVapGc+eygNaBJ
	PN8pByV/j7hhg6uBdVdbnARp4NGxaUlbtPNuGw9qkHgOE4LZeUj1gSH/QykKK4ofVlK7KX
	G+A3QFCVVPqtlkwx6KYq9DqU0GtV8fLEx+PrTvfvGxtJr2FRR5cnmeibGi3p6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720117975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDcV8kEzPAf/A/MzIBvdOOaPrERcXFgecsubSLplmmE=;
	b=itv0aFP4FFQD0OOEw2FIc2chidqpnz5KCdlQnQ4dpQsTU6QUM+Sly5rtvAy/iMOLOgJ0+s
	mETY8HKF3u6YOXBw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/migration: Move hierarchy setup into
 cpuhotplug prepare callback
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240703202839.8921-1-anna-maria@linutronix.de>
References: <20240703202839.8921-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172011797497.2215.8713769898422744796.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8cdb61838ee5c63556773ea2eed24deab6b15257
Gitweb:        https://git.kernel.org/tip/8cdb61838ee5c63556773ea2eed24deab6b15257
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 03 Jul 2024 22:28:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Jul 2024 20:22:22 +02:00

timers/migration: Move hierarchy setup into cpuhotplug prepare callback

When a CPU comes online the first time, it is possible that a new top level
group will be created. In general all propagation is done from the bottom
to top. This minimizes complexity and prevents possible races. But when a
new top level group is created, the formely top level group needs to be
connected to the new level. This is the only time, when the direction to
propagate changes is changed: the changes are propagated from top (new top
level group) to bottom (formerly top level group).

This introduces two races (see (A) and (B)) as reported by Frederic:

(A) This race happens, when marking the formely top level group as active,
but the last active CPU of the formerly top level group goes idle. Then
it's likely that formerly group is no longer active, but marked
nevertheless as active in new top level group:

		  [GRP0:0]
	       migrator = 0
	       active   = 0
	       nextevt  = KTIME_MAX
	       /         \
	      0         1 .. 7
	  active         idle

0) Hierarchy has for now only 8 CPUs and CPU 0 is the only active CPU.

			     [GRP1:0]
			migrator = TMIGR_NONE
			active   = NONE
			nextevt  = KTIME_MAX
					 \
		 [GRP0:0]                  [GRP0:1]
	      migrator = 0              migrator = TMIGR_NONE
	      active   = 0              active   = NONE
	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
		/         \
	      0          1 .. 7                8
	  active         idle                !online

1) CPU 8 is booting and creates a new group in first level GRP0:1 and
   therefore also a new top group GRP1:0. For now the setup code proceeded
   only until the connected between GRP0:1 to the new top group. The
   connection between CPU8 and GRP0:1 is not yet established and CPU 8 is
   still !online.

			     [GRP1:0]
			migrator = TMIGR_NONE
			active   = NONE
			nextevt  = KTIME_MAX
		       /                  \
		 [GRP0:0]                  [GRP0:1]
	      migrator = 0              migrator = TMIGR_NONE
	      active   = 0              active   = NONE
	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
		/         \
	      0          1 .. 7                8
	  active         idle                !online

2) Setup code now connects GRP0:0 to GRP1:0 and observes while in
   tmigr_connect_child_parent() that GRP0:0 is not TMIGR_NONE. So it
   prepares to call tmigr_active_up() on it. It hasn't done it yet.

			     [GRP1:0]
			migrator = TMIGR_NONE
			active   = NONE
			nextevt  = KTIME_MAX
		       /                  \
		 [GRP0:0]                  [GRP0:1]
	      migrator = TMIGR_NONE        migrator = TMIGR_NONE
	      active   = NONE              active   = NONE
	      nextevt  = KTIME_MAX         nextevt  = KTIME_MAX
		/         \
	      0          1 .. 7                8
	    idle         idle                !online

3) CPU 0 goes idle. Since GRP0:0->parent has been updated by CPU 8 with
   GRP0:0->lock held, CPU 0 observes GRP1:0 after calling
   tmigr_update_events() and it propagates the change to the top (no change
   there and no wakeup programmed since there is no timer).

			     [GRP1:0]
			migrator = GRP0:0
			active   = GRP0:0
			nextevt  = KTIME_MAX
		       /                  \
		 [GRP0:0]                  [GRP0:1]
	      migrator = TMIGR_NONE       migrator = TMIGR_NONE
	      active   = NONE             active   = NONE
	      nextevt  = KTIME_MAX        nextevt  = KTIME_MAX
		/         \
	      0          1 .. 7                8
	    idle         idle                !online

4) Now the setup code finally calls tmigr_active_up() to and sets GRP0:0
   active in GRP1:0

			     [GRP1:0]
			migrator = GRP0:0
			active   = GRP0:0, GRP0:1
			nextevt  = KTIME_MAX
		       /                  \
		 [GRP0:0]                  [GRP0:1]
	      migrator = TMIGR_NONE       migrator = 8
	      active   = NONE             active   = 8
	      nextevt  = KTIME_MAX        nextevt  = KTIME_MAX
		/         \                    |
	      0          1 .. 7                8
	    idle         idle                active

5) Now CPU 8 is connected with GRP0:1 and CPU 8 calls tmigr_active_up() out
   of tmigr_cpu_online().

			     [GRP1:0]
			migrator = GRP0:0
			active   = GRP0:0
			nextevt  = T8
		       /                  \
		 [GRP0:0]                  [GRP0:1]
	      migrator = TMIGR_NONE         migrator = TMIGR_NONE
	      active   = NONE               active   = NONE
	      nextevt  = KTIME_MAX          nextevt  = T8
		/         \                    |
	      0          1 .. 7                8
	    idle         idle                  idle

5) CPU 8 goes idle with a timer T8 and relies on GRP0:0 as the migrator.
   But it's not really active, so T8 gets ignored.

--> The update which is done in third step is not noticed by setup code. So
    a wrong migrator is set to top level group and a timer could get
    ignored.

(B) Reading group->parent and group->childmask when an hierarchy update is
ongoing and reaches the formerly top level group is racy as those values
could be inconsistent. (The notation of migrator and active now slightly
changes in contrast to the above example, as now the childmasks are used.)

			     [GRP1:0]
			migrator = TMIGR_NONE
			active   = 0x00
			nextevt  = KTIME_MAX
					 \
		 [GRP0:0]                  [GRP0:1]
	      migrator = TMIGR_NONE     migrator = TMIGR_NONE
	      active   = 0x00           active   = 0x00
	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
	      childmask= 0		childmask= 1
	      parent   = NULL		parent   = GRP1:0
		/         \
	      0          1 .. 7                8
	  idle           idle                !online
	  childmask=1

1) Hierarchy has 8 CPUs. CPU 8 is at the moment in the process of onlining
   but did not yet connect GRP0:0 to GRP1:0.

			     [GRP1:0]
			migrator = TMIGR_NONE
			active   = 0x00
			nextevt  = KTIME_MAX
		       /                  \
		 [GRP0:0]                  [GRP0:1]
	      migrator = TMIGR_NONE     migrator = TMIGR_NONE
	      active   = 0x00           active   = 0x00
	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
	      childmask= 0		childmask= 1
	      parent   = GRP1:0		parent   = GRP1:0
		/         \
	      0          1 .. 7                8
	  idle           idle                !online
	  childmask=1

2) Setup code (running on CPU 8) now connects GRP0:0 to GRP1:0, updates
   parent pointer of GRP0:0 and ...

			     [GRP1:0]
			migrator = TMIGR_NONE
			active   = 0x00
			nextevt  = KTIME_MAX
		       /                  \
		 [GRP0:0]                  [GRP0:1]
	      migrator = 0x01           migrator = TMIGR_NONE
	      active   = 0x01           active   = 0x00
	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
	      childmask= 0		childmask= 1
	      parent   = GRP1:0		parent   = GRP1:0
		/         \
	      0          1 .. 7                8
	  active          idle                !online
	  childmask=1

	  tmigr_walk.childmask = 0

3) ... CPU 0 comes active in the same time. As migrator in GRP0:0 was
   TMIGR_NONE, childmask of GRP0:0 is stored in update propagation data
   structure tmigr_walk (as update of childmask is not yet
   visible/updated). And now ...

			     [GRP1:0]
			migrator = TMIGR_NONE
			active   = 0x00
			nextevt  = KTIME_MAX
		       /                  \
		 [GRP0:0]                  [GRP0:1]
	      migrator = 0x01           migrator = TMIGR_NONE
	      active   = 0x01           active   = 0x00
	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
	      childmask= 2		childmask= 1
	      parent   = GRP1:0		parent   = GRP1:0
		/         \
	      0          1 .. 7                8
	  active          idle                !online
	  childmask=1

	  tmigr_walk.childmask = 0

4) ... childmask of GRP0:0 is updated by CPU 8 (still part of setup
   code).

			     [GRP1:0]
			migrator = 0x00
			active   = 0x00
			nextevt  = KTIME_MAX
		       /                  \
		 [GRP0:0]                  [GRP0:1]
	      migrator = 0x01           migrator = TMIGR_NONE
	      active   = 0x01           active   = 0x00
	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
	      childmask= 2		childmask= 1
	      parent   = GRP1:0		parent   = GRP1:0
		/         \
	      0          1 .. 7                8
	  active          idle                !online
	  childmask=1

	  tmigr_walk.childmask = 0

5) CPU 0 sees the connection to GRP1:0 and now propagates active state to
   GRP1:0 but with childmask = 0 as stored in propagation data structure.

--> Now GRP1:0 always has a migrator as 0x00 != TMIGR_NONE and for all CPUs
    it looks like GRP1:0 is always active.

To prevent those races, the setup of the hierarchy is moved into the
cpuhotplug prepare callback. The prepare callback is not executed by the
CPU which will come online, it is executed by the CPU which prepares
onlining of the other CPU. This CPU is active while it is connecting the
formerly top level to the new one. This prevents from (A) to happen and it
also prevents from any further walk above the formerly top level until that
active CPU becomes inactive, releasing the new ->parent and ->childmask
updates to be visible by any subsequent walk up above the formerly top
level hierarchy. This prevents from (B) to happen. The direction for the
updates is now forced to look like "from bottom to top".

However if the active CPU prevents from tmigr_cpu_(in)active() to walk up
with the update not-or-half visible, nothing prevents walking up to the new
top with a 0 childmask in tmigr_handle_remote_up() or
tmigr_requires_handle_remote_up() if the active CPU doing the prepare is
not the migrator. But then it looks fine because:

  * tmigr_check_migrator() should just return false
  * The migrator is active and should eventually observe the new childmask
    at some point in a future tick.

Split setup functionality of online callback into the cpuhotplug prepare
callback and setup hotplug state. Reorder the code, that all prepare
related functions are close to each other and online and offline callbacks
are also close together.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240703202839.8921-1-anna-maria@linutronix.de

---
 include/linux/cpuhotplug.h    |   1 +-
 kernel/time/timer_migration.c | 181 ++++++++++++++++++---------------
 2 files changed, 101 insertions(+), 81 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 7a5785f..df59666 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -122,6 +122,7 @@ enum cpuhp_state {
 	CPUHP_KVM_PPC_BOOK3S_PREPARE,
 	CPUHP_ZCOMP_PREPARE,
 	CPUHP_TIMERS_PREPARE,
+	CPUHP_TMIGR_PREPARE,
 	CPUHP_MIPS_SOC_PREPARE,
 	CPUHP_BP_PREPARE_DYN,
 	CPUHP_BP_PREPARE_DYN_END		= CPUHP_BP_PREPARE_DYN + 20,
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index d91efe1..9b86efd 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1438,6 +1438,66 @@ u64 tmigr_quick_check(u64 nextevt)
 	return KTIME_MAX;
 }
 
+/*
+ * tmigr_trigger_active() - trigger a CPU to become active again
+ *
+ * This function is executed on a CPU which is part of cpu_online_mask, when the
+ * last active CPU in the hierarchy is offlining. With this, it is ensured that
+ * the other CPU is active and takes over the migrator duty.
+ */
+static long tmigr_trigger_active(void *unused)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+
+	WARN_ON_ONCE(!tmc->online || tmc->idle);
+
+	return 0;
+}
+
+static int tmigr_cpu_offline(unsigned int cpu)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	int migrator;
+	u64 firstexp;
+
+	raw_spin_lock_irq(&tmc->lock);
+	tmc->online = false;
+	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
+
+	/*
+	 * CPU has to handle the local events on his own, when on the way to
+	 * offline; Therefore nextevt value is set to KTIME_MAX
+	 */
+	firstexp = __tmigr_cpu_deactivate(tmc, KTIME_MAX);
+	trace_tmigr_cpu_offline(tmc);
+	raw_spin_unlock_irq(&tmc->lock);
+
+	if (firstexp != KTIME_MAX) {
+		migrator = cpumask_any_but(cpu_online_mask, cpu);
+		work_on_cpu(migrator, tmigr_trigger_active, NULL);
+	}
+
+	return 0;
+}
+
+static int tmigr_cpu_online(unsigned int cpu)
+{
+	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+
+	/* Check whether CPU data was successfully initialized */
+	if (WARN_ON_ONCE(!tmc->tmgroup))
+		return -EINVAL;
+
+	raw_spin_lock_irq(&tmc->lock);
+	trace_tmigr_cpu_online(tmc);
+	tmc->idle = timer_base_is_idle();
+	if (!tmc->idle)
+		__tmigr_cpu_activate(tmc);
+	tmc->online = true;
+	raw_spin_unlock_irq(&tmc->lock);
+	return 0;
+}
+
 static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
 			     int node)
 {
@@ -1512,7 +1572,7 @@ static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
 static void tmigr_connect_child_parent(struct tmigr_group *child,
 				       struct tmigr_group *parent)
 {
-	union tmigr_state childstate;
+	struct tmigr_walk data;
 
 	raw_spin_lock_irq(&child->lock);
 	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
@@ -1540,22 +1600,24 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	 *   child to the new parent. So tmigr_connect_child_parent() is
 	 *   executed with the formerly top level group (child) and the newly
 	 *   created group (parent).
+	 *
+	 * * It is ensured that the child is active, as this setup path is
+	 *   executed in hotplug prepare callback. This is exectued by an
+	 *   already connected and !idle CPU. Even if all other CPUs go idle,
+	 *   the CPU executing the setup will be responsible up to current top
+	 *   level group. And the next time it goes inactive, it will release
+	 *   the new childmask and parent to subsequent walkers through this
+	 *   @child. Therefore propagate active state unconditionally.
 	 */
-	childstate.state = atomic_read(&child->migr_state);
-	if (childstate.migrator != TMIGR_NONE) {
-		struct tmigr_walk data;
-
-		data.childmask = child->childmask;
+	data.childmask = child->childmask;
 
-		/*
-		 * There is only one new level per time (which is protected by
-		 * tmigr_mutex). When connecting the child and the parent and
-		 * set the child active when the parent is inactive, the parent
-		 * needs to be the uppermost level. Otherwise there went
-		 * something wrong!
-		 */
-		WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
-	}
+	/*
+	 * There is only one new level per time (which is protected by
+	 * tmigr_mutex). When connecting the child and the parent and set the
+	 * child active when the parent is inactive, the parent needs to be the
+	 * uppermost level. Otherwise there went something wrong!
+	 */
+	WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
 }
 
 static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
@@ -1661,80 +1723,32 @@ static int tmigr_add_cpu(unsigned int cpu)
 	return ret;
 }
 
-static int tmigr_cpu_online(unsigned int cpu)
+static int tmigr_cpu_prepare(unsigned int cpu)
 {
-	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
-	int ret;
-
-	/* First online attempt? Initialize CPU data */
-	if (!tmc->tmgroup) {
-		raw_spin_lock_init(&tmc->lock);
-
-		ret = tmigr_add_cpu(cpu);
-		if (ret < 0)
-			return ret;
-
-		if (tmc->childmask == 0)
-			return -EINVAL;
+	struct tmigr_cpu *tmc = per_cpu_ptr(&tmigr_cpu, cpu);
+	int ret = 0;
 
-		timerqueue_init(&tmc->cpuevt.nextevt);
-		tmc->cpuevt.nextevt.expires = KTIME_MAX;
-		tmc->cpuevt.ignore = true;
-		tmc->cpuevt.cpu = cpu;
-
-		tmc->remote = false;
-		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
-	}
-	raw_spin_lock_irq(&tmc->lock);
-	trace_tmigr_cpu_online(tmc);
-	tmc->idle = timer_base_is_idle();
-	if (!tmc->idle)
-		__tmigr_cpu_activate(tmc);
-	tmc->online = true;
-	raw_spin_unlock_irq(&tmc->lock);
-	return 0;
-}
-
-/*
- * tmigr_trigger_active() - trigger a CPU to become active again
- *
- * This function is executed on a CPU which is part of cpu_online_mask, when the
- * last active CPU in the hierarchy is offlining. With this, it is ensured that
- * the other CPU is active and takes over the migrator duty.
- */
-static long tmigr_trigger_active(void *unused)
-{
-	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
+	/* Not first online attempt? */
+	if (tmc->tmgroup)
+		return ret;
 
-	WARN_ON_ONCE(!tmc->online || tmc->idle);
+	raw_spin_lock_init(&tmc->lock);
 
-	return 0;
-}
+	ret = tmigr_add_cpu(cpu);
+	if (ret < 0)
+		return ret;
 
-static int tmigr_cpu_offline(unsigned int cpu)
-{
-	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
-	int migrator;
-	u64 firstexp;
+	if (tmc->childmask == 0)
+		return -EINVAL;
 
-	raw_spin_lock_irq(&tmc->lock);
-	tmc->online = false;
+	timerqueue_init(&tmc->cpuevt.nextevt);
+	tmc->cpuevt.nextevt.expires = KTIME_MAX;
+	tmc->cpuevt.ignore = true;
+	tmc->cpuevt.cpu = cpu;
+	tmc->remote = false;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 
-	/*
-	 * CPU has to handle the local events on his own, when on the way to
-	 * offline; Therefore nextevt value is set to KTIME_MAX
-	 */
-	firstexp = __tmigr_cpu_deactivate(tmc, KTIME_MAX);
-	trace_tmigr_cpu_offline(tmc);
-	raw_spin_unlock_irq(&tmc->lock);
-
-	if (firstexp != KTIME_MAX) {
-		migrator = cpumask_any_but(cpu_online_mask, cpu);
-		work_on_cpu(migrator, tmigr_trigger_active, NULL);
-	}
-
-	return 0;
+	return ret;
 }
 
 static int __init tmigr_init(void)
@@ -1793,6 +1807,11 @@ static int __init tmigr_init(void)
 		tmigr_hierarchy_levels, TMIGR_CHILDREN_PER_GROUP,
 		tmigr_crossnode_level);
 
+	ret = cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:prepare",
+				tmigr_cpu_prepare, NULL);
+	if (ret)
+		goto err;
+
 	ret = cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
 				tmigr_cpu_online, tmigr_cpu_offline);
 	if (ret)

