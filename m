Return-Path: <stable+bounces-204440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB56CEE0A8
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 260EA300528D
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CF32D7DD1;
	Fri,  2 Jan 2026 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fDbkPhFm"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E8246BD2;
	Fri,  2 Jan 2026 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767344854; cv=none; b=JMAvNaZL4XRYo8Gvs6ihvh3EdzHJl7OQ/edokb6GQsAoeZUtN5/2WE4Zh6vjDvS3HQd1YiVduhxHXccY2rpuEO8zzYQXLPqusGExDhwnqXNbg3hPuB7N6pHj0+TZKVI6jVUYAuaM/02Ji1nR/sPy0Rl6/OYKQH7/i00Lk1qO39E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767344854; c=relaxed/simple;
	bh=606we/nL0XRz/O/Or1i17b8MgJv23/S0vSrqiHGEFgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSrsHI1cLwj4qhbMLYQBdfYFn1Vn6pB/VKhE3U4DFV89N12/XSUVELzCB+JMsG5wOaaaaVlXCBrvL8wHslh0nCeUkJAWNTEeeXjk1Sxi7zeQNuUGEIN/vFWQKlZbHBsmdOnrQvdRf5LWiwkZrZ8acm9WOclC3PWxZrwzLulbK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fDbkPhFm; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767344847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BK7dCxL5tYSm10/iiJpGo60DW/3GXRdSeb1BZQgwomM=;
	b=fDbkPhFmsQv+kCEoXyWfNk8QbJ8GLl25/mPwWflzfiKaM02pU55AFadZccEx9uQj+lY2+G
	GF1m0pSBq6ZFihlBfH0LRaE+XfJ/BVE2ZtxoOftXsa4xny34oyi/rpndcn+Psz88u11vmh
	gALcq+nbcScSzs0ahgS9rYN07CPe1+A=
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
Subject: [PATCH 6.6.y 3/4] perf/x86/amd: Support capturing LBR from software events
Date: Fri,  2 Jan 2026 17:03:19 +0800
Message-ID: <20260102090320.32843-4-leon.hwang@linux.dev>
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

[ Upstream commit a4d18112e5317c120bcadeb486fbe950f749bb5e ]

Upstream commit c22ac2a3d4bd ("perf: Enable branch record for software
events") added ability to capture LBR (Last Branch Records) on Intel CPUs
from inside BPF program at pretty much any arbitrary point. This is
extremely useful capability that allows to figure out otherwise
hard to debug problems, because LBR is now available based on some
application-defined conditions, not just hardware-supported events.

'retsnoop' is one such tool that takes a huge advantage of this
functionality and has proved to be an extremely useful tool in
practice:

  https://github.com/anakryiko/retsnoop

Now, AMD Zen4 CPUs got support for similar LBR functionality, but
necessary wiring inside the kernel is not yet setup. This patch seeks to
rectify this and follows a similar approach to the original patch
for Intel CPUs. We implement an AMD-specific callback set to be called
through perf_snapshot_branch_stack static call.

Previous preparatory patches ensured that amd_pmu_core_disable_all() and
__amd_pmu_lbr_disable() will be completely inlined and will have no
branches, so LBR snapshot contamination will be minimized.

This was tested on AMD Bergamo CPU and worked well when utilized from
the aforementioned retsnoop tool.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20240402022118.1046049-4-andrii@kernel.org
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/events/amd/core.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 3b09ec4f2b0d..002661418830 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -892,6 +892,37 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 	return amd_pmu_adjust_nmi_window(handled);
 }
 
+/*
+ * AMD-specific callback invoked through perf_snapshot_branch_stack static
+ * call, defined in include/linux/perf_event.h. See its definition for API
+ * details. It's up to caller to provide enough space in *entries* to fit all
+ * LBR records, otherwise returned result will be truncated to *cnt* entries.
+ */
+static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
+{
+	struct cpu_hw_events *cpuc;
+	unsigned long flags;
+
+	/*
+	 * The sequence of steps to freeze LBR should be completely inlined
+	 * and contain no branches to minimize contamination of LBR snapshot
+	 */
+	local_irq_save(flags);
+	amd_pmu_core_disable_all();
+	__amd_pmu_lbr_disable();
+
+	cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	amd_pmu_lbr_read();
+	cnt = min(cnt, x86_pmu.lbr_nr);
+	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
+
+	amd_pmu_v2_enable_all(0);
+	local_irq_restore(flags);
+
+	return cnt;
+}
+
 static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1434,6 +1465,10 @@ static int __init amd_core_pmu_init(void)
 		static_call_update(amd_pmu_branch_reset, amd_pmu_lbr_reset);
 		static_call_update(amd_pmu_branch_add, amd_pmu_lbr_add);
 		static_call_update(amd_pmu_branch_del, amd_pmu_lbr_del);
+
+		/* Only support branch_stack snapshot on perfmon v2 */
+		if (x86_pmu.handle_irq == amd_pmu_v2_handle_irq)
+			static_call_update(perf_snapshot_branch_stack, amd_pmu_v2_snapshot_branch_stack);
 	} else if (!amd_brs_init()) {
 		/*
 		 * BRS requires special event constraints and flushing on ctxsw.
-- 
2.52.0


