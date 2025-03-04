Return-Path: <stable+bounces-120310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86594A4E796
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3383189B201
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042DB27CCFA;
	Tue,  4 Mar 2025 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rp1RIYRh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8475255230
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106358; cv=none; b=EvKK9Mp+1X9CQvBHAmq16hEJIcRn7k2XqlWqTAxH8pcyOlYDIOUn8Vfjj90lIa8OVZlwgsGOsEsHR3AE+isJtB7n17YMCfoZSK6kukJePsJOmwkfnq46dPa5rfKqAwuC/K20axuJy4d8psk71lj+Zl9YRaXkjF77nxpzj0ztQJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106358; c=relaxed/simple;
	bh=/fyJ/AUUxwDJHjXAQSsCnTOC2zCba+Sb9p3nxIBORg0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GllL7y8ny5a/yY+PxWib3Rz0czH+gyzC28XVAJfEhqHYC6729Jw9SCHGkf0muUjqfNlW+VnsllJAPdW9jnI4CYeK2gEp9s8nzTJ0WZgL8aeMIwQ0Xf2mJMECj/QheMppgp5IPTOabInckcUZC6tTO4tJIYptD9/bUdq9N9lo0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rp1RIYRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77ECC4CEE5;
	Tue,  4 Mar 2025 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106358;
	bh=/fyJ/AUUxwDJHjXAQSsCnTOC2zCba+Sb9p3nxIBORg0=;
	h=Subject:To:Cc:From:Date:From;
	b=rp1RIYRhv2gmZe4nAjrpbx//AW+KWf2bRkFxg6dI0XDbDE8DAz/whbY1Z+d2XlRvu
	 /P3dLwVeyDZBkWsiO2gvNeCCQMOj3x0DXwEGCPINDs12b883NV+8LCljkc1KtQKUmg
	 rA1HDkYJibLNtbp+WnYriex4Cr9TqCB8TATLLh+c=
Subject: FAILED: patch "[PATCH] intel_idle: Handle older CPUs, which stop the TSC in deeper C" failed to apply to 6.6-stable tree
To: tglx@linutronix.de,fabstz-it@yahoo.fr,rafael.j.wysocki@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:39:15 +0100
Message-ID: <2025030415-uncombed-drinking-e339@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c157d351460bcf202970e97e611cb6b54a3dd4a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030415-uncombed-drinking-e339@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c157d351460bcf202970e97e611cb6b54a3dd4a4 Mon Sep 17 00:00:00 2001
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 25 Feb 2025 23:37:08 +0100
Subject: [PATCH] intel_idle: Handle older CPUs, which stop the TSC in deeper C
 states, correctly

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

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 118fe1d37c22..0fdb1d1316c4 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -56,6 +56,7 @@
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
+#include <asm/tsc.h>
 #include <asm/fpu/api.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
@@ -1799,6 +1800,9 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 		if (intel_idle_state_needs_timer_stop(state))
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 
+		if (cx->type > ACPI_STATE_C1 && !boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+			mark_tsc_unstable("TSC halts in idle");
+
 		state->enter = intel_idle;
 		state->enter_s2idle = intel_idle_s2idle;
 	}


