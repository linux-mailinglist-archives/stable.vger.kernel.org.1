Return-Path: <stable+bounces-186165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0830FBE3E75
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 16:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9083BF14D
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA6D33EAFD;
	Thu, 16 Oct 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xVNBhRKy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB602E03F1
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624712; cv=none; b=s/TyfW5XBJFriNarZlErpq6QjX0v+ixersv4vjMVGHdpU9KASChnmftGb5HWf5zNIZ4SztUGhtYYB+ryGKoqm5CJ3M//VynV3WuWiPNDNps/l5JoisPTze4cMg/I8UumqmMA1Jd+S9b1m2oZdVOAsajcH3Vim3VL5FMNOdwl7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624712; c=relaxed/simple;
	bh=wHowcAOSmTWX3SuFO2TQk4xOnBVOwW8fL2z7H0qO1jM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GM02j12EAqtkMz250C1jqb3mwLh5OMJqeEpnhHlJ06/RwghMpLeLxZARcapYHewQHMZmfvMlJR1u9s1rL4SqogS/o6Zx202gM6V8lErZL4YruEmv0/k0AmcR4FU/TgXPFJNpo7NK+OHimtKrcP54E/ltd2qTzJ3e15M7ZMebsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xVNBhRKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96B0C4CEF1;
	Thu, 16 Oct 2025 14:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760624712;
	bh=wHowcAOSmTWX3SuFO2TQk4xOnBVOwW8fL2z7H0qO1jM=;
	h=Subject:To:Cc:From:Date:From;
	b=xVNBhRKyKDClPSo+AFQprnKWrtrY/X4VclMcK+E16q5OXlaclsff/JkxtTq8nJmGa
	 eFFPoSXl7HmQLvfLBV88WqNfkU83DdphH1UZrpM9OjNYL8QpWTrT0OuetSC4KgI4UO
	 UqiWFZjbe+vvWetzsydok/KEFeIZMpvHZaLbJt4w=
Subject: FAILED: patch "[PATCH] cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as transition" failed to apply to 6.1-stable tree
To: rafael.j.wysocki@intel.com,qyousef@layalina.io,stable@vger.kernel.org,superm1@kernel.org,viresh.kumar@linaro.org,zhanjie9@hisilicon.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 16:25:09 +0200
Message-ID: <2025101609-footsore-ensnare-d320@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f965d111e68f4a993cc44d487d416e3d954eea11
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101609-footsore-ensnare-d320@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


