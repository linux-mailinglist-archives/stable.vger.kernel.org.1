Return-Path: <stable+bounces-85299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC20099E6B1
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935221F22C48
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604A51D5ACD;
	Tue, 15 Oct 2024 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xpSdqD87"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE3A146588;
	Tue, 15 Oct 2024 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992644; cv=none; b=o0TxfCRrMOV1avI6P+w4vsMgYPEj+4uTMupb07OfNzXgV/AOjZCPdr9wrGIzCpHLqtGFqmxSGZDEEVSl1QM8QwEzpu4HhT1i6Vu9uJGbnQ3Rsk2+6mlK4U24lYFaYVkyGugIuQ61bQNbLYS5/PAhhIQfI93rp5tLf4gtA4FEIa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992644; c=relaxed/simple;
	bh=CAC6RtdVWzA77LjBlgRdmzOFNDTvFX4JBNmIywh5Ki8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPz7xvzC1dw6nWWFquegt7GsskWGboOAr32w1PmskSuBjiVgXJNQQ442uqTB3eo6k2amlAkIfrlIoz3GFMRD0WG2hgXb/6A9T/xixA0aHXgs8Y3W4CaqH9J3cATV/XPU2cPyykDL9rg6X9OCVFTR8MJoHKlMmGXbvWT4UIlnDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xpSdqD87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F6CC4CEC6;
	Tue, 15 Oct 2024 11:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992644;
	bh=CAC6RtdVWzA77LjBlgRdmzOFNDTvFX4JBNmIywh5Ki8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xpSdqD87FGfFy13pLdmEwZdTJEKqacHEcq8N+Bnk4+A7zsSqvm5rOJMNAW7gQ6OjB
	 onlHEESfJ+3Iu1Eupl0j7/mkR8QlE8sNsoHLlObt6uiuTrMSFPXnAxDOKOHRjdEgwR
	 T0HfQROt0JMyjRr5lBBMS9DxJ5szZUN59RkA07Bw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 175/691] powerpc/32: Remove the nobats kernel parameter
Date: Tue, 15 Oct 2024 13:22:03 +0200
Message-ID: <20241015112447.310281729@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 1ce844973bb516e95d3f2bcb001a3992548def9d ]

Mapping without BATs doesn't bring any added value to the user.

Remove that option.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/6977314c823cfb728bc0273cea634b41807bfb64.1655202721.git.christophe.leroy@csgroup.eu
Stable-dep-of: f9f2bff64c2f ("powerpc/8xx: Fix initial memory mapping")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 ---
 arch/powerpc/mm/book3s32/mmu.c                  |  2 +-
 arch/powerpc/mm/init_32.c                       | 11 -----------
 arch/powerpc/mm/mmu_decl.h                      |  1 -
 arch/powerpc/platforms/83xx/misc.c              | 14 ++++++--------
 5 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cf35b2cf90c27..e2c2ccba6e388 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3451,9 +3451,6 @@
 
 	noautogroup	Disable scheduler automatic task group creation.
 
-	nobats		[PPC] Do not use BATs for mapping kernel lowmem
-			on "Classic" PPC cores.
-
 	nocache		[ARM]
 
 	noclflush	[BUGS=X86] Don't use the CLFLUSH instruction
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 692c336e4f55b..75c7f35666642 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -165,7 +165,7 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 	size = roundup_pow_of_two((unsigned long)_einittext - PAGE_OFFSET);
 	setibat(0, PAGE_OFFSET, 0, size, PAGE_KERNEL_X);
 
-	if (debug_pagealloc_enabled_or_kfence() || __map_without_bats) {
+	if (debug_pagealloc_enabled_or_kfence()) {
 		pr_debug_once("Read-Write memory mapped without BATs\n");
 		if (base >= border)
 			return base;
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 3d690be48e845..b702f2b642957 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -70,12 +70,6 @@ EXPORT_SYMBOL(agp_special_page);
 
 void MMU_init(void);
 
-/*
- * this tells the system to map all of ram with the segregs
- * (i.e. page tables) instead of the bats.
- * -- Cort
- */
-int __map_without_bats;
 int __map_without_ltlbs;
 
 /* max amount of low RAM to map in */
@@ -86,11 +80,6 @@ unsigned long __max_low_memory = MAX_LOW_MEM;
  */
 static void __init MMU_setup(void)
 {
-	/* Check for nobats option (used in mapin_ram). */
-	if (strstr(boot_command_line, "nobats")) {
-		__map_without_bats = 1;
-	}
-
 	if (strstr(boot_command_line, "noltlbs")) {
 		__map_without_ltlbs = 1;
 	}
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 21996b9e0a64f..990dccf45fc13 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -92,7 +92,6 @@ extern void mapin_ram(void);
 extern void setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, pgprot_t prot);
 
-extern int __map_without_bats;
 extern unsigned int rtas_data, rtas_size;
 
 struct hash_pte;
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index 3285dabcf923b..2fb2a85d131fd 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -121,17 +121,15 @@ void __init mpc83xx_setup_pci(void)
 
 void __init mpc83xx_setup_arch(void)
 {
+	phys_addr_t immrbase = get_immrbase();
+	int immrsize = IS_ALIGNED(immrbase, SZ_2M) ? SZ_2M : SZ_1M;
+	unsigned long va = fix_to_virt(FIX_IMMR_BASE);
+
 	if (ppc_md.progress)
 		ppc_md.progress("mpc83xx_setup_arch()", 0);
 
-	if (!__map_without_bats) {
-		phys_addr_t immrbase = get_immrbase();
-		int immrsize = IS_ALIGNED(immrbase, SZ_2M) ? SZ_2M : SZ_1M;
-		unsigned long va = fix_to_virt(FIX_IMMR_BASE);
-
-		setbat(-1, va, immrbase, immrsize, PAGE_KERNEL_NCG);
-		update_bats();
-	}
+	setbat(-1, va, immrbase, immrsize, PAGE_KERNEL_NCG);
+	update_bats();
 }
 
 int machine_check_83xx(struct pt_regs *regs)
-- 
2.43.0




