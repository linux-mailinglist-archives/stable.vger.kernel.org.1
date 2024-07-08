Return-Path: <stable+bounces-58251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C249692A9DA
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 21:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C56BB21CDB
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 19:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C3814BFB4;
	Mon,  8 Jul 2024 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRMJ59C4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5971CFAF;
	Mon,  8 Jul 2024 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467166; cv=none; b=iZg6hk0V9UKM/Na9h6Wj+Y/eBAi7OESAu1T5eeYbtk94gCDlJ56o4nf8rvuH4jj2fB4c9nborVQAcChp9/2I/SKuZZrmpcxC2RJ0iHgWqKUOVZjZIrIZycDtLqWnCJjMOkuUO/6B3mZqY4jAoED9+PylKCsiHuEZUaXSFREtHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467166; c=relaxed/simple;
	bh=9azAPtHQWpCrAcC4hsFvD58GfVAqXFENVg14P/0VMTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImpFgB8SZ5VuC3HR307Bn+e2Mvy0sTsCBZYPLPhCMzJTopb1JHz+qp8a8r2TKmo8IHZQnmjSTAC7nejqlyp0REbl7r1WIgWqwBgETTZbVRWnC+mBtvsIe96BVwhueIjWalipZLnkgP6IBL4T6RxClsAWtTXHSVA9uG3PzSlYaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRMJ59C4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720467165; x=1752003165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9azAPtHQWpCrAcC4hsFvD58GfVAqXFENVg14P/0VMTw=;
  b=nRMJ59C4oFaKJwcss+I8DHqIw7Gm/UwvJVz1fFfQFTAYqqief3C6+inc
   60dc8V7LSh221aNbNyyZIsYSyGhyGekTlqR2BhGGdopDcCLG0mG2N71l9
   aNJwtJv/k63Xr3JgL3+Bi5Q/KUoXWJcUky8J/OfODH3r/wPHRgYmm8J+p
   ndtJz0t5tNqGiNQu9j1AsnmuOVKsmJQLs7lun5yccD/09PMeK+s0X9Tmw
   R7/LJWZ74GRbuOZGfEXjLGDNVcu62dZ52/2WVqkIp4qE+AXojyqbLjeP8
   dCnRR8A4Hbhctdc+n3hTxciJn33Kq7EkPm9wSr2Ep55rtKN9OiQ9uivRh
   Q==;
X-CSE-ConnectionGUID: fc1b70G3Rfe1ZeXglMy0NA==
X-CSE-MsgGUID: FIZRcosYRVS1CV+dDNJrRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17520493"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="17520493"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 12:32:42 -0700
X-CSE-ConnectionGUID: 6WwrchycRtSTQilbKLfyEg==
X-CSE-MsgGUID: xWuTnf5kQvuR6i/rdnWOWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="48265598"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 08 Jul 2024 12:32:42 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Ahmad Yasin <ahmad.yasin@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] perf/x86/intel: Add a distinct name for Granite Rapids
Date: Mon,  8 Jul 2024 12:33:35 -0700
Message-Id: <20240708193336.1192217-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240708193336.1192217-1-kan.liang@linux.intel.com>
References: <20240708193336.1192217-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

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
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b61367991a16..7a9f931a1f48 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6943,12 +6943,17 @@ __init int intel_pmu_init(void)
 	case INTEL_EMERALDRAPIDS_X:
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 		x86_pmu.extra_regs = intel_glc_extra_regs;
+		pr_cont("Sapphire Rapids events, ");
+		name = "sapphire_rapids";
 		fallthrough;
 	case INTEL_GRANITERAPIDS_X:
 	case INTEL_GRANITERAPIDS_D:
 		intel_pmu_init_glc(NULL);
-		if (!x86_pmu.extra_regs)
+		if (!x86_pmu.extra_regs) {
 			x86_pmu.extra_regs = intel_rwc_extra_regs;
+			pr_cont("Granite Rapids events, ");
+			name = "granite_rapids";
+		}
 		x86_pmu.pebs_ept = 1;
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = glc_get_event_constraints;
@@ -6959,8 +6964,6 @@ __init int intel_pmu_init(void)
 		td_attr = glc_td_events_attrs;
 		tsx_attr = glc_tsx_events_attrs;
 		intel_pmu_pebs_data_source_skl(true);
-		pr_cont("Sapphire Rapids events, ");
-		name = "sapphire_rapids";
 		break;
 
 	case INTEL_ALDERLAKE:
-- 
2.38.1


