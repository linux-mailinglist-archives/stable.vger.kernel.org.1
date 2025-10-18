Return-Path: <stable+bounces-187856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92068BED42F
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 18:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6E8A34CA5D
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F124BC0A;
	Sat, 18 Oct 2025 16:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyTg7nEq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83311FDE01
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760806512; cv=none; b=A7ylV4RVFXMYlIGxNKKtNnwNa7ANv1l4KfuVzDYQpHYJ4gFTNFWjrJrnFuG9d2tBBg6flitA/DWwZlE36pRXUSOyfv9UfpYoaETaI6BEjRVCrj5gNNCuRNiy3hk4heDxydSvGEfLbc0fXrO0h0pg06cFyxYOCBBObHkIeXD47aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760806512; c=relaxed/simple;
	bh=TejrRNrW0ZZUFQZHtOlwbHYa9A87ok0CZcQJgsdf/8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAkYRgossb8uysWEB6RnKIB4CuGj6jXt6TyXlX4Z9kfGC0kcKlnyMF8GM41JIPKtsZWBSP7lIEd5kGv6lL6c73AfXn2twhogNYP5DuAuGkVl1Y6itb/kT4tjovczJdxdSVzfcczkCivszCaLRUhAuc5PVxHxlPFsdXCmXs4sJWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyTg7nEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B908FC4CEF8;
	Sat, 18 Oct 2025 16:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760806512;
	bh=TejrRNrW0ZZUFQZHtOlwbHYa9A87ok0CZcQJgsdf/8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OyTg7nEqcX7I/cOEHv+7HCgKqO2cdHhW+RynmgeebaMsk1S8Rx7uVf7BECkg/xdDp
	 ffjhtRxCfBxTl0qAxWpvZ7hujyCT+VyDgBtNAX3vokP9DxR9TLHmiZW/wqg45vHokk
	 SB3L/F44GjnPsAEXdiJbJoY6ix5OPpEk0PH6DsTMyJcj3m8h8RgF180VW5LTphaW9Z
	 WNxw/+z8NKEjd9ubXkqAFqMxPQTvgBlmDNoF0L6JjRBfbLbsBRWkBnks9KXxmie+hO
	 5B6c9ff+732oYnHhKl4Z9a2CdEMqyJqyRc0Ldg8sD2bDMhWMb5C+9TRUxCAVU/AsLb
	 snBZjc4Jq2otw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Qais Yousef <qyousef@layalina.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as transition delay
Date: Sat, 18 Oct 2025 12:55:09 -0400
Message-ID: <20251018165510.848330-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101655-grandma-populate-0fb4@gregkh>
References: <2025101655-grandma-populate-0fb4@gregkh>
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
index b7294531816be..b72fd4ff2cdac 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -395,6 +395,16 @@ static int cppc_verify_policy(struct cpufreq_policy_data *policy)
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
@@ -417,14 +427,14 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
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
index 025391be1b199..8e3a1d4e0a3a2 100644
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


