Return-Path: <stable+bounces-177949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E5B46D8E
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2EAD7B55E9
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C63F2EDD6D;
	Sat,  6 Sep 2025 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7X1DWSG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB7C131E2D
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164348; cv=none; b=rnYTiCI7m3gnqe6r08cnrpOmDHWpGhgz7QFF2qvdYReMmEPiWeMKeJK5oFqnrZSlQsL6B7+8cGHTIM6jXVpZy5HA30WE65i3q5PRIq8MKW2+nVay714IMZc1X9N2/or8dzZ/24x1K23cSRTEQ1SkH6yxy7uLaj1xov0dtKjwg6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164348; c=relaxed/simple;
	bh=FbCCccFAEspALZFjCbBhtO83VUm6j/6wVgwl2NjRb20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu5zqqm36nfuKzuCWnc4s1Ga19ST5J3RItudGM1vz0tW+NDe8xz1Xrp4X/QV4fipXFDBKkW6N0B/SSzjImW9tWIIm9ZUCwxXviDJp4qtE6XfAKNMFTuLcT6DO+ePcvtz18BlZLWn8EhuuAdXp0Eq/aCcs7XtKEC3gY1SOAbfR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7X1DWSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D310C4CEF4;
	Sat,  6 Sep 2025 13:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757164347;
	bh=FbCCccFAEspALZFjCbBhtO83VUm6j/6wVgwl2NjRb20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b7X1DWSG8m7YTXHE6c/OhYJqcWQvKIdJkS4mf5BpoUZx2cyz08A211H/iAfHKSiBb
	 /f9LZgAJulqeBrJMWIzCyxtvE4nc7YPiBCppVAL1x/a/Soy4vqzXXkhoV9hGKTacVr
	 IAQSyzQWURHBTxLsoSDlSyoiEaB/5M625Q4Ac6874TStLDmb/ZNvU2waj17zaWKrYm
	 sgJFeBqWJaieHoY5yPX4PjzBOEIBCjkC7C/GnxP8TS+9velPIftV1ReTKRB2JgP4F5
	 us9p+9sKFqppqRNHBQ439oPyE0xQXVrsDUqFkzNswzuW/StWrYKclVXvMbtsd3skIR
	 ZmyOZLhDDXccw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] cpufreq: intel_pstate: Fold intel_pstate_max_within_limits() into caller
Date: Sat,  6 Sep 2025 09:12:22 -0400
Message-ID: <20250906131224.3883544-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250906131224.3883544-1-sashal@kernel.org>
References: <2025050513-urchin-estranged-d31c@gregkh>
 <20250906131224.3883544-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 032c5565eb80edb6f2faeb31939540c897987119 ]

Fold intel_pstate_max_within_limits() into its only caller.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Stable-dep-of: ac4e04d9e378 ("cpufreq: intel_pstate: Unchecked MSR aceess in legacy mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/intel_pstate.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b2da03cd8ebd9..03c585113d569 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2027,14 +2027,6 @@ static void intel_pstate_set_min_pstate(struct cpudata *cpu)
 	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate);
 }
 
-static void intel_pstate_max_within_limits(struct cpudata *cpu)
-{
-	int pstate = max(cpu->pstate.min_pstate, cpu->max_perf_ratio);
-
-	update_turbo_state();
-	intel_pstate_set_pstate(cpu, pstate);
-}
-
 static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 {
 	int perf_ctl_max_phys = pstate_funcs.get_max_physical(cpu->cpu);
@@ -2608,12 +2600,15 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	intel_pstate_update_perf_limits(cpu, policy->min, policy->max);
 
 	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
+		int pstate = max(cpu->pstate.min_pstate, cpu->max_perf_ratio);
+
 		/*
 		 * NOHZ_FULL CPUs need this as the governor callback may not
 		 * be invoked on them.
 		 */
 		intel_pstate_clear_update_util_hook(policy->cpu);
-		intel_pstate_max_within_limits(cpu);
+		update_turbo_state();
+		intel_pstate_set_pstate(cpu, pstate);
 	} else {
 		intel_pstate_set_update_util_hook(policy->cpu);
 	}
-- 
2.50.1


