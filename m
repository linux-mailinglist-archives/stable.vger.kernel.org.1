Return-Path: <stable+bounces-164977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80F7B13DAE
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98AC17AB14
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32C92701B4;
	Mon, 28 Jul 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ/9BJc3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6358A263F5F
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714289; cv=none; b=OoCbLI+kEyFOkxAS2MOaQi7UdWdw+/KOmw+RuMP4uK3/02fQz1sv1t4sKBUwmWcfyyliXkRV1zbt4U2va9HfRa3qt5ouLzIVr4/KsfwqQ9Cs9c7FqU9qdWPy9J3xfSpUKce8RaDqoheCN3rwG8iaQMSIIaNDgak87ZkIXS4WffM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714289; c=relaxed/simple;
	bh=cHfDlvCpAnKtDl55w0+CCbi446Vc9vkfY6ETrpHL+hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBtaUvSpO622bzthXcRY81z19yMwQhYoDOuhX0yCX4jCzXQV/gnE7TE5ZGrGWjmqwmwmpTUK26bD5ItWM89eL8h9Uq9vtv26iZ+TSabgR823vegf7wVXL2+PGWLvXm5NSNUzQGLhl+zIzLB6pGvPfhsqtxjB8kCNYUdJmU9ZtZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ/9BJc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2399C4CEEF;
	Mon, 28 Jul 2025 14:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753714289;
	bh=cHfDlvCpAnKtDl55w0+CCbi446Vc9vkfY6ETrpHL+hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZ/9BJc3e2Q/0cOWBdT3+0x/FaLdvuI4jH702OfVW7p4TSSuzXi2A3rV8RjLwe13w
	 vikjUTet/tDwr/fCxsoaidm168m4FUJ+Q64ySVUHMQ0rgQ/nt3n815LNWXX6ABvOjL
	 nSGDgnjcdA9z3mSwZgRV6Mj7XWVBhWSfdkiA3PUp4bSSfOLKvbdwSBY2zdDwXtsqae
	 h1fJ2vzOW/ZWEHnv2oA2yE4ff5s5iAGmWRdHJiSYnj+cEY3CkGRB/MivZdskc4KO/I
	 8bEQNGWYHBe4g67WxXC75N8VlXtE3ja3lTDQaiHKJc4US9HTDVaKPCMqMW5bhL3p27
	 G1tlE/gtGh++Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	KernelCI bot <bot@kernelci.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS
Date: Mon, 28 Jul 2025 10:51:25 -0400
Message-Id: <20250728145125.2340542-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072854-backstab-skeletal-e45e@gregkh>
References: <2025072854-backstab-skeletal-e45e@gregkh>
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
index c846119c448f..590617240947 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -133,7 +133,7 @@ endif
 
 # Need -Uarm for gcc < 3.x
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include $(srctree)/arch/arm/include/asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
 
-- 
2.39.5


