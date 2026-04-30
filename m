Return-Path: <stable+bounces-241967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGZuCFuj8mm3tAEAu9opvQ
	(envelope-from <stable+bounces-241967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:33:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD8949BC29
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E8B5307D8EC
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 00:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEAD1CAA6C;
	Thu, 30 Apr 2026 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTBVTM2M"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22661A682F;
	Thu, 30 Apr 2026 00:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509065; cv=none; b=fMur9HnKnSGGM+2nVQPUCIevPMAJ9sR9SpUimM2pHd20Pc5MaF6u3wE3byxV+fP/L/HZjrZMDIm0aYRnM8hEHiU46whs8Fo9aZrf418xy2PqBc8hUrAmrWNKdIXU/PmDLNdKQAiLhqocjC5/M3ff85IvuVtOiLpQ3iB+eu4TBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509065; c=relaxed/simple;
	bh=qwSIvUAIHquGWy/otod5pyn/mc/Z6mxdBqjoaK+pMr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLRaK2oLUPPVSd/5TEI4+Fadqo4MGDBmiw0inuX78ZddopoKdJ3rBrsIdqt8kJlEKbWPHWNSaVXp0ylUauQfcRrDnvh+FmC1J03WUQV53lu/U78Pjp5WSrVfWJ0Eetq1fMQf3rmgETJatH9aLkF3CrMfExyNC2paCB3CyMzqW78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTBVTM2M; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777509065; x=1809045065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qwSIvUAIHquGWy/otod5pyn/mc/Z6mxdBqjoaK+pMr8=;
  b=CTBVTM2MwT5jxB6bRUjKFW+xBuougqt1mjQoo4tGzUzRcb4DKOqPdqAW
   nBbUxZrK4OZGIdj/XXEdAHzRCHUEzTSptQ4oieAl9159GnQl7zImDMj68
   6oDrJubz9SJGAehX/c28FN0Kfn1ye6mPwT4lK4HRTi4K1LSoqYpsnz0Ny
   JOBPi8M3b2fC+4/+4vzYos2OXCLszzoIYhtDuWSuiZqwOgWcMnQZuGCwB
   d3rMgAW3RTH0JPhXX9ei9ov7mONoKvD95tEbaODAa07uPHNir9Wky2n88
   LZkPU923rU214FAp+UzNF9zW0llS+NZoznuqk9bTjQs4AXfzwAh4pbJIM
   w==;
X-CSE-ConnectionGUID: bWjKF9vHQUSmwMFTwK1ZFg==
X-CSE-MsgGUID: CWB3pJWPQF23qyrNefcWrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="95873673"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="95873673"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 17:31:05 -0700
X-CSE-ConnectionGUID: BYLsI6v7SCOvlFBCuH+eYQ==
X-CSE-MsgGUID: D9tDnfB2TF2iQnbRaGUWxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="234455212"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 29 Apr 2026 17:31:01 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	stable@vger.kernel.org
Subject: [Patch v4 4/5] perf/x86/intel: Enable auto counter reload for DMR
Date: Thu, 30 Apr 2026 08:25:57 +0800
Message-Id: <20260430002558.712334-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430002558.712334-1-dapeng1.mi@linux.intel.com>
References: <20260430002558.712334-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9BD8949BC29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-241967-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid]

Panther cove µarch starts to support auto counter reload (ACR), but the
static_call intel_pmu_enable_acr_event() is not updated for the Panther
Cove µarch used by DMR. It leads to the auto counter reload is not
really enabled on DMR.

Update static_call intel_pmu_enable_acr_event() in intel_pmu_init_pnc().

Cc: stable@vger.kernel.org
Fixes: d345b6bb8860 ("perf/x86/intel: Add core PMU support for DMR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9e77d836b878..4d5c35f0df5c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7518,6 +7518,7 @@ static __always_inline void intel_pmu_init_pnc(struct pmu *pmu)
 	hybrid(pmu, event_constraints) = intel_pnc_event_constraints;
 	hybrid(pmu, pebs_constraints) = intel_pnc_pebs_event_constraints;
 	hybrid(pmu, extra_regs) = intel_pnc_extra_regs;
+	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
 }
 
 static __always_inline void intel_pmu_init_skt(struct pmu *pmu)
-- 
2.34.1


