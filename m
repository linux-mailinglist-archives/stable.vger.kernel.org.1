Return-Path: <stable+bounces-94423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2279D3D8E
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F7DB28024
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF3B1C57A0;
	Wed, 20 Nov 2024 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/GIiMW3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92F31AB51E;
	Wed, 20 Nov 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111725; cv=none; b=mT9r0WCyBImKKT5REnX/EP7dfyobpDtNBG9vAfcYiyqBsLWftJNIVi9If9ltPg2TWeV8sfGiTZ9tLzHXs9JEKEp6b3o2kBiN77A/aDVowISubATcPWLCSNSRSxD5svUzmudbzKkBh5gWDI/kzzME++PocMDRr1390cBUwJvPy7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111725; c=relaxed/simple;
	bh=0rtD2vJdBwhaemkw4RhjcLdbZDRuId21Y8WhxOGrsfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C91jfsL3zn6m/o+5wgH6HFmjiG8N1UbEiMl95h+gMbjxzJyNjWZDYZHo155yPBPoZMRVuIiLeCiL97UllyEqT2ToT3Rd4iNplhkaz6WWufQDh2E2YwPmU9BUbT87cERy8RHqAdyriXODmv/mAchmnnuznXEGIBzzRlz2JQCUpBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/GIiMW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D411C4CECD;
	Wed, 20 Nov 2024 14:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111725;
	bh=0rtD2vJdBwhaemkw4RhjcLdbZDRuId21Y8WhxOGrsfg=;
	h=From:To:Cc:Subject:Date:From;
	b=e/GIiMW3YK9CtbqIkAF38GLeYiPscyNrsYQYm90iYs2U8fsWF19Q3DqiqwBIElMyJ
	 jJs9aA9N1vFPVPu5j1ApXmaXJu9XXtO0LZCbOxX7J/LM8yGRjVJZl5l0kmFT1dBSJM
	 fDWbsy8T7880tGHEqhRFEn+QVYbC4e1zj5WPRXtEafNdSQkWIR5Ng1im/jwnaxr3rh
	 MrIz6c5KV4432vNAyGl79U8c0vwNLDgJ5PY8n23SxdYOkigi0VFDAhpK6goFkT53Hk
	 Rpk3BXAYiwcgkR5gwMAHEdNd2/PY6q+8Dhk8uTGvdNF5yyV50RFURmXRnX67C+kz3X
	 6blfReAhZ3s/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	arnd@arndb.de,
	samitolvanen@google.com,
	linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 4.19] ARM: 9434/1: cfi: Fix compilation corner case
Date: Wed, 20 Nov 2024 09:08:38 -0500
Message-ID: <20241120140842.1769864-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
Content-Transfer-Encoding: 8bit

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 4aea16b7cfb76bd3361858ceee6893ef5c9b5570 ]

When enabling expert mode CONFIG_EXPERT and using that power
user mode to disable the branch prediction hardening
!CONFIG_HARDEN_BRANCH_PREDICTOR, the assembly linker
in CLANG notices that some assembly in proc-v7.S does
not have corresponding C call sites, i.e. the prototypes
in proc-v7-bugs.c are enclosed in ifdef
CONFIG_HARDEN_BRANCH_PREDICTOR so this assembly:

SYM_TYPED_FUNC_START(cpu_v7_smc_switch_mm)
SYM_TYPED_FUNC_START(cpu_v7_hvc_switch_mm)

Results in:

ld.lld: error: undefined symbol: __kcfi_typeid_cpu_v7_smc_switch_mm
>>> referenced by proc-v7.S:94 (.../arch/arm/mm/proc-v7.S:94)
>>> arch/arm/mm/proc-v7.o:(.text+0x108) in archive vmlinux.a

ld.lld: error: undefined symbol: __kcfi_typeid_cpu_v7_hvc_switch_mm
>>> referenced by proc-v7.S:105 (.../arch/arm/mm/proc-v7.S:105)
>>> arch/arm/mm/proc-v7.o:(.text+0x124) in archive vmlinux.a

Fix this by adding an additional requirement that
CONFIG_HARDEN_BRANCH_PREDICTOR has to be enabled to compile
these assembly calls.

Closes: https://lore.kernel.org/oe-kbuild-all/202411041456.ZsoEiD7T-lkp@intel.com/

Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/proc-v7.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index e351d682c2e36..8bde80b31a861 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -94,7 +94,7 @@ ENTRY(cpu_v7_dcache_clean_area)
 	ret	lr
 ENDPROC(cpu_v7_dcache_clean_area)
 
-#ifdef CONFIG_ARM_PSCI
+#if defined(CONFIG_ARM_PSCI) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
 	.arch_extension sec
 ENTRY(cpu_v7_smc_switch_mm)
 	stmfd	sp!, {r0 - r3}
-- 
2.43.0


