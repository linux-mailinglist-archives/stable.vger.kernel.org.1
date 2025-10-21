Return-Path: <stable+bounces-188539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314F8BF86E5
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE013580507
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 19:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD94274B2E;
	Tue, 21 Oct 2025 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f3/1uUI9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D2246798;
	Tue, 21 Oct 2025 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076730; cv=none; b=IMMel1+npeTHi6J+hshARDRMslOwlsOXBlvzqAbml7WeRSbr53y5OpfSVzI6ebCk4CgRDRBD28mylyO5Y88ZJPydYkJSCu1Wp6XfWRIibVLlJ24LZKr1WvThdOKh3UHterSFfy2JqfjQ3LwERP98we1WkuQHK8A7EBVhkdY+7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076730; c=relaxed/simple;
	bh=z8WVqxBFbgDsHuNLgM1FHAPfqSB61aw9dmomFUgLXqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVxqIabmCgCw4ULLDX6hMRyFg2/6h+lXZcl6vYn5GMx9kLkkr1DSNcE0ITOMrS183atfn8mzDsE8YJVPJdNrpjm1nmOmA0TlwzOVWH5tdcIm9vrkzZvycqyazDaEpsk2NYDHEu9Uc5CuFEWrIKTFA6/c3/plYFHkxN+ouJXSeCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f3/1uUI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5023C4CEF1;
	Tue, 21 Oct 2025 19:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761076728;
	bh=z8WVqxBFbgDsHuNLgM1FHAPfqSB61aw9dmomFUgLXqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3/1uUI9zu1rK1mYdBVPJJcCrn78vxavAe7/Dfjfbr5S5Ymfgi4rqLDKFnhLNSRlR
	 kAwne4qCNhMlmfRC9bU40AEv6qAKlGRndrba5T1RptUoawfrKUkLuahWyvNNsEtb3C
	 XP/qTuGf0DVSIK+6N6vKnSWnO+xZxAa5Fwq8hfFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Paul Walmsley <pjw@kernel.org>
Subject: [PATCH 6.12 002/136] rust: cfi: only 64-bit arm and x86 support CFI_CLANG
Date: Tue, 21 Oct 2025 21:49:50 +0200
Message-ID: <20251021195036.014512641@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021195035.953989698@linuxfoundation.org>
References: <20251021195035.953989698@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Conor Dooley <conor.dooley@microchip.com>

commit 812258ff4166bcd41c7d44707e0591f9ae32ac8c upstream.

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
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20250908-distill-lint-1ae78bcf777c@spud
Signed-off-by: Paul Walmsley <pjw@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -861,6 +861,7 @@ config HAVE_CFI_ICALL_NORMALIZE_INTEGERS
 	def_bool y
 	depends on HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG
 	depends on RUSTC_VERSION >= 107900
+	depends on ARM64 || X86_64
 	# With GCOV/KASAN we need this fix: https://github.com/rust-lang/rust/pull/129373
 	depends on (RUSTC_LLVM_VERSION >= 190103 && RUSTC_VERSION >= 108200) || \
 		(!GCOV_KERNEL && !KASAN_GENERIC && !KASAN_SW_TAGS)



