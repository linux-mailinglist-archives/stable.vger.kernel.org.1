Return-Path: <stable+bounces-142316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65083AAEA1C
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB283A343C
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEE424E4CE;
	Wed,  7 May 2025 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AHcACUnQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95DF42A83;
	Wed,  7 May 2025 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643875; cv=none; b=SDroAkexloYv92eizy8yDBqWTBImeS2FIGlpdyz0gsuFRlX04M5fzgaSH+n4gGStcJcLUvE0wCibBbcbKGzOi36NHk/Zz25+yjVCsnk4hLP/JZFx54V00yedtk6Hv0ltbFzE1dYm9LIotZ8Vugy8B1FtUvfDVgIOOuBFTitb2uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643875; c=relaxed/simple;
	bh=U0L6TjIDbYVe/7XouW+0xrCZ48oMS+6Y1LDMrBIqEtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k97yOQWP+4Y8oQLf4H/uIemjyqhA0oR7P7croddfgmQX1JpUmIoPGXAIJNxjQ5t2rFb/oIdpqeThcjtRUVqQU80szSE+achJbpHlf4oogft47BOpm8GG/+4nd2yeuvzpalETMxAwJLihlx4BA+1sdw2P6sTNvrSWXmWHiRrcoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AHcACUnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310CBC4CEE2;
	Wed,  7 May 2025 18:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643875;
	bh=U0L6TjIDbYVe/7XouW+0xrCZ48oMS+6Y1LDMrBIqEtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AHcACUnQEPSziIEGohJUVhBSFoJorLBQK8hzYHb3onO1FTZMU2Rk629U4ZHQ0giHw
	 DlxFcH+CBScy9MscnecLg4VPYRMeallq7MtORwbEZAKqiBQ1o563/sSGfHaDEeXhdp
	 hZ5TJ6K+wkV5ZEWX7S+UiyuQVEU0wfe7Gs6h/JOw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>
Subject: [PATCH 6.14 045/183] cpufreq: Fix setting policy limits when frequency tables are used
Date: Wed,  7 May 2025 20:38:10 +0200
Message-ID: <20250507183826.517463152@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
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

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit b79028039f440e7d2c4df6ab243060c4e3803e84 upstream.

Commit 7491cdf46b5c ("cpufreq: Avoid using inconsistent policy->min and
policy->max") overlooked the fact that policy->min and policy->max were
accessed directly in cpufreq_frequency_table_target() and in the
functions called by it.  Consequently, the changes made by that commit
led to problems with setting policy limits.

Address this by passing the target frequency limits to __resolve_freq()
and cpufreq_frequency_table_target() and propagating them to the
functions called by the latter.

Fixes: 7491cdf46b5c ("cpufreq: Avoid using inconsistent policy->min and policy->max")
Cc: 5.16+ <stable@vger.kernel.org> # 5.16+
Closes: https://lore.kernel.org/linux-pm/aAplED3IA_J0eZN0@linaro.org/
Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Link: https://patch.msgid.link/5896780.DvuYhMxLoT@rjwysocki.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cpufreq.c          |   22 ++++++---
 drivers/cpufreq/cpufreq_ondemand.c |    3 -
 drivers/cpufreq/freq_table.c       |    6 +-
 include/linux/cpufreq.h            |   83 ++++++++++++++++++++++++-------------
 4 files changed, 73 insertions(+), 41 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -535,14 +535,18 @@ void cpufreq_disable_fast_switch(struct
 EXPORT_SYMBOL_GPL(cpufreq_disable_fast_switch);
 
 static unsigned int __resolve_freq(struct cpufreq_policy *policy,
-		unsigned int target_freq, unsigned int relation)
+				   unsigned int target_freq,
+				   unsigned int min, unsigned int max,
+				   unsigned int relation)
 {
 	unsigned int idx;
 
+	target_freq = clamp_val(target_freq, min, max);
+
 	if (!policy->freq_table)
 		return target_freq;
 
-	idx = cpufreq_frequency_table_target(policy, target_freq, relation);
+	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
 	policy->cached_resolved_idx = idx;
 	policy->cached_target_freq = target_freq;
 	return policy->freq_table[idx].frequency;
@@ -576,8 +580,7 @@ unsigned int cpufreq_driver_resolve_freq
 	if (unlikely(min > max))
 		min = max;
 
-	return __resolve_freq(policy, clamp_val(target_freq, min, max),
-			      CPUFREQ_RELATION_LE);
+	return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
@@ -2350,8 +2353,8 @@ int __cpufreq_driver_target(struct cpufr
 	if (cpufreq_disabled())
 		return -ENODEV;
 
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
-	target_freq = __resolve_freq(policy, target_freq, relation);
+	target_freq = __resolve_freq(policy, target_freq, policy->min,
+				     policy->max, relation);
 
 	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
 		 policy->cpu, target_freq, relation, old_target_freq);
@@ -2680,8 +2683,11 @@ static int cpufreq_set_policy(struct cpu
 	 * compiler optimizations around them because they may be accessed
 	 * concurrently by cpufreq_driver_resolve_freq() during the update.
 	 */
-	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPUFREQ_RELATION_H));
-	new_data.min = __resolve_freq(policy, new_data.min, CPUFREQ_RELATION_L);
+	WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max,
+					       new_data.min, new_data.max,
+					       CPUFREQ_RELATION_H));
+	new_data.min = __resolve_freq(policy, new_data.min, new_data.min,
+				      new_data.max, CPUFREQ_RELATION_L);
 	WRITE_ONCE(policy->min, new_data.min > policy->max ? policy->max : new_data.min);
 
 	trace_cpu_frequency_limits(policy);
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -76,7 +76,8 @@ static unsigned int generic_powersave_bi
 		return freq_next;
 	}
 
-	index = cpufreq_frequency_table_target(policy, freq_next, relation);
+	index = cpufreq_frequency_table_target(policy, freq_next, policy->min,
+					       policy->max, relation);
 	freq_req = freq_table[index].frequency;
 	freq_reduc = freq_req * od_tuners->powersave_bias / 1000;
 	freq_avg = freq_req - freq_reduc;
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -116,8 +116,8 @@ int cpufreq_generic_frequency_table_veri
 EXPORT_SYMBOL_GPL(cpufreq_generic_frequency_table_verify);
 
 int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
-				 unsigned int target_freq,
-				 unsigned int relation)
+				 unsigned int target_freq, unsigned int min,
+				 unsigned int max, unsigned int relation)
 {
 	struct cpufreq_frequency_table optimal = {
 		.driver_data = ~0,
@@ -148,7 +148,7 @@ int cpufreq_table_index_unsorted(struct
 	cpufreq_for_each_valid_entry_idx(pos, table, i) {
 		freq = pos->frequency;
 
-		if ((freq < policy->min) || (freq > policy->max))
+		if (freq < min || freq > max)
 			continue;
 		if (freq == target_freq) {
 			optimal.driver_data = i;
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -770,8 +770,8 @@ int cpufreq_frequency_table_verify(struc
 int cpufreq_generic_frequency_table_verify(struct cpufreq_policy_data *policy);
 
 int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
-				 unsigned int target_freq,
-				 unsigned int relation);
+				 unsigned int target_freq, unsigned int min,
+				 unsigned int max, unsigned int relation);
 int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
 		unsigned int freq);
 
@@ -836,12 +836,12 @@ static inline int cpufreq_table_find_ind
 	return best;
 }
 
-/* Works only on sorted freq-tables */
-static inline int cpufreq_table_find_index_l(struct cpufreq_policy *policy,
-					     unsigned int target_freq,
-					     bool efficiencies)
+static inline int find_index_l(struct cpufreq_policy *policy,
+			       unsigned int target_freq,
+			       unsigned int min, unsigned int max,
+			       bool efficiencies)
 {
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = clamp_val(target_freq, min, max);
 
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
 		return cpufreq_table_find_index_al(policy, target_freq,
@@ -851,6 +851,14 @@ static inline int cpufreq_table_find_ind
 						   efficiencies);
 }
 
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_l(struct cpufreq_policy *policy,
+					     unsigned int target_freq,
+					     bool efficiencies)
+{
+	return find_index_l(policy, target_freq, policy->min, policy->max, efficiencies);
+}
+
 /* Find highest freq at or below target in a table in ascending order */
 static inline int cpufreq_table_find_index_ah(struct cpufreq_policy *policy,
 					      unsigned int target_freq,
@@ -904,12 +912,12 @@ static inline int cpufreq_table_find_ind
 	return best;
 }
 
-/* Works only on sorted freq-tables */
-static inline int cpufreq_table_find_index_h(struct cpufreq_policy *policy,
-					     unsigned int target_freq,
-					     bool efficiencies)
+static inline int find_index_h(struct cpufreq_policy *policy,
+			       unsigned int target_freq,
+			       unsigned int min, unsigned int max,
+			       bool efficiencies)
 {
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = clamp_val(target_freq, min, max);
 
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
 		return cpufreq_table_find_index_ah(policy, target_freq,
@@ -919,6 +927,14 @@ static inline int cpufreq_table_find_ind
 						   efficiencies);
 }
 
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_h(struct cpufreq_policy *policy,
+					     unsigned int target_freq,
+					     bool efficiencies)
+{
+	return find_index_h(policy, target_freq, policy->min, policy->max, efficiencies);
+}
+
 /* Find closest freq to target in a table in ascending order */
 static inline int cpufreq_table_find_index_ac(struct cpufreq_policy *policy,
 					      unsigned int target_freq,
@@ -989,12 +1005,12 @@ static inline int cpufreq_table_find_ind
 	return best;
 }
 
-/* Works only on sorted freq-tables */
-static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
-					     unsigned int target_freq,
-					     bool efficiencies)
+static inline int find_index_c(struct cpufreq_policy *policy,
+			       unsigned int target_freq,
+			       unsigned int min, unsigned int max,
+			       bool efficiencies)
 {
-	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = clamp_val(target_freq, min, max);
 
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
 		return cpufreq_table_find_index_ac(policy, target_freq,
@@ -1004,7 +1020,17 @@ static inline int cpufreq_table_find_ind
 						   efficiencies);
 }
 
-static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy, int idx)
+/* Works only on sorted freq-tables */
+static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
+					     unsigned int target_freq,
+					     bool efficiencies)
+{
+	return find_index_c(policy, target_freq, policy->min, policy->max, efficiencies);
+}
+
+static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy,
+					unsigned int min, unsigned int max,
+					int idx)
 {
 	unsigned int freq;
 
@@ -1013,11 +1039,13 @@ static inline bool cpufreq_is_in_limits(
 
 	freq = policy->freq_table[idx].frequency;
 
-	return freq == clamp_val(freq, policy->min, policy->max);
+	return freq == clamp_val(freq, min, max);
 }
 
 static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 						 unsigned int target_freq,
+						 unsigned int min,
+						 unsigned int max,
 						 unsigned int relation)
 {
 	bool efficiencies = policy->efficiencies_available &&
@@ -1028,29 +1056,26 @@ static inline int cpufreq_frequency_tabl
 	relation &= ~CPUFREQ_RELATION_E;
 
 	if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
-		return cpufreq_table_index_unsorted(policy, target_freq,
-						    relation);
+		return cpufreq_table_index_unsorted(policy, target_freq, min,
+						    max, relation);
 retry:
 	switch (relation) {
 	case CPUFREQ_RELATION_L:
-		idx = cpufreq_table_find_index_l(policy, target_freq,
-						 efficiencies);
+		idx = find_index_l(policy, target_freq, min, max, efficiencies);
 		break;
 	case CPUFREQ_RELATION_H:
-		idx = cpufreq_table_find_index_h(policy, target_freq,
-						 efficiencies);
+		idx = find_index_h(policy, target_freq, min, max, efficiencies);
 		break;
 	case CPUFREQ_RELATION_C:
-		idx = cpufreq_table_find_index_c(policy, target_freq,
-						 efficiencies);
+		idx = find_index_c(policy, target_freq, min, max, efficiencies);
 		break;
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
 	}
 
-	/* Limit frequency index to honor policy->min/max */
-	if (!cpufreq_is_in_limits(policy, idx) && efficiencies) {
+	/* Limit frequency index to honor min and max */
+	if (!cpufreq_is_in_limits(policy, min, max, idx) && efficiencies) {
 		efficiencies = false;
 		goto retry;
 	}



