Return-Path: <stable+bounces-3001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D49D7FC726
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D34B25457
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B131D42ABD;
	Tue, 28 Nov 2023 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC17FHeD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E944379;
	Tue, 28 Nov 2023 21:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE09C433BA;
	Tue, 28 Nov 2023 21:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205699;
	bh=tLrGMh0H+lbFTvu/4CZ0b9WmlugO7q8z7G2NZDJFJAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XC17FHeDBqpF7jjuHgX44b2JwoTZwhiXbs9tgCTxoic4AEBwWW5OrrUn/PDrciHFJ
	 n+7HastfEwIWIyNvbw1XKFU+CtbAJKCLfcgNs5LZYCmUVHr3W8rUqc3ShbrK76i2aQ
	 43kIbY4V8TdIIM3uiSh/lXq6L9N+VARHCGYlKK09rdgiWG7mKr2cI5cw4/bT7P7CIA
	 Z87MfxDudw4LwMhExFpDcLl91CMX5CzbqGM9sPjHUraN82zQzKIDnZGhIFASFdO4K1
	 JgGYtsrD5Y7OJC0HnGy8t6q3c4rwlPnoKt/mrFPNRQaLka+9Dag/DiJAMpnHWFzDnD
	 weF8/m0nQcCmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 15/25] LoongArch: Add dependency between vmlinuz.efi and vmlinux.efi
Date: Tue, 28 Nov 2023 16:07:31 -0500
Message-ID: <20231128210750.875945-15-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210750.875945-1-sashal@kernel.org>
References: <20231128210750.875945-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.64
Content-Transfer-Encoding: 8bit

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit d3ec75bc635cb0cb8185b63293d33a3d1b942d22 ]

A common issue in Makefile is a race in parallel building.

You need to be careful to prevent multiple threads from writing to the
same file simultaneously.

Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
generate invalid images") addressed such a bad scenario.

A similar symptom occurs with the following command:

  $ make -j$(nproc) ARCH=loongarch vmlinux.efi vmlinuz.efi
    [ snip ]
    SORTTAB vmlinux
    OBJCOPY arch/loongarch/boot/vmlinux.efi
    OBJCOPY arch/loongarch/boot/vmlinux.efi
    PAD     arch/loongarch/boot/vmlinux.bin
    GZIP    arch/loongarch/boot/vmlinuz
    OBJCOPY arch/loongarch/boot/vmlinuz.o
    LD      arch/loongarch/boot/vmlinuz.efi.elf
    OBJCOPY arch/loongarch/boot/vmlinuz.efi

The log "OBJCOPY arch/loongarch/boot/vmlinux.efi" is displayed twice.

It indicates that two threads simultaneously enter arch/loongarch/boot/
and write to arch/loongarch/boot/vmlinux.efi.

It occasionally leads to a build failure:

  $ make -j$(nproc) ARCH=loongarch vmlinux.efi vmlinuz.efi
    [ snip ]
    SORTTAB vmlinux
    OBJCOPY arch/loongarch/boot/vmlinux.efi
    PAD     arch/loongarch/boot/vmlinux.bin
  truncate: Invalid number: ‘arch/loongarch/boot/vmlinux.bin’
  make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13:
  arch/loongarch/boot/vmlinux.bin] Error 1
  make[2]: *** Deleting file 'arch/loongarch/boot/vmlinux.bin'
  make[1]: *** [arch/loongarch/Makefile:146: vmlinuz.efi] Error 2
  make[1]: *** Waiting for unfinished jobs....
  make: *** [Makefile:234: __sub-make] Error 2

vmlinuz.efi depends on vmlinux.efi, but such a dependency is not
specified in arch/loongarch/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 01b57b7263225..ed47a3a87768e 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -116,6 +116,8 @@ vdso_install:
 
 all:	$(notdir $(KBUILD_IMAGE))
 
+vmlinuz.efi: vmlinux.efi
+
 vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(bootvars-y) $(boot)/$@
 
-- 
2.42.0


