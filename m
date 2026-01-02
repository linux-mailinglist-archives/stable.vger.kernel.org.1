Return-Path: <stable+bounces-204439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 527B7CEE0A5
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B13E13011AA9
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B22D2D7398;
	Fri,  2 Jan 2026 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u4xnv2vu"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394992D77E5
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767344845; cv=none; b=AriTOnt7gPK7Uh9VoSiK1zUrFsnlccaGn6YiM7+Fd9wkFKrEmVEkpj3qiwXx6FsbhgQxiHUbeF01S+pzpyjTMMkBzQtfbfaLvM4ytUkZ+eG9+IXqRRaalsGmzIXe1Vm3YbhoXv4HJhhaYH6uWhOUmzM+KxyeD/3LYiG4Kr9NDl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767344845; c=relaxed/simple;
	bh=DbKsjsJl7UB9Kh/oEojuD1taY+UTMizooxibpWw2+bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEZ9MSQvgp6xoxEsbiaHhccHrZBmNcEj9cfmbJNBqS0hLvkxpo2/x90lna89SWKUem7uACJNBs8DU91P9TKYyHJpjRL5PlC6aBnDyUdR0/UqEUp7QIYtewAI/79LP0wsBWyoDZWIdiRg00QwA7CF98Jx16uV1XP7S37Niv3hUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u4xnv2vu; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767344840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wD12dxnkK8iphtWn4IcvFyKcXErQTxG36lzru7IgNuo=;
	b=u4xnv2vuzQ/IXzfdzcp6c6j3H95PEoAkT+rLbwV06f58iizut9VuZ/bs96dxhHORi9lxX0
	wdMXnazprXONe1iAPNIxgGJ7LD45irX/EOWTDvUwonbWuJFS7aIjq5mKlLdg/YFuKDPGin
	+kQuefJ4Bc0GWZg7rZbTsbgmWGnJZAY=
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	Ingo Molnar <mingo@kernel.org>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 6.6.y 2/4] perf/x86/amd: Avoid taking branches before disabling LBR
Date: Fri,  2 Jan 2026 17:03:18 +0800
Message-ID: <20260102090320.32843-3-leon.hwang@linux.dev>
In-Reply-To: <20260102090320.32843-1-leon.hwang@linux.dev>
References: <20260102090320.32843-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

[ Upstream commit 1eddf187e5d087de4560ec7c3baa2f8283920710 ]

In the following patches we will enable LBR capture on AMD CPUs at
arbitrary point in time, which means that LBR recording won't be frozen
by hardware automatically as part of hardware overflow event. So we need
to take care to minimize amount of branches and function calls/returns
on the path to freezing LBR, minimizing LBR snapshot altering as much as
possible.

As such, split out LBR disabling logic from the sanity checking logic
inside amd_pmu_lbr_disable_all(). This will ensure that no branches are
taken before LBR is frozen in the functionality added in the next patch.
Use __always_inline to also eliminate any possible function calls.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20240402022118.1046049-3-andrii@kernel.org
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/events/amd/lbr.c    |  9 +--------
 arch/x86/events/perf_event.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 5149830c7c4f..33d0a45c0cd3 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -414,18 +414,11 @@ void amd_pmu_lbr_enable_all(void)
 void amd_pmu_lbr_disable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	u64 dbg_ctl, dbg_extn_cfg;
 
 	if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
 		return;
 
-	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
-	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
-
-	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
-		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
-	}
+	__amd_pmu_lbr_disable();
 }
 
 __init int amd_pmu_lbr_init(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 4564521296ac..f1dda8ee0e29 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1315,6 +1315,19 @@ void amd_pmu_lbr_enable_all(void);
 void amd_pmu_lbr_disable_all(void);
 int amd_pmu_lbr_hw_config(struct perf_event *event);
 
+static __always_inline void __amd_pmu_lbr_disable(void)
+{
+	u64 dbg_ctl, dbg_extn_cfg;
+
+	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
+
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	}
+}
+
 #ifdef CONFIG_PERF_EVENTS_AMD_BRS
 
 #define AMD_FAM19H_BRS_EVENT 0xc4 /* RETIRED_TAKEN_BRANCH_INSTRUCTIONS */
-- 
2.52.0


