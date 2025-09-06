Return-Path: <stable+bounces-177956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E81B46DFD
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 15:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C11188F7E9
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F4C2EFDAF;
	Sat,  6 Sep 2025 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2fQHLWB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C21527B4
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164934; cv=none; b=dI6SruVjAIqbdShqWlicN3bWw8lj7kFPa8JOFRW64Z0rnwUUcy7lA3oMPB9lxYjf32MnsmzAyKHT5P4hoVrFmpBifpJvWAGcmjYDLpdCxso+dUYEnm64rh56l2OV28LB5ubkda2Pzv0vEZCDbrWRAseasP7798MkHR7NndUTvHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164934; c=relaxed/simple;
	bh=HiLHlYe8Nb3edf0nfvjSTKtE6PP4W5hio/Kpt812TtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFtz/lTGpLb6i1vCZ4xSouNAqf8nNO89EjQi8bqL6C9BDU4pGz/povabrTpETY3FDVPkiZNRDcMSGlq9lti07472haDl/v/Hsafa09Gt+l1zJchpMSEE606dOOTY5zvN1glClNN28CUx36iTfXRU0m5Hx9Qg6rtaev/lO6JAIzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2fQHLWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5E5C4CEF5;
	Sat,  6 Sep 2025 13:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757164933;
	bh=HiLHlYe8Nb3edf0nfvjSTKtE6PP4W5hio/Kpt812TtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g2fQHLWBEHlhBk7RU0FmNFftRHLUZwpTFq9n3D078bhQj3icFBKwtG9D3WelKOuc7
	 Ao0N5gCIZMtWyv78Y9Ti9UqWeQkmqwPa50rLZMdm2+PzVj5RqI68FctbsVA0jFct28
	 aHWSOt0y73Bnwp+eQkeTvVehxkthj5PyWvnxlwSus6V1eecA/WSBHqZNVhf1uKCx55
	 Iw/tv40ebsRLO1AdCDK1lX4tp9u7sSallnEvV11WQih2/M6sIDS/XYrWhwzwmxeN41
	 qqS8RXtHwLX1ufPCvhsVXrJ9MwKHRzb3w1JAKirSO7FbrGzbiNXq+RmKXpQb5B8Q1V
	 BJc2UrnHhOrnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] cpufreq: intel_pstate: Fold intel_pstate_max_within_limits() into caller
Date: Sat,  6 Sep 2025 09:22:08 -0400
Message-ID: <20250906132210.3888723-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250906132210.3888723-1-sashal@kernel.org>
References: <2025050515-constrain-banter-97de@gregkh>
 <20250906132210.3888723-1-sashal@kernel.org>
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
index 15d0d498071f1..39af2970a4297 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1984,14 +1984,6 @@ static void intel_pstate_set_min_pstate(struct cpudata *cpu)
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
@@ -2573,12 +2565,15 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
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
2.51.0


