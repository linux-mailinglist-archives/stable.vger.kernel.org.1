Return-Path: <stable+bounces-94406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DBC9D3D22
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD941F238DF
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190451C9B6F;
	Wed, 20 Nov 2024 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqygtr3l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C5F1AC89A;
	Wed, 20 Nov 2024 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111629; cv=none; b=Fp/OeNQmYyYfMH4xJ2Tt+13f1NEmorK0A8JpPHb/POL8Vn6U29duZP5ZEbyvY+VHg+vEVxE1M+OsLQOuVcRuWHtSYR7dVwbRbmSMBo74JdSwHdI5aW1PuzAFoYLnBwloVFP7wNdrbc2R/SDm1Xo3EEAt4+eh1zr74eawoRyRclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111629; c=relaxed/simple;
	bh=DKek5Oayrz6LgCVAqEw5i/CoZsCQVMoEfVXkm5eofCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrF2mJJ5yKEuT7n9vP/T0YfFJjktWf1VQrx2ArfnDu+hz9rIbW6n8zKkqp+2BpPJVU/kgKjOEpbavtcgxqzKLk2dF/NvHuaIu8ZcNYY4Hhfi9r5R0uBbkisOQqUEAqyP68JyrI/VpPzCssWS3TL3ueQsX5QpGeEa2eCNYLBVs88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqygtr3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F412C4CECD;
	Wed, 20 Nov 2024 14:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111629;
	bh=DKek5Oayrz6LgCVAqEw5i/CoZsCQVMoEfVXkm5eofCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqygtr3l3eWWP8FDKFms99Z0wp+XfGQ5Ptxjh9k+ID/EYoE5I8ooKjj7FJY9H2yPo
	 /2pf7jrPFNVubG0S3F40Xs4TeOEcC33Mt4lGgDThx+vUgyBWRu3bD/wJjwz5kA0Py5
	 Xy6Qs83cPHAq35sJ1T3iS7NUXrezMMlgqh8OJY8l5mMS/OBy3bpPvb5ZtiMtEWGFs9
	 dnonGJL1DdDgPAbblbLv6v0IaJtEoS9EV6/7CPdd4AYUyJ0bVnklOScSQc6WD3AsZ1
	 jxRobYgyisDx4MVyyhjZVuT/jz8mp7IjNH15OK+xQcVd7CajoGCuWMoA+dH/ekHZtZ
	 +VX4KNxK0Nuig==
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
Subject: [PATCH AUTOSEL 6.6 5/6] ARM: 9434/1: cfi: Fix compilation corner case
Date: Wed, 20 Nov 2024 09:06:35 -0500
Message-ID: <20241120140647.1768984-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140647.1768984-1-sashal@kernel.org>
References: <20241120140647.1768984-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.62
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
index 193c7aeb67039..bea11f9bfe856 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -93,7 +93,7 @@ ENTRY(cpu_v7_dcache_clean_area)
 	ret	lr
 ENDPROC(cpu_v7_dcache_clean_area)
 
-#ifdef CONFIG_ARM_PSCI
+#if defined(CONFIG_ARM_PSCI) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
 	.arch_extension sec
 ENTRY(cpu_v7_smc_switch_mm)
 	stmfd	sp!, {r0 - r3}
-- 
2.43.0


