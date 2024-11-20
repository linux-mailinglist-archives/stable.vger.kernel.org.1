Return-Path: <stable+bounces-94411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDC39D3D6D
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 019B8B2ADEF
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436D21CB506;
	Wed, 20 Nov 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7eX6W/o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62B1CB33E;
	Wed, 20 Nov 2024 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111662; cv=none; b=DqIP6orR86IcZqKkdRAKAHZp4+Eky/whDEqF8fOWywrmQkXSHxzNVXGEaW7qbajDyytVwjavQpPJCdHmnfKfzPL4v8gCxSy0TTOUPnCVWilO/qqaC06yWoEWIQFXxOKdhJGIPNwL7RY+AoZGw3R0CWb6aRvDXS3IX/BjY9wpIdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111662; c=relaxed/simple;
	bh=vZepIqWe4NhMfvMorhCMGP/JM+N6CfMjOPvc3PBKFJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HU8w23bFQF2fxZj0STFBDwk2goSirTyrp3iH0jFHhUXAFEFuMnsk2tTdVSCnaSUzuloCp0xvWzxgggetbmbjGKHe02w/IBjEOcaIJcd5xhZqmzAz7XucNnTFQ1i0qLi5oM2E0Hch/SK+NJNTjt0/U1rSEyOHbMZT5PsRz3Z8bAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7eX6W/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997C1C4CED2;
	Wed, 20 Nov 2024 14:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111661;
	bh=vZepIqWe4NhMfvMorhCMGP/JM+N6CfMjOPvc3PBKFJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7eX6W/oRLiLUE/t1I2A/Ys1icff0Sge4jYbhMPqAErD7zJ0aZ2VVKuHjGz+MErfE
	 kqF0lv4FKgjDmLEawZkuhgp2BSONuy7Au/mcoV3pdf9R4UOrq7c4g4DeXIUSQQoiyV
	 E3R/B/AcVhMB6bDPypPIiY7wai2nNu+TazsCx1EXTf1Jj8XhG2YZ8QPthbJ6TvUk9N
	 m3Jpc0MJ9HpzqBsxPJ/zPGWdHx1aNo7WEyDnV4RaRRVW3gxIKX7wTEqvwhkGXf0wwH
	 6NMtRmoQBzo3v5C2SjtTNwvuefjiGxojGRIZjKjbN2xwvIKit6FUnTAw3U1TGClbmA
	 EBQphGeCTdaeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harith G <harith.g@alifsemi.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 4/6] ARM: 9420/1: smp: Fix SMP for xip kernels
Date: Wed, 20 Nov 2024 09:07:10 -0500
Message-ID: <20241120140722.1769147-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140722.1769147-1-sashal@kernel.org>
References: <20241120140722.1769147-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.118
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
index 29e2900178a1f..cf393402b4408 100644
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


