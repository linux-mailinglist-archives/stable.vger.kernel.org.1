Return-Path: <stable+bounces-179013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A979B49FBD
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 05:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8EB23AF161
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 03:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8318025A323;
	Tue,  9 Sep 2025 03:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szf7WnWx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3882241C63;
	Tue,  9 Sep 2025 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387509; cv=none; b=aaN+UhOw5EAIwQqCt/vzP7NE6LGpgLxAyLvzqx5/m2AWhhtM3V5taZ3+Wzv+xPCORXb7a7IGI1h/pICnxKwha277i5c37UyzJOEWbhGSSoRc36tif2nCxZLwo25UHD75x//ikY+ykSFpwmg4pX8/Hfi99juI5DwN4XCXDZrM10o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387509; c=relaxed/simple;
	bh=FHj0B++JBRs8wJM7cOGkVEvycIRxssERqZ4KwCKug7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nd3EUpLs/gOROCHMRt08ynMUoOsaLJpDCFjt4ykEy2K6qla5Bb/xqcak9WrIP3gMtpvuVdx5Y9yahojOX4MLSW7w+f6b4u53mJFMGCFXesGS58bqBPORrhYcOKpfdJ+j52wJ1VODrjaHvAiXqHOPGosHBcZK2RhWkbQlphWafig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szf7WnWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5F1C4CEF1;
	Tue,  9 Sep 2025 03:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757387508;
	bh=FHj0B++JBRs8wJM7cOGkVEvycIRxssERqZ4KwCKug7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szf7WnWxJI0Z+uRLOA54yiBvCY9EwjKEL7sVsugkMM9nFL7Fvf6jP95RN/emb1LPy
	 WytjBJRToGrJo2o31529JgVVFvYwlA5B5qC4zl/hAvlqKg7R7986xYyz8F8RyJaFWP
	 j2c2yfKppoQrWKWEtYC+q2CTzxk7iCvtbumufEMkBJ+vRlBOx5geR3p7dsyfvsyp8P
	 sCsVN+DwwRbPYcta11QGLI4/GhdBVsQEU5cAtQvUJDXLx4C68M5H2EWHr1GNkHTOmf
	 11tfQJSB4XlQeHJoZ2Gh5cFI4H9q+Xj4iQ7PWNmQg62cpn77qWwyodcbJlL4krbPsW
	 ZbYikePQis+ug==
Date: Mon, 8 Sep 2025 20:11:48 -0700
From: Kees Cook <kees@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Matthew Maurer <mmaurer@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v1] rust: cfi: only 64-bit arm and x86 support CFI_CLANG
Message-ID: <202509082009.4A8DC97BD2@keescook>
References: <20250908-distill-lint-1ae78bcf777c@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908-distill-lint-1ae78bcf777c@spud>

On Mon, Sep 08, 2025 at 02:12:35PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The kernel uses the standard rustc targets for non-x86 targets, and out
> of those only 64-bit arm's target has kcfi support enabled. For x86, the
> custom 64-bit target enables kcfi.
> 
> The HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC config option that allows
> CFI_CLANG to be used in combination with RUST does not check whether the
> rustc target supports kcfi. This breaks the build on riscv (and
> presumably 32-bit arm) when CFI_CLANG and RUST are enabled at the same
> time.
> 
> Ordinarily, a rustc-option check would be used to detect target support
> but unfortunately rustc-option filters out the target for reasons given
> in commit 46e24a545cdb4 ("rust: kasan/kbuild: fix missing flags on first
> build"). As a result, if the host supports kcfi but the target does not,
> e.g. when building for riscv on x86_64, the build would remain broken.
> 
> Instead, make HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC depend on the only
> two architectures where the target used supports it to fix the build.

I'm generally fine with this, but normally we do arch-specific stuff
only in arch/$arch/Kconfig, and expose some kind of
ARCH_HAS_CFI_ICALL_NORMALIZE_INTEGERS that would get tested here. Should
we do that here too?

-Kees

> 
> CC: stable@vger.kernel.org
> Fixes: ca627e636551e ("rust: cfi: add support for CFI_CLANG with Rust")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Alexandre Ghiti <alex@ghiti.fr>
> CC: Miguel Ojeda <ojeda@kernel.org>
> CC: Alex Gaynor <alex.gaynor@gmail.com>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: Gary Guo <gary@garyguo.net>
> CC: "Björn Roy Baron" <bjorn3_gh@protonmail.com>
> CC: Benno Lossin <lossin@kernel.org>
> CC: Andreas Hindborg <a.hindborg@kernel.org>
> CC: Alice Ryhl <aliceryhl@google.com>
> CC: Trevor Gross <tmgross@umich.edu>
> CC: Danilo Krummrich <dakr@kernel.org>
> CC: Kees Cook <kees@kernel.org>
> CC: Sami Tolvanen <samitolvanen@google.com>
> CC: Matthew Maurer <mmaurer@google.com>
> CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> CC: linux-kernel@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> CC: rust-for-linux@vger.kernel.org
> ---
>  arch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index d1b4ffd6e0856..880cddff5eda7 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -917,6 +917,7 @@ config HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
>  	def_bool y
>  	depends on HAVE_CFI_ICALL_NORMALIZE_INTEGERS_CLANG
>  	depends on RUSTC_VERSION >= 107900
> +	depends on ARM64 || X86_64
>  	# With GCOV/KASAN we need this fix: https://github.com/rust-lang/rust/pull/129373
>  	depends on (RUSTC_LLVM_VERSION >= 190103 && RUSTC_VERSION >= 108200) || \
>  		(!GCOV_KERNEL && !KASAN_GENERIC && !KASAN_SW_TAGS)
> -- 
> 2.47.2
> 

-- 
Kees Cook

