Return-Path: <stable+bounces-114529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0B2A2ED1E
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CD43A5E74
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA901C07E5;
	Mon, 10 Feb 2025 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JKYjaoap"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8E681741
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739192598; cv=none; b=WnOO47fBW3pywFT2dEn16h8doLthAn5XQVnMnDRpsLcFt3YkYCvAmeE1eeVR4Rw7AGtEgu/lbWKCzrk68/LTezRFL220mkS5vHbvtoqJtFLOLkBDena8Np+Sj6cKDZ/UUBnlCrx23LU6DudnZ1lTP2iuFU2OuRRO6f81SiboiOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739192598; c=relaxed/simple;
	bh=UO6ay9CqwuBnJFmqZSFpwRYIK93Et3MVaQnGcl0Qt+s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Qa2V2CTGShtLzpNLterO1dTe/n7I2EB1v4Y+qkDoAiDffk45JDifrFo12I668iyGdwqxDlw71Xtp5YB+F7a5/PvQtRGmn/THqr06VP3qSaGpl/EEckTfmBuq1nPeyX2ZhUl4UWBos6weMhmP1c67yTZF6QDg8L6lgXPRGn7KKTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JKYjaoap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5022C4CED1;
	Mon, 10 Feb 2025 13:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739192598;
	bh=UO6ay9CqwuBnJFmqZSFpwRYIK93Et3MVaQnGcl0Qt+s=;
	h=Subject:To:Cc:From:Date:From;
	b=JKYjaoapqsFqTEjo+wFfmrnAUNkjjUCp7JuZBrNjaLw1nVvSYTzLRXMlHXHXfa+jN
	 UhW5xewRKPbgniXSJiI9vhSM0DY+wN2Txms+BX+O0XX4PUJoidwkrrKdfpSVQNIp3a
	 6I/2x0OYECklMYYlpGC7yTyTllli/ot01V33c1tA=
Subject: FAILED: patch "[PATCH] arm64/sme: Move storage of reg_smidr to __cpuinfo_store_cpu()" failed to apply to 6.6-stable tree
To: broonie@kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:03:14 +0100
Message-ID: <2025021014-landscape-stencil-2aa9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d3c7c48d004f6c8d892f39b5d69884fd0fe98c81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021014-landscape-stencil-2aa9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d3c7c48d004f6c8d892f39b5d69884fd0fe98c81 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Tue, 17 Dec 2024 21:59:48 +0000
Subject: [PATCH] arm64/sme: Move storage of reg_smidr to __cpuinfo_store_cpu()

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
Link: https://lore.kernel.org/r/20241217-arm64-fix-boot-cpu-smidr-v3-1-7be278a85623@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 13de0c7af053..b105e6683571 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1166,12 +1166,6 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
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
@@ -1422,13 +1416,6 @@ void update_cpu_features(int cpu,
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
index d79e88fccdfc..c45633b5ae23 100644
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
 


