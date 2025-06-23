Return-Path: <stable+bounces-155293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51021AE3550
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300C51891F42
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 06:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B18A94A;
	Mon, 23 Jun 2025 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XC2cEy0w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA21DDA34
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 06:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750658995; cv=none; b=C6U2fECEcFt9DQB3iz9kEetxmvURJGzAcZlXKaljozJIZeQzB4wBpfqrD+b7qFBF9BMuiuWYGpngZbty1NnCSC0h8E87XkqsmopeLYZ5Z3I07iWrFfIF2+m+6h3WCB2oK7Arqt345OFJSZIedgHolk46gj/V+Jj6uPlxIbaJbtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750658995; c=relaxed/simple;
	bh=t18PdxfJGbYxZ4Rh41h4xf9whgAg9+QLQlHXiGYg17E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L51FHqIt9y8vjldFoSYopVABaIgcrvFaxjBIzTRpsVzZ1vP0SWH4KxP6NW37ZdbZqLLuf872oAuyoq52Nojw5zLuvwkMK2yJvTqafcg4A6eVvNfcA0sMV78ZJQerEdogiTdkRjbqMUby5gVjzXesa+BMmV5VV1UvEzhm/wpGMno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XC2cEy0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92612C4CEED;
	Mon, 23 Jun 2025 06:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750658994;
	bh=t18PdxfJGbYxZ4Rh41h4xf9whgAg9+QLQlHXiGYg17E=;
	h=Subject:To:Cc:From:Date:From;
	b=XC2cEy0wVKEyvSro+UDySkPFkLelpZW5yHt1Gi69Ilwj/dEVkG1IA5PxuzS14sooB
	 lqyg9UEsd3MiW+W2fosrZgo46KSI9Qte065zEZ7L7Zbi5snP0zUcBWDPiB7gi7LBYp
	 cfCzqkpKKC3iFbZgi/S4LnbmBEnBZFEetSobxuec=
Subject: FAILED: patch "[PATCH] perf/x86/intel: Fix crash in icl_update_topdown_event()" failed to apply to 6.1-stable tree
To: kan.liang@linux.intel.com,mingo@kernel.org,peterz@infradead.org,vincent.weaver@maine.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Jun 2025 08:09:38 +0200
Message-ID: <2025062338-sliver-bacteria-7a82@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b0823d5fbacb1c551d793cbfe7af24e0d1fa45ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062338-sliver-bacteria-7a82@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b0823d5fbacb1c551d793cbfe7af24e0d1fa45ed Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Thu, 12 Jun 2025 07:38:18 -0700
Subject: [PATCH] perf/x86/intel: Fix crash in icl_update_topdown_event()

The perf_fuzzer found a hard-lockup crash on a RaptorLake machine:

  Oops: general protection fault, maybe for address 0xffff89aeceab400: 0000
  CPU: 23 UID: 0 PID: 0 Comm: swapper/23
  Tainted: [W]=WARN
  Hardware name: Dell Inc. Precision 9660/0VJ762
  RIP: 0010:native_read_pmc+0x7/0x40
  Code: cc e8 8d a9 01 00 48 89 03 5b cd cc cc cc cc 0f 1f ...
  RSP: 000:fffb03100273de8 EFLAGS: 00010046
  ....
  Call Trace:
    <TASK>
    icl_update_topdown_event+0x165/0x190
    ? ktime_get+0x38/0xd0
    intel_pmu_read_event+0xf9/0x210
    __perf_event_read+0xf9/0x210

CPUs 16-23 are E-core CPUs that don't support the perf metrics feature.
The icl_update_topdown_event() should not be invoked on these CPUs.

It's a regression of commit:

  f9bdf1f95339 ("perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample read")

The bug introduced by that commit is that the is_topdown_event() function
is mistakenly used to replace the is_topdown_count() call to check if the
topdown functions for the perf metrics feature should be invoked.

Fix it.

Fixes: f9bdf1f95339 ("perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample read")
Closes: https://lore.kernel.org/lkml/352f0709-f026-cd45-e60c-60dfd97f73f3@maine.edu/
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Vince Weaver <vincent.weaver@maine.edu>
Cc: stable@vger.kernel.org # v6.15+
Link: https://lore.kernel.org/r/20250612143818.2889040-1-kan.liang@linux.intel.com

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 741b229f0718..c2fb729c270e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2826,7 +2826,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 		 * If the PEBS counters snapshotting is enabled,
 		 * the topdown event is available in PEBS records.
 		 */
-		if (is_topdown_event(event) && !is_pebs_counter_event_group(event))
+		if (is_topdown_count(event) && !is_pebs_counter_event_group(event))
 			static_call(intel_pmu_update_topdown_event)(event, NULL);
 		else
 			intel_pmu_drain_pebs_buffer();


