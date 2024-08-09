Return-Path: <stable+bounces-66292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EB494D841
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 22:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC1228658F
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 20:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DA61607BB;
	Fri,  9 Aug 2024 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiQTHIA/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAA224EA;
	Fri,  9 Aug 2024 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723236831; cv=none; b=N1eRz4LfTGwppIHtfKOD+WhTxKL88eRa9ITqZm26S+GlIfCG/Te1KN/uwWGHkr0yvhKf9K4QmhCZvIMwiIHJWbkEfbL97SnyVgaf5UvFR1b2r9ouV/8xfM3wOkfEtJCIOb4jn0W9SeziqP9+snf+2kyOl4Qu5qiY2D77QA+ceZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723236831; c=relaxed/simple;
	bh=ZIMEfbMse5Kndw/a02Y5MBWAE2vLVNaepF1FjPorpSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UCl95hXGBKvl5W4zESerILrVSPhyJCOavcElSrscsQee68JMnMKzpN/tuT+4Z5zIsDIRb3Gt3XpwK/ACSV66DgCOh2pzl12/V26v9paORieUn874/Y1G1Mn8+Hu6SBYd6jLUVrR33rLM9l8hxg2vzcToVWEXwanq+i4G3Go2w7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiQTHIA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC099C32782;
	Fri,  9 Aug 2024 20:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723236830;
	bh=ZIMEfbMse5Kndw/a02Y5MBWAE2vLVNaepF1FjPorpSA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=WiQTHIA/p5g5ya7WJizMp+KXdJfC0vDhRi+N51hgU9QU3VMVWEbRUfUtacwbNZN4F
	 5I7srq3LYCBdGZtmPbQqubgzjBckgDvoBpDxyWhYFg/IPG8skcRa8bYrMX1tz1XdFD
	 nuhnWKolxNq27vZozmDTuM8nuUeGpQ+fhj3wQIF6Qyh8jTVmSuMCG6ZxI5nqMEFPGb
	 NU2OlyEDaDoeZvQECA6wvDKhUfoffi/QT6bxRvGUpt1oXSGYGykjGBac+B/RRZqJY/
	 QY2EG+gVPht5Y+Cn30Cbezj8KuCp/asu3yVeBz7F53M11brTcn6Bp1frZkLlgrs531
	 BPK387giv/QYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2BEC3DA4A;
	Fri,  9 Aug 2024 20:53:50 +0000 (UTC)
From: Mitchell Levy via B4 Relay <devnull+levymitchell0.gmail.com@kernel.org>
Date: Fri, 09 Aug 2024 13:53:36 -0700
Subject: [PATCH v2] x86/fpu: Avoid writing LBR bit to IA32_XSS unless
 supported
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-xsave-lbr-fix-v2-1-04296b387380@gmail.com>
X-B4-Tracking: v=1; b=H4sIANCBtmYC/13MywrCMBCF4Vcps3Ykmd6CK99DuojptB3ojURCp
 fTdjQU3Lv8D59shsBcOcMt28BwlyDKnoEsGbrBzzyhtaiBFhTKqxi3YyDg+PXayoaK2pK4qdFX
 mkD6r5zSf3qNJPUh4Lf598lF/159k/qSoUaMlyo2qnMm5vveTlfHqlgma4zg+lA3cSqoAAAA=
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: stable@vger.kernel.org, Borislav Petkov <bp@suse.de>, 
 linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>, 
 Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723236831; l=3984;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=1mvumyyfM+T6h2ewfJ+FZwUTLm/pkb+WrwYbpjJNIPk=;
 b=MKEPIaOCzrdRRxZXjPrvsVQCyCYrjmhNdRoZ5IBNrvtBa9R7zjLkZKFdfjyCwqtKFdBJTU6cG
 uk+8Qiof9MMB96E5vULi0J6PicG/NpE66lIiBc3YCHO68ctxl+PjOb7
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=
X-Endpoint-Received: by B4 Relay for levymitchell0@gmail.com/20240719 with
 auth_id=188
X-Original-From: Mitchell Levy <levymitchell0@gmail.com>
Reply-To: levymitchell0@gmail.com

From: Mitchell Levy <levymitchell0@gmail.com>

When computing which xfeatures are available, make sure that LBR is only
present if both LBR is supported in general, as well as by XSAVES.

There are two distinct CPU features related to the use of XSAVES as it
applies to LBR: whether LBR is itself supported (strictly speaking, I'm
not sure that this is necessary to check though it's certainly a good
sanity check), and whether XSAVES supports LBR (see sections 13.2 and
13.5.12 of the Intel 64 and IA-32 Architectures Software Developer's
Manual, Volume 1). Currently, the LBR subsystem correctly checks both
(see intel_pmu_arch_lbr_init), however the xstate initialization
subsystem does not.

When calculating what value to place in the IA32_XSS MSR,
xfeatures_mask_independent only checks whether LBR support is present,
not whether XSAVES supports LBR. If XSAVES does not support LBR, this
write causes #GP, leaving the state of IA32_XSS unchanged (i.e., set to
zero, as its not written with other values, and its default value is
zero out of RESET per section 13.3 of the arch manual).

Then, the next time XRSTORS is used to restore supervisor state, it will
fail with #GP (because the RFBM has zero for all supervisor features,
which does not match the XCOMP_BV field). In particular,
XFEATURE_MASK_FPSTATE includes supervisor features, so setting up the FPU
will cause a #GP. This results in a call to fpu_reset_from_exception_fixup,
which by the same process results in another #GP. Eventually this causes
the kernel to run out of stack space and #DF.

Fixes: f0dccc9da4c0 ("x86/fpu/xstate: Support dynamic supervisor feature for LBR")
Cc: stable@vger.kernel.org

Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
Changes in v2:
- Corrected Fixes tag (thanks tglx)
- Properly check for XSAVES support of LBR (thanks tglx)
- Link to v1: https://lore.kernel.org/r/20240808-xsave-lbr-fix-v1-1-a223806c83e7@gmail.com
---
 arch/x86/include/asm/fpu/types.h | 7 +++++++
 arch/x86/kernel/fpu/xstate.c     | 3 +++
 arch/x86/kernel/fpu/xstate.h     | 4 ++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index eb17f31b06d2..de16862bf230 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -591,6 +591,13 @@ struct fpu_state_config {
 	 * even without XSAVE support, i.e. legacy features FP + SSE
 	 */
 	u64 legacy_features;
+	/*
+	 * @independent_features:
+	 *
+	 * Features that are supported by XSAVES, but not managed as part of
+	 * the FPU core, such as LBR
+	 */
+	u64 independent_features;
 };
 
 /* FPU state configuration information */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c5a026fee5e0..1339f8328db5 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -788,6 +788,9 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 	}
 
+	fpu_kernel_cfg.independent_features = fpu_kernel_cfg.max_features &
+					      XFEATURE_MASK_INDEPENDENT;
+
 	/*
 	 * Clear XSAVE features that are disabled in the normal CPUID.
 	 */
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 2ee0b9c53dcc..afb404cd2059 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -62,9 +62,9 @@ static inline u64 xfeatures_mask_supervisor(void)
 static inline u64 xfeatures_mask_independent(void)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
+		return fpu_kernel_cfg.independent_features & ~XFEATURE_MASK_LBR;
 
-	return XFEATURE_MASK_INDEPENDENT;
+	return fpu_kernel_cfg.independent_features;
 }
 
 /* XSAVE/XRSTOR wrapper functions */

---
base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
change-id: 20240807-xsave-lbr-fix-02d52f641653

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>



