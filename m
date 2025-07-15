Return-Path: <stable+bounces-161974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375FAB05AAB
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBA03A87EE
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 12:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB772D9795;
	Tue, 15 Jul 2025 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdeMibKp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBE51B043A;
	Tue, 15 Jul 2025 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584091; cv=none; b=gKVd5dClLUjRmwDZb5F6gMRfuI45gwr/JJYhS18brzgIS1/TPtqKHjR/ADYviFYT+0tO41ya3w5qMgTV9jIlPhA6I68+Yt/5OZMqbmcin57uyLHbkvgKWMq0GmRYcAE5K5afjKEbGkCTKlLeMJ8puk7OUaA+Il9SYJwb7Vj14Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584091; c=relaxed/simple;
	bh=5O2Y0BxfJj/Qqa+KlWHCOfUSGCTb2wf1Q/PPcxWsLNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aezfhPoeGdUWpWrVygZ7xhNYEtQlX2kOkFmwdagFdxvPxOc9iAPyR9l3ioj5Vuda+qVjTCnVSfs9IhuNojVGeBO/GidoJNDYjgKoY/INu6ol70RDq7IUm33pYnXJEqOdSfNlmMx22UOpA4co6VS6WiY71SdLJ/dmn0o/t4S5UUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdeMibKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3D2C4CEE3;
	Tue, 15 Jul 2025 12:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752584091;
	bh=5O2Y0BxfJj/Qqa+KlWHCOfUSGCTb2wf1Q/PPcxWsLNQ=;
	h=From:Date:Subject:To:Cc:From;
	b=fdeMibKpUPuMEbjx+PEeY1R4c9jWFe4K7jkPjT8DBRXAuDpuJ8ytPLwG8z9HAsGJY
	 N9X8S8Oevdse7sq4rOiSOHyHlOzv+tuTudJ6iqVrhsl4Go/ngGGWsWPrxEasPUzA10
	 AeNGE7cRocUJGamAPTr8ID60gm52hiObYOEdS0+SuGIOmbPSrWF8iaatp66j6nJxdX
	 pXRqIBBNZCzlvI0n/CEEy4pn6o9G69vEbD7E3pIxOj1jmvmVLlEAqq1wKOKU/IvY5o
	 RbBpapAzRFc/AqOpIX7AbdzFCUCoIQ+zptMzJFzNxWhQFRI8Y1luHqGQyW2tChzPm0
	 O/53OfPAu7mpA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 15 Jul 2025 13:49:23 +0100
Subject: [PATCH 6.12.y] arm64: Filter out SME hwcaps when FEAT_SME isn't
 implemented
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-stable-6-12-sme-feat-filt-v1-1-4c1d9c0336f6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFJOdmgC/x3MywqDMBBG4VeRWXckCV5CX6W4SPVPHbC2ZIJYx
 Hc3dPktzjlIkQRK9+qghE1UPmuBvVU0zmF9gWUqJmdca3rbsObwXMAdW8f6BkeEzFGWzB6tjyb
 40fiJSv9NiLL/3w/qauvqHw3neQHrmRN/cwAAAA==
X-Change-ID: 20250714-stable-6-12-sme-feat-filt-8e58f0a8c08d
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, stable@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yury Khrustalev <yury.khrustalev@arm.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=6158; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5O2Y0BxfJj/Qqa+KlWHCOfUSGCTb2wf1Q/PPcxWsLNQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBodk+YkBXzyFKccbuiUAxu1S/zl9ZiQCEz6djVo
 nGb2kewGs2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaHZPmAAKCRAk1otyXVSH
 0PWZB/4g+LvxhS1jnDuGNU/QzflvEeUEy4YKtQenEQ2k/wJh5b7rAorEKXu9JSku7z0bPWsD7ay
 omzfSzB3tqFTZgICGHB/uOAJ8fimjUrZ/Fkj8dJiPUOmxZOyhclviGfnklOhZC8OSxhf5/Vs6AK
 q7tsAW+fxRXcfkoP0hUrxW1mh/yBgvQDiHe6OGWiA8hf2Rki2Mf6vKlQ1lmdHhfVeEb+OdFNz78
 uMRw4/lBRXG69kmaP7kdziOCWg38tGwjGm+rel4rUIREkBaMNxcSdwyRfRlCqaqe4gGoX7BSQPy
 4GAbu5HepHKXWGfWpOBnNsfxhIwpNYwH4VCdnTgxBj4BwkyE
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
---
 arch/arm64/kernel/cpufeature.c | 45 ++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 05ccf4ec278f..9ca5ffd8d817 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2959,6 +2959,13 @@ static bool has_sve_feature(const struct arm64_cpu_capabilities *cap, int scope)
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
@@ -3037,25 +3044,25 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ISAR2_EL1, BC, IMP, CAP_HWCAP, KERNEL_HWCAP_HBC),
 #ifdef CONFIG_ARM64_SME
 	HWCAP_CAP(ID_AA64PFR1_EL1, SME, IMP, CAP_HWCAP, KERNEL_HWCAP_SME),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, FA64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
-	HWCAP_CAP(ID_AA64SMFR0_EL1, LUTv2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_LUTV2),
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
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, FA64, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_FA64),
+	HWCAP_CAP_MATCH_ID(has_sme_feature, ID_AA64SMFR0_EL1, LUTv2, IMP, CAP_HWCAP, KERNEL_HWCAP_SME_LUTV2),
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
 #endif /* CONFIG_ARM64_SME */
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8CVT, IMP, CAP_HWCAP, KERNEL_HWCAP_F8CVT),
 	HWCAP_CAP(ID_AA64FPFR0_EL1, F8FMA, IMP, CAP_HWCAP, KERNEL_HWCAP_F8FMA),

---
base-commit: fbad404f04d758c52bae79ca20d0e7fe5fef91d3
change-id: 20250714-stable-6-12-sme-feat-filt-8e58f0a8c08d

Best regards,
--  
Mark Brown <broonie@kernel.org>


