Return-Path: <stable+bounces-94419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43759D3D3E
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823311F22372
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0D41D0E34;
	Wed, 20 Nov 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBx/PlgK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5B1A0AF5;
	Wed, 20 Nov 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111707; cv=none; b=cEtBiMBsgHNkHrClI6Y7PgxVrWCg/i6G7CGARQWuWh+Zq2uO5EmZdBIN+eQSjD+3XWpK/LcJHG3a9/J9kiWJdSTkzcSI+7Q45t095j7kirQNmTdMrU2d+FaKCHOfwXRoUBmwf3u2h+Ku5NczHC7Fn79HiwfXmSXi/MnSL7VsNL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111707; c=relaxed/simple;
	bh=Qkn2TGa/epeCHDrjdIDriCHj6rl+KeWU7Q9FUblDxAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lq06Q/LHsDR37qSVOH6OCKKQM2sI2RqHXIHK3bg+6aMeqlpOZJ8P3AZ3PlvdI4kiQDImn4GkmCa2EB8r0rBlaQ0OhwR1yS/QrmcekJf67HS+rLw/GG1j0owiKEJk4dJgTwpy1i74NdUyXj3nQVDfMM/gZYvw1ZJJbx2/TbW2W9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBx/PlgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A82C4CECD;
	Wed, 20 Nov 2024 14:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111707;
	bh=Qkn2TGa/epeCHDrjdIDriCHj6rl+KeWU7Q9FUblDxAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kBx/PlgK4v6erVe9gXAg2ayc7aTS4AiYuecx80BpJ9XvSUXX2SZnZLY77WVf9D3mB
	 q4VSUsYT9rvj8Wum/Bh/SDlL9idi2Y7gbzoseMVkcQ4Np+2yNRaj/4qn4yenpq7q6x
	 mOiUjFyQEW9Pz/DC2gbgizeP8/OWu0Mzzl5kcJsxAjo7zbnu6BK0ZwubM/w3aO93Dh
	 y1/X2vygL9wToP2jZ8J34YRgLJEz2l2NFWCo891iOKr8qOeyBm8AiD6UO/CvwZQBht
	 vlmBYrdn04RaOgBODHRauI91/PLBfiLaASNZBbp7908N0fH9bhctpf0tf8oI7jR6Cj
	 guA+A3jDcQT7A==
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
Subject: [PATCH AUTOSEL 5.10 2/3] ARM: 9434/1: cfi: Fix compilation corner case
Date: Wed, 20 Nov 2024 09:08:12 -0500
Message-ID: <20241120140819.1769699-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140819.1769699-1-sashal@kernel.org>
References: <20241120140819.1769699-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index 28c9d32fa99a5..db6a720ec0fc4 100644
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


