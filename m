Return-Path: <stable+bounces-94005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33749D27AB
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D905B30AF6
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2DA1CDA3E;
	Tue, 19 Nov 2024 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HY7wgTbp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B141B1CCECF;
	Tue, 19 Nov 2024 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024698; cv=none; b=DMyoC8cBjMBCxH9LsCkRrM/gkDthcEacdi8XWHgkdNSpGh8aVIO8nxvT7V/2VrioB57PDfGv4AO660XnoiEvHAx8OAMnuRY4gJlqtUUnvVTgKNkCWRXjFUv3ho7dwYre1kopKPAzmZVrYwp7Aufzzp2GGH4at79Qw9lNV+jfsK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024698; c=relaxed/simple;
	bh=hubE/oIsEXcyJKdSHaK31n5gltZEvFOLvxTg1HGGg5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AaqoOT4FoKqIMU8yUYC5FpaNlSaYDeVBXsSBT9MQaHSPnQ2C2AOsEwJD8gEkFcQz9mXXlC+GIcmN12OTfhJl/B5EaF3dRBeT0BzKLpF3CdAsxTgVdP171BfpBF/SD9vDFS8tM+z5j1zdWf6GFEFKLuJ+TFdpP8Rzw5w3ns8CboU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HY7wgTbp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732024697; x=1763560697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hubE/oIsEXcyJKdSHaK31n5gltZEvFOLvxTg1HGGg5I=;
  b=HY7wgTbpXaCpcZqnUWE/tTqYi4LZdT6soPEkB63a261/K5sTjsqxDa3G
   fJh4oMKT5cNSpgDxkV4hAUt9TXsowIsgn5mlu92foRLUBHG/Hcd2x5aOV
   GSg1s+tMBrBK3h6n2YHLVtXbnk7gNKGSvLHHKtySobNVNzqBOWBiValti
   LQ3CzHZ8siv5/jWpS+ASdqgYigUbH/AiZrtUAdRbZfzwAd95maqRSuPxJ
   OWOIOfGqn17Q7hGg8aqk1NI9llRxz7Oj2OZmvObp8mNifAwDrx0m/NuA4
   fnmizx7LXsT9e5PIBrSwOjPRw5E9lEZQMNZiBWpHQp6lUNG/+T8IiBtne
   w==;
X-CSE-ConnectionGUID: rnID8a/nRLi46vFYswP2BQ==
X-CSE-MsgGUID: Tc0KVM9pTrWsup1pvl4Mkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="31435319"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="31435319"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 05:58:15 -0800
X-CSE-ConnectionGUID: kscStD/TSkuM5H2C5Q0xLg==
X-CSE-MsgGUID: /SGz3THoTFuQPsO3Z71Q1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89956369"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 19 Nov 2024 05:58:15 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	linux-kernel@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	eranian@google.com,
	ak@linux.intel.com,
	dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH V2 1/4] perf/x86/intel/ds: Unconditionally drain PEBS DS when changing PEBS_DATA_CFG
Date: Tue, 19 Nov 2024 05:55:01 -0800
Message-Id: <20241119135504.1463839-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241119135504.1463839-1-kan.liang@linux.intel.com>
References: <20241119135504.1463839-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The PEBS kernel warnings can still be observed with the below case.

when the below commands are running in parallel for a while.

  while true;
  do
	perf record --no-buildid -a --intr-regs=AX  \
		    -e cpu/event=0xd0,umask=0x81/pp \
		    -c 10003 -o /dev/null ./triad;
  done &

  while true;
  do
	perf record -e 'cpu/mem-loads,ldlat=3/uP' -W -d -- ./dtlb
  done

The commit b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing
PEBS_DATA_CFG") intends to flush the entire PEBS buffer before the
hardware is reprogrammed. However, it fails in the above case.

The first perf command utilizes the large PEBS, while the second perf
command only utilizes a single PEBS. When the second perf event is
added, only the n_pebs++. The intel_pmu_pebs_enable() is invoked after
intel_pmu_pebs_add(). So the cpuc->n_pebs == cpuc->n_large_pebs check in
the intel_pmu_drain_large_pebs() fails. The PEBS DS is not flushed.
The new PEBS event should not be taken into account when flushing the
existing PEBS DS.

The check is unnecessary here. Before the hardware is reprogrammed, all
the stale records must be drained unconditionally.

For single PEBS or PEBS-vi-pt, the DS must be empty. The drain_pebs()
can handle the empty case. There is no harm to unconditionally drain the
PEBS DS.

Fixes: b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing PEBS_DATA_CFG")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8afc4ad3cd16..1a4b326ca2ce 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1489,7 +1489,7 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 			 * hence we need to drain when changing said
 			 * size.
 			 */
-			intel_pmu_drain_large_pebs(cpuc);
+			intel_pmu_drain_pebs_buffer();
 			adaptive_pebs_record_size_update();
 			wrmsrl(MSR_PEBS_DATA_CFG, pebs_data_cfg);
 			cpuc->active_pebs_data_cfg = pebs_data_cfg;
-- 
2.38.1


