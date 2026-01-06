Return-Path: <stable+bounces-205068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54066CF7DD4
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 11:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94CC4303A3D1
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 10:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B1C2EF64D;
	Tue,  6 Jan 2026 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bresA0Tt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997211EC01B;
	Tue,  6 Jan 2026 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767696453; cv=none; b=dxxiEnf4OnmmDPlCWREsaN3bCtlBWFPZA274FMubaWMC1v2UW6SDH9jBF6G1PuddMFp+fUB5iZZK2/DaZPHwdgmNsBcahbgZN06G/GbyaRKLrT74Wlbf5nh5JYX4GOOp1a6mPqbcK5IFzX/cAz7Ky32143LiiLWT4ccBKQbpVVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767696453; c=relaxed/simple;
	bh=D415Vmm+d7Elv3P0DFSqcEe/eMe/7OE6ElIPBbXSSfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pBt8QAUwTfhupL3wAShi1qGnVvZR461ejv2v1KQHWarClfPvWaAqq8Ev/ZZ3B6ToBpANmacJkGMISHvR87XYxscWMyEVcBSAYKW8QNjoj6A3uHpng/ztulwD7VpEEwbjYfFD//+JLKopYNKapuN6Jk32m7/UsSJNkr3scrQXqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bresA0Tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7607EC116C6;
	Tue,  6 Jan 2026 10:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767696453;
	bh=D415Vmm+d7Elv3P0DFSqcEe/eMe/7OE6ElIPBbXSSfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bresA0TtwrDDsfi20uxaFi1g/hC2bT71h6bAPetD244H8uA900Nuyb+YyGpVa8KRI
	 jzuxpTXRyxpr381jJDPrlVm6Ux3NhPo/8FaxAHzcPXvEEGaue4KZiH+BJ5faoU6Bh+
	 XNAs7GazfhALw4H9HUqypAtt8F4RxMRxGdO4GhEJ3slMKUWVNp8rjgHrjEK3znQ+0B
	 Bb1vvKy1Zpx9Oxykbxug7Pr/0Xn7ZwEs2QCaOV5VzdSXqPKkf9lVXcEe/Ai7xp0S58
	 jGedEAhaHTMgExsX9khP3sLRgOKotRgyvJOVYzQHt9L7A41W9jtXBqMEvDNkt39jmV
	 V3aJsZ69tcf7Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Yury Norov <yury.norov@gmail.com>,
 Burak Emir <bqe@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary
 Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Alice Ryhl
 <aliceryhl@google.com>
Subject: Re: [PATCH v2] rust: bitops: fix missing _find_* functions on
 32-bit ARM
In-Reply-To: <20260105-bitops-find-helper-v2-1-ae70b4fc9ecc@google.com>
References: <20260105-bitops-find-helper-v2-1-ae70b4fc9ecc@google.com>
Date: Tue, 06 Jan 2026 11:47:19 +0100
Message-ID: <87secjhvbc.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alice Ryhl <aliceryhl@google.com> writes:

> On 32-bit ARM, you may encounter linker errors such as this one:
>
> 	ld.lld: error: undefined symbol: _find_next_zero_bit
> 	>>> referenced by rust_binder_main.43196037ba7bcee1-cgu.0
> 	>>>               drivers/android/binder/rust_binder_main.o:(<rust_binder_main::process::Process>::insert_or_update_handle) in archive vmlinux.a
> 	>>> referenced by rust_binder_main.43196037ba7bcee1-cgu.0
> 	>>>               drivers/android/binder/rust_binder_main.o:(<rust_binder_main::process::Process>::insert_or_update_handle) in archive vmlinux.a
>
> This error occurs because even though the functions are declared by
> include/linux/find.h, the definition is #ifdef'd out on 32-bit ARM. This
> is because arch/arm/include/asm/bitops.h contains:
>
> 	#define find_first_zero_bit(p,sz)	_find_first_zero_bit_le(p,sz)
> 	#define find_next_zero_bit(p,sz,off)	_find_next_zero_bit_le(p,sz,off)
> 	#define find_first_bit(p,sz)		_find_first_bit_le(p,sz)
> 	#define find_next_bit(p,sz,off)		_find_next_bit_le(p,sz,off)
>
> And the underscore-prefixed function is conditional on #ifndef of the
> non-underscore-prefixed name, but the declaration in find.h is *not*
> conditional on that #ifndef.
>
> To fix the linker error, we ensure that the symbols in question exist
> when compiling Rust code. We do this by definining them in rust/helpers/
> whenever the normal definition is #ifndef'd out.
>
> Note that these helpers are somewhat unusual in that they do not have
> the rust_helper_ prefix that most helpers have. Adding the rust_helper_
> prefix does not compile, as 'bindings::_find_next_zero_bit()' will
> result in a call to a symbol called _find_next_zero_bit as defined by
> include/linux/find.h rather than a symbol with the rust_helper_ prefix.
> This is because when a symbol is present in both include/ and
> rust/helpers/, the one from include/ wins under the assumption that the
> current configuration is one where that helper is unnecessary. This
> heuristic fails for _find_next_zero_bit() because the header file always
> declares it even if the symbol does not exist.
>
> The functions still use the __rust_helper annotation. This lets the
> wrapper function be inlined into Rust code even if full kernel LTO is
> not used once the patch series for that feature lands.
>
> Cc: stable@vger.kernel.org
> Fixes: 6cf93a9ed39e ("rust: add bindings for bitops.h")
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/x/topic/x/near/561677301
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Built tested for arm32 with bindgen 0.72.1 with rustc-1.78.0 and
rustc-1.88.0.

Tested-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




