Return-Path: <stable+bounces-109233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89118A136F6
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 10:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5E81889CDE
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 09:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B591D89FA;
	Thu, 16 Jan 2025 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WWO9mcRE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="77FOCWmZ"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83E18C332;
	Thu, 16 Jan 2025 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021044; cv=none; b=FfU2ywtqyibIuDuoHJtWI0kJGMGluzr/+Zz/0jpf6ERCn2jkSan5tVJZWRx/uE7tY5hz9ezKs4aOGejSe6s9YjR9gYP5r8o9mr0/CC4kYP+EpDVQI9EvWOPYeeSfra0MLua/6wzTSjjVg1VY9Ad+GGPEa9QYcZ/ysdxKG6XWaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021044; c=relaxed/simple;
	bh=aiG0KHsycQ476bCqiAtz7tf4FzzeH/BEWHczTtvlM0s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZDHVP2SyNUeI3eNXcyywm72HOx+p9XO2tGysCxCzRN3ATcJC+uR+yZFiroxZ24XLejtWH50W6coCgUP3HiJ+rpw+hR+InqWYD+C4e9kmjlwoFGjQkUTmP9WxrkQxTkZzv2k93/JXO8dSjvJkVtRp0srOiPPnbktq6O4Xbt3GfoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WWO9mcRE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=77FOCWmZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Jan 2025 09:50:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737021040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mknRUduUpTO0i0DaCHQBknOovVIEgkqbn8qDLaq4uk=;
	b=WWO9mcREAMSJINyjtdfA4VHxBwDtwnqW+9UMOh1ZAfjtputnL9IsFxeICqk9uc+lXbwLW8
	jq2LYbdv0mgJMp/6pZR5DJwF+CVSVSkNfJY4rq8RKR1yeJhG6wsDpRj2qxz6u7jGVEg+nd
	2onuAFk3DYkRUeg++qwg6cbu0esJ+gFyLkz5VzzPCtTCvF7GVv4yueV+4E/unHm2EP5gHB
	MVzzdPOHwlcZNCjDxxmmU86XUcAXvUiTvUyrbZSZVNptJSuqpZBvLu/f+Ffud65SzebQW0
	zaAYfJZSQZZ5KTS3IiXH1CUqCAB92LLSoxL6T7sjsPorvEFi2MK2dcexMrGN+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737021040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mknRUduUpTO0i0DaCHQBknOovVIEgkqbn8qDLaq4uk=;
	b=77FOCWmZdiQXrNKBTrP8MSWm0ImF3/m2yYnKZpDv48eZjZC5sE4SNW3D0xteI09u6FOjg6
	TnIu445cPi0FRfBQ==
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
Message-ID: <173702103889.31546.3399575954102921129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     e00954d8b0a2d54075131fbad4a11b2b7355eee1
Gitweb:        https://git.kernel.org/tip/e00954d8b0a2d54075131fbad4a11b2b7355eee1
Author:        Koichiro Den <koichiro.den@canonical.com>
AuthorDate:    Fri, 20 Dec 2024 22:44:21 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jan 2025 10:39:25 +01:00

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
 kernel/time/hrtimer.c   | 10 +++++++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

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
index 80fe374..edb04af 100644
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
 

