Return-Path: <stable+bounces-167082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD678B2198C
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 01:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8519117405C
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 23:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D412853ED;
	Mon, 11 Aug 2025 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK0oCCYl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D6E22D9EB;
	Mon, 11 Aug 2025 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956335; cv=none; b=frKaZZJXl/qgAqdne/iRQRK1RI/Xo3PI8tkHnpuFEtDoeiV12b4H0lE579S3TmpzgrA8TEJyAUWjmYjyugqRW/j6urk7afpqZFn5EEdey8HcvxSirOBowXShq0gADyZvQNTJVQ6B8Obpr/28bQ/xMo95MJAjhYSLC/8go+y7jog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956335; c=relaxed/simple;
	bh=VMH4XbUs0IzBAgNuYmjlScITgfW0kOl+OQENiCsEAxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryYF+BoO9PR2AONjPhhPaxp2Mg1ORKHFIPWwbUPyF2ncJp3l4f/cjQTr2fflyU/y2hiciHd/E9IHODOGes0ocmbfB9MffEbhx9rZCoq8OXvwLzkRrcAkYfGlF4kz44aXNgEQEQnxWnLZnJkX8PmJIHkK6bBKmoVgEk/2ryRWGcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK0oCCYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39862C4CEED;
	Mon, 11 Aug 2025 23:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754956335;
	bh=VMH4XbUs0IzBAgNuYmjlScITgfW0kOl+OQENiCsEAxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VK0oCCYl7jVAq3ZWQDv4kNWPE0bHn9QdRhSdd6Ief9XSgcAOYWTNWZP5TAapjFzKE
	 X5qfd6yE8QVhzJI0hbopBh4GbHhKZYe6E3vE7M3aM987VJcPh4GAIVvYkliYmtP5u/
	 ewrUIWZvdoxBBEiuXQrsrbIU6dBB9Ifv5K6z6pBRF3txb/6GmGCpB+yJG+rHTw75cN
	 plhkF4QAF4urGBRNaz9nFBlE2615D5bEy1j7Nt3b0CWm8qyA0HqkoHejdmfFiGc68/
	 eZpGOYcnVugBdB3Hyvk3B3kBzaaB/hjNcsbb+pIxJcMoJK6z0F5yRA0oFURUZ3JWcG
	 pimJI3xka4gEQ==
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 5.4 1/6] ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS
Date: Mon, 11 Aug 2025 16:51:46 -0700
Message-ID: <20250811235151.1108688-2-nathan@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811235151.1108688-1-nathan@kernel.org>
References: <20250811235151.1108688-1-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 87c4e1459e80bf65066f864c762ef4dc932fad4b upstream.

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
[nathan: Fix conflicts]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4f098edfbf20..cb33ed8de5f8 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -136,7 +136,7 @@ endif
 
 # Need -Uarm for gcc < 3.x
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include $(srctree)/arch/arm/include/asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
 
-- 
2.50.1


