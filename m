Return-Path: <stable+bounces-64748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8098942BDE
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 12:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821311F250AB
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 10:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5831AB52F;
	Wed, 31 Jul 2024 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TOGYzi17";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MevkQt1e"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5C51A8BE1;
	Wed, 31 Jul 2024 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421435; cv=none; b=LZ0GzeGgvOSJfnmo2XVppAFrDCFKrgpYNfBdOPpNLREwa7qWpQW3+W4+a6gIeP5sKXtYiTvLZ13aprYGNhujzNauwseuuzm2dTE9lb8yXaBlLvjrfuTVxMMjILlRaKuyDp7rDw1iDOuZgtRKKPIJivPJltdIgk+yvPWML6qQnGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421435; c=relaxed/simple;
	bh=oGEfHtD0ToV1+zuUa0mS21L7o66T5vc+gxcW+bLl6Ho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TArbKL1jUWLF26zmYol+l6+tX5FM6WkgXWfh48ErjSQQ2umkz2QbFn9KbwmLMyDVNnXPcsmEVrxNn3TER1c6jo4DOWFA0AIZ0/0l+aWf08QDNk9UuJBe68xk1WxItl/nHBuDSZA/P2LgU6tY3Azn8ZOpYO8r4FiVch2hOQlVHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TOGYzi17; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MevkQt1e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722421431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/BwLAahx4o9JQsvQ7g49tHiHUz9DIP+4aiCErtBm2/o=;
	b=TOGYzi17BaFYdy9jT+gZ24ydT+vkrVc3gkXxkabf67GWmBQBbO0o2D1Yy5YK2G+4cwnv/u
	9/WUr/YDuTAqGL3G/4EmEXm7iGWRusdMuV9sToafLgliy2ao9lWQ8tAymSuli/e90LUt1x
	R4cdjV+ipRwya7CxPwFz60ULgDk9F1AjGuFrot2vUUcG50fTGGLPRxcc4+Tp0FIh+g0sEF
	MltIl0TS3mkV+HfC9ht6Ot8VeTFj9k7wnbNwe0dz4lq3GFgSDe+Fwbja1BzIgLvtCRAP95
	Ru8GxFKsZ4AoV7snOwvOs73q3uu8IrHuL1dZVRoR4HZQlNWqgGM+Ojc1URNGBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722421431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/BwLAahx4o9JQsvQ7g49tHiHUz9DIP+4aiCErtBm2/o=;
	b=MevkQt1eG/uoOqgz3l2TkoKsoWublOvamjLpe9TO2PZnLOm5nW6VcmVz7Hoq8dGOtIsW4S
	0KSvt/mKIUk5+WDQ==
To: David Wang <00107082@163.com>, liaoyu15@huawei.com
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 stable@vger.kernel.org, x86@kernel.org, Frederic Weisbecker
 <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH] tick/broadcast: Move per CPU pointer access into the atomic
 section
In-Reply-To: <20240730142557.4619-1-00107082@163.com>
References: <20240730142557.4619-1-00107082@163.com>
Date: Wed, 31 Jul 2024 12:23:51 +0200
Message-ID: <87ttg56ers.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The recent fix for making the take over of the broadcast timer more
reliable retrieves a per CPU pointer in preemptible context.

This went unnoticed as compilers hoist the access into the non-preemptible
region where the pointer is actually used. But of course it's valid that
the compiler keeps it at the place where the code puts it which rightfully
triggers:

  BUG: using smp_processor_id() in preemptible [00000000] code:
       caller is hotplug_cpu__broadcast_tick_pull+0x1c/0xc0

Move it to the actual usage site which is in a non-preemptible region.

Fixes: f7d43dd206e7 ("tick/broadcast: Make takeover of broadcast hrtimer reliable")
Reported-by: David Wang <00107082@163.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 kernel/time/tick-broadcast.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1141,7 +1141,6 @@ void tick_broadcast_switch_to_oneshot(vo
 #ifdef CONFIG_HOTPLUG_CPU
 void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 {
-	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 	struct clock_event_device *bc;
 	unsigned long flags;
 
@@ -1167,6 +1166,8 @@ void hotplug_cpu__broadcast_tick_pull(in
 		 * device to avoid the starvation.
 		 */
 		if (tick_check_broadcast_expired()) {
+			struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
+
 			cpumask_clear_cpu(smp_processor_id(), tick_broadcast_force_mask);
 			tick_program_event(td->evtdev->next_event, 1);
 		}

