Return-Path: <stable+bounces-143879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BE2AB42F9
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F6517B242B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD1D297B9D;
	Mon, 12 May 2025 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VivvJ8nm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A50297B98;
	Mon, 12 May 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073164; cv=none; b=GPNfjBjOygonpl87gRPd1NMjKjC1GvpIkfTCzrKt++TArLW8fXBejebAPSCyfT0VfFLC9Gb0sKyPLFC3tmmVqnbqp6RrweG/Y0E+irgZ2YX2sWNR/gg/ycnuAzk4n9Ndw757YLiTbxqLFa/0Wa8QXKdKAf5/pZxn+O4nxw7IEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073164; c=relaxed/simple;
	bh=535LT4D28EcoXSAH9ycrDdWyY8R2BaIy/6S81dpahQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgXheZ3uXLXm8NfmIf+7BzJDGGoYnllvlvKYhztnwQRi2taovxOodj+DkA4Dg4ySc4CUoqZVc6NZAcCYM0Cu2bT7APnFleLV2hf6tfFZITat/HxYzNjAQzRxhTMOdugjbHMgtOm+L+R56imusP/r4GgclHNilHFyFaDXyEKz2/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VivvJ8nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191DDC4CEE9;
	Mon, 12 May 2025 18:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747073163;
	bh=535LT4D28EcoXSAH9ycrDdWyY8R2BaIy/6S81dpahQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VivvJ8nmFjJtNbqtWco6kb7wQVyRGbWsh44ezza+uzORpyC8w0CUz6awpqYw0XoF6
	 PtPPMIsB/RtBJtsoH3v/LONJ4pKaCpJKk+dPegnHC2Jav8Pb26Dq7XAk3qP83SIRb2
	 zkSvp5SQ9Xh9S2VqiXVwXWKct6170PwbPtMGevC0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 6.12 175/184] x86/its: Enumerate Indirect Target Selection (ITS) bug
Date: Mon, 12 May 2025 19:46:16 +0200
Message-ID: <20250512172048.934216975@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
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

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit 159013a7ca18c271ff64192deb62a689b622d860 upstream.

ITS bug in some pre-Alderlake Intel CPUs may allow indirect branches in the
first half of a cache line get predicted to a target of a branch located in
the second half of the cache line.

Set X86_BUG_ITS on affected CPUs. Mitigation to follow in later commits.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    1 
 arch/x86/include/asm/msr-index.h   |    8 +++++
 arch/x86/kernel/cpu/common.c       |   58 +++++++++++++++++++++++++++++--------
 arch/x86/kvm/x86.c                 |    4 +-
 4 files changed, 58 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -526,4 +526,5 @@
 #define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
 #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* "bhi" CPU is affected by Branch History Injection */
 #define X86_BUG_IBPB_NO_RET	   	X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
+#define X86_BUG_ITS			X86_BUG(1*32 + 5) /* "its" CPU is affected by Indirect Target Selection */
 #endif /* _ASM_X86_CPUFEATURES_H */
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -209,6 +209,14 @@
 						 * VERW clears CPU Register
 						 * File.
 						 */
+#define ARCH_CAP_ITS_NO			BIT_ULL(62) /*
+						     * Not susceptible to
+						     * Indirect Target Selection.
+						     * This bit is not set by
+						     * HW, but is synthesized by
+						     * VMMs for guests to know
+						     * their affected status.
+						     */
 
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1228,6 +1228,8 @@ static const __initconst struct x86_cpu_
 #define GDS		BIT(6)
 /* CPU is affected by Register File Data Sampling */
 #define RFDS		BIT(7)
+/* CPU is affected by Indirect Target Selection */
+#define ITS		BIT(8)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(INTEL_IVYBRIDGE,		X86_STEPPING_ANY,		SRBDS),
@@ -1239,22 +1241,25 @@ static const struct x86_cpu_id cpu_vuln_
 	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_G,	X86_STEPPING_ANY,		SRBDS),
 	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
 	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_X,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_X,		X86_STEPPINGS(0x0, 0x5),	MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_X,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS),
 	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_L,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
 	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE_L,	X86_STEPPINGS(0x0, 0xb),	MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | ITS),
+	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE,		X86_STEPPINGS(0x0, 0xc),	MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | ITS),
 	VULNBL_INTEL_STEPPINGS(INTEL_CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_L,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_D,		X86_STEPPING_ANY,		MMIO | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_X,		X86_STEPPING_ANY,		MMIO | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE_L,	X86_STEPPING_ANY,		GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE,		X86_STEPPING_ANY,		GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_L,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_D,		X86_STEPPING_ANY,		MMIO | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_X,		X86_STEPPING_ANY,		MMIO | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED | ITS),
+	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE_L,	X86_STEPPING_ANY,		GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE,		X86_STEPPING_ANY,		GDS | ITS),
 	VULNBL_INTEL_STEPPINGS(INTEL_LAKEFIELD,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS),
 	VULNBL_INTEL_STEPPINGS(INTEL_ALDERLAKE,		X86_STEPPING_ANY,		RFDS),
 	VULNBL_INTEL_STEPPINGS(INTEL_ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
 	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
@@ -1318,6 +1323,32 @@ static bool __init vulnerable_to_rfds(u6
 	return cpu_matches(cpu_vuln_blacklist, RFDS);
 }
 
+static bool __init vulnerable_to_its(u64 x86_arch_cap_msr)
+{
+	/* The "immunity" bit trumps everything else: */
+	if (x86_arch_cap_msr & ARCH_CAP_ITS_NO)
+		return false;
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return false;
+
+	/* None of the affected CPUs have BHI_CTRL */
+	if (boot_cpu_has(X86_FEATURE_BHI_CTRL))
+		return false;
+
+	/*
+	 * If a VMM did not expose ITS_NO, assume that a guest could
+	 * be running on a vulnerable hardware or may migrate to such
+	 * hardware.
+	 */
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return true;
+
+	if (cpu_matches(cpu_vuln_blacklist, ITS))
+		return true;
+
+	return false;
+}
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 x86_arch_cap_msr = x86_read_arch_cap_msr();
@@ -1450,6 +1481,9 @@ static void __init cpu_set_bug_bits(stru
 	if (cpu_has(c, X86_FEATURE_AMD_IBPB) && !cpu_has(c, X86_FEATURE_AMD_IBPB_RET))
 		setup_force_cpu_bug(X86_BUG_IBPB_NO_RET);
 
+	if (vulnerable_to_its(x86_arch_cap_msr))
+		setup_force_cpu_bug(X86_BUG_ITS);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1623,7 +1623,7 @@ EXPORT_SYMBOL_GPL(kvm_emulate_rdpmc);
 	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
 	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
 	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
-	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR | ARCH_CAP_BHI_NO)
+	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR | ARCH_CAP_BHI_NO | ARCH_CAP_ITS_NO)
 
 static u64 kvm_get_arch_capabilities(void)
 {
@@ -1657,6 +1657,8 @@ static u64 kvm_get_arch_capabilities(voi
 		data |= ARCH_CAP_MDS_NO;
 	if (!boot_cpu_has_bug(X86_BUG_RFDS))
 		data |= ARCH_CAP_RFDS_NO;
+	if (!boot_cpu_has_bug(X86_BUG_ITS))
+		data |= ARCH_CAP_ITS_NO;
 
 	if (!boot_cpu_has(X86_FEATURE_RTM)) {
 		/*



