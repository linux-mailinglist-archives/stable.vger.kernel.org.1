Return-Path: <stable+bounces-46733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D3D8D0B08
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9A91F22A6F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A10161302;
	Mon, 27 May 2024 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SUn7TCgD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165315FD01;
	Mon, 27 May 2024 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836720; cv=none; b=UYI/7o9U329fbHyoAl6HgO8kfoMrxZxT0r+XXOsCxcaa6uvDcIS3cxzY+NfgaHzd6H8ad8+nsXEx/g1qKcQ8A8NtQzDAMX68hIp/Kcd+Ncj0vFWKN0YRq+TsDMpA3Bw/rHmMVeyGswKIym/+C78bvR0Wke1iz5M8tnK4WdkNa2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836720; c=relaxed/simple;
	bh=wxTA85deJV4Bf7yIqbZWJ5sHhyurRkCmNtVD8GN+FSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgKv3Xle4MU6i0Gyikc5qe6HXDnY00RWZlZI2ANZokJ77+lCSWkfp6HF+pJmyvBJ9dLG9rTcH+nq9yGfaxyspW7KsZdzZKXHj3hHTkk564kdNvCfKML+NVxRLa1i2Yvlc5xo4xSUQnHUGnFQ8qjFDHJLAM0MxRbDBF7L0F9JaZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SUn7TCgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CE4C2BBFC;
	Mon, 27 May 2024 19:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836719;
	bh=wxTA85deJV4Bf7yIqbZWJ5sHhyurRkCmNtVD8GN+FSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUn7TCgDqgaFL3Ic94dLIqV0JXlAhNklSMy5gsFIY4RywbUsIEt/4rpPwF+UTg6Jh
	 CBv9MXo2r1mtm+6XsQHPKXdiopS+xrQZds3t8FH1+KqTtSTP6zx0I4AwKsLqnhjiqt
	 PJYjQec0/8H38pq7S0kJl7j0YRDfuuGc7rc3TgvU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Fangrui Song <maskray@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 161/427] x86/purgatory: Switch to the position-independent small code model
Date: Mon, 27 May 2024 20:53:28 +0200
Message-ID: <20240527185617.425136056@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit cba786af84a0f9716204e09f518ce3b7ada8555e ]

On x86, the ordinary, position dependent small and kernel code models
only support placement of the executable in 32-bit addressable memory,
due to the use of 32-bit signed immediates to generate references to
global variables. For the kernel, this implies that all global variables
must reside in the top 2 GiB of the kernel virtual address space, where
the implicit address bits 63:32 are equal to sign bit 31.

This means the kernel code model is not suitable for other bare metal
executables such as the kexec purgatory, which can be placed arbitrarily
in the physical address space, where its address may no longer be
representable as a sign extended 32-bit quantity. For this reason,
commit

  e16c2983fba0 ("x86/purgatory: Change compiler flags from -mcmodel=kernel to -mcmodel=large to fix kexec relocation errors")

switched to the large code model, which uses 64-bit immediates for all
symbol references, including function calls, in order to avoid relying
on any assumptions regarding proximity of symbols in the final
executable.

The large code model is rarely used, clunky and the least likely to
operate in a similar fashion when comparing GCC and Clang, so it is best
avoided. This is especially true now that Clang 18 has started to emit
executable code in two separate sections (.text and .ltext), which
triggers an issue in the kexec loading code at runtime.

The SUSE bugzilla fixes tag points to gcc 13 having issues with the
large model too and that perhaps the large model should simply not be
used at all.

Instead, use the position independent small code model, which makes no
assumptions about placement but only about proximity, where all
referenced symbols must be within -/+ 2 GiB, i.e., in range for a
RIP-relative reference. Use hidden visibility to suppress the use of a
GOT, which carries absolute addresses that are not covered by static ELF
relocations, and is therefore incompatible with the kexec loader's
relocation logic.

  [ bp: Massage commit message. ]

Fixes: e16c2983fba0 ("x86/purgatory: Change compiler flags from -mcmodel=kernel to -mcmodel=large to fix kexec relocation errors")
Fixes: https://bugzilla.suse.com/show_bug.cgi?id=1211853
Closes: https://github.com/ClangBuiltLinux/linux/issues/2016
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Fangrui Song <maskray@google.com>
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/all/20240417-x86-fix-kexec-with-llvm-18-v1-0-5383121e8fb7@kernel.org/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/purgatory/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index bc31863c5ee63..a18591f6e6d94 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -42,7 +42,8 @@ KCOV_INSTRUMENT := n
 # make up the standalone purgatory.ro
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
-PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
+PURGATORY_CFLAGS := -mcmodel=small -ffreestanding -fno-zero-initialized-in-bss -g0
+PURGATORY_CFLAGS += -fpic -fvisibility=hidden
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
 
-- 
2.43.0




