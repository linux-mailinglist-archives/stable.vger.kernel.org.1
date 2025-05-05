Return-Path: <stable+bounces-140600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A33AAA9F7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B1C16E2C3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4BF2DF568;
	Mon,  5 May 2025 22:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFl7pGS3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23C2D37EF;
	Mon,  5 May 2025 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485239; cv=none; b=junG3c7sNtGngr537OnS1kRE3vW3vPRCZAsG7WzdAoNre4L4kabX2xTji+H6a77E88/pVt3sg3ZLR7qwyEmp1WafbWv29ry1oracugpycRGnRvBPDr0o1r5SUc1oK+eHXyetW6k4mhHsz6AewXBOQZ6j4qXVMUW8pl+Uiel7BKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485239; c=relaxed/simple;
	bh=Q6mzvyxCFKn0LYzphUXFPUR4b1GinHCbmTPxZGgDFAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eGTZYkGCPO9n2Ba7CEwXemiwZFx4OYX8jGJGhSlnhZ9k9OfgSVhBfTeX70FLFqseo4BuNpKQLF3paJxZfX1HPLmoU64xXHY01yra8scQ3ck0kpKq+j9lT6yvtT3xO0D0CSKDHjX/w68ndahcHYGxEIN0e8YNKM/HOjiiCXHmD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFl7pGS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706D3C4CEED;
	Mon,  5 May 2025 22:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485238;
	bh=Q6mzvyxCFKn0LYzphUXFPUR4b1GinHCbmTPxZGgDFAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sFl7pGS3Mp5yRD+wJVWyy5C9CQkpAiJMR1VWSc0LlOQ3TbIDRcGrETxSru5A2JRvf
	 DB7ribZ42Nzyx4evfGdH9LGZzNm3USUiwQWz4LdDmOhLXE5B7DtXyW0yi0m6gRpHgv
	 EulKpVDBs43q95u/uOR9Gr1Ioa0xwga1X0iWuKnKGOK1eh8fTYJusb+0AD3h076zoU
	 LvU12QS7pKzvPPb2oGOmohpTrSM618oXGuxuKx4pI+ANdpCbWslheqyBHUO1RboLOr
	 t/4MQ929kGsVxqbLjtdNRXtbji2aKTAPGJ2e7Junf+Gt1s94FW4/6dqYLudZv5orfV
	 xGy5cl0/GdQew==
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
Subject: [PATCH AUTOSEL 6.12 228/486] perf: arm_pmuv3: Call kvm_vcpu_pmu_resync_el0() before enabling counters
Date: Mon,  5 May 2025 18:35:04 -0400
Message-Id: <20250505223922.2682012-228-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 0afe02f879b45..d9b56f0f90942 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -816,10 +816,10 @@ static void armv8pmu_start(struct arm_pmu *cpu_pmu)
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


