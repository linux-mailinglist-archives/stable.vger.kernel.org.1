Return-Path: <stable+bounces-105072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D62249F595D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 23:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E41E188A762
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 22:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AF21EE02E;
	Tue, 17 Dec 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU6wpPWT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FCE188014;
	Tue, 17 Dec 2024 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472834; cv=none; b=TXCrv8o0s/5OyZT2gBGcKtN1h9cuJo+12IEg2aPoSjzim1FgS1t5pOLFqvSgXf9wJIrSTr63iA17bJ+DCmAuJ+EFs7DByxzJ1ytkhzTyi1+vxJsbROzUX6/05jhdHgJKK35OGSzX3RontDFCfsxLxk5fa4h9U+lZthJKUFIghe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472834; c=relaxed/simple;
	bh=UdvwEKCif7SL13UWTKxZEOkRyDKodoLCPs1kFcwO9ik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V/Iq3fWy0rs1ZrEoHBxDVIauc4fmuVQYOGBO33Y4e9FJgjVlaV9YgxWPvkqCdnz2RO+kaNy40TrGGvw58Ydw9QoKC6XrIRv+cUI7FmZLJil2EVz86NzXdJ/XvAqN2Tx11Bg4/CBWY8Bse/uQROLyjNPg4QPkz0FFGh9585X0FP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU6wpPWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B76C4CED3;
	Tue, 17 Dec 2024 22:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734472833;
	bh=UdvwEKCif7SL13UWTKxZEOkRyDKodoLCPs1kFcwO9ik=;
	h=From:Date:Subject:To:Cc:From;
	b=AU6wpPWTpHjHUMi92kiJloIuVM7EgEVAzyuXekOtRMvIXED5z7QiizAUOJZ//s2wv
	 iCqe3bKyXqR1uKRRaZd+QIzshlaG4xnc47ZkJTfatHDwS4zUY1K39FI+e0ZHPXPNcb
	 y8ESFNmq7v0ckOlcseK94Mh4B/11t2sAkPcM8esW6OJ/fol4MwpOeSycMu2XoRoXkc
	 XUJrwRBlFGR543kBhGTeuE4qfNyhaWF3XZukS/t6QTVTETTv5rS5UFnsckTPnAj7uI
	 lBinPqWMowrXPn+l1o6NJW3yb7HC/CanBkgZEJYqvA4/SIzadzKWA99vhyxdfIdP3x
	 d9aM2UOBD/RuQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 17 Dec 2024 21:59:48 +0000
Subject: [PATCH v3] arm64/sme: Move storage of reg_smidr to
 __cpuinfo_store_cpu()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-arm64-fix-boot-cpu-smidr-v3-1-7be278a85623@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFT0YWcC/33NwQ6CMAyA4VchO1vDusnAk+9hPDA2YFEY6ZBoC
 O/uIDHRgx7/pv06s2DJ2cCOyczITi4438cQu4RVbdk3FpyJzTBFyZELKKnLJNTuAdr7EarhDqF
 zhkDkmc6NxgI1sng+kI1bG32+xG5dGD09t08TX6dvVP5GJw4cUiUPlUyVQmNOV0u9ve09NWxVJ
 /yUsj8SRqksirrWJVZC1V/SsiwvBFSiVgsBAAA=
X-Change-ID: 20241213-arm64-fix-boot-cpu-smidr-386b8db292b2
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Peter Collingbourne <pcc@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=4781; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UdvwEKCif7SL13UWTKxZEOkRyDKodoLCPs1kFcwO9ik=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnYfR+z0ttVHBHgHuta4bowAhzuy6x8DgqTDQWKRxy
 8lziSdmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2H0fgAKCRAk1otyXVSH0F9BB/
 wOFcy89llIBoJPEAQcioqnU8ppbKLYEVimCcjrsFnInq+ExM9mp4iPaThprBKSZuhcVbosteIr7Gf1
 J8Nmc+hBJqhjdBwF6zX5dRHMzuE4bnb+Q8faH7rSHu0rrtFhqnsnFIpNAAcxA/XUUMjWHZL7KLxmxj
 Myhe1uWXLARisurkHD7oU63fz8YF/aZqZfh5u0rnc3OaxypQLeNX11mNv5mJF1hovWIgJn+GaxK8np
 cD4FtHuLMBzQKtUK9DolIsGr9Xou72Atl7NbDsqjZvsj32DShuN/5zQePH8O1O1BpCD2RkBIeM/6XJ
 th3oSl+tKb13L99sEz7I4PgBtXGSku
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In commit 892f7237b3ff ("arm64: Delay initialisation of
cpuinfo_arm64::reg_{zcr,smcr}") we moved access to ZCR, SMCR and SMIDR
later in the boot process in order to ensure that we don't attempt to
interact with them if SVE or SME is disabled on the command line.
Unfortunately when initialising the boot CPU in init_cpu_features() we work
on a copy of the struct cpuinfo_arm64 for the boot CPU used only during
boot, not the percpu copy used by the sysfs code. The expectation of the
feature identification code was that the ID registers would be read in
__cpuinfo_store_cpu() and the values not modified by init_cpu_features().

The main reason for the original change was to avoid early accesses to
ZCR on practical systems that were seen shipping with SVE reported in ID
registers but traps enabled at EL3 and handled as fatal errors, SME was
rolled in due to the similarity with SVE. Since then we have removed the
early accesses to ZCR and SMCR in commits:

  abef0695f9665c3d ("arm64/sve: Remove ZCR pseudo register from cpufeature code")
  391208485c3ad50f ("arm64/sve: Remove SMCR pseudo register from cpufeature code")

so only the SMIDR_EL1 part of the change remains. Since SMIDR_EL1 is
only trapped via FEAT_IDST and not the SME trap it is less likely to be
affected by similar issues, and the factors that lead to issues with SVE
are less likely to apply to SME.

Since we have not yet seen practical SME systems that need to use a
command line override (and are only just beginning to see SME systems at
all) and the ID register read is much more likely to be safe let's just
store SMIDR_EL1 along with all the other ID register reads in
__cpuinfo_store_cpu().

This issue wasn't apparent when testing on emulated platforms that do not
report values in SMIDR_EL1.

Fixes: 892f7237b3ff ("arm64: Delay initialisation of cpuinfo_arm64::reg_{zcr,smcr}")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
Changes in v3:
- Leave the override in place.
- Link to v2: https://lore.kernel.org/r/20241216-arm64-fix-boot-cpu-smidr-v2-1-a99ffba2c37f@kernel.org

Changes in v2:
- Move the ID register read back to __cpuinfo_store_cpu().
- Remove the command line option for SME ID register override.
- Link to v1: https://lore.kernel.org/r/20241214-arm64-fix-boot-cpu-smidr-v1-1-0745c40772dd@kernel.org
---
 arch/arm64/kernel/cpufeature.c | 13 -------------
 arch/arm64/kernel/cpuinfo.c    | 10 ++++++++++
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6ce71f444ed84f9056196bb21bbfac61c9687e30..818aca922ca6066eb4bdf79e153cccb24246c61b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1167,12 +1167,6 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 	    id_aa64pfr1_sme(read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1))) {
 		unsigned long cpacr = cpacr_save_enable_kernel_sme();
 
-		/*
-		 * We mask out SMPS since even if the hardware
-		 * supports priorities the kernel does not at present
-		 * and we block access to them.
-		 */
-		info->reg_smidr = read_cpuid(SMIDR_EL1) & ~SMIDR_EL1_SMPS;
 		vec_init_vq_map(ARM64_VEC_SME);
 
 		cpacr_restore(cpacr);
@@ -1423,13 +1417,6 @@ void update_cpu_features(int cpu,
 	    id_aa64pfr1_sme(read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1))) {
 		unsigned long cpacr = cpacr_save_enable_kernel_sme();
 
-		/*
-		 * We mask out SMPS since even if the hardware
-		 * supports priorities the kernel does not at present
-		 * and we block access to them.
-		 */
-		info->reg_smidr = read_cpuid(SMIDR_EL1) & ~SMIDR_EL1_SMPS;
-
 		/* Probe vector lengths */
 		if (!system_capabilities_finalized())
 			vec_update_vq_map(ARM64_VEC_SME);
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index d79e88fccdfce427507e7a34c5959ce6309cbd12..c45633b5ae233fe78607fce3d623efb28a9f341a 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -482,6 +482,16 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	if (id_aa64pfr0_mpam(info->reg_id_aa64pfr0))
 		info->reg_mpamidr = read_cpuid(MPAMIDR_EL1);
 
+	if (IS_ENABLED(CONFIG_ARM64_SME) &&
+	    id_aa64pfr1_sme(info->reg_id_aa64pfr1)) {
+		/*
+		 * We mask out SMPS since even if the hardware
+		 * supports priorities the kernel does not at present
+		 * and we block access to them.
+		 */
+		info->reg_smidr = read_cpuid(SMIDR_EL1) & ~SMIDR_EL1_SMPS;
+	}
+
 	cpuinfo_detect_icache_policy(info);
 }
 

---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241213-arm64-fix-boot-cpu-smidr-386b8db292b2

Best regards,
-- 
Mark Brown <broonie@kernel.org>


