Return-Path: <stable+bounces-136313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF63A9937B
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6179A3A59
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EB4280CFF;
	Wed, 23 Apr 2025 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nmt2S3Fu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B92266F1E;
	Wed, 23 Apr 2025 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422220; cv=none; b=r4QdkC6EKo1Ql3ke0SQJo2z20xP80AA9MCaYEonRcChJp/5jv6IFj7vuGCrfaQPSYZzOvP5qnH3u65wfJpDKXN7qQoW7gJgwzwo7cy9vmHSLkRhTAl7I5RZHvj69vIdv3wvQbcWWVPdAJMI0xaC7XjHk+nrU7zxWI63jl7j9VFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422220; c=relaxed/simple;
	bh=y/sJc+yQfMtkLYyzdS7TSf6VPrAodI6yd5d3jqW+ZnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9J2b07nkVsTte81g1b294pAoPKKP90TJDgtGK80+kg05xLo6BgoeKtMGUEs+JZDN4H/lQt9BhdTKVsQ0a9ZxBoQXY13YYHfLwikgPw64FMY8/a6b6m+XE953/FWUFIMuYyt04DpAMOZG4nNUkUz+kA4hGrCO6yDZ/Pg0lOseHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nmt2S3Fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95E5C4CEE3;
	Wed, 23 Apr 2025 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422220;
	bh=y/sJc+yQfMtkLYyzdS7TSf6VPrAodI6yd5d3jqW+ZnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmt2S3Fu9G+u9Yiako3BKxlw5gDN+XIPUe9TLeEXTDuO4xtK1QEAdOQxDtXWtHab8
	 7CTo0zoi7ADREvNkshW0scEnj4EZaVMT2wnl6pbJAx7SuHoUm4q+R6kiUR4McVMvWe
	 EyR/u7lHYcu6aTzRdd+HYTuGUkwyNVnoX3cMcalw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 299/393] cpufreq/sched: Fix the usage of CPUFREQ_NEED_UPDATE_LIMITS
Date: Wed, 23 Apr 2025 16:43:15 +0200
Message-ID: <20250423142655.689461340@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit cfde542df7dd51d26cf667f4af497878ddffd85a ]

Commit 8e461a1cb43d ("cpufreq: schedutil: Fix superfluous updates caused
by need_freq_update") modified sugov_should_update_freq() to set the
need_freq_update flag only for drivers with CPUFREQ_NEED_UPDATE_LIMITS
set, but that flag generally needs to be set when the policy limits
change because the driver callback may need to be invoked for the new
limits to take effect.

However, if the return value of cpufreq_driver_resolve_freq() after
applying the new limits is still equal to the previously selected
frequency, the driver callback needs to be invoked only in the case
when CPUFREQ_NEED_UPDATE_LIMITS is set (which means that the driver
specifically wants its callback to be invoked every time the policy
limits change).

Update the code accordingly to avoid missing policy limits changes for
drivers without CPUFREQ_NEED_UPDATE_LIMITS.

Fixes: 8e461a1cb43d ("cpufreq: schedutil: Fix superfluous updates caused by need_freq_update")
Closes: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org/
Reported-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/3010358.e9J7NaK4W3@rjwysocki.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a49f136014ce6..259521b179aa1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 
 	if (unlikely(sg_policy->limits_changed)) {
 		sg_policy->limits_changed = false;
-		sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
+		sg_policy->need_freq_update = true;
 		return true;
 	}
 
@@ -95,10 +95,22 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
-	if (sg_policy->need_freq_update)
+	if (sg_policy->need_freq_update) {
 		sg_policy->need_freq_update = false;
-	else if (sg_policy->next_freq == next_freq)
+		/*
+		 * The policy limits have changed, but if the return value of
+		 * cpufreq_driver_resolve_freq() after applying the new limits
+		 * is still equal to the previously selected frequency, the
+		 * driver callback need not be invoked unless the driver
+		 * specifically wants that to happen on every update of the
+		 * policy limits.
+		 */
+		if (sg_policy->next_freq == next_freq &&
+		    !cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS))
+			return false;
+	} else if (sg_policy->next_freq == next_freq) {
 		return false;
+	}
 
 	sg_policy->next_freq = next_freq;
 	sg_policy->last_freq_update_time = time;
-- 
2.39.5




