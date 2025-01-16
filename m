Return-Path: <stable+bounces-109255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADF3A1398F
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 12:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2488C7A4233
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 11:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392AC1DE4ED;
	Thu, 16 Jan 2025 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KS51Ayne";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+IHIycy"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A11DE4DF;
	Thu, 16 Jan 2025 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028764; cv=none; b=k7IOWBzdHnD78PG1Bt/awEqsLlaaRtEi1B+U/zR4U8fRRMZnHB6QkfSxS2cxOYGfAOt+Rb1zRL3jG4+knxeR4hpfeYBievqWUWl27Uzfpodgrxs9TM3oFabOUeIc38uttkULe/BKKdnXU+rlKCjosP2AFbYqMoAji7L/O9N/g6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028764; c=relaxed/simple;
	bh=3cJU61/ZenvPxChdYrSQCkO/hY5x5qFih4oZuKVwdFQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jv5g8JL/Ts/aH82us+xH0MQUWZuRiXgKVcwxxIerOkvfnfZdBbJ/BPI5nHEv2YwYixMlpRrcBoK0v3Gy7bsMmX5LvwsT6Ro6gGsEKYC1FXu7uETzA6ppdhCjKNXEu8wonT3Ab1QPvPPVAy+L9bEg1hp0yehSPbIy/if8Sv6fzbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KS51Ayne; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+IHIycy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Jan 2025 11:59:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737028759;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbWNuPMnoH/ShCgpP3PO10BLIgninj07YzHaH1mHTDM=;
	b=KS51AyneYG/yyRqrh/gUXtx43pL4lSXgP/WXU8/R6XL6+a9JrIZp9447tkPcDdSPMX8IFy
	0uNuP+vmIa5ppWF6OL9XtZcu+j2U5gtC1WFq3Fu4xuUV3v5Bl0JAInYpXrV2VuGpLMfokm
	oJ6UYLXQimOAKFKodfFWj43ATyF9/mH0PFeaaeuXwPt04g8FSplOsx2xiBWOZjBnHHRAFb
	WVYHNtmZOCyy7P/u/VvDDLtlLCWD9/bMAFGVy/MZShgruBonYh+P/aJ3YLMjo6yaA8gaUL
	3WePosIPjc5DoyRlC5Et+JQuZ3BOPH7neXallzcn5HPPP+d1JmeZU/cNgl5WmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737028759;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbWNuPMnoH/ShCgpP3PO10BLIgninj07YzHaH1mHTDM=;
	b=I+IHIycy4LHJGypmCWOUBcXF0T39TENvkS5TugbMrVdc+yfON3a/5EDhy5DII1rBIyUPEu
	6lsbNrdsOTxwNyBA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/migration: Enforce group initialization
 visibility to tree walkers
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250114231507.21672-3-frederic@kernel.org>
References: <20250114231507.21672-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173702875928.31546.10203265346385825030.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     de3ced72a79280fefd680e5e101d8b9f03cfa1d7
Gitweb:        https://git.kernel.org/tip/de3ced72a79280fefd680e5e101d8b9f03cfa1d7
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 15 Jan 2025 00:15:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jan 2025 12:47:11 +01:00

timers/migration: Enforce group initialization visibility to tree walkers

Commit 2522c84db513 ("timers/migration: Fix another race between hotplug
and idle entry/exit") fixed yet another race between idle exit and CPU
hotplug up leading to a wrong "0" value migrator assigned to the top
level. However there is yet another situation that remains unhandled:

         [GRP0:0]
      migrator  = TMIGR_NONE
      active    = NONE
      groupmask = 1
      /     \      \
     0       1     2..7
   idle      idle   idle

0) The system is fully idle.

         [GRP0:0]
      migrator  = CPU 0
      active    = CPU 0
      groupmask = 1
      /     \      \
     0       1     2..7
   active   idle   idle

1) CPU 0 is activating. It has done the cmpxchg on the top's ->migr_state
but it hasn't yet returned to __walk_groups().

         [GRP0:0]
      migrator  = CPU 0
      active    = CPU 0, CPU 1
      groupmask = 1
      /     \      \
     0       1     2..7
   active  active  idle

2) CPU 1 is activating. CPU 0 stays the migrator (still stuck in
__walk_groups(), delayed by #VMEXIT for example).

                    [GRP1:0]
                migrator = TMIGR_NONE
                active   = NONE
                groupmask = 1
             /                   \
         [GRP0:0]                  [GRP0:1]
      migrator  = CPU 0           migrator = TMIGR_NONE
      active    = CPU 0, CPU1     active   = NONE
      groupmask = 1               groupmask = 2
      /     \      \
     0       1     2..7                   8
   active  active  idle                !online

3) CPU 8 is preparing to boot. CPUHP_TMIGR_PREPARE is being ran by CPU 1
which has created the GRP0:1 and the new top GRP1:0 connected to GRP0:1
and GRP0:0. CPU 1 hasn't yet propagated its activation up to GRP1:0.

                    [GRP1:0]
               migrator = GRP0:0
               active   = GRP0:0
               groupmask = 1
             /                   \
         [GRP0:0]                  [GRP0:1]
     migrator  = CPU 0           migrator = TMIGR_NONE
     active    = CPU 0, CPU1     active   = NONE
     groupmask = 1               groupmask = 2
     /     \      \
    0       1     2..7                   8
  active  active  idle                !online

4) CPU 0 finally resumed after its #VMEXIT. It's in __walk_groups()
returning from tmigr_cpu_active(). The new top GRP1:0 is visible and
fetched and the pre-initialized groupmask of GRP0:0 is also visible.
As a result tmigr_active_up() is called to GRP1:0 with GRP0:0 as active
and migrator. CPU 0 is returning to __walk_groups() but suffers again
a #VMEXIT.

                    [GRP1:0]
               migrator = GRP0:0
               active   = GRP0:0
               groupmask = 1
             /                   \
         [GRP0:0]                  [GRP0:1]
     migrator  = CPU 0           migrator = TMIGR_NONE
     active    = CPU 0, CPU1     active   = NONE
     groupmask = 1               groupmask = 2
     /     \      \
    0       1     2..7                   8
  active  active  idle                 !online

5) CPU 1 propagates its activation of GRP0:0 to GRP1:0. This has no
   effect since CPU 0 did it already.

                    [GRP1:0]
               migrator = GRP0:0
               active   = GRP0:0, GRP0:1
               groupmask = 1
             /                   \
         [GRP0:0]                  [GRP0:1]
     migrator  = CPU 0           migrator = CPU 8
     active    = CPU 0, CPU1     active   = CPU 8
     groupmask = 1               groupmask = 2
     /     \      \                     \
    0       1     2..7                   8
  active  active  idle                 active

6) CPU 1 links CPU 8 to its group. CPU 8 boots and goes through
   CPUHP_AP_TMIGR_ONLINE which propagates activation.

                                   [GRP2:0]
                              migrator = TMIGR_NONE
                              active   = NONE
                              groupmask = 1
                             /                \
                    [GRP1:0]                    [GRP1:1]
               migrator = GRP0:0              migrator = TMIGR_NONE
               active   = GRP0:0, GRP0:1      active   = NONE
               groupmask = 1                  groupmask = 2
             /                   \
         [GRP0:0]                  [GRP0:1]                [GRP0:2]
     migrator  = CPU 0           migrator = CPU 8        migrator = TMIGR_NONE
     active    = CPU 0, CPU1     active   = CPU 8        active   = NONE
     groupmask = 1               groupmask = 2           groupmask = 0
     /     \      \                     \
    0       1     2..7                   8                  64
  active  active  idle                 active             !online

7) CPU 64 is booting. CPUHP_TMIGR_PREPARE is being ran by CPU 1
which has created the GRP1:1, GRP0:2 and the new top GRP2:0 connected to
GRP1:1 and GRP1:0. CPU 1 hasn't yet propagated its activation up to
GRP2:0.

                                   [GRP2:0]
                              migrator = 0 (!!!)
                              active   = NONE
                              groupmask = 1
                             /                \
                    [GRP1:0]                    [GRP1:1]
               migrator = GRP0:0              migrator = TMIGR_NONE
               active   = GRP0:0, GRP0:1      active   = NONE
               groupmask = 1                  groupmask = 2
             /                   \
         [GRP0:0]                  [GRP0:1]                [GRP0:2]
     migrator  = CPU 0           migrator = CPU 8        migrator = TMIGR_NONE
     active    = CPU 0, CPU1     active   = CPU 8        active   = NONE
     groupmask = 1               groupmask = 2           groupmask = 0
     /     \      \                     \
    0       1     2..7                   8                  64
  active  active  idle                 active             !online

8) CPU 0 finally resumed after its #VMEXIT. It's in __walk_groups()
returning from tmigr_cpu_active(). The new top GRP2:0 is visible and
fetched but the pre-initialized groupmask of GRP1:0 is not because no
ordering made its initialization visible. As a result tmigr_active_up()
may be called to GRP2:0 with a "0" child's groumask. Leaving the timers
ignored for ever when the system is fully idle.

The race is highly theoretical and perhaps impossible in practice but
the groupmask of the child is not the only concern here as the whole
initialization of the child is not guaranteed to be visible to any
tree walker racing against hotplug (idle entry/exit, remote handling,
etc...). Although the current code layout seem to be resilient to such
hazards, this doesn't tell much about the future.

Fix this with enforcing address dependency between group initialization
and the write/read to the group's parent's pointer. Fortunately that
doesn't involve any barrier addition in the fast paths.

Fixes: 10a0e6f3d3db ("timers/migration: Move hierarchy setup into cpuhotplug prepare callback")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250114231507.21672-3-frederic@kernel.org

---
 kernel/time/timer_migration.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c8a8ea2..371a62a 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -534,8 +534,13 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
 			break;
 
 		child = group;
-		group = group->parent;
+		/*
+		 * Pairs with the store release on group connection
+		 * to make sure group initialization is visible.
+		 */
+		group = READ_ONCE(group->parent);
 		data->childmask = child->groupmask;
+		WARN_ON_ONCE(!data->childmask);
 	} while (group);
 }
 
@@ -1578,7 +1583,12 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 		child->groupmask = BIT(parent->num_children++);
 	}
 
-	child->parent = parent;
+	/*
+	 * Make sure parent initialization is visible before publishing it to a
+	 * racing CPU entering/exiting idle. This RELEASE barrier enforces an
+	 * address dependency that pairs with the READ_ONCE() in __walk_groups().
+	 */
+	smp_store_release(&child->parent, parent);
 
 	raw_spin_unlock(&parent->lock);
 	raw_spin_unlock_irq(&child->lock);

