Return-Path: <stable+bounces-77449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84021985DAD
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9053B280F8
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323211E1337;
	Wed, 25 Sep 2024 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljvglun/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07BF1E1330;
	Wed, 25 Sep 2024 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265807; cv=none; b=JIMUak4UQvZSUtdnMslBnxL2/2S7B2lU3NV1EmV09ZAT0O31b/qocyTzkKlCYqv7MD2e/GW4sBEndwbCxAi68FuaDESuX2cj7IHjrc7F4P79hK/K8yNlUBDnWTz4/9eodrK2m8U1XRqTiEz5JG4ossKtfIACs1Fm6Rr7Lg+hUHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265807; c=relaxed/simple;
	bh=NsTb6PzF0Xxoaa26bO8UBHdaZUfQrZ5zaWZ7jGPg0os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxATY/wz0BZlj7l1aHjWuzce+8dvjsBrXHwaa6cgcFayo0PDM9X5UcwkCNoTrDOSaghuYAmZThOiHtUqDAYp24U8c/ZW6C/4iQut+XJMITMK8Qb/Tx6eHv9jbsTAbjmPxLjRuaBM+fC9YnY1kjuErCK2xsTnmLk3QhgtVUjwNbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljvglun/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284E5C4CED0;
	Wed, 25 Sep 2024 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265807;
	bh=NsTb6PzF0Xxoaa26bO8UBHdaZUfQrZ5zaWZ7jGPg0os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ljvglun/hhjIBPPBy6hrZV+Aot0bGAiOyWr7nkhiModKoLqGUbnwL9NFmILMgRy0+
	 o8C7dDSmeDfSXIon2eebvf+nSSWcRABOdJfNsD+Xs+Xz8SHS5xbE5lDNGh4Fy6s21P
	 CQq27qKf+G5tr7Pku9xtxjNzewHcIxJftJFYcJMjVARTKMR228LMbcEmr7/9ftDsaF
	 Z24RAmrRrUIXs6b+2Bc+0TlI05AuPBHH++UkX4ySbqSPpHKzM5obS1koKFPq2I6xAK
	 Gr4lbG8nmM2w5/4ToVGOUsCtR7sUaQFXQglOXyaKTIRMPY6dGLpZpv9JNGIhgEUfsy
	 EBeskJtkOAYiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robdclark@gmail.com,
	joro@8bytes.org,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 104/197] iommu/arm-smmu-qcom: Work around SDM845 Adreno SMMU w/ 16K pages
Date: Wed, 25 Sep 2024 07:52:03 -0400
Message-ID: <20240925115823.1303019-104-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 2d42d3ba443706c9164fa0bef4e5fd1c36bc1bd9 ]

SDM845's Adreno SMMU is unique in that it actually advertizes support
for 16K (and 32M) pages, which doesn't hold for newer SoCs.

This however, seems either broken in the hardware implementation, the
hypervisor middleware that abstracts the SMMU, or there's a bug in the
Linux kernel somewhere down the line that nobody managed to track down.

Booting SDM845 with 16K page sizes and drm/msm results in:

*** gpu fault: ttbr0=0000000000000000 iova=000100000000c000 dir=READ
type=TRANSLATION source=CP (0,0,0,0)

right after loading the firmware. The GPU then starts spitting out
illegal intstruction errors, as it's quite obvious that it got a
bogus pointer.

Moreover, it seems like this issue also concerns other implementations
of SMMUv2 on Qualcomm SoCs, such as the one on SC7180.

Hide 16K support on such instances to work around this.

Reported-by: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240824-topic-845_gpu_smmu-v2-1-a302b8acc052@quicinc.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 8bc71449aabc3..eff090b1f4fc7 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -345,6 +345,14 @@ static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static int qcom_adreno_smmuv2_cfg_probe(struct arm_smmu_device *smmu)
+{
+	/* Support for 16K pages is advertised on some SoCs, but it doesn't seem to work */
+	smmu->features &= ~ARM_SMMU_FEAT_FMT_AARCH64_16K;
+
+	return 0;
+}
+
 static void qcom_smmu_write_s2cr(struct arm_smmu_device *smmu, int idx)
 {
 	struct arm_smmu_s2cr *s2cr = smmu->s2crs + idx;
@@ -443,6 +451,7 @@ static const struct arm_smmu_impl sdm845_smmu_500_impl = {
 
 static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
 	.init_context = qcom_adreno_smmu_init_context,
+	.cfg_probe = qcom_adreno_smmuv2_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
-- 
2.43.0


