Return-Path: <stable+bounces-114209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3206A2BDA1
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 09:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5730F168A06
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 08:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B291A4F2D;
	Fri,  7 Feb 2025 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="36MBkKWr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bw1eyIbx"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2F1547CA;
	Fri,  7 Feb 2025 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738915996; cv=none; b=qkolyYY1MJOgK4oHXwqQ53HmvXtPSxliZ73k+9ZrWa4lDCWNSA4b20vTsGAlSCuXx2XP8rtoFazyti3+gZkzyFTNGwdVIOF+7Ps8rck1BX6x/fS6Obh3ViuQfdhJ+kO3nDYYJO9DJNjrly6RGEN8y42pFuaJgzC8wGD15befDW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738915996; c=relaxed/simple;
	bh=pwdgnneK3dst1VUutsdE5GPzlHdvaje/IbI+REn1fKg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TiaAxFx9lu4kSclDakCdQ32ngLcUWN0+9Rig8kGy8uQUXsvutXUWzwOfSDoXSOQxvGDVK/9NXl8VUD3icZvxbXzvaEHRKYf1lxe9C1rtFi+faKs0XaWznOEV/j296XgzVb1bOmFecrEwmebwlMUcRgORpU5ln8SNsRdiORRcfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=36MBkKWr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bw1eyIbx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 07 Feb 2025 08:13:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738915993;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZjbsWaHjvehxwqwuNv4yk95BFAXowqdx+sHrdVqZDY=;
	b=36MBkKWrrNXZVJ4U2quYSC+nC3cyy2oRnVm7Mirx+l3rNwxRmTM1haBc5m/MJgly88Uw6H
	3M1GsI/xxhzYiMhKXfDMNml5/0pI5cslPTobTIV4b/1jG9ju4JBdwGIU+abOHm8tDyLJqG
	/ZwSpzuss9NWLlmYhwf3rDDF3Qib82As94qd7vUFto7s4XuKJclXjIosuBClNpiAMNP+R2
	eY8wAhwU0ckJArtwAsANjL+Sh7REVg8xYkVsrqXTSwnhkgFwC1gzVwO0wu25lW4L7areJT
	qCZ7sKEZiDoQ96vGLZZml+evQ9dzfWHO0jju/JaBnwxpQumTNeu0NzHFOevyeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738915993;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZjbsWaHjvehxwqwuNv4yk95BFAXowqdx+sHrdVqZDY=;
	b=bw1eyIbxNJF2KrqmA9sJlfM+RQVZ2R8+4bhaN4yK8xak+/vCmCG27v2gBeSaXOH0R16E6t
	clthY5R0Qz7yvwAA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] timers/migration: Fix off-by-one root mis-connection
Cc: Matt Fleming <mfleming@cloudflare.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250205160220.39467-1-frederic@kernel.org>
References: <20250205160220.39467-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173891599227.10177.12341111504955542995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     868c9037df626b3c245ee26a290a03ae1f9f58d3
Gitweb:        https://git.kernel.org/tip/868c9037df626b3c245ee26a290a03ae1f9f58d3
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 05 Feb 2025 17:02:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 07 Feb 2025 09:02:16 +01:00

timers/migration: Fix off-by-one root mis-connection

Before attaching a new root to the old root, the children counter of the
new root is checked to verify that only the upcoming CPU's top group have
been connected to it. However since the recently added commit b729cc1ec21a
("timers/migration: Fix another race between hotplug and idle entry/exit")
this check is not valid anymore because the old root is pre-accounted
as a child to the new root. Therefore after connecting the upcoming
CPU's top group to the new root, the children count to be expected must
be 2 and not 1 anymore.

This omission results in the old root to not be connected to the new
root. Then eventually the system may run with more than one top level,
which defeats the purpose of a single idle migrator.

Also the old root is pre-accounted but not connected upon the new root
creation. But it can be connected to the new root later on. Therefore
the old root may be accounted twice to the new root. The propagation of
such overcommit can end up creating a double final top-level root with a
groupmask incorrectly initialized. Although harmless given that the final
top level roots will never have a parent to walk up to, this oddity
opportunistically reported the core issue:

  WARNING: CPU: 8 PID: 0 at kernel/time/timer_migration.c:543 tmigr_requires_handle_remote
  CPU: 8 UID: 0 PID: 0 Comm: swapper/8
  RIP: 0010:tmigr_requires_handle_remote
  Call Trace:
   <IRQ>
   ? tmigr_requires_handle_remote
   ? hrtimer_run_queues
   update_process_times
   tick_periodic
   tick_handle_periodic
   __sysvec_apic_timer_interrupt
   sysvec_apic_timer_interrupt
  </IRQ>

Fix the problem by taking the old root into account in the children count
of the new root so the connection is not omitted.

Also warn when more than one top level group exists to better detect
similar issues in the future.

Fixes: b729cc1ec21a ("timers/migration: Fix another race between hotplug and idle entry/exit")
Reported-by: Matt Fleming <mfleming@cloudflare.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250205160220.39467-1-frederic@kernel.org
---
 kernel/time/timer_migration.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 9cb9b65..2f63308 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1675,6 +1675,9 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 	} while (i < tmigr_hierarchy_levels);
 
+	/* Assert single root */
+	WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_list[top]));
+
 	while (i > 0) {
 		group = stack[--i];
 
@@ -1716,7 +1719,12 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 		WARN_ON_ONCE(top == 0);
 
 		lvllist = &tmigr_level_list[top];
-		if (group->num_children == 1 && list_is_singular(lvllist)) {
+
+		/*
+		 * Newly created root level should have accounted the upcoming
+		 * CPU's child group and pre-accounted the old root.
+		 */
+		if (group->num_children == 2 && list_is_singular(lvllist)) {
 			/*
 			 * The target CPU must never do the prepare work, except
 			 * on early boot when the boot CPU is the target. Otherwise

