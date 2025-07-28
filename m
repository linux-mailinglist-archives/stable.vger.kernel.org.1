Return-Path: <stable+bounces-164967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB4FB13D4A
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8844189A306
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DA53C1F;
	Mon, 28 Jul 2025 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nt4g0cZT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ECF846C
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713357; cv=none; b=XvRFdvYYGV+EI27A6gT5Cul0s75E8vw4FFMygZ2a5rm6yP4AK9DZnoISOB9IMDDMJ27Jxnk9f8zSNFBaCnELogvGLBrJ/PI3o1Hn6qD7FI/9QDuehhu7qKqptWQgQV8LalOTdC7dHMbzece0Z+oTCIjgk0/auQ1T+W+4Dq2nBlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713357; c=relaxed/simple;
	bh=ncNsECm20uOiN6uWg/cYMtd4cbxdvq49C6+F11BtWjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBOkthgdGpPQm06sYI3eXZl3vt6ITcsGo7EvKiKpwaCPj6VRRqViKqA2lPw1JQPLZvxeZnFtHFgpwu7CdKT3yk49mpqztpNyZ/zcdW1pxLNuac+2ppC6LbAoTFeody3YWoy8a3B5D9McauBXE88aA4EVqKuXpbtd5TJ8Fgz55P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nt4g0cZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F96CC4CEE7;
	Mon, 28 Jul 2025 14:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753713356;
	bh=ncNsECm20uOiN6uWg/cYMtd4cbxdvq49C6+F11BtWjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nt4g0cZTBF5JFjAbuQ7PusEDhiPjwX3VMuWnjCYqigOoaIzFwmiYKwIK8DNcJZnkr
	 iK1tLGj/Z0SGGcR6h9vzfzvMf+VY9mVnYXOWVlZQ8mO6Dgb372t1CQM7jWuf8paXos
	 sPDxH/GbIL3CuJqe9n8yR5RWBDRIF+A+HAhqP0vU4sD0KutYnsPljmjYGeSgSefFbk
	 qYoRzXANk1lfzblDpsfZgTygOI80ylzOplxtQVdesVmbB+PplxEkKsuhs3BPbemSK9
	 AxXdEKRmz40AcaCFOzyid5ZWy5KKTek0pGrzFScfFE8P/09e9wKo+QZY01fJ/OIqsF
	 8HWEv264c7mdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	KernelCI bot <bot@kernelci.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS
Date: Mon, 28 Jul 2025 10:35:52 -0400
Message-Id: <20250728143552.2337910-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072854-unpledged-repaint-0eac@gregkh>
References: <2025072854-unpledged-repaint-0eac@gregkh>
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
[ No KBUILD_RUSTFLAGS in <=6.12 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5ba42f69f8ce..351d0b039b5c 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -142,7 +142,7 @@ endif
 # Need -Uarm for gcc < 3.x
 KBUILD_CPPFLAGS	+=$(cpp-y)
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -include $(srctree)/arch/arm/include/asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
 
-- 
2.39.5


