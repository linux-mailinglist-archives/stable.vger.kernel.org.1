Return-Path: <stable+bounces-116848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C90CAA3A91C
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C871175E12
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848EC1E7C11;
	Tue, 18 Feb 2025 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlYdW3WU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4267C1D63EB;
	Tue, 18 Feb 2025 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910353; cv=none; b=OA+anB/IpBLX179qbG/rt3twVFIIgrX5rF6Tu/KB/GUF0HAA51LSlGEnV6ue5S2KMx9D2BwX5V7T2g4jG6bnuU00NAXgQlvLZkH3o8DAE9l/djRII5k60rIY6hHNGiKSnfiA+zCayTFfekwT6UZDDGyvdgt9yn4N8Wj6neI3uyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910353; c=relaxed/simple;
	bh=rhEnxd6dxqXUn4fdDYtvd/B4dG/MCx/T8Z8mlfAZ6fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X15rlB4pjW6z5OGEuIXJXLqpcEujJpSyTOo2mpKvfjOVhPiB8ptbspeNQ8Qqxq3/8CqJXhTIz6GjD+shUhd+98lX7liYcgrfaG4pMZul9STLqiGYeINTY3sdeDhcl9J3RRmWNCrkXquZEIbWtxCj7Uf0ejb1dDheeQFNdyqorwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlYdW3WU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54E6C4CEE8;
	Tue, 18 Feb 2025 20:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910351;
	bh=rhEnxd6dxqXUn4fdDYtvd/B4dG/MCx/T8Z8mlfAZ6fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZlYdW3WUpOwB+630by4/Y94uWeGStmKia/nExviRi+NgaCfAvGHmf2ENF0Lvyt5lF
	 IZxnUi4LAwyBhOAhag/g/s1zbu5zWsLt8gG64SP7bajqmNf/Mx6p3S1VIhP2pE5VJO
	 cTy1GA1UTLaMQdmPlPXFdVePUkvS88Cc2wayQ/QHHoVKP2j93TW1vrSOTkLjOY3SQk
	 2lN5/ZPKfqek7DwzZYsYR8+fr3o1pTC3RoEcRiQ0/8bB6SqPm2G7GdDVE+xhKXbnq8
	 wDioNA38YCpo0O5jDPC8FSlS5zx7YeE1/lhHpwBgFUgrCg9wKh/VB5Ir35b8UXe0Wb
	 ACOPUOzOIfGYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Beata Michalska <beata.michalska@arm.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 26/31] arm64: amu: Delay allocating cpumask for AMU FIE support
Date: Tue, 18 Feb 2025 15:24:46 -0500
Message-Id: <20250218202455.3592096-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202455.3592096-1-sashal@kernel.org>
References: <20250218202455.3592096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.3
Content-Transfer-Encoding: 8bit

From: Beata Michalska <beata.michalska@arm.com>

[ Upstream commit d923782b041218ef3804b2fed87619b5b1a497f3 ]

For the time being, the amu_fie_cpus cpumask is being exclusively used
by the AMU-related internals of FIE support and is guaranteed to be
valid on every access currently made. Still the mask is not being
invalidated on one of the error handling code paths, which leaves
a soft spot with theoretical risk of UAF for CPUMASK_OFFSTACK cases.
To make things sound, delay allocating said cpumask
(for CPUMASK_OFFSTACK) avoiding otherwise nasty sanitising case failing
to register the cpufreq policy notifications.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://lore.kernel.org/r/20250131155842.3839098-1-beata.michalska@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/topology.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 1a2c72f3e7f80..cb180684d10d5 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -194,12 +194,19 @@ static void amu_fie_setup(const struct cpumask *cpus)
 	int cpu;
 
 	/* We are already set since the last insmod of cpufreq driver */
-	if (unlikely(cpumask_subset(cpus, amu_fie_cpus)))
+	if (cpumask_available(amu_fie_cpus) &&
+	    unlikely(cpumask_subset(cpus, amu_fie_cpus)))
 		return;
 
-	for_each_cpu(cpu, cpus) {
+	for_each_cpu(cpu, cpus)
 		if (!freq_counters_valid(cpu))
 			return;
+
+	if (!cpumask_available(amu_fie_cpus) &&
+	    !zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL)) {
+		WARN_ONCE(1, "Failed to allocate FIE cpumask for CPUs[%*pbl]\n",
+			  cpumask_pr_args(cpus));
+		return;
 	}
 
 	cpumask_or(amu_fie_cpus, amu_fie_cpus, cpus);
@@ -237,17 +244,8 @@ static struct notifier_block init_amu_fie_notifier = {
 
 static int __init init_amu_fie(void)
 {
-	int ret;
-
-	if (!zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL))
-		return -ENOMEM;
-
-	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
+	return cpufreq_register_notifier(&init_amu_fie_notifier,
 					CPUFREQ_POLICY_NOTIFIER);
-	if (ret)
-		free_cpumask_var(amu_fie_cpus);
-
-	return ret;
 }
 core_initcall(init_amu_fie);
 
-- 
2.39.5


