Return-Path: <stable+bounces-169805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD9DB285BB
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006E05E2282
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19FC1FECB1;
	Fri, 15 Aug 2025 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IMYju8BN"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DC7317714
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282014; cv=none; b=j520m1LsCV3HLte2AF1Y9d4+eWa9dA7hOIbqVYZ7Krxt4f9DC0sY2NR/yHKbUVQmoc0r1PoYuZqFs8jzAJX76DCR/zkylfodQWQ7Y24eodu59j9MwMTNzbQxZbdyjGUcmQTb+l6yDBnKlkjvEl+4jkeFHAbgTNXewGnsssLPZ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282014; c=relaxed/simple;
	bh=4BG3G8g6R3ZXXILaamLuO1L9mrmxE7fV2z6ZpgOkbVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gof8aIaFfyVaHz6EnOx0PFKeja6tYuyJ95Vvrj2NSBNq76jfEuhe+Mjw+v8n/GOwoBkbuB2WIcxSa9ADmGwzf0CGM+eyTnlLisZXFWWSG3ZV+HhZKYWFKljoklzPle/3xKq2ln4vwYnh4T4107aw7akYNCtzDX2VQGSdT2Wgh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IMYju8BN; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755281979;
	bh=fvvh8liICgFd2vOiB3UvzfEm9VXS9FYy1MUKFxBHHxA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=IMYju8BNwlDjb2rmKuHWiTqofSGFLlDT6A3eVX3aESr/bE8/bLj1/iCupvxwEc833
	 aOeaPbAmgTKBCTMGvEMoNi/KfODZEMX3P4QYVYXWdHU6ujzfrk5O1lh+9oCBGXWYBu
	 1fm6PGa32yKOUKY5gtxxfoWb+xJGXMjM3BYOPFHI=
X-QQ-mid: esmtpgz10t1755281959ta1ae6757
X-QQ-Originating-IP: vSDWlBX/sZI3nr+pBcqUTrMPgWg7aWwHiZmqriFm2OQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 16 Aug 2025 02:19:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 789921427643263250
EX-QQ-RecipientCnt: 8
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6 2/8] cpufreq: Use the fixed and coherent frequency for scaling capacity
Date: Sat, 16 Aug 2025 02:16:12 +0800
Message-Id: <20250815181618.3199442-3-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: M3xXVM5KDueGiAR02y5Ad3ZIQKPbxm91QegyrX3sJKYep7F5W/XWZuNe
	mJgdqTo2uXrr3/jyDyIbKlkhdzTGKFi4kg9G6eWtRGLFO8ucSvrTgloqUOI5mMSf6dcogQE
	bRxlYiVF5vXyGPEPDQOBmPAPDakdDTAV7i8pQL1Wnz2ogHW1i6WlgrmJFVJuR3klQo6yt9Z
	D0COi2hmhDquPjGymHA/ib7Ih42+ZfLSVO7DW1GkyPNszMRX87hl1pi7eiXCYmJLFMKMgRq
	8pMv4rzAzFGo70yEWlGrjzymykzUhtNqfstZjHnJK7D2b0cs/sPy7p8vTtygGVJL05NEeMv
	s17pV5FTJeC0sW7uoDJz3Gg7+8X3TkXkw670S6bYCVC7hJXORqQGMts5faoHhUxuFf+W8tH
	ZjzzNL53Ws63qijkjcIeqZ3B4J1hDRNHWZq7J1HDXOpz/tJLdAFcujBS0/AFhGVaSZZ4U6X
	TgonstZcRNPP2RMLU/lCqzzIX1CXInfsD/ngVLssLBdm+0r/YlhImwXDqLeVnWC0uCfmIWv
	sVtd1ynzD0xuMyxt+QDG1DVmwVh3z2OCZtNoN/fVzlG+SYizRdT3/sAVSyKxb0tFvH6tR+c
	EsisoCMtAmKjFf3g+Oau5GGIUu7Q0qYH7lPq+HRJnXPmwzQaDHoX91IXyK4XvjKGlfnsJ03
	LQ9W2yi5gCGMXSlkkP+oNDmMgItbgx22nLv/YOjk7WihHMNDBRHUt2is1o+VuPmrIIzd2MY
	Itj1xx7nadhViJMoPCp++fLs9gCNbCJGUE3DEkRyETXOV2wxMOtRHvznpQWmhnnTPmpMGY6
	88YLWQbzhCDXu2eib22xOjC7NGNIFYuEyQ4hc5OihG24i3Z0XS5sxWVkQ5SCDCuKdPWH5ZK
	dlRf5eOTCejk4tIwNMKgj+VQSAAf+j/B//CYGVR/yWBmtTalCubDpZvbHY0RNPcxYSNV7SD
	sZpQCb2MDPny17KWK40xkjG3Z7A7PryMXSgrdS0KHh+K7BFo1HCnOJQETGKvx+/n8+AKbAq
	BFxQHXecbHfNFa0ZEt5isftp/NQkqNBstla8ue4ajsY5D0OfBZx7Ezcv9h53i9ZSSK2tZtY
	fyNNrb+TQi+N1F2cjCH+Mx36gnkRwpLBV2TheTM4P3a
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

From: Vincent Guittot <vincent.guittot@linaro.org>

cpuinfo.max_freq can change at runtime because of boost as an example. This
implies that the value could be different from the frequency that has been
used to compute the capacity of a CPU.

The new arch_scale_freq_ref() returns a fixed and coherent frequency
that can be used to compute the capacity for a given frequency.

[ Also fix a arch_set_freq_scale()  newline style wart in <linux/cpufreq.h>. ]

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20231211104855.558096-3-vincent.guittot@linaro.org
(cherry picked from commit 599457ba15403037b489fe536266a3d5f9efaed7)
Stable-dep-of: e37617c8e53a ("sched/fair: Fix frequency selection for non-invariant case")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 include/linux/cpufreq.h   | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index cc98d8cf5433..6b00507f9f33 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -454,7 +454,7 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
 
 	arch_set_freq_scale(policy->related_cpus,
 			    policy->cur,
-			    policy->cpuinfo.max_freq);
+			    arch_scale_freq_ref(policy->cpu));
 
 	spin_lock(&policy->transition_lock);
 	policy->transition_ongoing = false;
@@ -2205,7 +2205,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 
 	policy->cur = freq;
 	arch_set_freq_scale(policy->related_cpus, freq,
-			    policy->cpuinfo.max_freq);
+			    arch_scale_freq_ref(policy->cpu));
 	cpufreq_stats_record_transition(policy, freq);
 
 	if (trace_cpu_frequency_enabled()) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 184a84dd467e..bfecd9dcb552 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1245,6 +1245,7 @@ void arch_set_freq_scale(const struct cpumask *cpus,
 {
 }
 #endif
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
2.20.1


