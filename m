Return-Path: <stable+bounces-120381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EED7A4EE54
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 21:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2120188F9B4
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 20:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6811FAC46;
	Tue,  4 Mar 2025 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UEL714Ck";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u10G06uD"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B27DA93
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120122; cv=none; b=usWqxgNxNhipWAcCgkGa7yOEaryFIFXL3zt/I9rDTf9a5Zu9aIHyEs9jIZqSwYj8D03DHoG9CclV77yksKSW3XqF/pToxouJoeNYXz73+kBwMfSQeUAKyj3DHio3kqRvQXlioBdB24q0POR5HJJMaFbU89vzP7jObct+WfNFW+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120122; c=relaxed/simple;
	bh=mDGYdSW0qh1kVJzyiuqg8+107+esJVVONHcS+tw5Bl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=prwBIFuyjnMds0ZwcHfeUlDxjcLYIwju1Uvyor0kbmIzgOUf+2twIV6w9e+bkuxikGnqkK+oIRwHtXDxVgKiBhIYSZi37oX4Nefd+ouI8nhwg+vKmI85MhdQTWUcL/AJVJOKIMoqBIjUhEOU1KMeCgeZLGeHsY0LGkR7WXn2nsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UEL714Ck; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u10G06uD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741120118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vx2EGfCBOUUVk3JlXR1HNaU2Xxwq4Z39Z4VXqbyWXs0=;
	b=UEL714Ckw5eS2vlA3AvusXDurSHERxZi9B8AmbfHebzSXiYVeCGoQUTh1CManvBqbIFnII
	l07xyB+x3xqk5uNeHyzyURKdyMWIlu6g9zi3Shm4O+WTjIM36PSsl8mkc7gpRYXP6QENDT
	GxJhCISB9UpC88D5nTbK1KoSlLLunOuRnSiHiy2sNK5gpCFgbkH7+74fB/C9lXtgXoxgFo
	4E8JmJzk4SDy7/9bbFYa0FKEKwmhjI0ZMsBhMJlWvSaA5T+loWSUvlP72WG0+CitBa3eDG
	R7rUZIqL1Z1cIPACgHXPg/0okdVgtYI9oZwuksQwLhABhhehufe0ea+0h9p2UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741120118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vx2EGfCBOUUVk3JlXR1HNaU2Xxwq4Z39Z4VXqbyWXs0=;
	b=u10G06uDiu71ACOkTME7I0nt7fTXi8ot3ualqzzAK6fkrv7R8wHEhEwHndJZbnuEzudqK3
	6hA7WXTYf7F8TaAA==
To: gregkh@linuxfoundation.org, fabstz-it@yahoo.fr,
 rafael.j.wysocki@intel.com, stable@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v5.15.y, v5.10.y] intel_idle: Handle older CPUs, which stop
 the TSC in deeper C
In-Reply-To: <2025030416-straining-detergent-2e6d@gregkh>
References: <2025030416-straining-detergent-2e6d@gregkh>
Date: Tue, 04 Mar 2025 21:28:38 +0100
Message-ID: <87pliw5ymh.ffs@tglx>
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
Backport to 5.15.y and 5.10.y
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
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -1335,6 +1336,9 @@ static void __init intel_idle_init_cstat
 		if (intel_idle_state_needs_timer_stop(state))
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 
+		if (cx->type > ACPI_STATE_C1 && !boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+			mark_tsc_unstable("TSC halts in idle");
+
 		state->enter = intel_idle;
 		state->enter_s2idle = intel_idle_s2idle;
 	}

