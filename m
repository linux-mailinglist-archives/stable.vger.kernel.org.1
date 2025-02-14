Return-Path: <stable+bounces-116403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1D5A35C96
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 12:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108A11892010
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 11:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B638263C69;
	Fri, 14 Feb 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9vNBsh7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0E263C65
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532691; cv=none; b=Quf7TcevnAn0DfRuPFlVNhOc8bk3YRH70NxXvoGMYTJ1ryxmoiqeZKtYm/7AbrBT9OzQSKBiF4fyS5dp+M9gmyVuaOvsU57sYfzw14A9XPelibMmywCvlWuAVE4t8Y3sanChv1ksxHUVgbhugIEPjo2NoGSHGNAs/BDzVs89gdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532691; c=relaxed/simple;
	bh=sDJ3GovbUss9aMUaAaOy+550jjRdY4AcEzY/v/nvd1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XLaA8u4c/41sK+Ld2rGQK0Y6faCNyMxnW7ZI4IQ4aWNUuBx/jlgDMwY2s26hWlrxZXPhuQHIwfI+pn14wAzNRdTQ0c3Tu3q2WXKfP1mNiPgH+reMVELp8wX+FJHb0JOyQGTFV3DifBYDRJMNnz1C5j88UqELmPqiU5EKeMq4M4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9vNBsh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AFDC4CEE6;
	Fri, 14 Feb 2025 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739532690;
	bh=sDJ3GovbUss9aMUaAaOy+550jjRdY4AcEzY/v/nvd1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9vNBsh7vVarmOlPFNapX+jgf5rxP+ig9PH5HTI+AXYko96zwnaMqzUuU9YwMOUt+
	 3BQCG8jCi3yVVKu4rLrfz60nCLK9mkBcd51Oifq4gdQfblNQ1Fljvg38AxgM98lAbA
	 OftAzXmlwAYiW2LJlXydcwmk9XyDQibt8I6TQSYCcn1opwukwVK4wt9D4kps909pYt
	 Z5Jc4FqnGvcKFrL0nSPbVF3Eb2QbVRws1d6idxN+3Cq5ZIER+Xu/M6YsJIm4u9c7+w
	 NTj0yp9/R4Z1SxpICIKzEyXNPAy3ks3vi50M9KRxzdBjTCc3jnPExtb417B+SJLc55
	 t7RljixG3IKTQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tituq-00431I-8p;
	Fri, 14 Feb 2025 11:31:28 +0000
From: Marc Zyngier <maz@kernel.org>
To: stable@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	gregkh@linuxfoundation.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 6.6.y] arm64: Filter out SVE hwcaps when FEAT_SVE isn't implemented
Date: Fri, 14 Feb 2025 11:31:20 +0000
Message-Id: <20250214113120.2985535-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <2025021004-lung-polyester-844c@gregkh>
References: <2025021004-lung-polyester-844c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, catalin.marinas@arm.com, broonie@kernel.org, will@kernel.org, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

commit 064737920bdbca86df91b96aed256e88018fef3a upstream.

The hwcaps code that exposes SVE features to userspace only
considers ID_AA64ZFR0_EL1, while this is only valid when
ID_AA64PFR0_EL1.SVE advertises that SVE is actually supported.

The expectations are that when ID_AA64PFR0_EL1.SVE is 0, the
ID_AA64ZFR0_EL1 register is also 0. So far, so good.

Things become a bit more interesting if the HW implements SME.
In this case, a few ID_AA64ZFR0_EL1 fields indicate *SME*
features. And these fields overlap with their SVE interpretations.
But the architecture says that the SME and SVE feature sets must
match, so we're still hunky-dory.

This goes wrong if the HW implements SME, but not SVE. In this
case, we end-up advertising some SVE features to userspace, even
if the HW has none. That's because we never consider whether SVE
is actually implemented. Oh well.

Fix it by restricting all SVE capabilities to ID_AA64PFR0_EL1.SVE
being non-zero. The HWCAPS documentation is amended to reflect the
actually checks performed by the kernel.

Fixes: 06a916feca2b ("arm64: Expose SVE2 features for userspace")
Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org
Reviewed-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20250107-arm64-2024-dpisa-v5-1-7578da51fc3d@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 Documentation/arch/arm64/elf_hwcaps.rst | 36 +++++++++++++++--------
 arch/arm64/kernel/cpufeature.c          | 38 +++++++++++++++++--------
 2 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index 76ff9d7398fda..f88a24d621dd4 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -174,22 +174,28 @@ HWCAP2_DCPODP
     Functionality implied by ID_AA64ISAR1_EL1.DPB == 0b0010.
 
 HWCAP2_SVE2
-    Functionality implied by ID_AA64ZFR0_EL1.SVEVer == 0b0001.
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.SVEver == 0b0001.
 
 HWCAP2_SVEAES
-    Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0001.
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.AES == 0b0001.
 
 HWCAP2_SVEPMULL
-    Functionality implied by ID_AA64ZFR0_EL1.AES == 0b0010.
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.AES == 0b0010.
 
 HWCAP2_SVEBITPERM
-    Functionality implied by ID_AA64ZFR0_EL1.BitPerm == 0b0001.
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.BitPerm == 0b0001.
 
 HWCAP2_SVESHA3
-    Functionality implied by ID_AA64ZFR0_EL1.SHA3 == 0b0001.
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.SHA3 == 0b0001.
 
 HWCAP2_SVESM4
-    Functionality implied by ID_AA64ZFR0_EL1.SM4 == 0b0001.
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.SM4 == 0b0001.
 
 HWCAP2_FLAGM2
     Functionality implied by ID_AA64ISAR0_EL1.TS == 0b0010.
@@ -198,16 +204,20 @@ HWCAP2_FRINT
     Functionality implied by ID_AA64ISAR1_EL1.FRINTTS == 0b0001.
 
 HWCAP2_SVEI8MM
-    Functionality implied by ID_AA64ZFR0_EL1.I8MM == 0b0001.
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.I8MM == 0b0001.
 
 HWCAP2_SVEF32MM
-    Functionality implied by ID_AA64ZFR0_EL1.F32MM == 0b0001.
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.F32MM == 0b0001.
 
 HWCAP2_SVEF64MM
-    Functionality implied by ID_AA64ZFR0_EL1.F64MM == 0b0001.
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.F64MM == 0b0001.
 
 HWCAP2_SVEBF16
-    Functionality implied by ID_AA64ZFR0_EL1.BF16 == 0b0001.
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.BF16 == 0b0001.
 
 HWCAP2_I8MM
     Functionality implied by ID_AA64ISAR1_EL1.I8MM == 0b0001.
@@ -273,7 +283,8 @@ HWCAP2_EBF16
     Functionality implied by ID_AA64ISAR1_EL1.BF16 == 0b0010.
 
 HWCAP2_SVE_EBF16
-    Functionality implied by ID_AA64ZFR0_EL1.BF16 == 0b0010.
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.BF16 == 0b0010.
 
 HWCAP2_CSSC
     Functionality implied by ID_AA64ISAR2_EL1.CSSC == 0b0001.
@@ -282,7 +293,8 @@ HWCAP2_RPRFM
     Functionality implied by ID_AA64ISAR2_EL1.RPRFM == 0b0001.
 
 HWCAP2_SVE2P1
-    Functionality implied by ID_AA64ZFR0_EL1.SVEver == 0b0010.
+    Functionality implied by ID_AA64PFR0_EL1.SVE == 0b0001 and
+    ID_AA64ZFR0_EL1.SVEver == 0b0010.
 
 HWCAP2_SME2
     Functionality implied by ID_AA64SMFR0_EL1.SMEver == 0b0001.
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7e96604559004..82778258855d1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2762,6 +2762,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = match,						\
 	}
 
+#define HWCAP_CAP_MATCH_ID(match, reg, field, min_value, cap_type, cap)		\
+	{									\
+		__HWCAP_CAP(#cap, cap_type, cap)				\
+		HWCAP_CPUID_MATCH(reg, field, min_value) 			\
+		.matches = match,						\
+	}
+
 #ifdef CONFIG_ARM64_PTR_AUTH
 static const struct arm64_cpu_capabilities ptr_auth_hwcap_addr_matches[] = {
 	{
@@ -2790,6 +2797,13 @@ static const struct arm64_cpu_capabilities ptr_auth_hwcap_gen_matches[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_SVE
+static bool has_sve_feature(const struct arm64_cpu_capabilities *cap, int scope)
+{
+	return system_supports_sve() && has_user_cpuid_feature(cap, scope);
+}
+#endif
+
 static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ISAR0_EL1, AES, PMULL, CAP_HWCAP, KERNEL_HWCAP_PMULL),
 	HWCAP_CAP(ID_AA64ISAR0_EL1, AES, AES, CAP_HWCAP, KERNEL_HWCAP_AES),
@@ -2827,18 +2841,18 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64MMFR2_EL1, AT, IMP, CAP_HWCAP, KERNEL_HWCAP_USCAT),
 #ifdef CONFIG_ARM64_SVE
 	HWCAP_CAP(ID_AA64PFR0_EL1, SVE, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, SVEver, SVE2p1, CAP_HWCAP, KERNEL_HWCAP_SVE2P1),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, SVEver, SVE2, CAP_HWCAP, KERNEL_HWCAP_SVE2),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, AES, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEAES),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, AES, PMULL128, CAP_HWCAP, KERNEL_HWCAP_SVEPMULL),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, BitPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBITPERM),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, BF16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBF16),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, BF16, EBF16, CAP_HWCAP, KERNEL_HWCAP_SVE_EBF16),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, SHA3, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESHA3),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, SM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESM4),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, F32MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, F64MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2p1, CAP_HWCAP, KERNEL_HWCAP_SVE2P1),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SVEver, SVE2, CAP_HWCAP, KERNEL_HWCAP_SVE2),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, AES, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEAES),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, AES, PMULL128, CAP_HWCAP, KERNEL_HWCAP_SVEPMULL),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, BitPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBITPERM),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, BF16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBF16),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, BF16, EBF16, CAP_HWCAP, KERNEL_HWCAP_SVE_EBF16),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SHA3, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESHA3),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, SM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESM4),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, F32MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
+	HWCAP_CAP_MATCH_ID(has_sve_feature, ID_AA64ZFR0_EL1, F64MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
 #endif
 	HWCAP_CAP(ID_AA64PFR1_EL1, SSBS, SSBS2, CAP_HWCAP, KERNEL_HWCAP_SSBS),
 #ifdef CONFIG_ARM64_BTI
-- 
2.39.2


