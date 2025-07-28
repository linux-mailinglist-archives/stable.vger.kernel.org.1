Return-Path: <stable+bounces-164981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C9BB13DC9
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 17:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C497A2F8F
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7DB1684B0;
	Mon, 28 Jul 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUCcc6yT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB857E9
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714848; cv=none; b=YI39snAigWO6/3vdhgwF1uu/4YiL0wcqljYisvaEuUNRnBpEJjWuaiI5gz2jiTqvnftGdpTgSJIKJH9b3nyNLd/v7zGiqOCGQlzjlzQxFBhErhIesFG/9GmeQ5zhDrB2dEPtzYsVNieAqXd3hzsX4CtxyeGw9R0dWKDX3Kb8ykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714848; c=relaxed/simple;
	bh=S8SS2UNSA0rrA/twcC0lrHNGmJNwhgjG1MtNwwrKY2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mz0FTj/p33++6ZbqYSsv8vHuNM/fl9RVxrCUDIYWlAN2iviSqwrIbSl/XoDG0pcHOH8MX+QCqDDxmhxlsPGg4wPFs2RoftqpgtDnNspqOP7B/Q76ne3BUd9FA0pqADJUa6Fdl7wpxiWbQzAR1euiF78bFAG3d2RaRhGkaaUUO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUCcc6yT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72F2C4CEE7;
	Mon, 28 Jul 2025 15:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753714847;
	bh=S8SS2UNSA0rrA/twcC0lrHNGmJNwhgjG1MtNwwrKY2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUCcc6yTIDWEyw/LQ8c5vw5h7LzamVh4wzNTbzHV4xKDiymOpZVDDBjHxaFGS/8rg
	 crZ5c69n4u1Rl0JZwYF9pLhsBlkYGZQOsLHDJFm21S0LPTuhTggTulHEvmEkJP70rJ
	 sa3kx3Vu49PlGApnXRTzEOxCVIptl6NDqSYTJTctswQxxeaLKPuVjA0qmgGfxMmvJK
	 Zyw8rL663/MPuKeoaA1wMI57APGcbFhqpVilHPs+hSHmo33peqT+cB9IhuzRE0A6nI
	 p4zQAFur/reaOG7W8UA+o37u4KDCSbEMsIx08VIxBmE/FPhRV8BdYipYbvEx/iXKV5
	 4KrJ8UEEahIwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	KernelCI bot <bot@kernelci.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS
Date: Mon, 28 Jul 2025 11:00:44 -0400
Message-Id: <20250728150044.2341245-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072856-crisply-wannabe-7c72@gregkh>
References: <2025072856-crisply-wannabe-7c72@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 87c4e1459e80bf65066f864c762ef4dc932fad4b ]

After commit d5c8d6e0fa61 ("kbuild: Update assembler calls to use proper
flags and language target"), which updated as-instr to use the
'assembler-with-cpp' language option, the Kbuild version of as-instr
always fails internally for arch/arm with

  <command-line>: fatal error: asm/unified.h: No such file or directory
  compilation terminated.

because '-include' flags are now taken into account by the compiler
driver and as-instr does not have '$(LINUXINCLUDE)', so unified.h is not
found.

This went unnoticed at the time of the Kbuild change because the last
use of as-instr in Kbuild that arch/arm could reach was removed in 5.7
by commit 541ad0150ca4 ("arm: Remove 32bit KVM host support") but a
stable backport of the Kbuild change to before that point exposed this
potential issue if one were to be reintroduced.

Follow the general pattern of '-include' paths throughout the tree and
make unified.h absolute using '$(srctree)' to ensure KBUILD_AFLAGS can
be used independently.

Closes: https://lore.kernel.org/CACo-S-1qbCX4WAVFA63dWfHtrRHZBTyyr2js8Lx=Az03XHTTHg@mail.gmail.com/

Cc: stable@vger.kernel.org
Fixes: d5c8d6e0fa61 ("kbuild: Update assembler calls to use proper flags and language target")
Reported-by: KernelCI bot <bot@kernelci.org>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
[ adapted to missing -Wa ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 0e5a8765e60b..37646ba4feae 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -126,7 +126,7 @@ endif
 
 # Need -Uarm for gcc < 3.x
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include $(srctree)/arch/arm/include/asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
 
-- 
2.39.5


