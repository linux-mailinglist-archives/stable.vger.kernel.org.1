Return-Path: <stable+bounces-163141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A91B076B3
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 15:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1419D1C22E63
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 13:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F38199E89;
	Wed, 16 Jul 2025 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADK5pPO2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E40954673;
	Wed, 16 Jul 2025 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671840; cv=none; b=eZ0ShrVN5A3ZaaqyA63Vei/PUopelg2z/y410weihhK+BaVKPdEejUCAuviVZInkJxAy4DE3UP+7RpSjpJTsYjndwBT7G5mhGrDjw1kneDV3m6eVu1io7hFxO+fadeWipIhRc7+DnfH46aGJpHiFwFT90C769GlQV2kZ8QiX/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671840; c=relaxed/simple;
	bh=r06vB+o6n5DzzNy6Vxt3fTI22jXwX0V/KZVy/iAXAG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QDlnsKtFz3G4fbSr9MVoQiDGPSLjcODbsvPwVvp6t0x2G81lKzsTO+erSfjGJDKqHX3c0SWRxCc0E2/W5nxrsMr6iqFAj25230qdpPaBlH7Ai15B04cW+hGelFzR68O9yFvJ8orAb6vx2MEKcvftuKSp3kFWQJJmtNi6c31hyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADK5pPO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE3DC4CEF0;
	Wed, 16 Jul 2025 13:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752671840;
	bh=r06vB+o6n5DzzNy6Vxt3fTI22jXwX0V/KZVy/iAXAG4=;
	h=From:Date:Subject:To:Cc:From;
	b=ADK5pPO286DOVrzlh/FIcBydXj8sM/hNc9i0fVqeMd66JBYxjrp09jDkF/KGFS6tT
	 Hu4dVn4kCd37QyC25XPngqpPb7a1QkvocaKOSOTY9LdlNLe2WaTxzWSxbg67NYdLxw
	 jql2i6tBUOdDuJlZbzpTpNLbF/3ciU1g+fg+NHdTFg9UwpB1masRaq9fbKg5wFRhBQ
	 yynC0zCJsYERfHPfPSDyVm8dDZ14AoXjAjhLkIJOTLMgYUYxtW3iZYKlGZPXTGT5cU
	 Z6uMPjqu/+oKmWnB3CEV4mFZ+ckCeP8fC4puiA9XYBT6nTxMtAhfxXaQfRORQ6XcRX
	 2L0jKFyouZckg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 16 Jul 2025 14:08:27 +0100
Subject: [PATCH 6.6.y] arm64: Filter out SME hwcaps when FEAT_SME isn't
 implemented
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-stable-6-6-sme-feat-filt-v1-1-151d319dc41e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEukd2gC/x2MwQ6CMBAFf4Xs2SVtQ4v4K4RD1VfdBNB0G6Ih/
 LuNmdMcZnZSZIHSpdkpYxOV11rFnhq6PeP6AMu9OjnjvOmtZy3xOoNDRRdwQiycZC7sMXSu68/
 W+EQ1f2ck+fzXI4U2tF+ajuMHomQWkXEAAAA=
X-Change-ID: 20250715-stable-6-6-sme-feat-filt-5e942478105f
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, stable@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yury Khrustalev <yury.khrustalev@arm.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=5113; i=broonie@kernel.org;
 h=from:subject:message-id; bh=r06vB+o6n5DzzNy6Vxt3fTI22jXwX0V/KZVy/iAXAG4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBod6ZdYfddNKzn0owWDLlwsYgqjUnj9ZX+RM4An
 YJCnIX20e2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaHemXQAKCRAk1otyXVSH
 0A3OB/sHnmOYNEc+uijXErFaUB4i+F2vgcQaQCOhhXjnY/WaBkJMRObMPMTS9GiY0GV7xoYtCOn
 wTjsdPDImfmORLFe78Eez1+2K1Ye9zyYLWGjqN82qH6XEjD+mgCM0qFylJwGGwSNua7qlifc3Ov
 gulq+yKMI3ENME7eqijBgZfTLVp/n6xSw0wDyRC4h6SQavx8YSQ4+nnZLiYKqw4CAmikoO5K5ve
 0+06hAlMsq5Am985c+RMDUqd6MnhmfS6jYcz/lNRCFr5+4AH5Stue1fO0K9UheTTt3wyXO5vZ4K
 lRkp7WoJDYVU4X6IjeXoFHCQKP11XUaoF/Gk+PgNO/AjbpwG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

[ Upstream commit a75ad2fc76a2ab70817c7eed3163b66ea84ca6ac ]

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
Link: https://lore.kernel.org/r/20250620-arm64-sme-filter-hwcaps-v1-1-02b9d3c2d8ef@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 82778258855d..b6d381f743f3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2804,6 +2804,13 @@ static bool has_sve_feature(const struct arm64_cpu_capabilities *cap, int scope)
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
@@ -2875,20 +2882,20 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ISAR2_EL1, MOPS, IMP, CAP_HWCAP, KERNEL_HWCAP_MOPS),
 	HWCAP_CAP(ID_AA64ISAR2_EL1, BC, IMP, CAP_HWCAP, KERNEL_HWCAP_HBC),
 #ifdef CONFIG_ARM64_SME
-	HWCAP_CAP(ID_AA64PFR1_EL1, SME, IMP, CAP_HWCAP, KERNEL_HWCAP_SME),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, FA64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2p1, CAP_HWCAP, KERNEL_HWCAP_SME2P1),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, SMEver, SME2, CAP_HWCAP, KERNEL_HWCAP_SME2),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, I16I64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F64F64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F64F64),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, I16I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16B16),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F16F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F16),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, I8I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, B16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16F32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, BI32I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_BI32I32),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, F32F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F32F32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64PFR1_EL1, SME, IMP, CAP_HWCAP, KERNEL_HWCAP_SME),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, FA64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SMEver, SME2p1, CAP_HWCAP, KERNEL_HWCAP_SME2P1),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, SMEver, SME2, CAP_HWCAP, KERNEL_HWCAP_SME2),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, I16I64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I64),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F64F64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F64F64),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, I16I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I16I32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16B16),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F16F16, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F16),
+	HWCAP_CAP(ID_MATCH_ID(has_sme_feature, AA64SMFR0_EL1, I8I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_I8I32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F16F32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, B16F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_B16F32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, BI32I32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_BI32I32),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, F32F32, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_F32F32),
 #endif /* CONFIG_ARM64_SME */
 	{},
 };

---
base-commit: 9247f4e6573a4d05fe70c3e90dbd53da26e8c5cb
change-id: 20250715-stable-6-6-sme-feat-filt-5e942478105f

Best regards,
--  
Mark Brown <broonie@kernel.org>


