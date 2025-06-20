Return-Path: <stable+bounces-155125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E308AE1A02
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 13:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F257D1BC2B56
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1728A1F8;
	Fri, 20 Jun 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luPXHCkz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA7327E7D9;
	Fri, 20 Jun 2025 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750419005; cv=none; b=Cmfr7iwqed0PL3uxoYX/6Q+3hvhpFuJixZOUPSmdo+2ra0K3BuTaBszVPvFdCaKWtvTUt2+a8X0ZrZonkUUL/9knlgpbYmBW9MRgtxfDuFT7eCTcRv1PoVPJg/vl4J3iEur3fH9GHBupeENWf6H5juW+Dr/nXtaftOmFAvb9VRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750419005; c=relaxed/simple;
	bh=u448jzyYDYymD2jHYZMheiM/0ZHuiGizT/yHf2Wx23k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rmvPyQarrWBpsbM7r3XiZpnGKZxHYEhpsUE32ffKVJ8NxnCMcl9inR7vM6XcijAcvvWlZvKJD52A5WeocvJ5To0B2uBbJPxc8DRxRh1YODoCTUGXyPQigsPBIXrBuAlsFO3kAYRbBtrsk95PxnFGE4YFnoAZmmXgw/jSEEyAppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luPXHCkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139A2C4CEE3;
	Fri, 20 Jun 2025 11:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750419004;
	bh=u448jzyYDYymD2jHYZMheiM/0ZHuiGizT/yHf2Wx23k=;
	h=From:Date:Subject:To:Cc:From;
	b=luPXHCkzNsBfM44ygLmgfv6czfsRoHMO9uhA3vJZMbkSHwcJiGUVCEGjn1tHZiKwt
	 tXAkjh023T0bRTdN14Vw+bST0+oC2vsKd+wm0ykSAYJotgjIoHPyVmPn1th/FFI/rg
	 qagksfm9gSv4W5Jz8hxZZtPZn5TjATDG+b4xEwX4djOtzmqdWE1hpbV0CCn55qrPmG
	 lm0rOwwrigYPTnyW3gyNwZ8sue+lx4ot+2Ydd9+84R8DU96ROdvEPvMqbQFyxmY7po
	 9bIJV9eZc7PBdD1VcvaJkCjfFM1gogRV19ioay4+dCnNWon8y0awpH1vqIdhK+9+oU
	 X4MnMLFCBBhyg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Jun 2025 12:28:48 +0100
Subject: [PATCH] arm64: Filter out SME hwcaps when FEAT_SME isn't
 implemented
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-arm64-sme-filter-hwcaps-v1-1-02b9d3c2d8ef@kernel.org>
X-B4-Tracking: v=1; b=H4sIAO9FVWgC/x3MTQqDQAxA4atI1g1odMbiVUoXo2Y0UH9Iigri3
 R1cfov3TjBWYYMmO0F5E5NlTiheGXRjmAdG6ZOBcnK5L94YdPIV2sQY5fdnxXHvwmrY1r6kiqL
 z5CDVq3KU4zl/vtd1A6yPPuNpAAAA
X-Change-ID: 20250618-arm64-sme-filter-hwcaps-b763242f5625
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yury Khrustalev <yury.khrustalev@arm.com>, Mark Brown <broonie@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-08c49
X-Developer-Signature: v=1; a=openpgp-sha256; l=7065; i=broonie@kernel.org;
 h=from:subject:message-id; bh=u448jzyYDYymD2jHYZMheiM/0ZHuiGizT/yHf2Wx23k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoVUY6N40qMRjDa/t+oU0dUn6BKFuIevcr482sk
 WxunWEZHtGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFVGOgAKCRAk1otyXVSH
 0OmUB/9i40oT/lKh218FYkmI8A6uxpN1pSx3oWx/NdRgqlPo4QORaHxqo6khYUeKYykRW2dIvgr
 Cn5CWq+LnAkJYCoBF0QziqNLqp4yMg3ugtSwB7xkqUy+X1xR4JPyEK+wC6BpI5QiRiHhbQpxEJ8
 gZITuuf0xfITjy2Wu9UAOGKcdRTuT41ie3TUup0qmkFXl0S5JTRDaxe2Nsk+ALgXfchi0yqPdye
 2vFCw56cGbowsCP+yV249rt9/R3tJ6dKet6VJpKKgesw/7Dy2dq0HfDX04VVGdwQPbMb0oRPlfY
 2uaZG14wAXExgtGwlnaLk0S99kT1tVT9gRx99LbIvXOCzHH2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We have a number of hwcaps for various SME subfeatures enumerated via
ID_AA64SMFR0_EL1. Currently we advertise these without cross checking
against the main SME feature, advertised in ID_AA64PFR1_EL1.SME which
means that if the two are out of sync userspace can see a confusing
situation where SME subfeatures are advertised without the base SME
hwcap. This can be readily triggered by using the arm64.nosme override
which only masks out ID_AA64PFR1_EL1.SME, and there have also been
reports of VMMs which do the same thing.

Fix this as we did previously for SVE in 064737920bdb ("arm64: Filter
out SVE hwcaps when FEAT_SVE isn't implemented") by filtering out the
SME subfeature hwcaps when FEAT_SME is not present.

Fixes: 5e64b862c482 ("arm64/sme: Basic enumeration support")
Reported-by: Yury Khrustalev <yury.khrustalev@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/cpufeature.c | 57 ++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b34044e20128..e151585c6cca 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3135,6 +3135,13 @@ static bool has_sve_feature(const struct arm64_cpu_capabilities *cap, int scope)
 }
 #endif
 
+#ifdef CONFIG_ARM64_SME
+static bool has_sme_feature(const struct arm64_cpu_capabilities *cap, int scope)
+{
+	return system_supports_sme() && has_user_cpuid_feature(cap, scope);
+}
+#endif
+
 static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ISAR0_EL1, AES, PMULL, CAP_HWCAP, KERNEL_HWCAP_PMULL),
 	HWCAP_CAP(ID_AA64ISAR0_EL1, AES, AES, CAP_HWCAP, KERNEL_HWCAP_AES),
@@ -3223,31 +3230,31 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ISAR2_EL1, BC, IMP, CAP_HWCAP, KERNEL_HWCAP_HBC),
 #ifdef CONFIG_ARM64_SME
 	HWCAP_CAP(ID_AA64PFR1_EL1, SME, IMP, CAP_HWCAP, KERNEL_HWCAP_SME),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, FA64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, LUTv2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_LUTV2),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2p2, CAP_HWCAP, KERNEL_HWCAP_SME2P2),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2p1, CAP_HWCAP, KERNEL_HWCAP_SME2P1),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2, CAP_HWCAP, KERNEL_HWCAP_SME2),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, I16I64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F64F64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F64F64),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, I16I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16B16),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F16F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F16),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F8F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F8F16),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F8F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F8F32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, I8I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, B16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16F32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, BI32I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_BI32I32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F32F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F32F32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8FMA),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8DP4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP4),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SF8DP2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP2),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SBitPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SBITPERM),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, AES, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_AES),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SFEXPA, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SFEXPA),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, STMOP, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_STMOP),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SMOP4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SMOP4),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, FA64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, LUTv2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_LUTV2),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SMEver, SME2p2, CAP_HWCAP, KERNEL_HWCAP_SME2P2),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SMEver, SME2p1, CAP_HWCAP, KERNEL_HWCAP_SME2P1),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SMEver, SME2, CAP_HWCAP, KERNEL_HWCAP_SME2),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, I16I64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F64F64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F64F64),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, I16I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16B16),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F16F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F16),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F8F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F8F16),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F8F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F8F32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, I8I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, B16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16F32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, BI32I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_BI32I32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F32F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F32F32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SF8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8FMA),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SF8DP4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP4),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SF8DP2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SF8DP2),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SBitPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SBITPERM),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, AES, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_AES),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SFEXPA, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SFEXPA),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, STMOP, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_STMOP),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SMOP4, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_SMOP4),
 #endif /* CONFIG_ARM64_SME */
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8CVT, IMP, CAP_HWCAP, KERNEL_HWCAP_F8CVT),
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_F8FMA),

---
base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
change-id: 20250618-arm64-sme-filter-hwcaps-b763242f5625

Best regards,
--  
Mark Brown <broonie@kernel.org>


