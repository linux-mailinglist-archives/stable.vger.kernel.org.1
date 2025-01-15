Return-Path: <stable+bounces-109159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB68A12B13
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 19:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80713165D32
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 18:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355E51D63EC;
	Wed, 15 Jan 2025 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGsFU88B"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187F31AA783;
	Wed, 15 Jan 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736966573; cv=none; b=Kn+6mfysO28URPdS38URhpELrZ4NaZxjevnic9wyR62JUGRLab827zpst4wjghJq9W1qY+xsNC01RkCdYgQlOfGC/6+3J1c59EERGt60ObTig+sBKbXiT2EprAOXxenvYwg4O2w36S+T7VRL5vGQM/06xR5qls5fYct6jpDSgrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736966573; c=relaxed/simple;
	bh=zrLHgBy1diKkcJvN+xtaUMXNWjr5eHsI4YrTiaKyn+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cXKxJhR7RlRCWA7WN5jY5v4+9rFNZKUigYXgsSLES6M/t8FssHLHfQSwLNr4iPvJvcQrEYLDkeMESp9ojOFlzAEscsP50HuU/ZDLVd+A2Rx3AfQ8smi7CkQS065lU7G656dAXYPbilqe5cVzyHsaObb4h5G1zX8vUyHxIiOFiQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGsFU88B; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736966571; x=1768502571;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zrLHgBy1diKkcJvN+xtaUMXNWjr5eHsI4YrTiaKyn+s=;
  b=lGsFU88BMvX/yL2of4Nx+Rgd2XUp6+3pELehkCjtymr+oM37Itheyy76
   uS+lTDhI8KD9GrNsiRJ8TAhuSGGWL2+Nrf0nNv6rhy1tr9iFrMQsdc7H5
   /1lX4tW659NavOgb4xWv2qHHD+SsGfpdsF495cMZVoBCcIsLX8U+1hZNe
   KP6oBJndlKHqyDeq+dFMNh1R6FI4f/Rp3yGc7R1uT4xBXX2FAxRhiprIG
   1Q0U9Af7SblG5/UtyfsmyuB+bkQL8uSr93c0r90iBjYouZto3hXM3MdCu
   ldST5Hszlm1MHJLTu8G5POUqQ0gkGIzecvCQe8j4kmDRb+M9rI81BBumB
   Q==;
X-CSE-ConnectionGUID: gRCPj6QBRgiGdHVPXSlVFg==
X-CSE-MsgGUID: xegFKhVVQ8WMX7TuZ602eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48733346"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48733346"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 10:42:50 -0800
X-CSE-ConnectionGUID: bCbqAb5DTyybhiMyzijadA==
X-CSE-MsgGUID: 0gqFBqctR5eiZ4f1/O5Oiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="105278506"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa006.jf.intel.com with ESMTP; 15 Jan 2025 10:42:49 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH V9 1/3] perf/x86/intel: Avoid pmu_disable/enable if !cpuc->enabled in sample read
Date: Wed, 15 Jan 2025 10:43:16 -0800
Message-Id: <20250115184318.2854459-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The WARN_ON(this_cpu_read(cpu_hw_events.enabled)) in the
intel_pmu_save_and_restart_reload() is triggered, when sampling read
topdown events.

In a NMI handler, the cpu_hw_events.enabled is set and used to indicate
the status of core PMU. The generic pmu->pmu_disable_count, updated in
the perf_pmu_disable/enable pair, is not touched.
However, the perf_pmu_disable/enable pair is invoked when sampling read
in a NMI handler. The cpuc->enabled is mistakenly set by the
perf_pmu_enable().

Avoid perf_pmu_disable/enable() if the core PMU is already disabled.

Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---

A new patch to fix the issue found on a legacy platform.
(Not related to counters snapshotting feature)

But since it also touches the sampling read code, the patches to enable
the counters snapshotting feature must be on top of the patch.
The patch itself can be applied separately.


 arch/x86/events/intel/core.c | 7 +++++--
 arch/x86/events/intel/ds.c   | 9 ++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2a2824e9c50d..bce423ad3fad 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2778,15 +2778,18 @@ DEFINE_STATIC_CALL(intel_pmu_update_topdown_event, x86_perf_event_update);
 static void intel_pmu_read_topdown_event(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int pmu_enabled = cpuc->enabled;
 
 	/* Only need to call update_topdown_event() once for group read. */
 	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
 	    !is_slots_event(event))
 		return;
 
-	perf_pmu_disable(event->pmu);
+	if (pmu_enabled)
+		perf_pmu_disable(event->pmu);
 	static_call(intel_pmu_update_topdown_event)(event);
-	perf_pmu_enable(event->pmu);
+	if (pmu_enabled)
+		perf_pmu_enable(event->pmu);
 }
 
 static void intel_pmu_read_event(struct perf_event *event)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ba74e1198328..81b6ec8e824e 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2096,11 +2096,14 @@ get_next_pebs_record_by_bit(void *base, void *top, int bit)
 
 void intel_pmu_auto_reload_read(struct perf_event *event)
 {
-	WARN_ON(!(event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD));
+	int pmu_enabled = this_cpu_read(cpu_hw_events.enabled);
 
-	perf_pmu_disable(event->pmu);
+	WARN_ON(!(event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD));
+	if (pmu_enabled)
+		perf_pmu_disable(event->pmu);
 	intel_pmu_drain_pebs_buffer();
-	perf_pmu_enable(event->pmu);
+	if (pmu_enabled)
+		perf_pmu_enable(event->pmu);
 }
 
 /*
-- 
2.38.1


