Return-Path: <stable+bounces-146718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7FDAC5446
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E39517B877
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5800027FB37;
	Tue, 27 May 2025 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1SbcSwE8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149A12CCC0;
	Tue, 27 May 2025 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365094; cv=none; b=CqdtQmlASsH/5nBOh8owpK1KtKHzrG6rLdMVUsgXzmHuliuiUYc+2bk9k/zgOZUepP+HADCqkSAE1FOAOgw4awQtqSuVRqnWTvvBzCNUTzBOqpMLFYL92xKDkYpKm6tLu5RdjhRM2GhlZZHPvaeqU0eTN4lqIweX23r4S6izbcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365094; c=relaxed/simple;
	bh=FbWjWAnFYFFpUsgDpFXiTM5fmNkGWZxXgTtFEdJFQkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0C7z4JKO0sjpzhX+E3m4s5Y5XI1lSakS3n5kozIQZdSBAQQA7bdjReFUQoOF6UIurOUNCJOyfFHiQTR9TNYOLTLWPK79uTZLUwMcHmm2jBq4FjuwDpktKZDsPn4aq8fB8VzsxknHK/+ClusZYGTmpOhhC2ToyJgebsHVnnttsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1SbcSwE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E34C4CEE9;
	Tue, 27 May 2025 16:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365093;
	bh=FbWjWAnFYFFpUsgDpFXiTM5fmNkGWZxXgTtFEdJFQkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1SbcSwE8f9NPapqJRCknexbL4KK2nGRcnO6HLTfKwCBvCUuRCPBx4W3m3l19oRmqj
	 cLFnNB5PZ4RjW/z0VMsNc551IlyuAOnBBFTFYuElcMd9HDWRtYfigcLzPRy3jeDFtm
	 vUUJAUIx3bLi1KR/VOlyl56wI/QQCYIy9Nrg1utU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Clark <james.clark@linaro.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 264/626] perf: arm_pmuv3: Call kvm_vcpu_pmu_resync_el0() before enabling counters
Date: Tue, 27 May 2025 18:22:37 +0200
Message-ID: <20250527162455.734184681@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring (Arm) <robh@kernel.org>

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




