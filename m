Return-Path: <stable+bounces-109261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB80A13A02
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 13:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462DF1649BD
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218911DE4E1;
	Thu, 16 Jan 2025 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ao2PcRIa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dDhuFC+8"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C1024A7F8;
	Thu, 16 Jan 2025 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737030971; cv=none; b=fowlesvB+EfnPqyZilTJGcavK6ANb19T2AedbbsJkxXMZyQhJZoUkX+l2b54boVEkjtGLgqziGhnf4G6k5rxa1ajEjlM1qQ/x2zCpP8frIx1ZmDttl9y2nY8LcW7/bLIladxTMahHyaCRKtB3HXJSX5OPsksE8zKLbncryfFWuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737030971; c=relaxed/simple;
	bh=Mc5NbTY5ITF1qqajCHYIWrEwVrAh6CQ+E20x2atM42Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Rcu9ZPghgRBOE4A5RvKZOulC+pd1oObNybMnbfFdGor+cieDvs4KbtheCoDpjvAJF5Q9ejOWjUx+aCGVgGxRYU2bgSBbELJt+bXDojPuDtIRI0J1DsMt2bBfylVov4/80QA5LpTey20CV9xgsoainWVk2C1OwaBRY0IGX8P/2RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ao2PcRIa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dDhuFC+8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Jan 2025 12:36:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737030968;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ej4l6wuZJB9G3BGGgBaL+wxiRkD0U0/BOuINWAZDAZo=;
	b=Ao2PcRIa/pm+SOXrXZNr4zZfzuCHTaxSeM0rHEmOJnSgp4Ope2c4CFbHeUCh6v3R1ybndL
	QP/Fb+tH3opQCwcpCwz222wrxUdxzGkGMzONxgVRhbDQzfE1f4FTJReAlhhF055O/+nchz
	JFhgYytl6MpYbVr0RLSafXB5/p0Xf60Oaif6NmEW16kmGxf2MF3iQxPx35lupZUGuUrzVN
	WON7WNm4ag+MrJN83D1AyO8I5r4Wy7ZCkz0KIWLGVauYAVNDqvdaDZmmcPiTateBr44UWV
	nGbPpKaKvozssAPNsHBMpwnMDkna72YgiFRymvH/24Q/ythwFQw9M9zxeeNJ2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737030968;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ej4l6wuZJB9G3BGGgBaL+wxiRkD0U0/BOuINWAZDAZo=;
	b=dDhuFC+8tXj6TIscy8NUT5AhLmfgtWuN4xZarwzA5JAUPgnzU1J2kiK+r5CUM4+jqvKy3l
	av4VbCPtDWZTG6BA==
From: "tip-bot2 for Koichiro Den" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] hrtimers: Handle CPU state correctly on hotplug
Cc: Koichiro Den <koichiro.den@canonical.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241220134421.3809834-1-koichiro.den@canonical.com>
References: <20241220134421.3809834-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173703096711.31546.10185525717139575022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     2f8dea1692eef2b7ba6a256246ed82c365fdc686
Gitweb:        https://git.kernel.org/tip/2f8dea1692eef2b7ba6a256246ed82c365fdc686
Author:        Koichiro Den <koichiro.den@canonical.com>
AuthorDate:    Fri, 20 Dec 2024 22:44:21 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jan 2025 13:06:14 +01:00

hrtimers: Handle CPU state correctly on hotplug

Consider a scenario where a CPU transitions from CPUHP_ONLINE to halfway
through a CPU hotunplug down to CPUHP_HRTIMERS_PREPARE, and then back to
CPUHP_ONLINE:

Since hrtimers_prepare_cpu() does not run, cpu_base.hres_active remains set
to 1 throughout. However, during a CPU unplug operation, the tick and the
clockevents are shut down at CPUHP_AP_TICK_DYING. On return to the online
state, for instance CFS incorrectly assumes that the hrtick is already
active, and the chance of the clockevent device to transition to oneshot
mode is also lost forever for the CPU, unless it goes back to a lower state
than CPUHP_HRTIMERS_PREPARE once.

This round-trip reveals another issue; cpu_base.online is not set to 1
after the transition, which appears as a WARN_ON_ONCE in enqueue_hrtimer().

Aside of that, the bulk of the per CPU state is not reset either, which
means there are dangling pointers in the worst case.

Address this by adding a corresponding startup() callback, which resets the
stale per CPU state and sets the online flag.

[ tglx: Make the new callback unconditionally available, remove the online
  	modification in the prepare() callback and clear the remaining
  	state in the starting callback instead of the prepare callback ]

Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241220134421.3809834-1-koichiro.den@canonical.com
---
 include/linux/hrtimer.h |  1 +
 kernel/cpu.c            |  2 +-
 kernel/time/hrtimer.c   | 11 ++++++++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 7ef5f7e..f7bfdcf 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -386,6 +386,7 @@ extern void __init hrtimers_init(void);
 extern void sysrq_timer_list_show(void);
 
 int hrtimers_prepare_cpu(unsigned int cpu);
+int hrtimers_cpu_starting(unsigned int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 int hrtimers_cpu_dying(unsigned int cpu);
 #else
diff --git a/kernel/cpu.c b/kernel/cpu.c
index b605334..0509a97 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2179,7 +2179,7 @@ static struct cpuhp_step cpuhp_hp_states[] = {
 	},
 	[CPUHP_AP_HRTIMERS_DYING] = {
 		.name			= "hrtimers:dying",
-		.startup.single		= NULL,
+		.startup.single		= hrtimers_cpu_starting,
 		.teardown.single	= hrtimers_cpu_dying,
 	},
 	[CPUHP_AP_TICK_DYING] = {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 80fe374..030426c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2202,6 +2202,15 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	}
 
 	cpu_base->cpu = cpu;
+	hrtimer_cpu_base_init_expiry_lock(cpu_base);
+	return 0;
+}
+
+int hrtimers_cpu_starting(unsigned int cpu)
+{
+	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
+
+	/* Clear out any left over state from a CPU down operation */
 	cpu_base->active_bases = 0;
 	cpu_base->hres_active = 0;
 	cpu_base->hang_detected = 0;
@@ -2210,7 +2219,6 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
 	cpu_base->online = 1;
-	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
 
@@ -2286,5 +2294,6 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 void __init hrtimers_init(void)
 {
 	hrtimers_prepare_cpu(smp_processor_id());
+	hrtimers_cpu_starting(smp_processor_id());
 	open_softirq(HRTIMER_SOFTIRQ, hrtimer_run_softirq);
 }

