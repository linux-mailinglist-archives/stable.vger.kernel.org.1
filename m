Return-Path: <stable+bounces-169807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2ECB285BF
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B57D1CE160C
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082851F4165;
	Fri, 15 Aug 2025 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FzQknMCF"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6A3176E2
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282021; cv=none; b=NYwmysdaPq5z1aDqnHaLMaclJjL1s5SrmVp1LDFnJmQjaKyKOstncpg536RPAZ/Shva00V3eQuJDR7CFYgoAt0xBr6YsrWRrel/Aruu+fJ1Trrf8GBfuEkoRpJOvuemmpDUD9dgl4k8eOwM4/voy4w79aSHhKIz7CJ/8F7v+B1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282021; c=relaxed/simple;
	bh=D3uGQ/sz+2NczXpsmiRMBzuFS4/0qf5b9jAFrMYfkFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uqjRnQZUZloob0zoIJkMVNohfbl0B9+si9MYcs3ZOfSPCtgvtaNAXRliBeHhMHZk/gkFNh3zJo9ZygCAnRUuwaOT5UFUBK7kaK+tDVJPExJAtNL2g+/IGhP+qwc1SHvD5Nw0CKs2F68RSaBerT8Y1SdFcvZxS/4KKTq7URs2BEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FzQknMCF; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755281988;
	bh=WqXpth2YUO3vVfg2IdPwSArnusf1DiSRyd7L/0Q9VF4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=FzQknMCF0kM5yEpWgZSnqKPe55LvrHz7mh//3ZIuM/aYI7SykYMIkE4oQsd5Fnesa
	 wo+gRJG6MYCgXa0yhPgcWVMgyUKbQ8qGb8dCNyXuOLMi60HbR+XowY6LZMqATWcrcH
	 tVamaCMJ5I8c2nzVpcfm8UwoQmS12r9BAlwjqlQM=
X-QQ-mid: esmtpgz10t1755281970t29cb3c91
X-QQ-Originating-IP: 9Kut6X26CleY5sVNK7B0U+YXyYREpDM3EwCA3Cb7ObI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 16 Aug 2025 02:19:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7533342935379590194
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6 5/8] cpufreq/cppc: Set the frequency used for computing the capacity
Date: Sat, 16 Aug 2025 02:16:15 +0800
Message-Id: <20250815181618.3199442-6-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250815181618.3199442-1-guanwentao@uniontech.com>
References: <20250815181618.3199442-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NlrfLQhmr2s5o/JowfFsOiN7+nGq8y7ZgW9hDMSGwzUqywJprAR9+o/1
	8OLe8PW+g8ognKF6IOotJHg4x/wg1wuju3m+1X9ujwyEao3wQsz+UuLTw41TJj6/s60s1Tz
	k9SoTS7gWAlXopDHr6yOjVc32MLtAHayGStkmKGTDNRsmGTMLelCfDkdw1xvI380ajsTjh5
	L+49V9XaoUM5iCOiLK6FIvnDc2S7nuVm63smdAW/IrFGA2f2qxj2qsKhGogpzqomgG6v5xg
	4+tzIzdj/8stbhCmMCw/+aNT0zqlt0AnuaC9ebhl540WymhRXfWyBuOvs3BaBJKW8a+WIep
	hTdRUc2XLVO0AEYmlKWoPJ2Af3Yq5E3ltJPhsm2rudsZq/rDyVdKtnbZ+XBfazv73T/QCON
	nKiJoXPYEYTRKofVdvfwhLWyrnzNw85JreL4Vk+n/0pmFbUGollctpUcv75m1VIkbnFCtPz
	ZxeWytSWEnpndSwEYqSelaIoGxx2ouFjk1tEsHjkP7FhtVOHfrzEGt2MV37epPicTUYTFJQ
	xA+3xq+fBC7oNSKB/+LDUQayI/RWuNQnOWX/mfvcIhzUSj6xFeAJOV2vfxgU8oSMz0hfwct
	e5VQtK/q51K0I9OlhOCQsFmzc12EHs3kxo0d5fEhF48QvtxFcdh0UWJT3xuueN7pY4ZXpRP
	WFCvmq3cbUstUTk36A/CEKM4wfiTpQWUfPnqbgFFtv/7diKcdmTIzyC5tFmFgKZdSqRMmS7
	QZohXrt+xKiBqFeV3uCVhYdNRbYqYDu9e/68Rlotqcw95yN/ZBuYJZiR05CA/DjiG4V8YXe
	eJLsevHX9QUsp5YBPOqTxlMWXmRN/cx2WnWN/EgKfuRXSONClbJrtWkVLBM9khcDxPqtZ68
	DPo+xlih3l0+hTV5iUo0TIAxJ1iQQ1ALQjU3Xp2M75ziRGt4TBWdHeYhRSaBQwDA1I1II87
	S+zdoyz2EXuKpHUBcwzVCJa8uk0ZQF1YQdjDPsbcfwFSD6gswsMG50+ZGsR/4OTEnnCMWQn
	okKVe0E2ilHAjZIxxAuaWoQJZn1zsFr2IY53dnIltPIhq0D8fjCO97+HDgeUus7L+qS5lWJ
	inV7IANaIw0qQB2qKZFDr2qW0zxNPWFIe29dmQtG69j2A+hB+0vjWE=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

From: Vincent Guittot <vincent.guittot@linaro.org>

Save the frequency associated to the performance that has been used when
initializing the capacity of CPUs.

Also, cppc cpufreq driver can register an artificial energy model. In such
case, it needs the frequency for this compute capacity.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lore.kernel.org/r/20231211104855.558096-7-vincent.guittot@linaro.org
(cherry picked from commit 5477fa249b56c59c3baa1b237bf083cffa64c84a)
Stable-dep-of: e37617c8e53a ("sched/fair: Fix frequency selection for non-invariant case")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/base/arch_topology.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 0c9ae5b157b1..1aa76b5c96c2 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -349,6 +349,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 
 void topology_init_cpu_capacity_cppc(void)
 {
+	u64 capacity, capacity_scale = 0;
 	struct cppc_perf_caps perf_caps;
 	int cpu;
 
@@ -365,6 +366,10 @@ void topology_init_cpu_capacity_cppc(void)
 		    (perf_caps.highest_perf >= perf_caps.nominal_perf) &&
 		    (perf_caps.highest_perf >= perf_caps.lowest_perf)) {
 			raw_capacity[cpu] = perf_caps.highest_perf;
+			capacity_scale = max_t(u64, capacity_scale, raw_capacity[cpu]);
+
+			per_cpu(capacity_freq_ref, cpu) = cppc_perf_to_khz(&perf_caps, raw_capacity[cpu]);
+
 			pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
 				 cpu, raw_capacity[cpu]);
 			continue;
@@ -375,7 +380,15 @@ void topology_init_cpu_capacity_cppc(void)
 		goto exit;
 	}
 
-	topology_normalize_cpu_scale();
+	for_each_possible_cpu(cpu) {
+		capacity = raw_capacity[cpu];
+		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
+				     capacity_scale);
+		topology_set_cpu_scale(cpu, capacity);
+		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
+			cpu, topology_get_cpu_scale(cpu));
+	}
+
 	schedule_work(&update_topology_flags_work);
 	pr_debug("cpu_capacity: cpu_capacity initialization done\n");
 
-- 
2.20.1


