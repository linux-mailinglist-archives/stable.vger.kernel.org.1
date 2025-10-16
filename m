Return-Path: <stable+bounces-186023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E03BE363D
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E411134FB0D
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AE030EF69;
	Thu, 16 Oct 2025 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nLnUNdeA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436931607AC
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618048; cv=none; b=IgfDwoQpvCE26GFHy9bFv6MZCpRuHXoawCuMZLqsqAu+Thsl2aEnczXB0MQBsXRCt/pM4q9JAnXV1rDeUXsxfJsOeCKQfdQ3ry2fewIy6BQw4Csn6C6Dkxg0khYEvSRYKMETbMr+4/TWa4ZISua5LCDfp46xBiNvY9Nf/2pE3Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618048; c=relaxed/simple;
	bh=1gZO1end2bQGZYdfwQApWNCrSglZPFNpDxt6FrCKCXY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ij9IF9w3qgarX4icHYorle8Rmc5jPvujrE9ghN0qO4O4PnyG9PStzu7cd+SL3fIgr0+CxGIeQTDsZI4DygMuXDKU/jdZ8uFPnU49QnsacMI1DdSb1ZvxiS/FBPIJlltgL4w5l0PvOWWi9KlbIDiA128Moru60P4GeVPuV3RkqH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nLnUNdeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2C6C19423;
	Thu, 16 Oct 2025 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760618046;
	bh=1gZO1end2bQGZYdfwQApWNCrSglZPFNpDxt6FrCKCXY=;
	h=Subject:To:Cc:From:Date:From;
	b=nLnUNdeAK2wciKPsUhNtuIF2Z6+h6V604Il7Ntz1jl6pHTzFWf/PrZrjSHMDWnDeQ
	 Mdr23+0wMoRx+R/BCi70HG47eP26b7hClTfAy3mJbCFyTrFK0GmZ536mqAqGAChnCJ
	 qVFiEUC5lCV6MGScnn59FVgwq8nDd4OqcGmXZKL0=
Subject: FAILED: patch "[PATCH] cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as transition" failed to apply to 5.10-stable tree
To: rafael.j.wysocki@intel.com,qyousef@layalina.io,stable@vger.kernel.org,superm1@kernel.org,viresh.kumar@linaro.org,zhanjie9@hisilicon.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:33:55 +0200
Message-ID: <2025101655-hardhead-variably-b7de@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f965d111e68f4a993cc44d487d416e3d954eea11
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101655-hardhead-variably-b7de@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f965d111e68f4a993cc44d487d416e3d954eea11 Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Fri, 26 Sep 2025 12:19:41 +0200
Subject: [PATCH] cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as transition
 delay

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

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 12de0ac7bbaf..b71946937c52 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -308,6 +308,16 @@ static int cppc_verify_policy(struct cpufreq_policy_data *policy)
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
@@ -330,12 +340,12 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
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
 


