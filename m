Return-Path: <stable+bounces-134856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DA4A95285
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 16:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F551894D64
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75F478F39;
	Mon, 21 Apr 2025 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SDhWE0CK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638C18B03
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244628; cv=none; b=Zf5i1007133sP0RSj5TGZY8FHy/qxINdaPiaEWEu7UvF/aKhOklMkQVmC0BLtlBIFREsI3eio7LcXGxpaRkiGEugyg0CDWS8kLWdkHMlgkmLDu6Rj4x6/89MFl5RsG8s97+vGpSEbePgbxHb6Q/FiXtsFKhTU112nwj4wkLrjOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244628; c=relaxed/simple;
	bh=RBoseAcq8y9WM9UNZTjgxbRF73p//yts5mLbXEdLFho=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R1IIatPzFCJXr0lbVOEPlKBFho/z9RvvlhNaEYm4GMF+cIuj8ky6B/ldtPm9T9O/cX6nAhdPQj58MGtnF5Mxd/shun7kooSBT9DRhzjJAhUPVMatQAH461lGMq1W7+1AtqT0qbXq2j4hCS11q0+oMBawTCbbxVpABY0Uh+l78Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SDhWE0CK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F363C4CEE4;
	Mon, 21 Apr 2025 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745244628;
	bh=RBoseAcq8y9WM9UNZTjgxbRF73p//yts5mLbXEdLFho=;
	h=Subject:To:Cc:From:Date:From;
	b=SDhWE0CK9IWFHgUjWRoEkreNCNDe+IIg7O9DuS7d+KobyaUmN+bqWf/oKYVkMgCE8
	 3RoUyrnbCQtuZwvXwxtCjjAjhUFituo5JhkD00C40rvk5OdSGvEUOAKdHzZFdMOK9d
	 bVOHFITG8AjKmxtOlYYmg35FjDLA15NiZu51R08c=
Subject: FAILED: patch "[PATCH] perf/x86/intel: Don't clear perf metrics overflow bit" failed to apply to 6.14-stable tree
To: dapeng1.mi@linux.intel.com,kan.liang@linux.intel.com,mingo@kernel.org,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 16:10:25 +0200
Message-ID: <2025042125-nutlike-cornfield-f823@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x a5f5e1238f4ff919816f69e77d2537a48911767b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042125-nutlike-cornfield-f823@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a5f5e1238f4ff919816f69e77d2537a48911767b Mon Sep 17 00:00:00 2001
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
Date: Tue, 15 Apr 2025 10:41:34 +0000
Subject: [PATCH] perf/x86/intel: Don't clear perf metrics overflow bit
 unconditionally

The below code would always unconditionally clear other status bits like
perf metrics overflow bit once PEBS buffer overflows:

        status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;

This is incorrect. Perf metrics overflow bit should be cleared only when
fixed counter 3 in PEBS counter group. Otherwise perf metrics overflow
could be missed to handle.

Closes: https://lore.kernel.org/all/20250225110012.GK31462@noisy.programming.kicks-ass.net/
Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250415104135.318169-1-dapeng1.mi@linux.intel.com

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 09d2d66c9f21..2b70a3adde2f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3049,7 +3049,6 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int bit;
 	int handled = 0;
-	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 
 	inc_irq_stat(apic_perf_irqs);
 
@@ -3093,7 +3092,6 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		handled++;
 		x86_pmu_handle_guest_pebs(regs, &data);
 		static_call(x86_pmu_drain_pebs)(regs, &data);
-		status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
 
 		/*
 		 * PMI throttle may be triggered, which stops the PEBS event.
@@ -3104,6 +3102,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 */
 		if (pebs_enabled != cpuc->pebs_enabled)
 			wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
+
+		/*
+		 * Above PEBS handler (PEBS counters snapshotting) has updated fixed
+		 * counter 3 and perf metrics counts if they are in counter group,
+		 * unnecessary to update again.
+		 */
+		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
+		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
+			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
 	}
 
 	/*
@@ -3123,6 +3130,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		static_call(intel_pmu_update_topdown_event)(NULL, NULL);
 	}
 
+	status &= hybrid(cpuc->pmu, intel_ctrl);
+
 	/*
 	 * Checkpointed counters can lead to 'spurious' PMIs because the
 	 * rollback caused by the PMI will have cleared the overflow status


