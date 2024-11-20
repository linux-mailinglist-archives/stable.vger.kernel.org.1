Return-Path: <stable+bounces-94421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D169D3D78
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E04B2C38C
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD3C1D2F6D;
	Wed, 20 Nov 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clasueZq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D51C4A00;
	Wed, 20 Nov 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111717; cv=none; b=bJxKfrBrwGHniPxB5B4+gk6IEh6pGOkGB7lvcmDa8YJJZ5roCMQCvsCeHcAp2TOP2YAo4EVe35nEv7WCnvpXiwBIK8p/vKmPnQovP7dAgH4TP+KoAHDsUn1wmSCdRJQh+5zvbDyIKX4iM6a21vyPtJPEHA8wS1aN0EABMswtTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111717; c=relaxed/simple;
	bh=4jdFJWsdI9PxVp1APJgllRrhtufNYUIdFGx8Y2yorsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BPpOmSTguBJqOT0GinIRx6YZ/Lbdsuh/IrlemUTjWGykLEwQlv0dLLvGzmHFMDKoPD1dWmMR73C34jriT+LVBY8tBwQ0tBDQREW4DWHvnpAXfPqx4behro653Sju2ySHfAqccQ4VSgweSqbQYP6rX1rwnE93m+Vzk8VCkhVUoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clasueZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEDEC4CECD;
	Wed, 20 Nov 2024 14:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111716;
	bh=4jdFJWsdI9PxVp1APJgllRrhtufNYUIdFGx8Y2yorsY=;
	h=From:To:Cc:Subject:Date:From;
	b=clasueZqwH9CiaOhsw4b39/1aSXEE0XSqJ8b97IVQliu+oXeLcubF8eE5z6YSwt3n
	 pp61T7nDKIGs8smjHbwg3FsCWWk13+z2wWRhFPJXR5YW0oEm56JQeDplhauu92129Z
	 NsDgLFIB4JxNbqPCl7a2HI8/K8Oy2Rt8eU17JcJBJmQnXUV7vaIiTpLSt3YL554fZB
	 //+fxWTv3ldlbfFtgK/wewiEU87x4iBm2UAyPfb9y4gO3LcrOBkUdKZTe2F/CBdwCG
	 Xx/36utxpzlJfyvwIdQNELwok70y11ilhg3A7vhzoVQxOWOFzckMX08LuAgfLCSCyG
	 P5gnKuQ899ykg==
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
Subject: [PATCH AUTOSEL 5.4 1/2] ARM: 9434/1: cfi: Fix compilation corner case
Date: Wed, 20 Nov 2024 09:08:28 -0500
Message-ID: <20241120140833.1769807-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index 48e0ef6f0dccf..aee85fd261f5d 100644
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


