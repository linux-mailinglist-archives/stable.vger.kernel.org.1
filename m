Return-Path: <stable+bounces-169806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D73B285BC
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 20:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08974B66C76
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E0D2192E4;
	Fri, 15 Aug 2025 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="aw7Q7tpf"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19EF3176E2
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282015; cv=none; b=BWZWEg3wgBcGJbYJJX5TtwY/xZnIpBZabHt0CgG/87HHbIDWLm5Dk84SRzqJGx4M6TQ+UNST0yzmaZcUQPzV2GvXTo/9fgh0/UqeCpX4l5ymDdbBnfT30gI9NxXaamKWQ7bGzUQone3EhTerUMV4gste3NY2buMJKto/3GOZLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282015; c=relaxed/simple;
	bh=dv6j/IEgyoNbhFliSF2ZsTFLiulBGF30Zxn7SkdUKO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ll6NTSorrwJurQrwSiPhzr0IwMDTDZqlQIbCYZBvONwjPNGEmnYASwdFPQWcrPy1JoGIRxe5Y365lpUErcAdQc6Ox0lEokMXHgcWWwt54y6tE7jwxp/JENuBaXOsrqWC8+JfT2wVGEwZLMgdTJU8xvVgUCBsCp7pV6Cp9jh2jzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=aw7Q7tpf; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1755281983;
	bh=ZbNkvUMxUqZ+pT35xfzhmKrjiiqxsmNGbFYYvdxYg04=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=aw7Q7tpftxs14E5CzditFuMJbueu++/AJ6QHlrPwN/FeSSzNF6U8M4srhyqxPu2oI
	 umpi6HVay3dA2oiz/TIm8xekxiL7JmxgkOTEoV56iR23iYLWwxA5pxjcgLlBmQafsQ
	 s+wBzFFmglEs6LZ7cbyq7PL6e7TO51U5SOVSrN68=
X-QQ-mid: esmtpgz10t1755281963t4130ea23
X-QQ-Originating-IP: LxzQo1FYkpOLdmzlY+PCBjeV9RvSjlR7poKwSFZtzqQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 16 Aug 2025 02:19:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13549524922343842836
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: [PATCH 6.6 3/8] cpufreq/schedutil: Use a fixed reference frequency
Date: Sat, 16 Aug 2025 02:16:13 +0800
Message-Id: <20250815181618.3199442-4-guanwentao@uniontech.com>
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
X-QQ-XMAILINFO: MxX5kg4KifQ2Fle+ItAdayXmZ6IMck2jq4BHBAErkFVyqLRIArmFKoG0
	JK0Z/TT6XXXWyaF5y3liAI6XTQGGNRVvs1KKE2v1DLJrFt+jqODhlJdeyB6x0Tc+iVofFJU
	LEFwt9S/e5URe1bni7Na3ayBYxD/APkp8ol35vfuKHNZIu4bIWyyzeq0rmYKarmeaSnwfNM
	W8LluqCvQsD/3YcmCq5uBh0WO/vVqbEFV8L9Ix80CfcLpyrh19P8gfpKzg8aDN8F111RHig
	Sr16DNVVVHzuCaU30aCuQ9Zuh2efdXRuCuHcy1ho7avYyQDaV+hwPBWLr1WdLTaERJD7KnA
	CxjCgi/qM/1PRGVuIeShXUJAjeuj6STxPzpnfGEUKE85mfNCLkjDkm31f2FoDzVR9zU6sg/
	c8GBroGCwTW5+NQS8x4j9pRoAQ/8tD6OCh+W/J3AMf1A1UwftGxNY7CAL+8CI2TwBb1EeUO
	/gMwexys9nouhiZFAThcM/dnM+CBEkGyNSO70PIn943S69H/DgnFawYVNnnpBT019PsSk04
	TiV5cP7tYfsy6JMuQ0MCgo8BJNX3k+OIWylBhA8RWvttvLvypaHVR0IRGDu/luwtBy794Uu
	dkLoUl0KRn7SptNJpLNfFWxEUGqWECAKKtzRsqlQZdYsfSyMVWKMKnc+0H8D5afqoid8bbT
	U/mRkcgyXA76L6S8fNLpRQTU56k1A40RzMBxtI4BNPDz2sS/wVTae6a0OLllnkIz6yrBtr5
	/zaJtWe0xQZKgsZO3lxXkurkaJQTLsEDo/tR7rM/ywDlKQ2T1nGDQ34isMXUOsHaG5oesbG
	QDKrO36rCTbFlybqFqHGbXnw6Wp9HQ9FRgpT4QlZz59FCiAA+wJs38ch3aXs+yTrz4/0yhG
	9mUmD0PObKPqRo53T/UIu6JBnVKAblCiPvlFXxDA4ktzM3Km/exRLq/Niqu0dj/Zp83yA4o
	GsZa3kx4xjJ+U1QREsyMlPI/YJzQvFQTI5KBYTJeHI+qi3fcJQLTEm4Yjbc9GotZlqReOa3
	uSOb9oM4z8HJGlFiCB9x4H+ye6M9EtoRpG+sU0FNeTvYunMdzDcMIvTrAh/KVDOW/yEvyZe
	SI1hpGxzA8K9099MI9EEKFAfIKpwyNKdTNzpKrYaLs4
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

From: Vincent Guittot <vincent.guittot@linaro.org>

cpuinfo.max_freq can change at runtime because of boost as an example. This
implies that the value could be different than the one that has been
used when computing the capacity of a CPU.

The new arch_scale_freq_ref() returns a fixed and coherent reference
frequency that can be used when computing a frequency based on utilization.

Use this arch_scale_freq_ref() when available and fallback to
policy otherwise.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lore.kernel.org/r/20231211104855.558096-4-vincent.guittot@linaro.org
(cherry picked from commit b3edde44e5d4504c23a176819865cd603fd16d6c)
Stable-dep-of: e37617c8e53a ("sched/fair: Fix frequency selection for non-invariant case")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 776be0549162..cfe7c625d2ad 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -137,6 +137,28 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
 	}
 }
 
+/**
+ * get_capacity_ref_freq - get the reference frequency that has been used to
+ * correlate frequency and compute capacity for a given cpufreq policy. We use
+ * the CPU managing it for the arch_scale_freq_ref() call in the function.
+ * @policy: the cpufreq policy of the CPU in question.
+ *
+ * Return: the reference CPU frequency to compute a capacity.
+ */
+static __always_inline
+unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
+{
+	unsigned int freq = arch_scale_freq_ref(policy->cpu);
+
+	if (freq)
+		return freq;
+
+	if (arch_scale_freq_invariant())
+		return policy->cpuinfo.max_freq;
+
+	return policy->cur;
+}
+
 /**
  * get_next_freq - Compute a new frequency for a given cpufreq policy.
  * @sg_policy: schedutil policy object to compute the new frequency for.
@@ -163,9 +185,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 				  unsigned long util, unsigned long max)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned int freq = arch_scale_freq_invariant() ?
-				policy->cpuinfo.max_freq : policy->cur;
+	unsigned int freq;
 
+	freq = get_capacity_ref_freq(policy);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
-- 
2.20.1


