Return-Path: <stable+bounces-104167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AD29F1B94
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 01:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609C4162CE6
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 00:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B4C84D0E;
	Sat, 14 Dec 2024 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM5JrsDY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A588782C60;
	Sat, 14 Dec 2024 00:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137600; cv=none; b=VEOd1k0ppLrWfYVj6kmNVP+pIqRA0nNC/ifBY1a9R/FiTUfn8LUs0Yi+UALKg+Ukwn5UJH13FqIdryg2JEtC59Mgw7fnHBQfm/cUvA3qV0Q6T/dwPQgUjbkdGDFMthQ3taBgjBFM3PJveHSRJEg74Y4b8I7xQFueRn3ifrmLzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137600; c=relaxed/simple;
	bh=TU7beI3w2g6z5G8iT84//FPeFwQvnKablyc1aMJP4JE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fCZaeX/AqwgTvyNHq3iyyJfzLcwBldX6NVcXCAYWZvfFMtwLFxhiHCuY/jzZiYVXXVmH4WlR1LEhBPzFWwv2FQx3ROK7K7KV6Mfh/LN5gXspTlvcXcyfhl5RMbQHxkFYL+NVnNTH0ukeSNEMkSumsMDcodtyq7qLaY2By6EjbNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM5JrsDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94797C4CED0;
	Sat, 14 Dec 2024 00:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734137600;
	bh=TU7beI3w2g6z5G8iT84//FPeFwQvnKablyc1aMJP4JE=;
	h=From:Date:Subject:To:Cc:From;
	b=kM5JrsDYHFuauJhvfUTwWoHEKNgcBPjVnGR9KwDc8viRCPgBNlxHtrXyK2S1bGqEi
	 v4F4xv1kssglbriZNeaVgYgAGzhRP97MjMRp1aflh9+0hbMgZvGf6yGUGKLTi+S//7
	 /wdsHE+HQwPKhQ5Zcp0KnT3ZcKxMKjfOTO55oKsQrTIY4uj8BeJk2CeRReus2gCjuC
	 kz9iv0CU+1d1skpfaKSBtunfireTWs+9U9s9gO1su+rruMoiiyfN6+YUM89cequSYN
	 MmI3kP3bhSFTMHXDmSrrI8B1xkpr9bh/Gc3mGqzCwWZ9caw9YabMe3V3+qJii57poC
	 BsQM0wkQbcpQg==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 14 Dec 2024 00:52:08 +0000
Subject: [PATCH] arm64/sme: Move storage of reg_smidr to
 __cpuinfo_store_cpu()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-arm64-fix-boot-cpu-smidr-v1-1-0745c40772dd@kernel.org>
X-B4-Tracking: v=1; b=H4sIALfWXGcC/x2MQQ5AMBAAvyJ7tokuEXxFHFpd7IHKFpGIv2scJ
 5mZByKrcIQue0D5kihhS2DyDMbFbjOj+MRABVWGTIlW17rCSW50IRw47ifGVbxi2dSu8Y5acgQ
 p35WT9a/74X0/z2wzFWoAAAA=
X-Change-ID: 20241213-arm64-fix-boot-cpu-smidr-386b8db292b2
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Peter Collingbourne <pcc@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2881; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TU7beI3w2g6z5G8iT84//FPeFwQvnKablyc1aMJP4JE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnXNb9A0sFwErABm1PkpyY8E9bipFtL2o3asskTfST
 0a3YhaiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1zW/QAKCRAk1otyXVSH0B23CA
 CDgnCBHdnKTjOZmTQ+K+vA3rdNNZl4B31eptRG3/hV71c3oiMORttN/cFZ5yjwrgmA+KO+2HueqI2V
 0JROSKJqV3pAae4WWgtTP8JRhvFwAjKRL4wEGnrDq7LotAhY32lVndkK3fBzJmOyyJKBSyp8OSS9TV
 lvDKz6AyrSHin8fqhqFQuUBln3UHZsG9lEM5nX54SrZYU6q8DwY8K5yB/uIaECvNixkHrJicUTpzOz
 XYHmkT/YFxRO89WwaxhhHVDmuRcyIw15uYfdwOBAkLkjm4Akw4rM5+Rulrayd1W9oDbsIPuICUBOW+
 9SEHmBq1XURiVX+WM6yDCP6Kokz2Ek
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In commit 892f7237b3ff ("arm64: Delay initialisation of
cpuinfo_arm64::reg_{zcr,smcr}") we moved access to ZCR, SMCR and SMIDR
later in the boot process in order to ensure that we don't attempt to
interact with them if SVE or SME is disabled on the command line.
Unfortunately when initialising the boot CPU in init_cpu_features() we work
on a copy of the struct cpuinfo_arm64 for the boot CPU used only during
boot, not the percpu copy used by the sysfs code.

Fix this by moving the handling for SMIDR_EL1 for the boot CPU to
cpuinfo_store_boot_cpu() so it can operate on the percpu copy of the data.
This reduces the potential for error that could come from having both the
percpu and boot CPU copies in init_cpu_features().

This issue wasn't apparent when testing on emulated platforms that do not
report values in this ID register.

Fixes: 892f7237b3ff ("arm64: Delay initialisation of cpuinfo_arm64::reg_{zcr,smcr}")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/cpufeature.c |  6 ------
 arch/arm64/kernel/cpuinfo.c    | 11 +++++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6ce71f444ed84f9056196bb21bbfac61c9687e30..b88102fd2c20f77e25af6df513fda09a484e882e 100644
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
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index d79e88fccdfce427507e7a34c5959ce6309cbd12..b7d403da71e5a01ed3943eb37e7a00af238771a2 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -499,4 +499,15 @@ void __init cpuinfo_store_boot_cpu(void)
 
 	boot_cpu_data = *info;
 	init_cpu_features(&boot_cpu_data);
+
+	/* SMIDR_EL1 needs to be stored in the percpu data for sysfs */
+	if (IS_ENABLED(CONFIG_ARM64_SME) &&
+	    id_aa64pfr1_sme(read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1))) {
+		/*
+		 * We mask out SMPS since even if the hardware
+		 * supports priorities the kernel does not at present
+		 * and we block access to them.
+		 */
+		info->reg_smidr = read_cpuid(SMIDR_EL1) & ~SMIDR_EL1_SMPS;
+	}
 }

---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241213-arm64-fix-boot-cpu-smidr-386b8db292b2

Best regards,
-- 
Mark Brown <broonie@kernel.org>


