Return-Path: <stable+bounces-2986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFE77FC706
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FEA286E23
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4293527B;
	Tue, 28 Nov 2023 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbXqbBdg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351FE44399
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 21:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BF4C433AD;
	Tue, 28 Nov 2023 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205660;
	bh=eIk2dnnN8ECjpLeVjR074CRL1uhZ+7+Nsn/KwElj5rE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbXqbBdgZc1mOSUbzJYtPjc67j8RcO0TNmkIRYDJ3PlSgr8liUcnS5SQVTOW2/YYl
	 hXf3VWWDPCKwy6BRImjIfDymzbwuArxSJfCzlxfVAR5aAo44HKiWUeTCLMwkv2Ccwi
	 hr0dwcXfWL9wtbw6+so6HUNoU8vjkgnTe6UaeR4/bcgsYA4vPhOSi2IPVPX5hycwmD
	 x7FAZ5K1zokXdzCAuu7EDJiwUX/k5lJMkalr+18IShXqfwrJPyHGDLvV4MRszFLLfb
	 E4bfil1yh141Lbrsi2/yxsRHNImLYU1KlnijkZ9dYs/CyR6ARuJ4W+zyyhjcii9ptJ
	 oPtgxHio8zlNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	SImon Glass <sjg@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 40/40] arm64: add dependency between vmlinuz.efi and Image
Date: Tue, 28 Nov 2023 16:05:46 -0500
Message-ID: <20231128210615.875085-40-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit c0a8574204054effad6ac83cc75c02576e2985fe ]

A common issue in Makefile is a race in parallel building.

You need to be careful to prevent multiple threads from writing to the
same file simultaneously.

Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
generate invalid images") addressed such a bad scenario.

A similar symptom occurs with the following command:

  $ make -j$(nproc) ARCH=arm64 Image vmlinuz.efi
    [ snip ]
    SORTTAB vmlinux
    OBJCOPY arch/arm64/boot/Image
    OBJCOPY arch/arm64/boot/Image
    AS      arch/arm64/boot/zboot-header.o
    PAD     arch/arm64/boot/vmlinux.bin
    GZIP    arch/arm64/boot/vmlinuz
    OBJCOPY arch/arm64/boot/vmlinuz.o
    LD      arch/arm64/boot/vmlinuz.efi.elf
    OBJCOPY arch/arm64/boot/vmlinuz.efi

The log "OBJCOPY arch/arm64/boot/Image" is displayed twice.

It indicates that two threads simultaneously enter arch/arm64/boot/
and write to arch/arm64/boot/Image.

It occasionally leads to a build failure:

  $ make -j$(nproc) ARCH=arm64 Image vmlinuz.efi
    [ snip ]
    SORTTAB vmlinux
    OBJCOPY arch/arm64/boot/Image
    PAD     arch/arm64/boot/vmlinux.bin
  truncate: Invalid number: 'arch/arm64/boot/vmlinux.bin'
  make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13:
  arch/arm64/boot/vmlinux.bin] Error 1
  make[2]: *** Deleting file 'arch/arm64/boot/vmlinux.bin'
  make[1]: *** [arch/arm64/Makefile:163: vmlinuz.efi] Error 2
  make[1]: *** Waiting for unfinished jobs....
  make: *** [Makefile:234: __sub-make] Error 2

vmlinuz.efi depends on Image, but such a dependency is not specified
in arch/arm64/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: SImon Glass <sjg@chromium.org>
Link: https://lore.kernel.org/r/20231119053234.2367621-1-masahiroy@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2d49aea0ff67a..26b8c7630a214 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -158,7 +158,7 @@ endif
 
 all:	$(notdir $(KBUILD_IMAGE))
 
-
+vmlinuz.efi: Image
 Image vmlinuz.efi: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-- 
2.42.0


