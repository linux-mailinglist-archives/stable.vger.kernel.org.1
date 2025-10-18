Return-Path: <stable+bounces-187855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7330BED3F0
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 18:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97A144E2955
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 16:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFB4229B36;
	Sat, 18 Oct 2025 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OT1NFjiE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F41F4606
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760805659; cv=none; b=ghEMfCFzBAGPFqfrM/rMgXALEZDZT41K0fdwWj12XRjFpehlkTb0q9+d0A2B9LBVTcnqtyuiGYXb6YREDZgCxR/ihtM6cutIuwLJGHcQ+uS5L6SFxmetKgyayhHKFNX5fJ7XInQbVByqWbJ3nDfxRlRLuJcJuBAg6HaYU4kd+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760805659; c=relaxed/simple;
	bh=v9gMucYu4W7sER7lhbfHreybsml0sb+tRqnAZsU4Azo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJBIJghXRiTS6MQIa9eDGrkO5Fp1qmMBviTq+4oaH1r3LtItT7dI5FLDICwbbLUatlF7Y/j5X54XG3UOIhs8UgFHVEkaWs0rZDfqGhlPa/NCaaqipJuQg+dcjtubdvrYtY0qYjwVAcPAOPs038RAu2+Vkq9oWE9WCuQ3XoM0/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OT1NFjiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC257C4CEF8;
	Sat, 18 Oct 2025 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760805658;
	bh=v9gMucYu4W7sER7lhbfHreybsml0sb+tRqnAZsU4Azo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OT1NFjiEDlrKIaUZ3onZ15v9x5qjJvaGXU0Qx0+8LWdq9qea9AwRR295Lye/Qw113
	 qci0WH5s642MDtQ0VQ2J2BKxqrO1rU/BKf0nD+P3aeSyR1wanQv8fXRQeFJPguyQMQ
	 LPvqgJR0Bk3Kcf3MoP78PZAve0eADGq8f2QRkbp7xY56DA+7KdSPUzMSjCOVR6EIiU
	 J1n9mORozYI3hPUq6uLMBICqDtpoUux6gaJ/OwA8s4w9BnqganKbqgdZNTD7MqEKZV
	 saCHqeGlGPd9aPRCAL8RdsQEDJvpZu6dgGbGa1QQa/gnxUjmu7e9TgcO1AAXJCGtPk
	 hdClLXxTGGymA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Qais Yousef <qyousef@layalina.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as transition delay
Date: Sat, 18 Oct 2025 12:40:55 -0400
Message-ID: <20251018164055.845206-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101609-footsore-ensnare-d320@gregkh>
References: <2025101609-footsore-ensnare-d320@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit f965d111e68f4a993cc44d487d416e3d954eea11 ]

If cppc_get_transition_latency() returns CPUFREQ_ETERNAL to indicate a
failure to retrieve the transition latency value from the platform
firmware, the CPPC cpufreq driver will use that value (converted to
microseconds) as the policy transition delay, but it is way too large
for any practical use.

Address this by making the driver use the cpufreq's default
transition latency value (in microseconds) as the transition delay
if CPUFREQ_ETERNAL is returned by cppc_get_transition_latency().

Fixes: d4f3388afd48 ("cpufreq / CPPC: Set platform specific transition_delay_us")
Cc: 5.19+ <stable@vger.kernel.org> # 5.19
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
[ added CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS definition to include/linux/cpufreq.h ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 14 ++++++++++++--
 include/linux/cpufreq.h        |  3 +++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index d77e4aa209d96..cfad081893826 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -338,6 +338,16 @@ static int cppc_verify_policy(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
+static unsigned int __cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
+{
+	unsigned int transition_latency_ns = cppc_get_transition_latency(cpu);
+
+	if (transition_latency_ns == CPUFREQ_ETERNAL)
+		return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_USEC;
+
+	return transition_latency_ns / NSEC_PER_USEC;
+}
+
 /*
  * The PCC subspace describes the rate at which platform can accept commands
  * on the shared PCC channel (including READs which do not count towards freq
@@ -360,12 +370,12 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 			return 10000;
 		}
 	}
-	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+	return __cppc_cpufreq_get_transition_delay_us(cpu);
 }
 #else
 static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 {
-	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+	return __cppc_cpufreq_get_transition_delay_us(cpu);
 }
 #endif
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d87a0d0246935..89f226f1b4ec4 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -32,6 +32,9 @@
  */
 
 #define CPUFREQ_ETERNAL			(-1)
+
+#define CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS	NSEC_PER_MSEC
+
 #define CPUFREQ_NAME_LEN		16
 /* Print length for names. Extra 1 space for accommodating '\n' in prints */
 #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
-- 
2.51.0


