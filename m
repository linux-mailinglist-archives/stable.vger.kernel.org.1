Return-Path: <stable+bounces-94399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320C39D3D14
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC3E2834D9
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB3C1C1F3F;
	Wed, 20 Nov 2024 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5+Ja0kd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6611AA793;
	Wed, 20 Nov 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111592; cv=none; b=sjT58Wfp+yyS1WgvHU4xKZVLh5zww2enVEPxmd0hciSuWWUpWyBOrfZcDIgMgcsmUe6/YuptrS2DXaPDW9xnpEQf7kA+MiHZ/npLE5lYBYx3aLvNA6SFpehSopmIqRiOEiPU1DtW5NGx8TtnleCyjSTGSV4u/WSbPKc/Xn/g3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111592; c=relaxed/simple;
	bh=KuoIMBg67mYDfTqIN7sr1wrRw2U2x4tiGcaH/+aG0tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiUJy2WuSczx+oybtEyjnjycs1KjgMyhZEx0Ep0gQZypfv3x09Fh75wsWOpUlQJUP8xgIpPJrzC6RwGGIpe/WK0KVa4Jj6LtI44XuxgFXWIPBqyrpItnPb8xEVIr7opHQ6y7//vtQQF0Rs+DTLA7y/RVbZIvz8I50T9KLlK0pFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5+Ja0kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AACDC4CED3;
	Wed, 20 Nov 2024 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111591;
	bh=KuoIMBg67mYDfTqIN7sr1wrRw2U2x4tiGcaH/+aG0tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5+Ja0kdax5E92QJzJS5ZPYFLRA3ghv2tVkTFBd/b3sJo69yDwi7qyk25TJtrAw50
	 8z8Kfk79REAWF4hUKUMJWfTuKUyhVZKaqWXdGQTg3h1o4bDG8/GJuP0cZML5FKIeN4
	 3/GF5635dFPVsTihLIrZ3K3sJCAhHzIRUi3ZJTkdYfXDsrjnPISAu5iF7zMmxkU4Do
	 qZCK4K2UEqgY9jmWrAUtcMZc3dQPr7LgFzScMKytdHeLbFfvhi09gqpaY0IDAFkAns
	 C+RqitjKWCYzFfOOFByZ9FlZvfIGlJah+A1Hh5Qhmkc2Zx3KCvLgV92y5pTGrUsNxy
	 drSEzadU24zqg==
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
Subject: [PATCH AUTOSEL 6.11 08/10] ARM: 9434/1: cfi: Fix compilation corner case
Date: Wed, 20 Nov 2024 09:05:33 -0500
Message-ID: <20241120140556.1768511-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120140556.1768511-1-sashal@kernel.org>
References: <20241120140556.1768511-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.9
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
index 5fb9a6aecb001..2cd9333426794 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -94,7 +94,7 @@ SYM_TYPED_FUNC_START(cpu_v7_dcache_clean_area)
 	ret	lr
 SYM_FUNC_END(cpu_v7_dcache_clean_area)
 
-#ifdef CONFIG_ARM_PSCI
+#if defined(CONFIG_ARM_PSCI) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
 	.arch_extension sec
 SYM_TYPED_FUNC_START(cpu_v7_smc_switch_mm)
 	stmfd	sp!, {r0 - r3}
-- 
2.43.0


