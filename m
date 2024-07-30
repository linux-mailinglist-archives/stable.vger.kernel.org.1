Return-Path: <stable+bounces-62703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 700C5940D9D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E96AB27485
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2981195F00;
	Tue, 30 Jul 2024 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QJcpGKRg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632CE195B33
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331729; cv=none; b=tnuGA/Qt5NFlqmBufxuzrWGrwnk++Kj04d1qL+KgYjxa812QhXwuO4cpyshcqzm8MXQ8u39ZqaD2lgQ2MzSDIr30dqBjFrJuvjuBr9M00ec8Z9aYxnAzmSnjV73dmJGQNz9QHgvfXniNyENL8IEf35ubMhWq9AooXnH+liQDkaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331729; c=relaxed/simple;
	bh=LsWpTrlfPIVN5216nZ8MaukAi/Sceavw78LO8OHJZ8w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bY78Xh1A7N5SyoCwp+5xNH2NLfgxzWQQQ5MO/DazKUF+lKANh+B19cfkpGhouanqL9sXS3Q5gDnU4tbTIba47Y61RlOE9jw2Hh624chF827pu40O/rBFLAmWbFzIrTfnvMQxQUA99+wDjceta2zmejZfnkAaZXFR6CXfefG8yEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QJcpGKRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12A7C4AF0C;
	Tue, 30 Jul 2024 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722331729;
	bh=LsWpTrlfPIVN5216nZ8MaukAi/Sceavw78LO8OHJZ8w=;
	h=Subject:To:Cc:From:Date:From;
	b=QJcpGKRgUo02QMpdy1mLCohSrec+IcDodEIWVDcOonhXZL60HEOamUvs/ZrzBMQES
	 blI8k2N4nfkpIi/DL9R8DJFebR6M523U5SWg89efVm0SlwUk5xOkE4GR3SWAlPOIVd
	 Ys3Hj11HxGDTeAGHS5fYVx5X9KZKddhIOS1Q770U=
Subject: FAILED: patch "[PATCH] perf/x86/intel: Add a distinct name for Granite Rapids" failed to apply to 6.10-stable tree
To: kan.liang@linux.intel.com,ahmad.yasin@intel.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:28:43 +0200
Message-ID: <2024073042-perennial-patio-0790@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x fa0c1c9d283b37fdb7fc1dcccbb88fc8f48a4aa4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073042-perennial-patio-0790@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

fa0c1c9d283b ("perf/x86/intel: Add a distinct name for Granite Rapids")
d142df13f357 ("perf/x86/intel: Switch to new Intel CPU model defines")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa0c1c9d283b37fdb7fc1dcccbb88fc8f48a4aa4 Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Mon, 8 Jul 2024 12:33:35 -0700
Subject: [PATCH] perf/x86/intel: Add a distinct name for Granite Rapids
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, the Sapphire Rapids and Granite Rapids share the same PMU
name, sapphire_rapids. Because from the kernel’s perspective, GNR is
similar to SPR. The only key difference is that they support different
extra MSRs. The code path and the PMU name are shared.

However, from end users' perspective, they are quite different. Besides
the extra MSRs, GNR has a newer PEBS format, supports Retire Latency,
supports new CPUID enumeration architecture, doesn't required the
load-latency AUX event, has additional TMA Level 1 Architectural Events,
etc. The differences can be enumerated by CPUID or the PERF_CAPABILITIES
MSR. They weren't reflected in the model-specific kernel setup.
But it is worth to have a distinct PMU name for GNR.

Fixes: a6742cb90b56 ("perf/x86/intel: Fix the FRONTEND encoding on GNR and MTL")
Suggested-by: Ahmad Yasin <ahmad.yasin@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20240708193336.1192217-3-kan.liang@linux.intel.com

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b61367991a16..0c9c2706d4ec 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6943,12 +6943,18 @@ __init int intel_pmu_init(void)
 	case INTEL_EMERALDRAPIDS_X:
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 		x86_pmu.extra_regs = intel_glc_extra_regs;
-		fallthrough;
+		pr_cont("Sapphire Rapids events, ");
+		name = "sapphire_rapids";
+		goto glc_common;
+
 	case INTEL_GRANITERAPIDS_X:
 	case INTEL_GRANITERAPIDS_D:
+		x86_pmu.extra_regs = intel_rwc_extra_regs;
+		pr_cont("Granite Rapids events, ");
+		name = "granite_rapids";
+
+	glc_common:
 		intel_pmu_init_glc(NULL);
-		if (!x86_pmu.extra_regs)
-			x86_pmu.extra_regs = intel_rwc_extra_regs;
 		x86_pmu.pebs_ept = 1;
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = glc_get_event_constraints;
@@ -6959,8 +6965,6 @@ __init int intel_pmu_init(void)
 		td_attr = glc_td_events_attrs;
 		tsx_attr = glc_tsx_events_attrs;
 		intel_pmu_pebs_data_source_skl(true);
-		pr_cont("Sapphire Rapids events, ");
-		name = "sapphire_rapids";
 		break;
 
 	case INTEL_ALDERLAKE:


