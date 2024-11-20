Return-Path: <stable+bounces-94416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3049D3D36
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7C21F22452
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CAD1AA7A6;
	Wed, 20 Nov 2024 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSGXeRla"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E21CF5E0;
	Wed, 20 Nov 2024 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111691; cv=none; b=d89b1GL4P39iRPkMXLgtSO38/XFPcxvz1EJnSB8MMgBVrQe7p9F290IdTF2hasjkRL0z7T7JEun30hey9iCtfmbWPefzGa/k62O0IfElWVNKb+IpqoVirSvC3qy0Fe4pLS2LHyPkFojCfRlPSNPDySikMdkVBSCDWpuX+lVwpc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111691; c=relaxed/simple;
	bh=1h+r44bKItFpy5BY/SuLv+HOEtbQLxNAGpyYMYt2Hyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TONjr5nWOt9oPeO74dKtM+dFNkJq9t/aOmUfkLTQxFO8J/l9my4kr/FrRx3Xlzzulm24DW2l87jPuYkpHce0olZ1vSHOYy7f+dmnQXmaF1TmA484A8ydcW0wcKhdXrgnSJhjVeMX6kknct6vLC57k/G1rcSXrKTn4bXDpody/YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSGXeRla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4186C4CECD;
	Wed, 20 Nov 2024 14:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111691;
	bh=1h+r44bKItFpy5BY/SuLv+HOEtbQLxNAGpyYMYt2Hyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSGXeRlacVCYMzINqJemW9UJUiq8r+FYqwN2P8hzUmLBb5yMwjgRpdz+4irFobQT5
	 K/wkUpDPgLNYbTiJFoq8decP4O0kD+LOXvA/NwKZD715ncvXEfwaTIDjW2zoJAerwK
	 gnr9GE07wCOyOFNuvvZiZL4IqNKJ8Rz77oEXplA8+vZKze9cQUf436p7PIZI7EPadO
	 lROy52LHfIzctTYkRfqSBCFCIsqyAE46HvsGnJrepMtG8bNTIx791nSN9s7xv6h+eW
	 mH/la8syG4IbDvX+0O1/b8HS1IwzDzE5lsCS4rAPDC9hDYEuwjiUOEXiy/7Qn/W5L7
	 GYI1mlAh/ufbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	samitolvanen@google.com,
	arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 3/4] ARM: 9434/1: cfi: Fix compilation corner case
Date: Wed, 20 Nov 2024 09:07:46 -0500
Message-ID: <20241120140758.1769473-3-sashal@kernel.org>
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
index 26d726a08a34b..2090c23e49311 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -91,7 +91,7 @@ ENTRY(cpu_v7_dcache_clean_area)
 	ret	lr
 ENDPROC(cpu_v7_dcache_clean_area)
 
-#ifdef CONFIG_ARM_PSCI
+#if defined(CONFIG_ARM_PSCI) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
 	.arch_extension sec
 ENTRY(cpu_v7_smc_switch_mm)
 	stmfd	sp!, {r0 - r3}
-- 
2.43.0


