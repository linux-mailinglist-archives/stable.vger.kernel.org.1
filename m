Return-Path: <stable+bounces-2964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D1A7FC6DC
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CBF2865F8
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF2744C8C;
	Tue, 28 Nov 2023 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiWeM5qQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B6B42AAA;
	Tue, 28 Nov 2023 21:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF79C433C7;
	Tue, 28 Nov 2023 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205609;
	bh=xRoEIjR3KV/1kAEQG2vgN5KGGWtoecQCkzDjciK9N1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aiWeM5qQns4M7irrxvJIn1lTTAyaAZbs86/QCO2v+Y2kc0l1tLFVIVWUkgdM8aMGc
	 G+e0PWBmBWe9+YkDzoWc5H7rqR6B4MOcAzwjX1R3tEK50OzFWK3zqgqMR0t/Zg0nFZ
	 LyxxuQMcXMttXI8os53ZJONFJYEw9ZsoZBrZrDeZuTGWHNKuBhP1gRHCeM17VphznU
	 Wvig8Qa6KiOloUD4UwiBPPpDeAjkAHCFcAJzON6bbd9wm8EK4HCbjfl+SbWissloLl
	 GOCN3DDiiD90il4oayJ8OWiQDtd0+92kWrFfOEgD71EjxJI3mTAnvMvG4l/mqTnupW
	 jZv1T1ItfYiNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 18/40] LoongArch: Add dependency between vmlinuz.efi and vmlinux.efi
Date: Tue, 28 Nov 2023 16:05:24 -0500
Message-ID: <20231128210615.875085-18-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
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
index fb0fada43197e..96747bfec1a10 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -142,6 +142,8 @@ vdso_install:
 
 all:	$(notdir $(KBUILD_IMAGE))
 
+vmlinuz.efi: vmlinux.efi
+
 vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(bootvars-y) $(boot)/$@
 
-- 
2.42.0


