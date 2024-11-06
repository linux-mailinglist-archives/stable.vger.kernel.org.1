Return-Path: <stable+bounces-89948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3A69BDBD4
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FB0284627
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04B18FDB0;
	Wed,  6 Nov 2024 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLHmkCgU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA218C903;
	Wed,  6 Nov 2024 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858923; cv=none; b=VFu+DtC08/RIQH2WrvtFKb3jTdYQNLcdTM3w6bkYFC4uEk6NrN/g9YvrjGV6IHJv9YPONx5EoY+jy4yQUwyu1O305jJ2hGYruQgI8fAmAmWjsCXFWhMe/mCQ2FUfF63jfLwfpSuZFmFcCxbHbpJl4zEamnQRuk/Sf1snWhDFFKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858923; c=relaxed/simple;
	bh=6RdsDJCekACBSQ/decuXvIXkG38AIIzXKc9s9K/m2gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lr3yLsxcELH4ZEviu4VrdtYRl43Kp66ga93tfizhtb2RKCgp6I57JX1ngQT8C4vwsTy8cCULleIFdUoHWaWnpcWWU76y+OCW8pwiyzMGpu/KGmNyDo5x+9haai1+tVh1qGfMb/KhC64edndvDOMH+JcYFOF6hUhhygWJM6mBgH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLHmkCgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9674AC4CECF;
	Wed,  6 Nov 2024 02:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730858923;
	bh=6RdsDJCekACBSQ/decuXvIXkG38AIIzXKc9s9K/m2gg=;
	h=From:To:Cc:Subject:Date:From;
	b=bLHmkCgUJ8DNphFMJIs7Y3zWta2o/5rLa7tqziceKYdXxus72OVZ4cX+WT3Owi4tH
	 GeCEDoEbkPXfWNLhFNVRVU3ay+cNaMYJa2ReoghcKoWNjHPVVVZiSKrXE4aKEMlWiu
	 H2tS88ZzFwO7Re5Wmuz1xRquMvrWiIZAYE8kPVY1o1dNUEzaUzR9cfq2ejIEddVgFN
	 wullEsRfSuLLKnImSGCS7lZiFgtk8mlvUoks/y7F+tzmnA9rmXFNGKZGhkjzQAC4Qo
	 dnAnympltpJLRlZvIwnNaoabTBpI8AijOmlIq0rBxWkCkSfY+sT2XPQybyA8l/2DxZ
	 XsNTTbAkmF/1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	conor.dooley@microchip.com
Cc: Jason Montleon <jmontleo@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	rust-for-linux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev
Subject: FAILED: Patch "RISC-V: disallow gcc + rust builds" failed to apply to v6.11-stable tree
Date: Tue,  5 Nov 2024 21:08:39 -0500
Message-ID: <20241106020840.164364-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 33549fcf37ec461f398f0a41e1c9948be2e5aca4 Mon Sep 17 00:00:00 2001
From: Conor Dooley <conor.dooley@microchip.com>
Date: Tue, 1 Oct 2024 12:28:13 +0100
Subject: [PATCH] RISC-V: disallow gcc + rust builds

During the discussion before supporting rust on riscv, it was decided
not to support gcc yet, due to differences in extension handling
compared to llvm (only the version of libclang matching the c compiler
is supported). Recently Jason Montleon reported [1] that building with
gcc caused build issues, due to unsupported arguments being passed to
libclang. After some discussion between myself and Miguel, it is better
to disable gcc + rust builds to match the original intent, and
subsequently support it when an appropriate set of extensions can be
deduced from the version of libclang.

Closes: https://lore.kernel.org/all/20240917000848.720765-2-jmontleo@redhat.com/ [1]
Link: https://lore.kernel.org/all/20240926-battering-revolt-6c6a7827413e@spud/ [2]
Fixes: 70a57b247251a ("RISC-V: enable building 64-bit kernels with rust support")
Cc: stable@vger.kernel.org
Reported-by: Jason Montleon <jmontleo@redhat.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20241001-playlist-deceiving-16ece2f440f5@spud
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 Documentation/rust/arch-support.rst | 2 +-
 arch/riscv/Kconfig                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index 750ff371570a0..54be7ddf3e57a 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -17,7 +17,7 @@ Architecture   Level of support  Constraints
 =============  ================  ==============================================
 ``arm64``      Maintained        Little Endian only.
 ``loongarch``  Maintained        \-
-``riscv``      Maintained        ``riscv64`` only.
+``riscv``      Maintained        ``riscv64`` and LLVM/Clang only.
 ``um``         Maintained        \-
 ``x86``        Maintained        ``x86_64`` only.
 =============  ================  ==============================================
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 62545946ecf43..f4c570538d55b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -177,7 +177,7 @@ config RISCV
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RETHOOK if !XIP_KERNEL
 	select HAVE_RSEQ
-	select HAVE_RUST if RUSTC_SUPPORTS_RISCV
+	select HAVE_RUST if RUSTC_SUPPORTS_RISCV && CC_IS_CLANG
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_STACKPROTECTOR
-- 
2.43.0





