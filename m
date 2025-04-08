Return-Path: <stable+bounces-128837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20C0A7F59D
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55FB3B96D1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 07:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B9C25FA17;
	Tue,  8 Apr 2025 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IrYAYgsI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7325FA0D
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095833; cv=none; b=sq/nw30amgwVIfuYi7inqX3/cFgGTisy/boTROoDi3/X1+Fy6bpAZcUOSkDTFrV+biST8L1BWgiYyKvvW0yZ2bAQymNEeDaIV938QScvBKnLWORoA4AvrKeOPPUO0ndvpuvFDUJdzQgHTKYS/ohhVPJ0Kelg72r5oC6H2oJ0HnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095833; c=relaxed/simple;
	bh=ASfIUYc98m28JphwVX/1T6x6JjJSaQZIxWgc3thR5EY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SDIrOJyYFHQZRkZ5yZfrK4TBXsw3j9H/ZlPJSgi5kXcMsOExObonm2ej8BUloM7HD5IjjGkUgMROFzg/aOsvkKLDiZ4gjnIDiadaAE2CIzValVtSEzq/dd7Mg4Eo9JU9wkddk2mAhx7dYf84onm3zv6K3LdGlROrJlQmNndjO8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IrYAYgsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F4FC4CEE5;
	Tue,  8 Apr 2025 07:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744095832;
	bh=ASfIUYc98m28JphwVX/1T6x6JjJSaQZIxWgc3thR5EY=;
	h=Subject:To:Cc:From:Date:From;
	b=IrYAYgsI+fVDIBux3sA6g8qEm3pvpfMhQC5QFxp6my8hq2k8DZyZn5GnVFqp9iYw3
	 sttw2fdQMoNQZW9bD4hDN6gaI3eLfbzV+TeNAPCPfwTLEApOB0PbRxv+OhhgT11cTH
	 uMhI/y2OEt9ahZ2zLN/EI9dLPwb8yq4gPcG+5J14=
Subject: FAILED: patch "[PATCH] perf/x86/intel: Apply static call for drain_pebs" failed to apply to 5.15-stable tree
To: peterz@infradead.org,kan.liang@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 09:02:20 +0200
Message-ID: <2025040819-awry-tutor-54ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 314dfe10576912e1d786b13c5d4eee8c51b63caa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040819-awry-tutor-54ca@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 314dfe10576912e1d786b13c5d4eee8c51b63caa Mon Sep 17 00:00:00 2001
From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Date: Tue, 21 Jan 2025 07:23:00 -0800
Subject: [PATCH] perf/x86/intel: Apply static call for drain_pebs

The x86_pmu_drain_pebs static call was introduced in commit 7c9903c9bf71
("x86/perf, static_call: Optimize x86_pmu methods"), but it's not really
used to replace the old method.

Apply the static call for drain_pebs.

Fixes: 7c9903c9bf71 ("x86/perf, static_call: Optimize x86_pmu methods")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250121152303.3128733-1-kan.liang@linux.intel.com

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7601196d1d18..2acea83526c6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3076,7 +3076,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		handled++;
 		x86_pmu_handle_guest_pebs(regs, &data);
-		x86_pmu.drain_pebs(regs, &data);
+		static_call(x86_pmu_drain_pebs)(regs, &data);
 		status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
 
 		/*
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ba74e1198328..322963b02a91 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -957,7 +957,7 @@ static inline void intel_pmu_drain_pebs_buffer(void)
 {
 	struct perf_sample_data data;
 
-	x86_pmu.drain_pebs(NULL, &data);
+	static_call(x86_pmu_drain_pebs)(NULL, &data);
 }
 
 /*
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 31c2771545a6..084e9196b458 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1107,6 +1107,7 @@ extern struct x86_pmu x86_pmu __read_mostly;
 
 DECLARE_STATIC_CALL(x86_pmu_set_period, *x86_pmu.set_period);
 DECLARE_STATIC_CALL(x86_pmu_update,     *x86_pmu.update);
+DECLARE_STATIC_CALL(x86_pmu_drain_pebs,	*x86_pmu.drain_pebs);
 
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {


