Return-Path: <stable+bounces-178908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6FAB48F04
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 15:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F291C22025
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB67C30C62F;
	Mon,  8 Sep 2025 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8l2QPQ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629A830C621;
	Mon,  8 Sep 2025 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337189; cv=none; b=u/LErT2Zhb5Na9B/PotVrGYFtuJfiRN65SV2+cxZ0NQlme0fyXGSyk99WeNYRg7Do2NqRiv2MkqFxHzG95lhqP4LmtoCQArzrNMY6uGQsNbf5X+P95PS1POmJUk0bHX5l0hDykHE8/wp4CmRhjRqO7VZjj8cJjGZ7rCGcSJFFG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337189; c=relaxed/simple;
	bh=fQDFjQcz0IedbEFnJ9guRZ4GSjnRmUcisJu/YxLaXoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N6nwiGLegxxU8dakxtFbAB//t0X2olbscNuAC8BKhiV6pTEHL9MwCVZBPf6i8Fp6b4vZ7NaWnhLVHM1ZPhfy+LqYfVKgjAUc7zv/cVGSwmxMsTdbPeLYTMMnkGU017gJ7tKPGaH0m0CzpLc7SGdYHu45ePtvYiyI0FQg98DTixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8l2QPQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEC8C2BC86;
	Mon,  8 Sep 2025 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757337188;
	bh=fQDFjQcz0IedbEFnJ9guRZ4GSjnRmUcisJu/YxLaXoM=;
	h=From:To:Cc:Subject:Date:From;
	b=G8l2QPQ41pxBIHkLR7HU/T70zTPGfaD187Bytk4z3y9NnnMHH5yWjZqiuCnTGTLU6
	 XzX7C409xVbJUG0ePo0vqWMsp1YwYOiSs5xTmzcLNLFDIySLH9IMsit3BTu0F7GpHB
	 aWwKZqwD+RsXOm/R9Slu+GRWDTE6AQ68yHTytJCo1nXWn2GlIPpSIFeMhdTHip/wQa
	 rqA282SGFv/PYKPIaY45pHpiAAGdHoUx3P/raUa0OYaTnZBgb5T6/h7SP3esTddSlO
	 g4bP4NLhrSQOH8qLD7HHYNCzbzkNX4+pSBmMBQWTXznI44pM2QLfiUa9f9Rnrf25jQ
	 apubOiibtlfAw==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Matthew Maurer <mmaurer@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-riscv@lists.infradead.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v1] rust: cfi: only 64-bit arm and x86 support CFI_CLANG
Date: Mon,  8 Sep 2025 14:12:35 +0100
Message-ID: <20250908-distill-lint-1ae78bcf777c@spud>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2580; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=y1gmjhD9ErBCpNbGt7upWsHOxmK+aK3iAxT5o+MajMg=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBn7rjlxhZfcU/YQu8H4v4TLsG/KveL3veGXLzMLbDawt ytTPnW/o5SFQYyLQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABN5z8bwP+V27y2uE4eNuJQV ZovtdS37k5VzQvrbgY2LL0Z5XuK88Jbhf+TlnPWyUnEVERtu+kx71Wr8o3bR3PjZjPOmM/5ninL 4ywsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The kernel uses the standard rustc targets for non-x86 targets, and out
of those only 64-bit arm's target has kcfi support enabled. For x86, the
custom 64-bit target enables kcfi.

The HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC config option that allows
CFI_CLANG to be used in combination with RUST does not check whether the
rustc target supports kcfi. This breaks the build on riscv (and
presumably 32-bit arm) when CFI_CLANG and RUST are enabled at the same
time.

Ordinarily, a rustc-option check would be used to detect target support
but unfortunately rustc-option filters out the target for reasons given
in commit 46e24a545cdb4 ("rust: kasan/kbuild: fix missing flags on first
build"). As a result, if the host supports kcfi but the target does not,
e.g. when building for riscv on x86_64, the build would remain broken.

Instead, make HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC depend on the only
two architectures where the target used supports it to fix the build.

CC: stable@vger.kernel.org
Fixes: ca627e636551e ("rust: cfi: add support for CFI_CLANG with Rust")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Alexandre Ghiti <alex@ghiti.fr>
CC: Miguel Ojeda <ojeda@kernel.org>
CC: Alex Gaynor <alex.gaynor@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Gary Guo <gary@garyguo.net>
CC: "Björn Roy Baron" <bjorn3_gh@protonmail.com>
CC: Benno Lossin <lossin@kernel.org>
CC: Andreas Hindborg <a.hindborg@kernel.org>
CC: Alice Ryhl <aliceryhl@google.com>
CC: Trevor Gross <tmgross@umich.edu>
CC: Danilo Krummrich <dakr@kernel.org>
CC: Kees Cook <kees@kernel.org>
CC: Sami Tolvanen <samitolvanen@google.com>
CC: Matthew Maurer <mmaurer@google.com>
CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: rust-for-linux@vger.kernel.org
---
 arch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd6e0856..880cddff5eda7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -917,6 +917,7 @@ config HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
 	def_bool y
 	depends on HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG
 	depends on RUSTC_VERSION >= 107900
+	depends on ARM64 || X86_64
 	# With GCOV/KASAN we need this fix: https://github.com/rust-lang/rust/pull/129373
 	depends on (RUSTC_LLVM_VERSION >= 190103 && RUSTC_VERSION >= 108200) || \
 		(!GCOV_KERNEL && !KASAN_GENERIC && !KASAN_SW_TAGS)
-- 
2.47.2


