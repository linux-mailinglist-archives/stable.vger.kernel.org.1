Return-Path: <stable+bounces-94412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92619D3D30
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB5D1F2227D
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051F21CB532;
	Wed, 20 Nov 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8n1+8FI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B5F1BE235;
	Wed, 20 Nov 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111665; cv=none; b=TGBCSbslHyi6P9EgQ8BlTXF8wljvSqlW2GIz5It2khfkwtP061Re0AEkDOqaldeTGnKsefmbfjE2pp7sB8a4n9kyqjBfJ7wh2ayMbgwDImVHufjFDnWbPruk6ci78qpohMUxmlmmtq7x+NhkUFSyK9cRWef5UvLammBu/u/f5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111665; c=relaxed/simple;
	bh=1h+r44bKItFpy5BY/SuLv+HOEtbQLxNAGpyYMYt2Hyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fx9tqoSbNB+OtPIATRlK2QZVVLN7ha8kFSAeQ7VgwMenSSA0qOdO6cGHJy4lEujUe4cOGwz+l719dXxNsiU+7SPaBWuJzGHxbruio91EzL9VSsXSREVnV2z4YpRRsFNakTyfNZbRzEHB3kCS630mzvIGRrURUVqm4oir+T7HZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8n1+8FI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB18CC4CECD;
	Wed, 20 Nov 2024 14:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732111665;
	bh=1h+r44bKItFpy5BY/SuLv+HOEtbQLxNAGpyYMYt2Hyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C8n1+8FIuMhs7cV0wU8DT3wZxqIbIHvqlfJmJokC65INu6hxHVRitEHntDQb92YMu
	 uUu/wtJfX2S3X0mgOmMGfn9l8uP/hyKyjsoCtrZeE6EIoZAzkk7t4usmkecC4YI+fZ
	 tKCAKE9vrBtvWr/HPfVi0mqCJckWH6Ue5iTKJD9fP0S788sdiQq7myoPzMV9l+Gxlm
	 SRR0DkKeTu2K4Ybhjq5iRsaUYeZvbGPP7XA8vpD6a+1HrfoUNDxd7u9LtQanQj1mtg
	 1TwBkIpMrCu8xvPxbqQH2goGpBxwuyFRgbhWTjVMF9DuYr+stgblBsSeb2PCMzCci3
	 iDL/nr53Ep5VQ==
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
Subject: [PATCH AUTOSEL 6.1 5/6] ARM: 9434/1: cfi: Fix compilation corner case
Date: Wed, 20 Nov 2024 09:07:11 -0500
Message-ID: <20241120140722.1769147-5-sashal@kernel.org>
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


