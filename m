Return-Path: <stable+bounces-129173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9D2A7FE5A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4449417A804
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AA7268C7C;
	Tue,  8 Apr 2025 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h9nBwQym"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA01FBCB2;
	Tue,  8 Apr 2025 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110313; cv=none; b=AWE8tojJLlg03zCIXC8Dry8lrl1MPiu058yb5FF7JFSp2ArJoK1Wj2WhNMgcBQXSq2es+TLICG1QYlvzj2J5eNZhFgpd3taMcoDf2V3lp/+x+okEdkW17Sw1mFySu8iTIVJL32nZWhExbT4SqEn1eDWCqCKBfiINEADihY5LgUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110313; c=relaxed/simple;
	bh=EWLwhz4iGejgfMNq+rqcVaeritKr1FslxJyILBokdq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rL2ET+5VvNOaGD8f5pGsGfVIwHjjngRnGfqUtTl6Fz0P6G2ZtsXpOnONFHmpuv7OJ6KHHR7g0oReK2wbdMwEngChWaGN7GXGlDRIvr8bge3KwQtBAD46bA1EuUJvzsBLIVAcYkLzHYTkXQMo6b6uJjlrx5nfRP/Wskzt34lViPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h9nBwQym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41292C4CEE5;
	Tue,  8 Apr 2025 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744110313;
	bh=EWLwhz4iGejgfMNq+rqcVaeritKr1FslxJyILBokdq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h9nBwQymtFR/vRIWnUKTjqcVBmnO1QA3qhw8dc0QwpfKR5HCRT8rZb70YEAjVTPqS
	 6O98T+jGp9xoTs+WCTyktPpZdBDCKod6GLNF/vayeXgf04ePl6LCNx907rtHfqwzCa
	 rLOwbodbPxGJTw3fGn6ImEQuga9WSCOaU3uAnljA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 019/731] cpufreq/amd-pstate: Convert all perf values to u8
Date: Tue,  8 Apr 2025 12:38:36 +0200
Message-ID: <20250408104914.711689705@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>

[ Upstream commit 555bbe67a622b297405e246d1868dbda3284bde8 ]

All perf values are always within 0-255 range, hence convert their
datatype to u8 everywhere.

Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Link: https://lore.kernel.org/r/20250205112523.201101-7-dhananjay.ugwekar@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Stable-dep-of: 426db24d4db2 ("cpufreq/amd-pstate: Add missing NULL ptr check in amd_pstate_update")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate-trace.h | 46 +++++++++++------------
 drivers/cpufreq/amd-pstate.c       | 60 +++++++++++++++---------------
 drivers/cpufreq/amd-pstate.h       | 18 ++++-----
 3 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
index 8d692415d9050..f457d4af2c62e 100644
--- a/drivers/cpufreq/amd-pstate-trace.h
+++ b/drivers/cpufreq/amd-pstate-trace.h
@@ -24,9 +24,9 @@
 
 TRACE_EVENT(amd_pstate_perf,
 
-	TP_PROTO(unsigned long min_perf,
-		 unsigned long target_perf,
-		 unsigned long capacity,
+	TP_PROTO(u8 min_perf,
+		 u8 target_perf,
+		 u8 capacity,
 		 u64 freq,
 		 u64 mperf,
 		 u64 aperf,
@@ -47,9 +47,9 @@ TRACE_EVENT(amd_pstate_perf,
 		),
 
 	TP_STRUCT__entry(
-		__field(unsigned long, min_perf)
-		__field(unsigned long, target_perf)
-		__field(unsigned long, capacity)
+		__field(u8, min_perf)
+		__field(u8, target_perf)
+		__field(u8, capacity)
 		__field(unsigned long long, freq)
 		__field(unsigned long long, mperf)
 		__field(unsigned long long, aperf)
@@ -70,10 +70,10 @@ TRACE_EVENT(amd_pstate_perf,
 		__entry->fast_switch = fast_switch;
 		),
 
-	TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u fast_switch=%s",
-		  (unsigned long)__entry->min_perf,
-		  (unsigned long)__entry->target_perf,
-		  (unsigned long)__entry->capacity,
+	TP_printk("amd_min_perf=%hhu amd_des_perf=%hhu amd_max_perf=%hhu freq=%llu mperf=%llu aperf=%llu tsc=%llu cpu_id=%u fast_switch=%s",
+		  (u8)__entry->min_perf,
+		  (u8)__entry->target_perf,
+		  (u8)__entry->capacity,
 		  (unsigned long long)__entry->freq,
 		  (unsigned long long)__entry->mperf,
 		  (unsigned long long)__entry->aperf,
@@ -86,10 +86,10 @@ TRACE_EVENT(amd_pstate_perf,
 TRACE_EVENT(amd_pstate_epp_perf,
 
 	TP_PROTO(unsigned int cpu_id,
-		 unsigned int highest_perf,
-		 unsigned int epp,
-		 unsigned int min_perf,
-		 unsigned int max_perf,
+		 u8 highest_perf,
+		 u8 epp,
+		 u8 min_perf,
+		 u8 max_perf,
 		 bool boost
 		 ),
 
@@ -102,10 +102,10 @@ TRACE_EVENT(amd_pstate_epp_perf,
 
 	TP_STRUCT__entry(
 		__field(unsigned int, cpu_id)
-		__field(unsigned int, highest_perf)
-		__field(unsigned int, epp)
-		__field(unsigned int, min_perf)
-		__field(unsigned int, max_perf)
+		__field(u8, highest_perf)
+		__field(u8, epp)
+		__field(u8, min_perf)
+		__field(u8, max_perf)
 		__field(bool, boost)
 		),
 
@@ -118,12 +118,12 @@ TRACE_EVENT(amd_pstate_epp_perf,
 		__entry->boost = boost;
 		),
 
-	TP_printk("cpu%u: [%u<->%u]/%u, epp=%u, boost=%u",
+	TP_printk("cpu%u: [%hhu<->%hhu]/%hhu, epp=%hhu, boost=%u",
 		  (unsigned int)__entry->cpu_id,
-		  (unsigned int)__entry->min_perf,
-		  (unsigned int)__entry->max_perf,
-		  (unsigned int)__entry->highest_perf,
-		  (unsigned int)__entry->epp,
+		  (u8)__entry->min_perf,
+		  (u8)__entry->max_perf,
+		  (u8)__entry->highest_perf,
+		  (u8)__entry->epp,
 		  (bool)__entry->boost
 		 )
 );
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3ef10aae0502f..32f1b659904bc 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -186,7 +186,7 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
 static DEFINE_MUTEX(amd_pstate_limits_lock);
 static DEFINE_MUTEX(amd_pstate_driver_lock);
 
-static s16 msr_get_epp(struct amd_cpudata *cpudata)
+static u8 msr_get_epp(struct amd_cpudata *cpudata)
 {
 	u64 value;
 	int ret;
@@ -207,7 +207,7 @@ static inline s16 amd_pstate_get_epp(struct amd_cpudata *cpudata)
 	return static_call(amd_pstate_get_epp)(cpudata);
 }
 
-static s16 shmem_get_epp(struct amd_cpudata *cpudata)
+static u8 shmem_get_epp(struct amd_cpudata *cpudata)
 {
 	u64 epp;
 	int ret;
@@ -218,11 +218,11 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata)
 		return ret;
 	}
 
-	return (s16)(epp & 0xff);
+	return FIELD_GET(AMD_CPPC_EPP_PERF_MASK, epp);
 }
 
-static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
-			   u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
+static int msr_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
+			   u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
 {
 	u64 value, prev;
 
@@ -257,15 +257,15 @@ static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
 DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
 
 static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
-					  u32 min_perf, u32 des_perf,
-					  u32 max_perf, u32 epp,
+					  u8 min_perf, u8 des_perf,
+					  u8 max_perf, u8 epp,
 					  bool fast_switch)
 {
 	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
 						   max_perf, epp, fast_switch);
 }
 
-static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
+static int msr_set_epp(struct amd_cpudata *cpudata, u8 epp)
 {
 	u64 value, prev;
 	int ret;
@@ -292,12 +292,12 @@ static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
 
 DEFINE_STATIC_CALL(amd_pstate_set_epp, msr_set_epp);
 
-static inline int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
+static inline int amd_pstate_set_epp(struct amd_cpudata *cpudata, u8 epp)
 {
 	return static_call(amd_pstate_set_epp)(cpudata, epp);
 }
 
-static int shmem_set_epp(struct amd_cpudata *cpudata, u32 epp)
+static int shmem_set_epp(struct amd_cpudata *cpudata, u8 epp)
 {
 	int ret;
 	struct cppc_perf_ctrls perf_ctrls;
@@ -320,7 +320,7 @@ static int amd_pstate_set_energy_pref_index(struct cpufreq_policy *policy,
 					    int pref_index)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	int epp;
+	u8 epp;
 
 	if (!pref_index)
 		epp = cpudata->epp_default;
@@ -479,8 +479,8 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
 	return static_call(amd_pstate_init_perf)(cpudata);
 }
 
-static int shmem_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
-			     u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
+static int shmem_update_perf(struct amd_cpudata *cpudata, u8 min_perf,
+			     u8 des_perf, u8 max_perf, u8 epp, bool fast_switch)
 {
 	struct cppc_perf_ctrls perf_ctrls;
 
@@ -531,14 +531,14 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
 	return true;
 }
 
-static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
-			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
+static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
+			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
 {
 	unsigned long max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpudata->cpu);
-	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
+	u8 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
-	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
+	des_perf = clamp_t(u8, des_perf, min_perf, max_perf);
 
 	max_freq = READ_ONCE(cpudata->max_limit_freq);
 	policy->cur = div_u64(des_perf * max_freq, max_perf);
@@ -550,7 +550,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 
 	/* limit the max perf when core performance boost feature is disabled */
 	if (!cpudata->boost_supported)
-		max_perf = min_t(unsigned long, nominal_perf, max_perf);
+		max_perf = min_t(u8, nominal_perf, max_perf);
 
 	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
 		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
@@ -591,7 +591,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy_data)
 
 static int amd_pstate_update_min_max_limit(struct cpufreq_policy *policy)
 {
-	u32 max_limit_perf, min_limit_perf, max_perf, max_freq;
+	u8 max_limit_perf, min_limit_perf, max_perf;
+	u32 max_freq;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	max_perf = READ_ONCE(cpudata->highest_perf);
@@ -615,7 +616,7 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
 {
 	struct cpufreq_freqs freqs;
 	struct amd_cpudata *cpudata = policy->driver_data;
-	unsigned long des_perf, cap_perf;
+	u8 des_perf, cap_perf;
 
 	if (!cpudata->max_freq)
 		return -ENODEV;
@@ -670,8 +671,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 				   unsigned long target_perf,
 				   unsigned long capacity)
 {
-	unsigned long max_perf, min_perf, des_perf,
-		      cap_perf, min_limit_perf;
+	u8 max_perf, min_perf, des_perf, cap_perf, min_limit_perf;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata;
 
@@ -907,8 +907,8 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 {
 	int ret;
 	u32 min_freq, max_freq;
-	u32 highest_perf, nominal_perf, nominal_freq;
-	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
+	u8 highest_perf, nominal_perf, lowest_nonlinear_perf;
+	u32 nominal_freq, lowest_nonlinear_freq;
 	struct cppc_perf_caps cppc_perf;
 
 	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
@@ -1115,7 +1115,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 					    char *buf)
 {
-	u32 perf;
+	u8 perf;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	perf = READ_ONCE(cpudata->highest_perf);
@@ -1126,7 +1126,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 static ssize_t show_amd_pstate_prefcore_ranking(struct cpufreq_policy *policy,
 						char *buf)
 {
-	u32 perf;
+	u8 perf;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	perf = READ_ONCE(cpudata->prefcore_ranking);
@@ -1189,7 +1189,7 @@ static ssize_t show_energy_performance_preference(
 				struct cpufreq_policy *policy, char *buf)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	int preference;
+	u8 preference;
 
 	switch (cpudata->epp_cached) {
 	case AMD_CPPC_EPP_PERFORMANCE:
@@ -1551,7 +1551,7 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u32 epp;
+	u8 epp;
 
 	amd_pstate_update_min_max_limit(policy);
 
@@ -1600,7 +1600,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 static int amd_pstate_epp_reenable(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u64 max_perf;
+	u8 max_perf;
 	int ret;
 
 	ret = amd_pstate_cppc_enable(true);
@@ -1637,7 +1637,7 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	int min_perf;
+	u8 min_perf;
 
 	if (cpudata->suspended)
 		return 0;
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 9747e3be6ceee..19d405c6d805e 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -70,13 +70,13 @@ struct amd_cpudata {
 	struct	freq_qos_request req[2];
 	u64	cppc_req_cached;
 
-	u32	highest_perf;
-	u32	nominal_perf;
-	u32	lowest_nonlinear_perf;
-	u32	lowest_perf;
-	u32     prefcore_ranking;
-	u32     min_limit_perf;
-	u32     max_limit_perf;
+	u8	highest_perf;
+	u8	nominal_perf;
+	u8	lowest_nonlinear_perf;
+	u8	lowest_perf;
+	u8	prefcore_ranking;
+	u8	min_limit_perf;
+	u8	max_limit_perf;
 	u32     min_limit_freq;
 	u32     max_limit_freq;
 
@@ -93,11 +93,11 @@ struct amd_cpudata {
 	bool	hw_prefcore;
 
 	/* EPP feature related attributes*/
-	s16	epp_cached;
+	u8	epp_cached;
 	u32	policy;
 	u64	cppc_cap1_cached;
 	bool	suspended;
-	s16	epp_default;
+	u8	epp_default;
 };
 
 /*
-- 
2.39.5




