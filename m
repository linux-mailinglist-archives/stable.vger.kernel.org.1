Return-Path: <stable+bounces-99992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B68B59E7B6B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 23:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DCE2826A9
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 22:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9641EBFFC;
	Fri,  6 Dec 2024 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFNJxnr2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A82022C6C0
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523019; cv=none; b=c6CuIdIcfWoLBUQqQLkiNOV8f/mQvG2/i2xZ96a1+O1t8AzuN0QJ2Wwlw0PsW2bv6ldQx8qs4F3llwEAwFD54om39gvWrEKwdpgBWfA8xXFW00wwn9TtXHlOu0vVGWCv7Kmgv6J7Z0JyAAw+JVzmtdh8pA2wlC2kNeH5FWgcgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523019; c=relaxed/simple;
	bh=0qrEZT8ypuxzDYJYOIXcXVeWak1KmPT/Noz9JcsUEVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbW+kxTMQ0kydeGzhku/cGdXuGTvo8XRNLu+DO3uXeH+TLxjlYz8oInrA6WTVmv7oS299C+5laq1JE4+Jdx5f9FPqGbE1Rf422gxo1/KxGN1hKYLJ7sdBuuILZt5P/Nv8qsctKn2x6A9/uZSE+tjFTH8aH31TQsbUrbDck4/IYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFNJxnr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6079C4CED1;
	Fri,  6 Dec 2024 22:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733523018;
	bh=0qrEZT8ypuxzDYJYOIXcXVeWak1KmPT/Noz9JcsUEVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VFNJxnr2Tyb8jhggI6Zzd8r/utzJlq3vrd0w+H1VjLf2z0zeFyXFHCV2EHzBBfuM8
	 lPi9R0OwR3jGiGvbd0dtElxtfR5wX5oJxP1Q9YriS2sWwo/4Ep5rrFvg0r0QjhKA+N
	 PmKb+EFRde78w0tM6GCd/PHx0MbC7xdgPqGw0QwuKaLOzZKlDzxw2Dwc6j8CfECnFP
	 ZFbrqtmtoESTKtD3rd8osdrGx4Ja6O8PUpXClAdaFHaZo3fk6z28wKEgIhni8I2rKS
	 ufJcAyGk17edZpd1LPOXoSkvrKC9AataS0/axAQvw6ERLURasdwsyXxOL+Ca+t81sT
	 HqyC9/0q3eZUA==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	nathan@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.1] powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang
Date: Fri,  6 Dec 2024 15:10:05 -0700
Message-ID: <20241206221005.2313691-1-nathan@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2024120642-steep-reply-a3bd@gregkh>
References: <2024120642-steep-reply-a3bd@gregkh>
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
[nathan: Backport to 6.1, which lacks both a6b67eb09963 and 05e05bfc92d1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/kernel/vdso/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index a2e7b0ce5b19..48bf579eedae 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -16,6 +16,12 @@ ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday-32.o += -ffreestanding -fasynchronous-unwind-tables
   CFLAGS_REMOVE_vgettimeofday-32.o = $(CC_FLAGS_FTRACE)
   CFLAGS_REMOVE_vgettimeofday-32.o += -mcmodel=medium -mabi=elfv1 -mabi=elfv2 -mcall-aixdesc
+  ifdef CONFIG_CC_IS_CLANG
+  # -mstack-protector-guard values from the 64-bit build are not valid for the
+  # 32-bit one. clang validates the values passed to these arguments during
+  # parsing, even when -fno-stack-protector is passed afterwards.
+  CFLAGS_REMOVE_vgettimeofday-32.o += -mstack-protector-guard%
+  endif
   CFLAGS_vgettimeofday-64.o += -include $(c-gettimeofday-y)
   CFLAGS_vgettimeofday-64.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
   CFLAGS_vgettimeofday-64.o += $(call cc-option, -fno-stack-protector)
-- 
2.47.1


