Return-Path: <stable+bounces-94415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7684A9D3D34
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF1A1F2193E
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D751C1F24;
	Wed, 20 Nov 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzswJd+D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B21AA1FC;
	Wed, 20 Nov 2024 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111688; cv=none; b=jf1+gLLfaUGcDY0opjPVJHOiVd1DtaaocluGk8u9EbO3IBF9HB+NpYiC/A5PIDvLNBfUaZP3dBrey08bNlyNP1RvuCw8GTiUJWHP7FfUqe/iMn15BZsnj7ujSrH/ES/6//krr4PgWp4fPPW81tlvz4kVoamZCVK/xfnfiR28VL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111688; c=relaxed/simple;
	bh=2XwH/kArcNj2S46eo/6RFM8V2G4b0n3ScbcqO15AEO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0q0ipfxBCChUdRwXyTk02PWB9QFMiHi71LjplOo19PJCuKUjSMFhnjpKTUQC3ScJQQuX/rMVJc2AKENi+60ULlUNps2wANLBcRg1r0iHoBa0xDqRURta/0ZtsK+G1Hm2f/MKAvNvnhs+Kb7Mx2VcA3HP/YOVgDH3ybotXJrRmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzswJd+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FBFC4CECD;
	Wed, 20 Nov 2024 14:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111687;
	bh=2XwH/kArcNj2S46eo/6RFM8V2G4b0n3ScbcqO15AEO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzswJd+DriBD91WZp+ISvkCIB8SVuW+pdDYPl6xXEv/B0y9dWiymAb/PWeJOAC36q
	 OFMpED1h4LbFONfE1cqqltwPyHriJ8DQMbQnheK7u9xiJmQsvKKrM0eqRQ5vouSLCY
	 iMuIJC2K6QCRHhH8iBwZG1iBvhItuv/zXlqU9hfY3zBdeKjbUcCfVuJn9N4fB7DbWw
	 r/GMoblLEMVu+rCW+Dfqiw0S/Hsc0/yY+3dRuWel2qcN2E5fzM898SRSg4ypkkacn0
	 YEAV0kmR3yysrEeBdCVQnKLtbEQGUfnjhs7E+Xak5fxwPNu8IiJ4dqJp4d78NX30Pe
	 ak62HMlY9LNWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harith G <harith.g@alifsemi.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 2/4] ARM: 9420/1: smp: Fix SMP for xip kernels
Date: Wed, 20 Nov 2024 09:07:45 -0500
Message-ID: <20241120140758.1769473-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140758.1769473-1-sashal@kernel.org>
References: <20241120140758.1769473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Harith G <harith.g@alifsemi.com>

[ Upstream commit 9e9b0cf9319b4db143014477b0bc4b39894248f1 ]

Fix the physical address calculation of the following to get smp working
on xip kernels.
- secondary_data needed for secondary cpu bootup.
- secondary_startup address passed through psci.
- identity mapped code region needed for enabling mmu for secondary cpus.

Signed-off-by: Harith George <harith.g@alifsemi.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/head.S     | 4 ++++
 arch/arm/kernel/psci_smp.c | 7 +++++++
 arch/arm/mm/idmap.c        | 7 +++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 3fc7f9750ce4b..ac3b1892a7a85 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -407,7 +407,11 @@ ENTRY(secondary_startup)
 	/*
 	 * Use the page tables supplied from  __cpu_up.
 	 */
+#ifdef CONFIG_XIP_KERNEL
+	ldr	r3, =(secondary_data + PLAT_PHYS_OFFSET - PAGE_OFFSET)
+#else
 	adr_l	r3, secondary_data
+#endif
 	mov_l	r12, __secondary_switched
 	ldrd	r4, r5, [r3, #0]		@ get secondary_data.pgdir
 ARM_BE8(eor	r4, r4, r5)			@ Swap r5 and r4 in BE:
diff --git a/arch/arm/kernel/psci_smp.c b/arch/arm/kernel/psci_smp.c
index d4392e1774848..3bb0c4dcfc5c9 100644
--- a/arch/arm/kernel/psci_smp.c
+++ b/arch/arm/kernel/psci_smp.c
@@ -45,8 +45,15 @@ extern void secondary_startup(void);
 static int psci_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	if (psci_ops.cpu_on)
+#ifdef CONFIG_XIP_KERNEL
+		return psci_ops.cpu_on(cpu_logical_map(cpu),
+			((phys_addr_t)(&secondary_startup)
+			- XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
+			+ CONFIG_XIP_PHYS_ADDR));
+#else
 		return psci_ops.cpu_on(cpu_logical_map(cpu),
 					virt_to_idmap(&secondary_startup));
+#endif
 	return -ENODEV;
 }
 
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 448e57c6f6534..4a833e89782aa 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -84,8 +84,15 @@ static void identity_mapping_add(pgd_t *pgd, const char *text_start,
 	unsigned long addr, end;
 	unsigned long next;
 
+#ifdef CONFIG_XIP_KERNEL
+	addr = (phys_addr_t)(text_start) - XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
+		+ CONFIG_XIP_PHYS_ADDR;
+	end = (phys_addr_t)(text_end) - XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR)
+		+ CONFIG_XIP_PHYS_ADDR;
+#else
 	addr = virt_to_idmap(text_start);
 	end = virt_to_idmap(text_end);
+#endif
 	pr_info("Setting up static identity map for 0x%lx - 0x%lx\n", addr, end);
 
 	prot |= PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AF;
-- 
2.43.0


