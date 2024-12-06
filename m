Return-Path: <stable+bounces-99991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D809E7B67
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 23:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDAD31885CE4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F401B87DA;
	Fri,  6 Dec 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUhGH5kE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DED22C6C0
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522982; cv=none; b=U+Zug800WrxMnEMNGozl2+Z0nhSciZgdODExRgFXru6Fn9wRKmjLrUlTfGoYL5NnDZZ9lnhBSXNZIrDirQGP2XjP9Np2D6vasMd4R/vYIp6UeXRb7DNNircnmD8+7GEMalXevUoeCcK+nc/FaP8qsesm8r2+KsGbi0FF7VZEeis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522982; c=relaxed/simple;
	bh=IoshGe0DuS2FUZ6yPy9DMR6cL9EMzjq3OH01IjJW7xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDjzTFIZ1XH4QfKCZAwptYzJw65lBEs8svERPTmKuqt7URks1kGq84oNNrRkNb7SSEAHpdoWz2RxqKuW8E27MCYmvC9iLgO/NAfUrL+Gn2t0CktN8cCWygdVexdPj3FGKRv4vwOyznEdz7Rqy4v6lbKTj/3fvutV61is4IZGuVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUhGH5kE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B0DC4CEDE;
	Fri,  6 Dec 2024 22:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733522982;
	bh=IoshGe0DuS2FUZ6yPy9DMR6cL9EMzjq3OH01IjJW7xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUhGH5kEeJDmPZ77TtaxG3mmJ9QNw7VykQmU9Vzq37wB2ld9AOHj+q5yz7S5ySsbE
	 JwHilnzSGtYjyr/n2Snm7PFL+eZ3owMyhC2zviYZ6gfArNHLoFv9LPQUWvDJj88XNE
	 KJLO3XvZH22zdisuSfKRVL6RT7IusdnObY9S/LLhFatkY88dtNGeCg4jlHHr/eOsFu
	 ZErhMXQ0WBH7tGbNieCaOl4Z0Psu/PTQzzD5VV3+OPQnXY7GrzaS/pRBtF+FUlEuJ7
	 4DZ7Yuggv1k4q8TMWu4sr4llJYqNFu3crpSnKbP1jwBklmfzpOfZ3CflC9MWHnRdYp
	 XGoFTQhAXYvdg==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	nathan@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.6] powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang
Date: Fri,  6 Dec 2024 15:09:26 -0700
Message-ID: <20241206220926.2099603-1-nathan@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2024120641-patriarch-wiring-1eed@gregkh>
References: <2024120641-patriarch-wiring-1eed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit d677ce521334d8f1f327cafc8b1b7854b0833158 upstream.

Under certain conditions, the 64-bit '-mstack-protector-guard' flags may
end up in the 32-bit vDSO flags, resulting in build failures due to the
structure of clang's argument parsing of the stack protector options,
which validates the arguments of the stack protector guard flags
unconditionally in the frontend, choking on the 64-bit values when
targeting 32-bit:

  clang: error: invalid value 'r13' in 'mstack-protector-guard-reg=', expected one of: r2
  clang: error: invalid value 'r13' in 'mstack-protector-guard-reg=', expected one of: r2
  make[3]: *** [arch/powerpc/kernel/vdso/Makefile:85: arch/powerpc/kernel/vdso/vgettimeofday-32.o] Error 1
  make[3]: *** [arch/powerpc/kernel/vdso/Makefile:87: arch/powerpc/kernel/vdso/vgetrandom-32.o] Error 1

Remove these flags by adding them to the CC32FLAGSREMOVE variable, which
already handles situations similar to this. Additionally, reformat and
align a comment better for the expanding CONFIG_CC_IS_CLANG block.

Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://patch.msgid.link/20241030-powerpc-vdso-drop-stackp-flags-clang-v1-1-d95e7376d29c@kernel.org
[nathan: Backport to 6.6, which lacks a6b67eb09963]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/kernel/vdso/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index 0c7d82c270c3..33d68e51cc9d 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -16,10 +16,14 @@ ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday-32.o += -ffreestanding -fasynchronous-unwind-tables
   CFLAGS_REMOVE_vgettimeofday-32.o = $(CC_FLAGS_FTRACE)
   CFLAGS_REMOVE_vgettimeofday-32.o += -mcmodel=medium -mabi=elfv1 -mabi=elfv2 -mcall-aixdesc
+  ifdef CONFIG_CC_IS_CLANG
   # This flag is supported by clang for 64-bit but not 32-bit so it will cause
   # an unused command line flag warning for this file.
-  ifdef CONFIG_CC_IS_CLANG
   CFLAGS_REMOVE_vgettimeofday-32.o += -fno-stack-clash-protection
+  # -mstack-protector-guard values from the 64-bit build are not valid for the
+  # 32-bit one. clang validates the values passed to these arguments during
+  # parsing, even when -fno-stack-protector is passed afterwards.
+  CFLAGS_REMOVE_vgettimeofday-32.o += -mstack-protector-guard%
   endif
   CFLAGS_vgettimeofday-64.o += -include $(c-gettimeofday-y)
   CFLAGS_vgettimeofday-64.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
-- 
2.47.1


