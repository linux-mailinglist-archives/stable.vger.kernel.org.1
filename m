Return-Path: <stable+bounces-146125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE29AC159E
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 22:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCB44A188A
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99A52417EF;
	Thu, 22 May 2025 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NfI0zkTp"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69329241CA4
	for <stable@vger.kernel.org>; Thu, 22 May 2025 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747946568; cv=none; b=gRF0bN4+gZAp4TTk0EM1HXYRblfIpJus2qVI2SEPwbW6J0hxCiOApvhULmAPikOGDoFmzosVH3ZdtLuh5vyNTYkzCGEshMSGswYiK91k8OyfVIJWejNjCz+gyEnAPzVkgWZmqtKE6PQtPsM/i9Y99BncrCDEmQnenBBKYsLYAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747946568; c=relaxed/simple;
	bh=DajyzcMwNtkzou3lWjw64zqnbU70NyWsQMFg1fxZOC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T2sIHDUgLJoW0vurmL9GrCKkaqzRVuB+LrjzfumuR2fHCcVyMbedT1qzZ3Z9t4icMGvJRPvmX643aAaBngsNBzoMMjBCPzyeH80KLzFf+XrqvK1uv/1VQSX5OO8wrqnY1IYAB+Q4Nuts7SkkskO8hLw3x1AI6F2ZDoRVdH1V9y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NfI0zkTp; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747946562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Lcmz2b2wSBLp1++UV6kYxaG0Vo4vr1rEmMZnQRdpssM=;
	b=NfI0zkTpxFo4zF2V9xvSZwmIlzpsN46mruuvPZv1/29WcudYO2GPcTA1g07gX4gXts5xqn
	WO5dKG2NG4tULaDe6iMWMB3eqmMnwmEDFGQG0iseHOhl3ybzSDKjVNSzCBapdADsIw0ex+
	tvHO5wXETqH7HCJV4Vced+Gk7iH9lSs=
From: Oliver Upton <oliver.upton@linux.dev>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Mingwei Zhang <mizhang@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: Add MIDR-based check for FEAT_ECBHB
Date: Thu, 22 May 2025 13:41:48 -0700
Message-Id: <20250522204148.4007406-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Prior to commit e8cde32f111f ("arm64/cpufeatures/kvm: Add ARMv8.9
FEAT_ECBHB bits in ID_AA64MMFR1 register") KVM was erroneously masking
FEAT_ECBHB from VMs, giving the perception that safe implementations are
actually vulnerable to Spectre-BHB. And, after commit e403e8538359
("arm64: errata: Assume that unknown CPUs _are_ vulnerable to Spectre
BHB") guests are enabling the loop mitigation.

This broken virtual hardware is going to be around for some time, so do
the ugly thing and check for revisions of Neoverse-V2 [1], Cortex-X3 [2],
Cortex-A720 [3], and Neoverse-N3 [4] that are documented to have FEAT_ECBHB.

Cc: stable@vger.kernel.org
Link: https://developer.arm.com/documentation/102375/0002
Link: https://developer.arm.com/documentation/101593/0102
Link: https://developer.arm.com/documentation/102530/0002
Link: https://developer.arm.com/documentation/107997/0001
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---

I thoroughly hate this but the alternative of nuking these busted VMs
isn't exactly popular...

 arch/arm64/include/asm/cputype.h |  1 +
 arch/arm64/kernel/proton-pack.c  | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index d1cc0571798b..5c6152e61cad 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -282,6 +282,7 @@ struct midr_range {
 #define MIDR_REV_RANGE(m, v, r_min, r_max) MIDR_RANGE(m, v, r_min, v, r_max)
 #define MIDR_REV(m, v, r) MIDR_RANGE(m, v, r, v, r)
 #define MIDR_ALL_VERSIONS(m) MIDR_RANGE(m, 0, 0, 0xf, 0xf)
+#define MIDR_MIN_VERSION(m, v, r) MIDR_RANGE(m, v, r, 0xf, 0xf)
 
 static inline bool midr_is_cpu_model_range(u32 midr, u32 model, u32 rv_min,
 					   u32 rv_max)
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index b198dde79e59..3d00d4c22d58 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -962,8 +962,24 @@ static bool has_spectre_bhb_fw_mitigation(void)
 
 static bool supports_ecbhb(int scope)
 {
+	static const struct midr_range spectre_ecbhb_list[] = {
+		MIDR_MIN_VERSION(MIDR_NEOVERSE_V2, 0, 2),
+		MIDR_MIN_VERSION(MIDR_CORTEX_X3, 1, 1),
+		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N3),
+		MIDR_MIN_VERSION(MIDR_CORTEX_A720, 0, 1),
+		{},
+	};
 	u64 mmfr1;
 
+	/*
+	 * Prior to commit e8cde32f111f ("arm64/cpufeatures/kvm: Add ARMv8.9
+	 * FEAT_ECBHB bits in ID_AA64MMFR1 register"), KVM masked FEAT_ECBHB
+	 * on implementations that actually have the feature. That sucks; infer
+	 * presence of FEAT_ECBHB based on MIDR.
+	 */
+	if (is_midr_in_range_list(spectre_ecbhb_list))
+		return true;
+
 	if (scope == SCOPE_LOCAL_CPU)
 		mmfr1 = read_sysreg_s(SYS_ID_AA64MMFR1_EL1);
 	else

base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
-- 
2.39.5


