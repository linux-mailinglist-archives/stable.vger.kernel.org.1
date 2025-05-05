Return-Path: <stable+bounces-140036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3852AAA42B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E87E464699
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B0E2FC2DC;
	Mon,  5 May 2025 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSMkfTKe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8FE2FC2D0;
	Mon,  5 May 2025 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483956; cv=none; b=mD+YJUg1Eg+Ps+6A64Hnyx/00DKvStLtyORzEy5ae0UeE2by5LXoKgAjnYaZhtXpubCv4uq/95JUXF2fp1On/JaFet6/pTq+vqdRuUtX7LEga90IXdYrDvAg2AasRFEL4I9vZZjPa0PsVTUYP/QRzKcAdVlX+qL3fVA+g/m/0lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483956; c=relaxed/simple;
	bh=lA11mi3pVZ3Zgt4Qb1dPLIWEf000WMWrP3zmD8x6dCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfRSCm6OIoR60jedTg9Gyqlul1jSHdX5EWkT9uZC0sqk6IvL2tJQAZ2E9gqk7GBcJMI6aY1WL7xYS95UpZA+sO9l2d0bw0kOw6JbIR++j0IouTOYbbSHWDT5owK3JORSSoH2ryWbQ56gYmO0OHZokpMvVW4WEJ6wg1VglLcsfL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSMkfTKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD45C4CEE4;
	Mon,  5 May 2025 22:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483956;
	bh=lA11mi3pVZ3Zgt4Qb1dPLIWEf000WMWrP3zmD8x6dCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSMkfTKeCL/Ym0f0lRDWsCDqgm+BVhWCqQqWabxDbrIW3FQpvXrqNfABh5BiN8Oaa
	 C4pfI8uQGyyAxCQcqO4MzCrAJjIYARmmoNyZPRzQMEqBXt6fg0M1zw+kQ8g8GUAC8r
	 wnm4HHsFTf1R8yKX/xQM3+H5h8uB1r+74wKABORXJvcO+4EwlqQzxD+cY/Kmht4nYm
	 4ap05AtnbhCkWow4S1WjH5Glmeak6m9c9rr3wjlo2799plR8mg5A+e+y8T3VBq/Rjh
	 CeuntQsGbywOXPkAwF6Ls28GRzrXVny9EbytwEJUug4X2W3PFGFUjimAynwIhKlkHi
	 azzd1dS2kLQFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 289/642] perf: arm_pmuv3: Call kvm_vcpu_pmu_resync_el0() before enabling counters
Date: Mon,  5 May 2025 18:08:25 -0400
Message-Id: <20250505221419.2672473-289-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: "Rob Herring (Arm)" <robh@kernel.org>

[ Upstream commit 04bd15c4cbc3f7bd2399d1baab958c5e738dbfc9 ]

Counting events related to setup of the PMU is not desired, but
kvm_vcpu_pmu_resync_el0() is called just after the PMU counters have
been enabled. Move the call to before enabling the counters.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Tested-by: James Clark <james.clark@linaro.org>
Link: https://lore.kernel.org/r/20250218-arm-brbe-v19-v20-1-4e9922fc2e8e@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm_pmuv3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 0e360feb3432e..9ebc950559c0a 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -825,10 +825,10 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
 	else
 		armv8pmu_disable_user_access();
 
+	kvm_vcpu_pmu_resync_el0();
+
 	/* Enable all counters */
 	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
-
-	kvm_vcpu_pmu_resync_el0();
 }
 
 static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
-- 
2.39.5


