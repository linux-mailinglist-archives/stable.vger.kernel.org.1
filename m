Return-Path: <stable+bounces-124918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC3AA68D82
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2435F3B9F94
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 13:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4AD2561DC;
	Wed, 19 Mar 2025 13:14:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52CB17BCE;
	Wed, 19 Mar 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390066; cv=none; b=gGRmm7VpdoBPS4Kowp/BayfdVAikJlRDMEQZj4cOeQKjuUbF5mi6B87D5ole0/Gaevp3xscjfUlK8fzegq32pJ0pifBOxy5MJmLM3kCzse7k04wDLxcMvTXAQOQRceECVuKrrnSjMkQhElNVQ49dVY2Fa8tTpVbz5txDf9kNwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390066; c=relaxed/simple;
	bh=SljNGVdiNzN+yTSjjeD/mCJwtjnWRvo0+8/If/d3kTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uPG0DWwN4Ef+jMAiVveA/K288Mmuvtpk6D6Mkuo0VuybOxbIqjxM0adfMEyub+5oxoabGvCyyMpTTMXqFmcL9kLOSSA/ic3ix60o9aNxQDgp009TDGw4YAFrTGldjZi4QEzuLAH3RsMn2SDqP9RidLt8GvYN1BDbdmCKYVdl0T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E610EFEC;
	Wed, 19 Mar 2025 06:14:31 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.85.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 352B63F673;
	Wed, 19 Mar 2025 06:14:21 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@redhat.com
Cc: juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	vincent.guittot@linaro.org,
	Christian Loehle <christian.loehle@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] sched/topology: Fix EAS cpufreq check print
Date: Wed, 19 Mar 2025 13:13:23 +0000
Message-Id: <20250319131324.224228-2-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319131324.224228-1-christian.loehle@arm.com>
References: <20250319131324.224228-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing newline on cpufreq check to ensure the EAS abort
reason doesn't go missing.

Fixes: 8f833c82cdab ("sched/topology: Change behaviour of the 'sched_energy_aware' sysctl, based on the platform")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c49aea8c1025..27f14a775004 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -256,7 +256,7 @@ static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
 		policy = cpufreq_cpu_get(i);
 		if (!policy) {
 			if (sched_debug()) {
-				pr_info("rd %*pbl: Checking EAS, cpufreq policy not set for CPU: %d",
+				pr_info("rd %*pbl: Checking EAS, cpufreq policy not set for CPU: %d\n",
 					cpumask_pr_args(cpu_mask), i);
 			}
 			return false;
-- 
2.34.1


