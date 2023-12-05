Return-Path: <stable+bounces-4130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB34A80461F
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D9E2B20BD3
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C68F6FB1;
	Tue,  5 Dec 2023 03:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P6WVug61"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0DE6110;
	Tue,  5 Dec 2023 03:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1BDC433C8;
	Tue,  5 Dec 2023 03:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746698;
	bh=ON4/2L5wMi4RvEXIHqJT9BKBlTPg8pWAQLQxSsyWOLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P6WVug61z5PA7TBaJgHzneODAtJjIKmj1Lk93J1dLhS12ozQvc47YtJjqkcMqwFl+
	 KeJ337YtAeILYnyhjykFLKHTM6OhFNoYapcxB/kvmkpdZUEvUuS8IOn1oXqfMcbyV6
	 8wmNG7J4UTTH+7HC/3qWZcTmPCpzLCmfUvVxrtvU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huang Rui <ray.huang@amd.com>,
	Wyes Karny <wyes.karny@amd.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 123/134] cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update
Date: Tue,  5 Dec 2023 12:16:35 +0900
Message-ID: <20231205031543.252639093@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wyes Karny <wyes.karny@amd.com>

[ Upstream commit febab20caebac959fdc3d7520bc52de8b1184455 ]

When amd_pstate is running, writing to scaling_min_freq and
scaling_max_freq has no effect. These values are only passed to the
policy level, but not to the platform level. This means that the
platform does not know about the frequency limits set by the user.

To fix this, update the min_perf and max_perf values at the platform
level whenever the user changes the scaling_min_freq and scaling_max_freq
values.

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 60 ++++++++++++++++++++++++++++--------
 include/linux/amd-pstate.h   |  4 +++
 2 files changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 300f81d36291b..3313d1d2c6ddf 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -307,11 +307,11 @@ static int pstate_init_perf(struct amd_cpudata *cpudata)
 		highest_perf = AMD_CPPC_HIGHEST_PERF(cap1);
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
-
+	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
 	WRITE_ONCE(cpudata->nominal_perf, AMD_CPPC_NOMINAL_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf, AMD_CPPC_LOWNONLIN_PERF(cap1));
 	WRITE_ONCE(cpudata->lowest_perf, AMD_CPPC_LOWEST_PERF(cap1));
-
+	WRITE_ONCE(cpudata->min_limit_perf, AMD_CPPC_LOWEST_PERF(cap1));
 	return 0;
 }
 
@@ -329,11 +329,12 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 		highest_perf = cppc_perf.highest_perf;
 
 	WRITE_ONCE(cpudata->highest_perf, highest_perf);
-
+	WRITE_ONCE(cpudata->max_limit_perf, highest_perf);
 	WRITE_ONCE(cpudata->nominal_perf, cppc_perf.nominal_perf);
 	WRITE_ONCE(cpudata->lowest_nonlinear_perf,
 		   cppc_perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
+	WRITE_ONCE(cpudata->min_limit_perf, cppc_perf.lowest_perf);
 
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
@@ -432,6 +433,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u64 value = prev;
 
+	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
+	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
 
 	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
@@ -470,6 +475,22 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
+static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
+{
+	u32 max_limit_perf, min_limit_perf;
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
+	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
+
+	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
+	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
+	WRITE_ONCE(cpudata->max_limit_freq, policy->max);
+	WRITE_ONCE(cpudata->min_limit_freq, policy->min);
+
+	return 0;
+}
+
 static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 				  unsigned int target_freq, bool fast_switch)
 {
@@ -480,6 +501,9 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 	if (!cpudata->max_freq)
 		return -ENODEV;
 
+	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
+		amd_pstate_update_min_max_limit(policy);
+
 	cap_perf = READ_ONCE(cpudata->highest_perf);
 	min_perf = READ_ONCE(cpudata->lowest_perf);
 	max_perf = cap_perf;
@@ -534,6 +558,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	struct amd_cpudata *cpudata = policy->driver_data;
 	unsigned int target_freq;
 
+	if (policy->min != cpudata->min_limit_freq || policy->max != cpudata->max_limit_freq)
+		amd_pstate_update_min_max_limit(policy);
+
+
 	cap_perf = READ_ONCE(cpudata->highest_perf);
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
 	max_freq = READ_ONCE(cpudata->max_freq);
@@ -747,6 +775,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* Initial processor data capability frequencies */
 	cpudata->max_freq = max_freq;
 	cpudata->min_freq = min_freq;
+	cpudata->max_limit_freq = max_freq;
+	cpudata->min_limit_freq = min_freq;
 	cpudata->nominal_freq = nominal_freq;
 	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
@@ -1185,16 +1215,25 @@ static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void amd_pstate_epp_init(unsigned int cpu)
+static void amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u32 max_perf, min_perf;
+	u32 max_perf, min_perf, min_limit_perf, max_limit_perf;
 	u64 value;
 	s16 epp;
 
 	max_perf = READ_ONCE(cpudata->highest_perf);
 	min_perf = READ_ONCE(cpudata->lowest_perf);
+	max_limit_perf = div_u64(policy->max * cpudata->highest_perf, cpudata->max_freq);
+	min_limit_perf = div_u64(policy->min * cpudata->highest_perf, cpudata->max_freq);
+
+	max_perf = clamp_t(unsigned long, max_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
+	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
+			cpudata->max_limit_perf);
+
+	WRITE_ONCE(cpudata->max_limit_perf, max_limit_perf);
+	WRITE_ONCE(cpudata->min_limit_perf, min_limit_perf);
 
 	value = READ_ONCE(cpudata->cppc_req_cached);
 
@@ -1212,9 +1251,6 @@ static void amd_pstate_epp_init(unsigned int cpu)
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(0);
 
-	if (cpudata->epp_policy == cpudata->policy)
-		goto skip_epp;
-
 	cpudata->epp_policy = cpudata->policy;
 
 	/* Get BIOS pre-defined epp value */
@@ -1224,7 +1260,7 @@ static void amd_pstate_epp_init(unsigned int cpu)
 		 * This return value can only be negative for shared_memory
 		 * systems where EPP register read/write not supported.
 		 */
-		goto skip_epp;
+		return;
 	}
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
@@ -1238,8 +1274,6 @@ static void amd_pstate_epp_init(unsigned int cpu)
 
 	WRITE_ONCE(cpudata->cppc_req_cached, value);
 	amd_pstate_set_epp(cpudata, epp);
-skip_epp:
-	cpufreq_cpu_put(policy);
 }
 
 static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
@@ -1254,7 +1288,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 
 	cpudata->policy = policy->policy;
 
-	amd_pstate_epp_init(policy->cpu);
+	amd_pstate_epp_update_limit(policy);
 
 	return 0;
 }
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 446394f846064..6ad02ad9c7b42 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -70,6 +70,10 @@ struct amd_cpudata {
 	u32	nominal_perf;
 	u32	lowest_nonlinear_perf;
 	u32	lowest_perf;
+	u32     min_limit_perf;
+	u32     max_limit_perf;
+	u32     min_limit_freq;
+	u32     max_limit_freq;
 
 	u32	max_freq;
 	u32	min_freq;
-- 
2.42.0




