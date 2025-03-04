Return-Path: <stable+bounces-120380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58348A4EE4F
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 21:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8434B174FB5
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 20:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9091FBC8A;
	Tue,  4 Mar 2025 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BXjiw/S2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PFXA9y4o"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2070A7DA93
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120025; cv=none; b=TQYQtnNJA6/62wzaALwd8c8onAtK2ldCCHASR4E2222US31Fc/5yEuOFwyYq4vWt702/68F3ZfxSA26Zw5rqRrwHgDN6hLloievaXAjia4NNYAhmaKL4qZzP6YQrcyFwBrNbZkVihwOn3gEZMb7WVnziJefzGiXf4qIL/V1B8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120025; c=relaxed/simple;
	bh=kwLtGIaKl/fFSCqY2DrPc0X2oS23r1sZJq3RwipiRNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=alWLk51OSi/K9q99Q8J8JVIJAh39tmtIpAe0LeVkK7zmK3NexUr6hFbjIpbdzNCG47GrnydQsZOmrmxMEEc3i8Y+JKHQS9fqGtDrtULAS0nvO06mT9kRlHdox30sYhPmkQiogXz/abjd5+X8AGz2ep1MUVGYx4AdGqrBoFuaKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BXjiw/S2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PFXA9y4o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741120021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKldEf15/8ppaWz8WIEX29cX+5mhmJ3ttn4RqTLd694=;
	b=BXjiw/S2G/TcnjnLi1cY4oQOdqHC7/QnQ5eB9DbDFkU1GzPAy+XeuMU+4eImKMOqB7N9ld
	7tIHkKIuONC48XjsG4AIoHerm2uuoHyEiTwGefxD/e/KVh4drVWkCMpBwRgeuJjLCFIZg3
	5PyBVhhUl3PXbAvfIA1aT2oC6nMFik3i02rQHeE9SZuKsY1bqYo6HV8jXNuqNEs9E3YRYQ
	avD4JSSDCJ1fvw1/30WyePK6cQ0hd+vhltJyM+GBvc5eQhxKSuKpCNxFkNkNGO7VdKik/8
	Dw6RBPdN3/9kAFmWsaMXKcKt4yMI2a7LaNaxOiqA2kJR+S9a4V5JZvUR4HGfCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741120021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKldEf15/8ppaWz8WIEX29cX+5mhmJ3ttn4RqTLd694=;
	b=PFXA9y4oXZmG8aEZZKG5wnM/ocfz4sX5VBlGaJ7zuMPFPueMqHqmCP3d3S7r8tipjhrk+z
	luxXhEWYoFMecYDw==
To: gregkh@linuxfoundation.org, fabstz-it@yahoo.fr,
 rafael.j.wysocki@intel.com, stable@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y, 6.1.y] intel_idle: Handle older CPUs, which stop the
 TSC in deeper C
In-Reply-To: <2025030415-uncombed-drinking-e339@gregkh>
References: <2025030415-uncombed-drinking-e339@gregkh>
Date: Tue, 04 Mar 2025 21:27:00 +0100
Message-ID: <87sens5yp7.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

commit c157d351460bcf202970e97e611cb6b54a3dd4a4 upstream.

The Intel idle driver is preferred over the ACPI processor idle driver,
but fails to implement the work around for Core2 generation CPUs, where
the TSC stops in C2 and deeper C-states. This causes stalls and boot
delays, when the clocksource watchdog does not catch the unstable TSC
before the CPU goes deep idle for the first time.

The ACPI driver marks the TSC unstable when it detects that the CPU
supports C2 or deeper and the CPU does not have a non-stop TSC.

Add the equivivalent work around to the Intel idle driver to cure that.

Fixes: 18734958e9bf ("intel_idle: Use ACPI _CST for processor models without C-state tables")
Reported-by: Fab Stz <fabstz-it@yahoo.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Fab Stz <fabstz-it@yahoo.fr>
Cc: All applicable <stable@vger.kernel.org>
Closes: https://lore.kernel.org/all/10cf96aa-1276-4bd4-8966-c890377030c3@yahoo.fr
Link: https://patch.msgid.link/87bjupfy7f.ffs@tglx
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
Backport to 6.6.y and 6.1.y
---
 drivers/idle/intel_idle.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -56,6 +56,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <asm/tsc.h>
 #include <asm/fpu/api.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
@@ -1573,6 +1574,9 @@ static void __init intel_idle_init_cstat
 		if (intel_idle_state_needs_timer_stop(state))
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 
+		if (cx->type > ACPI_STATE_C1 && !boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+			mark_tsc_unstable("TSC halts in idle");
+
 		state->enter = intel_idle;
 		state->enter_s2idle = intel_idle_s2idle;
 	}


