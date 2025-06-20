Return-Path: <stable+bounces-155115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D76AAE1988
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 13:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224CD163F97
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEDF285411;
	Fri, 20 Jun 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5TQWyll"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE423AB9C;
	Fri, 20 Jun 2025 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417481; cv=none; b=Z3ufF75efTm3tSiRYAFLATGsUfnkMK3qspDStqRw2e7YTnYyqQiehp+hBKmkaxdqj5Tzm6wa71zzeyIpQyF/+f8T19BLp9xXJS7WkULTv7/DAxiYpxB+1mkQXBwWUAG3Xr+TAdxxR2UG20048RXFf59L6blL9I4tyYsicJDlbRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417481; c=relaxed/simple;
	bh=2Kr0s01O6FHXBu+oXsyg7E2mw35WNhmqc1EtpaC2LQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HyLy6hQRmhnJn5zHSkqSOqIupMHmWQMd2ZoglumDFJ/o01A/Oz7hN1kKvF0GSaVfTZMeTjegue1ICOqoE5WoFWbOGnETryFaWxvCxrWPgmHHPkflVKW4Y2Doa5qbi91VZnELbQKS3Op/F3Mfz4ULR6R4hxNA8N2XsJpN6eCO78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5TQWyll; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750417480; x=1781953480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2Kr0s01O6FHXBu+oXsyg7E2mw35WNhmqc1EtpaC2LQ8=;
  b=j5TQWyllNtf2zpAPJ52k+Wi7B5IqR4Xi4oIkYJlsF9Eg1gkrgbN2VX1r
   +KDqyHo96wI+agKBk0BqB16zE+6EdDm9Re1AjGTF/NoI5KH0Bb8hfaSnc
   ApLzt1z08I1w5T4bJpmoLEzRpnifV6u4MkVqJHa/AWWIw1DP4NqCtiy8s
   iAtKJMorF8LY/Dbr4g+P9stj7KPE6J5egs+4+L+kEnf9jRrqdfrN00SiF
   ++6iW9tJ91qwdivJYS9MSHmdePzdgNsLIehd6eW4TE+5CFAUhptFAgiYW
   9ocDXEonDJir/as89DtUzp2vfRjxIysETB7TZLywGiH5Vgh03xgbJfe2l
   Q==;
X-CSE-ConnectionGUID: 9zdaxZ1iRiKLkwDbyLWe9w==
X-CSE-MsgGUID: ByyY1OE9RxyqhsrZt+HWTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52759863"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="52759863"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 04:04:39 -0700
X-CSE-ConnectionGUID: +OzpplOmQPO09MAPskEdGw==
X-CSE-MsgGUID: ivzRA5eyTdqyiXW1hk7Ktg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="150307555"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 20 Jun 2025 04:04:38 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Vince Weaver <vincent.weaver@maine.edu>,
	stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel: Fix unchecked PEBS_ENABLE MSR access error
Date: Fri, 20 Jun 2025 04:04:06 -0700
Message-Id: <20250620110406.3782402-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

perf_fuzzzer reported an unchecked MSR access error.

[12646.001692] unchecked MSR access error: WRMSR to 0x3f1
(tried to write 0x0001000000000001) at
rIP: 0xffffffffa98932af (native_write_msr+0xf/0x20)
[12646.001698] Call Trace:
[12646.001700]  <TASK>
[12646.001700]  intel_pmu_pebs_enable_all+0x2c/0x40
[12646.001703]  intel_pmu_enable_all+0xe/0x20
[12646.001705]  ctx_resched+0x227/0x280
[12646.001708]  event_function+0x8f/0xd0

Thank Vince very much for providing a small reproducible test case.
https://lore.kernel.org/lkml/d12d4300-9926-5e58-6515-a53cb5c7bee0@maine.edu/

The error is because perf mistakenly creates a precise Topdown perf
metrics event, INTEL_TD_METRIC_RETIRING, which uses the idx 48
internally.
The Topdown perf metrics events never be a precise event (PEBS). Any
illegal creation should be filtered out by the intel_pmu_hw_config.
However, the is_available_metric_event() failed to detect the Topdown
perf metrics event. The filter is not applied.

To detect an event, the pure event encoding should be used, rather than
the whole event->attr.config. Only check the pure event encoding in
is_available_metric_event.

Fixes: 1ab5f235c176 ("perf/x86/intel: Filter unsupported Topdown metrics event")
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Closes: https://lore.kernel.org/lkml/14d3167e-4dad-f68e-822f-21cd86eab873@maine.edu/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8f2e36ad89db..bf5ca4cb232b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4082,7 +4082,7 @@ static int core_pmu_hw_config(struct perf_event *event)
 static bool is_available_metric_event(struct perf_event *event)
 {
 	return is_metric_event(event) &&
-		event->attr.config <= INTEL_TD_METRIC_AVAILABLE_MAX;
+	       (event->attr.config & INTEL_ARCH_EVENT_MASK) <= INTEL_TD_METRIC_AVAILABLE_MAX;
 }
 
 static inline bool is_mem_loads_event(struct perf_event *event)
-- 
2.38.1


