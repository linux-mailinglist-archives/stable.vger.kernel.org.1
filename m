Return-Path: <stable+bounces-76075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2032D978038
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4AC284536
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567711D932B;
	Fri, 13 Sep 2024 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2OYm/oVM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC01D6DA0
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231198; cv=none; b=VNdsbD4+wIDjlfrY+NcbQi0d8IkGXm/4qYj1jK7axN4FA+KAvnpeTZp+oJ6WznThpkVwLVz6ouv6qB0aKgULAI0X+A+RgabWFEBByrv45ad0BxfTQt11d91YlmuF/tnfH6a2NOnAGHo5tMqaCR1sYwPq8V7jrRB0sTEh9Mm9SvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231198; c=relaxed/simple;
	bh=IFBUWwYBiz3bQYg8obcG6+Latreh+m33Kw8vBDz6QjI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b2joAjRIRWKERWufNpdSE61BFrty4qh/HYhLOI5zTetrNV6x087C/fo3UWabVXG5fRb62wAvVDQs1WlXejXzrw2oO78RDNoEUWWb002m3rA84fx/0rImvLbE7oNjvscxWEa+vsWHPL3N9PeGNkIrDUZNv8V2uxiPxY5g/YSVLfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2OYm/oVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48469C4CEC0;
	Fri, 13 Sep 2024 12:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726231197;
	bh=IFBUWwYBiz3bQYg8obcG6+Latreh+m33Kw8vBDz6QjI=;
	h=Subject:To:Cc:From:Date:From;
	b=2OYm/oVMP42d/Ob3af+nRG4MdwrEdusUzcFeUfQCRx7557zLqiBMk8y5dpMHUrWVP
	 O/hrtqufi5J1cmU3EJAFtfTnIjJk8epYs6ToU3966V4ZNs58VcVUNB5YREZfLFxCmY
	 Tl5MHyJ/SF1Zb7moUaR1oRwpTIo/3VtVJxp1s8K0=
Subject: FAILED: patch "[PATCH] clocksource: hyper-v: Use lapic timer in a TDX VM without" failed to apply to 6.6-stable tree
To: decui@microsoft.com,mhklinux@outlook.com,romank@linux.microsoft.com,wei.liu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 13 Sep 2024 14:39:54 +0200
Message-ID: <2024091354-stock-suspend-e1ee@gregkh>
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
git cherry-pick -x 7f828d5fff7d24752e1ecf6bebb6617a81f97b93
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024091354-stock-suspend-e1ee@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

7f828d5fff7d ("clocksource: hyper-v: Use lapic timer in a TDX VM without paravisor")
b967df629351 ("hyperv-tlfs: Rename some HV_REGISTER_* defines for consistency")
0e3f7d120086 ("hyperv-tlfs: Change prefix of generic HV_REGISTER_* MSRs to HV_MSR_*")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f828d5fff7d24752e1ecf6bebb6617a81f97b93 Mon Sep 17 00:00:00 2001
From: Dexuan Cui <decui@microsoft.com>
Date: Thu, 20 Jun 2024 23:16:14 -0700
Subject: [PATCH] clocksource: hyper-v: Use lapic timer in a TDX VM without
 paravisor

In a TDX VM without paravisor, currently the default timer is the Hyper-V
timer, which depends on the slow VM Reference Counter MSR: the Hyper-V TSC
page is not enabled in such a VM because the VM uses Invariant TSC as a
better clocksource and it's challenging to mark the Hyper-V TSC page shared
in very early boot.

Lower the rating of the Hyper-V timer so the local APIC timer becomes the
the default timer in such a VM, and print a warning in case Invariant TSC
is unavailable in such a VM. This change should cause no perceivable
performance difference.

Cc: stable@vger.kernel.org # 6.6+
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/20240621061614.8339-1-decui@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20240621061614.8339-1-decui@microsoft.com>

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e0fd57a8ba84..954b7cbfa2f0 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -449,9 +449,23 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
 
 			if (!ms_hyperv.paravisor_present) {
-				/* To be supported: more work is required.  */
+				/*
+				 * Mark the Hyper-V TSC page feature as disabled
+				 * in a TDX VM without paravisor so that the
+				 * Invariant TSC, which is a better clocksource
+				 * anyway, is used instead.
+				 */
 				ms_hyperv.features &= ~HV_MSR_REFERENCE_TSC_AVAILABLE;
 
+				/*
+				 * The Invariant TSC is expected to be available
+				 * in a TDX VM without paravisor, but if not,
+				 * print a warning message. The slower Hyper-V MSR-based
+				 * Ref Counter should end up being the clocksource.
+				 */
+				if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
+					pr_warn("Hyper-V: Invariant TSC is unavailable\n");
+
 				/* HV_MSR_CRASH_CTL is unsupported. */
 				ms_hyperv.misc_features &= ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
 
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index b2a080647e41..99177835cade 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -137,7 +137,21 @@ static int hv_stimer_init(unsigned int cpu)
 	ce->name = "Hyper-V clockevent";
 	ce->features = CLOCK_EVT_FEAT_ONESHOT;
 	ce->cpumask = cpumask_of(cpu);
-	ce->rating = 1000;
+
+	/*
+	 * Lower the rating of the Hyper-V timer in a TDX VM without paravisor,
+	 * so the local APIC timer (lapic_clockevent) is the default timer in
+	 * such a VM. The Hyper-V timer is not preferred in such a VM because
+	 * it depends on the slow VM Reference Counter MSR (the Hyper-V TSC
+	 * page is not enbled in such a VM because the VM uses Invariant TSC
+	 * as a better clocksource and it's challenging to mark the Hyper-V
+	 * TSC page shared in very early boot).
+	 */
+	if (!ms_hyperv.paravisor_present && hv_isolation_type_tdx())
+		ce->rating = 90;
+	else
+		ce->rating = 1000;
+
 	ce->set_state_shutdown = hv_ce_shutdown;
 	ce->set_state_oneshot = hv_ce_set_oneshot;
 	ce->set_next_event = hv_ce_set_next_event;


