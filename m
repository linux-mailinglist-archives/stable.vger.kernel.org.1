Return-Path: <stable+bounces-164960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 916CDB13CE2
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09856189178D
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE1E26B76D;
	Mon, 28 Jul 2025 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyhTShMX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED2526B748
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712201; cv=none; b=O6Ip2KOPe++GorXS5X3Rt0GO+NLmdQWcXanPlAHSITPAhggROJKlfsD51hhxZUtNTvBQiBLzHF94T9i1aUwjCFzWbd1ODRyJp85TOxZHBVNLNNlAsS+pLDFXWnwAsKpAubqHSUDaMiCvz3VVx92rFYhv5bCGX1xK1LoEVuRFg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712201; c=relaxed/simple;
	bh=RJCRycmZUaaeiBtTNJFt/o7W2IeheFtDGQn++Fqb9ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTPJPV8G5+Ee1bverZiMBz29HT3r8sofBEzJgtMBAxUaAtxmM0WgmRGYOnagQx48eFG51QVMcNKpQpxLYHnGImXzSpdO/hvdUVvMbOruF3up0CKj96kPPKzrB9r/JDdgYGl34XvNjtuyRdHxSjscAZ4d1qvaHODjixnUZFRglx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyhTShMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83912C4CEE7;
	Mon, 28 Jul 2025 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753712200;
	bh=RJCRycmZUaaeiBtTNJFt/o7W2IeheFtDGQn++Fqb9ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyhTShMX7o7J5ET5N7a6LIQpNx13J/BRCTixn1inMbc7SLvFZwmvDqrHqn3GlNfJ9
	 hvqZ4OnKCCU6oVYmS/u8Z9DeGjq3vlYJLqCVFQ6BPmXO27M3iWLPYKkSlNcFvnpjH0
	 gab5qbVpovkwtTearOOIi7p3L+6RlvDdml987pRurU28wZwf+Q1NewWApzlOHSr58T
	 priwMs/K3qt1nSvnVi3WIGjHtT+8tqVSz94L/dizi2uBzZApQKRzFN5rp17vpuRNyR
	 t2tHzjvbmtRYWDbhTTvslps7QQtf5lzewTQoAGfvFxf9N+XwzMiN1ICwk7a4MTp12g
	 wW/Oas1qzWnmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	KernelCI bot <bot@kernelci.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS
Date: Mon, 28 Jul 2025 10:16:34 -0400
Message-Id: <20250728141634.2334125-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072848-unwitting-glandular-25db@gregkh>
References: <2025072848-unwitting-glandular-25db@gregkh>
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
[ No KBUILD_RUSTFLAGS in 6.12 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index aafebf145738..dee8c9fe25a2 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -149,7 +149,7 @@ endif
 # Need -Uarm for gcc < 3.x
 KBUILD_CPPFLAGS	+=$(cpp-y)
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -include $(srctree)/arch/arm/include/asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
 
-- 
2.39.5


