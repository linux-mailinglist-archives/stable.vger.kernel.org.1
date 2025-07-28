Return-Path: <stable+bounces-164978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80DAB13DBC
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCC03BB5E1
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE0426772C;
	Mon, 28 Jul 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0oHpMOi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14426FA60
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714542; cv=none; b=QQviPedDSqiWn7jvvysEjvyeA02IWn+H6Ymln5DJyyRVfEpMdZ1x2XzevNxJnyHDticFXMKuykwh3Wx9pSiOd7/PQ4J638gLwLK7t4H1d5cJyUyJmNaakpx83W5JgIRRNUR9UhHyDHAADmJxxgDS4g3BvoVVbW8aNd8i/6wkRU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714542; c=relaxed/simple;
	bh=VTAIKQaTVAbAl4rDe5qzMRzQLOuSyg/xk7oStGwzAno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XuhKc0Vivqc3Ks2scL5vJsNgATvPYIj9st8bLW9ZnIG/xGGvl6ioYzmmr/M7iDe+Q1MjxljrHGmOqD1MRi5wbWBrOGXxZAjMxD/eJmSxmB/1qgB2AEqIFW95HDXje5KJHE62/hpiQJZbwWDNuUB6A9PVcr/8v2nK/+ikEnFptNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0oHpMOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769DAC4CEE7;
	Mon, 28 Jul 2025 14:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753714541;
	bh=VTAIKQaTVAbAl4rDe5qzMRzQLOuSyg/xk7oStGwzAno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0oHpMOilgaz/ppFlN2+bb7kLs+bt1mj0In6psV5MHVK5CJ+D0f94uSmhy70VdIjr
	 G1yZ/G55nY39uOblVI/zJXeMDH/zf3LeVVj038OzVt5XoAteZCjuW48kCyaLR16TRO
	 xTOHWFJEqa8RIl4DZ9hubvz56jOSpbxIvUhIzAFLwMGBpWvG2YSDaRoSeBy2xnM9QE
	 G/3EHI2rA7NMFpUvksVEIQ0vYmqVBLx6109PDfRw1UpkyrL+8ljiTw0np5g0Ad0xym
	 mCuo3LVNnykiJr4voGTL90xSXfu7D7q3K8tIcSUlf9G5TZMRYf8EKsBesnKA+rNZso
	 FZ1I0btZWhNCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	KernelCI bot <bot@kernelci.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ARM: 9448/1: Use an absolute path to unified.h in KBUILD_AFLAGS
Date: Mon, 28 Jul 2025 10:55:37 -0400
Message-Id: <20250728145537.2340885-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072855-footbath-stooge-3311@gregkh>
References: <2025072855-footbath-stooge-3311@gregkh>
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
index fa45837b8065..326dba5dd530 100644
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


