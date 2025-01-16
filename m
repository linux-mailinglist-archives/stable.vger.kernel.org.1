Return-Path: <stable+bounces-109246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D180DA138A0
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 12:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E8C18872B0
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3631DE4CB;
	Thu, 16 Jan 2025 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kvJ64pl3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PxPJPDoT"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C21DE3C0;
	Thu, 16 Jan 2025 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737026011; cv=none; b=VuD4GQW2cGbAVjowjfEgHL/26bV3XUpomhTDBiTXAqX1ULem8RkOa4x6ZvdcTqbnV6kqgKzwH8b6lqHGJu0DG40e7bcZQkKM46WPCiCu+71ROXJ66tVdDKjn0jbL8CNKHnen0y07pK/UKOdndsgWdAxwpIjVG8fno7GzqsoaW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737026011; c=relaxed/simple;
	bh=3PnGK52siKBTn5cOfz/1CrIgPO3FdeY8u53DR605p+E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KLcNVxuIgkmUFEJS1/Xgw7XnHXohRzrcc87ZuJH35PZVaowyk1ZdqUAI2Feu2Ksu8iSvqA8bWpJy1KaTJKVr8OWOdL5YS4WDOsTvZg76tZD7P5e2Z3tsw/JFE0FqOwiwXGAgxGi29txgRjqm54CbKeVR9IOauqde2r3FQLUEQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kvJ64pl3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PxPJPDoT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Jan 2025 11:13:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737026004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iupcYys6vcMdRBweDmPXFNiQxVuV4cGKl0bQiEkAsrw=;
	b=kvJ64pl3ZJuoJGC1JfBjpiEHeSkdxC6R+DdrWBpMUmi1HWck+7GloxQQ8aowHkEr9GDw3i
	pRrlgrOfKP5XtalnILaMj1Pv97ZABqs3a+Ta7n35VaxcYtlK9YsKmrYxcImvXuf52TmFLt
	uxxMw2UKfrPlEj3pzS0NYCPsnIMIgfcDlKLRvmBPqGvb2dXJWtH9n6epYp51T29tLQVDQa
	Aipi/OGY3HQvjZBd3RSHntLHYAaQ3BTOOU1nwAaF95hBw1WvZYIZEmue4Mr+S95Q/Axy4G
	LQvX49Mn+AqmCzLTQIiKNMJUQpfXbxFRHcqrAeEghhbh7K8Kj5Nth0Lb3dHcrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737026004;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iupcYys6vcMdRBweDmPXFNiQxVuV4cGKl0bQiEkAsrw=;
	b=PxPJPDoTwr9Kn4WvwNP5RjKfTSS2POyA8C/cPug1QoBBIDVlPUxXR+Nxk6h8kq13NtfpMY
	i//VuAn8tT0A0WDg==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/migration: Fix another race between
 hotplug and idle entry/exit
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250114231507.21672-2-frederic@kernel.org>
References: <20250114231507.21672-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173702600353.31546.17341122830057754852.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     de7cf2540a9b69e8e057ac25aa3c6b33fca81978
Gitweb:        https://git.kernel.org/tip/de7cf2540a9b69e8e057ac25aa3c6b33fca81978
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 15 Jan 2025 00:15:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jan 2025 12:04:47 +01:00

timers/migration: Fix another race between hotplug and idle entry/exit

Commit 10a0e6f3d3db ("timers/migration: Move hierarchy setup into
cpuhotplug prepare callback") fixed a race between idle exit and CPU
hotplug up leading to a wrong "0" value migrator assigned to the top
level. However there is still a situation that remains unhandled:

         [GRP0:0]
        migrator  = TMIGR_NONE
        active    = NONE
        groupmask = 0
        /     \      \
       0       1     2..7
     idle      idle   idle

0) The system is fully idle.

         [GRP0:0]
        migrator  = CPU 0
        active    = CPU 0
        groupmask = 0
        /     \      \
       0       1     2..7
     active   idle   idle

1) CPU 0 is activating. It has done the cmpxchg on the top's ->migr_state
but it hasn't yet returned to __walk_groups().

         [GRP0:0]
        migrator  = CPU 0
        active    = CPU 0, CPU 1
        groupmask = 0
        /     \      \
       0       1     2..7
     active  active  idle

2) CPU 1 is activating. CPU 0 stays the migrator (still stuck in
__walk_groups(), delayed by #VMEXIT for example).

                 [GRP1:0]
              migrator = TMIGR_NONE
              active   = NONE
              groupmask = 0
              /                  \
        [GRP0:0]                      [GRP0:1]
       migrator  = CPU 0           migrator = TMIGR_NONE
       active    = CPU 0, CPU1     active   = NONE
       groupmask = 2               groupmask = 1
       /     \      \
      0       1     2..7                   8
    active  active  idle              !online

3) CPU 8 is preparing to boot. CPUHP_TMIGR_PREPARE is being ran by CPU 1
which has created the GRP0:1 and the new top GRP1:0 connected to GRP0:1
and GRP0:0. The groupmask of GRP0:0 is now 2. CPU 1 hasn't yet
propagated its activation up to GRP1:0.

                 [GRP1:0]
              migrator = 0 (!!!)
              active   = NONE
              groupmask = 0
              /                  \
        [GRP0:0]                  [GRP0:1]
       migrator  = CPU 0           migrator = TMIGR_NONE
       active    = CPU 0, CPU1     active   = NONE
       groupmask = 2               groupmask = 1
       /     \      \
      0       1     2..7                   8
    active  active  idle                !online

4) CPU 0 finally resumed after its #VMEXIT. It's in __walk_groups()
returning from tmigr_cpu_active(). The new top GRP1:0 is visible and
fetched but the freshly updated groupmask of GRP0:0 may not be visible
due to lack of ordering! As a result tmigr_active_up() is called to
GRP0:0 with a child's groupmask of "0". This buggy "0" groupmask then
becomes the migrator for GRP1:0 forever. As a result, timers on a fully
idle system get ignored.

One possible fix would be to define TMIGR_NONE as "0" so that such a
race would have no effect. And after all TMIGR_NONE doesn't need to be
anything else. However this would leave an uncomfortable state machine
where gears happen not to break by chance but are vulnerable to future
modifications.

Keep TMIGR_NONE as is instead and pre-initialize to "1" the groupmask of
any newly created top level. This groupmask is guaranteed to be visible
upon fetching the corresponding group for the 1st time:

_ By the upcoming CPU thanks to CPU hotplug synchronization between the
  control CPU (BP) and the booting one (AP).

_ By the control CPU since the groupmask and parent pointers are
  initialized locally.

_ By all CPUs belonging to the same group than the control CPU because
  they must wait for it to ever become idle before needing to walk to
  the new top. The cmpcxhg() on ->migr_state then makes sure its
  groupmask is visible.

With this pre-initialization, it is guaranteed that if a future top level
is linked to an old one, it is walked through with a valid groupmask.

Fixes: 10a0e6f3d3db ("timers/migration: Move hierarchy setup into cpuhotplug prepare callback")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250114231507.21672-2-frederic@kernel.org
---
 kernel/time/timer_migration.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 8d57f76..c8a8ea2 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1487,6 +1487,21 @@ static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,
 	s.seq = 0;
 	atomic_set(&group->migr_state, s.state);
 
+	/*
+	 * If this is a new top-level, prepare its groupmask in advance.
+	 * This avoids accidents where yet another new top-level is
+	 * created in the future and made visible before the current groupmask.
+	 */
+	if (list_empty(&tmigr_level_list[lvl])) {
+		group->groupmask = BIT(0);
+		/*
+		 * The previous top level has prepared its groupmask already,
+		 * simply account it as the first child.
+		 */
+		if (lvl > 0)
+			group->num_children = 1;
+	}
+
 	timerqueue_init_head(&group->events);
 	timerqueue_init(&group->groupevt.nextevt);
 	group->groupevt.nextevt.expires = KTIME_MAX;
@@ -1550,8 +1565,20 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	raw_spin_lock_irq(&child->lock);
 	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
 
+	if (activate) {
+		/*
+		 * @child is the old top and @parent the new one. In this
+		 * case groupmask is pre-initialized and @child already
+		 * accounted, along with its new sibling corresponding to the
+		 * CPU going up.
+		 */
+		WARN_ON_ONCE(child->groupmask != BIT(0) || parent->num_children != 2);
+	} else {
+		/* Adding @child for the CPU going up to @parent. */
+		child->groupmask = BIT(parent->num_children++);
+	}
+
 	child->parent = parent;
-	child->groupmask = BIT(parent->num_children++);
 
 	raw_spin_unlock(&parent->lock);
 	raw_spin_unlock_irq(&child->lock);

