Return-Path: <stable+bounces-106695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BB6A00A84
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 15:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED0A3A1FFB
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 14:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99BA1FA8C7;
	Fri,  3 Jan 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pm+pXBh7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C91FA851
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735914407; cv=none; b=o6K0SHeF5tQOi9qvwjYU2uxaPTXHW6b9XoGsIbzt6jQrSCKF4NObKHrZbMUdt7HfVkBXliVB6StTFYNCFhwwOthS4lmPAwnrIFwyP2kgPxGJVSBARQrFFKONME/t1hC7NMNOrt6YLq7MmCkcJf1yb0RA+ioZXiUgPh5KUPPUUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735914407; c=relaxed/simple;
	bh=3SSf2lU8RqANspOD06SsPV0f6XpSiVxM2RGnP/oeW5c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ikamO2VidxLSlUlGJqO4swhjIyyYzi56rETjBpCGUSj1wE3gTQBUjTjONH+2oOXhquT6XHbrCt/NTjJweUFPxAsoNQ2flFMawW6nJrz7Q8I7UZs6pj+U24dqgWsmD1XX2+a/ldyOG9c9sj6SMdlkXZmbrCseqNyAFyqMipeDeAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pm+pXBh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19FDC4CECE;
	Fri,  3 Jan 2025 14:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735914406;
	bh=3SSf2lU8RqANspOD06SsPV0f6XpSiVxM2RGnP/oeW5c=;
	h=From:To:Cc:Subject:Date:From;
	b=Pm+pXBh7ynVMSryhfDQ9BjxlyGbnc1XzzJK0pJ4QWpDKoNpnwizA9fF5lcluf6uMF
	 oYwThz75X3LKmfBTpiGakn0Tpl+ZEwGwM6eqZ/SKEyE0IZCZ+LnXOFTP3AlPm7cRZM
	 lfso1udoxaW0YlU41wLbCb2U5AfRP8TmPuo6yLBbkWqpOvemxhoN1dM+CALZsk/17O
	 5JniedJB+ylrCJVjlsoIv6ohMBe2z3NlhAE7Mynjpvg6AK4e/AjI6ZBWcXJe0+b+Tz
	 S/xdaDlBUSUhzA60/n6RzdZ8Bsr1lznkG2GznU7XAdk+KCFmoEO0FdLfUoOwjh0Z9i
	 AlJ/Fa/ffok2w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tTidQ-008iZ8-KQ;
	Fri, 03 Jan 2025 14:26:44 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: Filter out SVE hwcaps when FEAT_SVE isn't implemented
Date: Fri,  3 Jan 2025 14:26:35 +0000
Message-Id: <20250103142635.1759674-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, broonie@kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

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
being non-zero.

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/cpufeature.c | 58 ++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6ce71f444ed84..d793ca08549cd 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1593,14 +1593,19 @@ feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 	return val >= min && val <= max;
 }
 
-static u64
-read_scoped_sysreg(const struct arm64_cpu_capabilities *entry, int scope)
+static u64 __read_scoped_sysreg(u64 reg, int scope)
 {
 	WARN_ON(scope == SCOPE_LOCAL_CPU && preemptible());
 	if (scope == SCOPE_SYSTEM)
-		return read_sanitised_ftr_reg(entry->sys_reg);
+		return read_sanitised_ftr_reg(reg);
 	else
-		return __read_sysreg_by_encoding(entry->sys_reg);
+		return __read_sysreg_by_encoding(reg);
+}
+
+static u64
+read_scoped_sysreg(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	return __read_scoped_sysreg(entry->sys_reg, scope);
 }
 
 static bool
@@ -3022,6 +3027,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
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
@@ -3050,6 +3062,18 @@ static const struct arm64_cpu_capabilities ptr_auth_hwcap_gen_matches[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_SVE
+static bool has_sve(const struct arm64_cpu_capabilities *cap, int scope)
+{
+	u64 aa64pfr0 = __read_scoped_sysreg(SYS_ID_AA64PFR0_EL1, scope);
+
+	if (FIELD_GET(ID_AA64PFR0_EL1_SVE, aa64pfr0) < ID_AA64PFR0_EL1_SVE_IMP)
+		return false;
+
+	return has_user_cpuid_feature(cap, scope);
+}
+#endif
+
 static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ISAR0_EL1, AES, PMULL, CAP_HWCAP, KERNEL_HWCAP_PMULL),
 	HWCAP_CAP(ID_AA64ISAR0_EL1, AES, AES, CAP_HWCAP, KERNEL_HWCAP_AES),
@@ -3092,19 +3116,19 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64MMFR2_EL1, AT, IMP, CAP_HWCAP, KERNEL_HWCAP_USCAT),
 #ifdef CONFIG_ARM64_SVE
 	HWCAP_CAP(ID_AA64PFR0_EL1, SVE, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, SVEver, SVE2p1, CAP_HWCAP, KERNEL_HWCAP_SVE2P1),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, SVEver, SVE2, CAP_HWCAP, KERNEL_HWCAP_SVE2),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, AES, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEAES),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, AES, PMULL128, CAP_HWCAP, KERNEL_HWCAP_SVEPMULL),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, BitPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBITPERM),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE_B16B16),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, BF16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBF16),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, BF16, EBF16, CAP_HWCAP, KERNEL_HWCAP_SVE_EBF16),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, SHA3, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESHA3),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, SM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESM4),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, F32MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
-	HWCAP_CAP(ID_AA64ZFR0_EL1, F64MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
+	HWCAP_CAP_MATCH_ID(has_sve, ID_AA64ZFR0_EL1, SVEver, SVE2p1, CAP_HWCAP, KERNEL_HWCAP_SVE2P1),
+	HWCAP_CAP_MATCH_ID(has_sve, ID_AA64ZFR0_EL1, SVEver, SVE2, CAP_HWCAP, KERNEL_HWCAP_SVE2),
+	HWCAP_CAP_MATCH_ID(has_sve, ID_AA64ZFR0_EL1, AES, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEAES),
+	HWCAP_CAP_MATCH_ID(has_sve, ID_AA64ZFR0_EL1, AES, PMULL128, CAP_HWCAP, KERNEL_HWCAP_SVEPMULL),
+	HWCAP_CAP_MATCH_ID(has_sve, ID_AA64ZFR0_EL1, BitPerm, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBITPERM),
+	HWCAP_CAP_MATCH_ID(has_sve, ID_AA64ZFR0_EL1, B16B16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVE_B16B16),
+	HWCAP_CAP_MATCH_ID(has_sve, ID_AA64ZFR0_EL1, BF16, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEBF16),
+	HWCAP_CAP_MATCH_ID(has_sve, ID_AA64ZFR0_EL1, BF16, EBF16, CAP_HWCAP, KERNEL_HWCAP_SVE_EBF16),
+	HWCAP_CAP_MATCH_ID(has_sve, ID_AA64ZFR0_EL1, SHA3, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESHA3),
+	HWCAP_CAP_MATCH_ID(has_sve, ID_AA64ZFR0_EL1, SM4, IMP, CAP_HWCAP, KERNEL_HWCAP_SVESM4),
+	HWCAP_CAP_MATCH_ID(has_sve, ID_AA64ZFR0_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
+	HWCAP_CAP_MATCH_ID(has_sve, ID_AA64ZFR0_EL1, F32MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
+	HWCAP_CAP_MATCH_ID(has_sve, ID_AA64ZFR0_EL1, F64MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
 #endif
 #ifdef CONFIG_ARM64_GCS
 	HWCAP_CAP(ID_AA64PFR1_EL1, GCS, IMP, CAP_HWCAP, KERNEL_HWCAP_GCS),
-- 
2.39.2


