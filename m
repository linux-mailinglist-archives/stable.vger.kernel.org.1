Return-Path: <stable+bounces-245361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCNKNEJtAmqosgEAu9opvQ
	(envelope-from <stable+bounces-245361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 01:58:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D5410517AB8
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 01:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EDF530142A2
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 23:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19F436A35F;
	Mon, 11 May 2026 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJns1m/+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762A363C75;
	Mon, 11 May 2026 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543615; cv=none; b=KkST1+g4wQfwbwIBxZGVRU7OOoTt+nv8oIvLLbLe/Cnj+80+N/jfTlvmL7iJKALBXN74DiUeWI/DFGO1xJW9mtvc/XFNlfcTAwCnWPp11NNvXF4WiST95lXsQWKDFH4PQLZT41tEfF33Y0LKnAa4crU4Qvb0rzUcj4Npqajl/VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543615; c=relaxed/simple;
	bh=bdqK3wxSZ7fn5l9i+QKCZmvLjVgO4GGihF8twhzJ9o8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQneuR8RPk1CYUDGMUlHm08KSddv26hFJMdjz1QA8Z+BvBL8h+cFIIfHaClHKw2nDizRVMdsQRWImPJE3LAFy2FCVpinkNcb7DUHVsn4YWWjOzlQeqeBmm+JG/w4EWWUxdjdPGmnhVrCHilp6ZjATj13K+7kVe1PaKYbu2lJ8gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJns1m/+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778543614; x=1810079614;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bdqK3wxSZ7fn5l9i+QKCZmvLjVgO4GGihF8twhzJ9o8=;
  b=kJns1m/+o7eCw2M4FqyBFixpshirGcDcvCamaS8ZNSkqzLq8stfPgPrh
   21bgFA+7YX2KfMXVv1cIeDow1FIim4hnVh0UxbFdFPVtbAg5BssSeA4nq
   wdZSFV3PuJMjdEJpNpxhK8/b9UFxw/37p3GTDJ7JMIwLlGftNJtqlMpQT
   JhZxttUYzZiIVUTMcsiD0FDRnsD/24v8oT6tZbUIsjKl2REW7jWSsOTu5
   vDBSDmPrRAdWP5fCE+9mAYyN+Z9QIRsMOnwZztbwrGNtgfOB+MiUt6uHO
   LDBwHdwkLAcQlKJorM2e82mVglAHGjJXJdDU23S1kGPbRsm2sJl/dnMzz
   g==;
X-CSE-ConnectionGUID: DaoUFSDeQnuf/0BT+Ei1Iw==
X-CSE-MsgGUID: 7/abrQAmQ6WHCndXJaTf/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79393270"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79393270"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:53:33 -0700
X-CSE-ConnectionGUID: Wv2UeC1DRVarUf5MyxtcjA==
X-CSE-MsgGUID: 5FO5m48+S52ff23cjdzqZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="239423967"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa004.fm.intel.com with ESMTP; 11 May 2026 16:53:32 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Henry Tseng <henrytseng@qnap.com>,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: intel_pstate: Fix Raptor Lake-E cpufreq limits
Date: Mon, 11 May 2026 16:53:28 -0700
Message-ID: <20260511235328.2018458-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D5410517AB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245361-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qnap.com:email,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Action: no action

Raptor Lake-E processors are not correctly showing cpufreq frequency
limits.

These CPUs don't set X86_FEATURE_HYBRID_CPU and have no E-cores, but
P-cores still use hybrid scaling factor.

commit 0fcfc9e51990 ("cpufreq: intel_pstate: Fix scaling for
hybrid-capable systems with disabled E-cores") added support for
such configuration. Here using CPPC nominal freq and perf was compared
to still return hybrid scaling factor.

Commit 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get scaling
factors") restructured hwp_get_cpu_scaling() and added an explicit check
for X86_FEATURE_HYBRID_CPU and when not set returns core scaling factor.

To address this remove check for X86_FEATURE_HYBRID_CPU and call
intel_pstate_cppc_get_scaling().

Ideally this change should be enough. But using CPPC for scaling factor
results in rounding error, so still doesn't restore the original
behavior.

In intel_pstate_cppc_get_scaling() return core scaling factor when
ACPI CPPC is not present or when CPPC nominal frequency or nominal
performance are invalid.

Use hybrid_scaling_factor for P-cores when defined for a CPU, if not
calculate from ACPI CPPC nominal frequency and performance.

Fixes: 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get scaling factors")
Reported-by: Henry Tseng <henrytseng@qnap.com>
Closes: https://lore.kernel.org/linux-pm/20260508063032.3248602-1-henrytseng@qnap.com/
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/cpufreq/intel_pstate.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1292da53e5fc..0379efdee5f8 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -421,15 +421,23 @@ static int intel_pstate_cppc_get_scaling(int cpu)
 {
 	struct cppc_perf_caps cppc_perf;
 
+	if (cppc_get_perf_caps(cpu, &cppc_perf) || !cppc_perf.nominal_freq ||
+	    !cppc_perf.nominal_perf)
+		goto core_scaling;
+
+	if (cppc_perf.nominal_perf * 100 == cppc_perf.nominal_freq)
+		goto core_scaling;
+
+	if (hybrid_scaling_factor)
+		return hybrid_scaling_factor;
+
 	/*
-	 * Compute the perf-to-frequency scaling factor for the given CPU if
-	 * possible, unless it would be 0.
+	 * Compute the perf-to-frequency scaling factor for the given CPU
+	 * from nominal freq and nominal_perf
 	 */
-	if (!cppc_get_perf_caps(cpu, &cppc_perf) &&
-	    cppc_perf.nominal_perf && cppc_perf.nominal_freq)
-		return div_u64(cppc_perf.nominal_freq * KHZ_PER_MHZ,
-			       cppc_perf.nominal_perf);
+	return div_u64(cppc_perf.nominal_freq * KHZ_PER_MHZ, cppc_perf.nominal_perf);
 
+core_scaling:
 	return core_get_scaling();
 }
 
@@ -2281,17 +2289,10 @@ static int hwp_get_cpu_scaling(int cpu)
 		 */
 		if (hybrid_get_cpu_type(cpu) == INTEL_CPU_TYPE_CORE)
 			return hybrid_scaling_factor;
-
-		return core_get_scaling();
 	}
 
-	/* Use core scaling on non-hybrid systems. */
-	if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
-		return core_get_scaling();
-
 	/*
-	 * The system is hybrid, but the hybrid scaling factor is not known or
-	 * the CPU type is not one of the above, so use CPPC to compute the
+	 * The system is hybrid, so use CPPC to compute the
 	 * scaling factor for this CPU.
 	 */
 	return intel_pstate_cppc_get_scaling(cpu);
-- 
2.43.0


