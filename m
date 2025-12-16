Return-Path: <stable+bounces-202519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFC6CC32BE
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EF4830303AC
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D825A3590DF;
	Tue, 16 Dec 2025 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh3SghvL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0B3590CF;
	Tue, 16 Dec 2025 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888159; cv=none; b=F/OaLWju4scVcrP2XQkjWHLIbVpI7Gd7blEEFWaBwu3JvymRj+JgbWILYEC910PQmMm8MjmFAX8EkVva9g5aTUHHeGWMstfm0pL+LSKzsXFm0EppZgR6wPvpATOEiiMKOTAVKNKsfoGvUWqXJjRivMwVZbkI+u3WIP3wMLqX8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888159; c=relaxed/simple;
	bh=F8gszaYKbV5HBAp35rcM076dRwaoeGkXE5yARasU2g4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=G5jjtGA2e1u7xeOEm8UDV/k+6TYTD8Q2kdGu8Iriha+Xu+T4FsCReKvLBe0gVFZy/KMH2f6htn8LNpHQXMoBGg+ur2rMm0b0QA0XCbZjfZH2H5PEZw3CRHB7W+Sj+rr+Ora36KGlFq49ewy8GemBX7E3TEqK2E6HP3esSHiYyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh3SghvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F760C4CEF1;
	Tue, 16 Dec 2025 12:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765888159;
	bh=F8gszaYKbV5HBAp35rcM076dRwaoeGkXE5yARasU2g4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Qh3SghvL1mqI8azw0usigfFwIY8XyF4eC5pT4vaoNJnGM+a1pPsLYECT4xH3p3Wpt
	 LteN/WvdZkQG0o9yF+J4D4DiDIBI+49yJR9Asv4oj8Mu8TmfYpDKEJ0WBazGjt5Y9R
	 ksBZKvHZkXkRGjzmHhrJaGBOIhacJxt6Ar8VqC9zy3DH+tWbieUg88lOpgWrYlPPzK
	 94tm5toYvy4XfGe1OflwYkDyz1Ei2yPiPm171K0UQMQjsTVmTsHhdiNyqFAO4iDWbr
	 oebAIY+GELTjZmWI6AU71LUea6giBvRK7tumGmMysvdScJTy65gfu+wQdhCsJhhr+d
	 7E7WuAyZd5EPQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Dec 2025 13:29:14 +0100
Message-Id: <DEZN3V4LT8XM.VQRQ1IXP4DDU@kernel.org>
Subject: Re: [PATCH v1] rust: Add some DMA helpers for architectures without
 CONFIG_HAS_DMA
Cc: <ojeda@kernel.org>, <a.hindborg@kernel.org>,
 <abdiel.janulgue@gmail.com>, <aliceryhl@google.com>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>,
 <daniel.almeida@collabora.com>, <gary@garyguo.net>, <lossin@kernel.org>,
 <robin.murphy@arm.com>, <rust-for-linux@vger.kernel.org>,
 <tmgross@umich.edu>, <stable@vger.kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251204160639.364936-1-fujita.tomonori@gmail.com>
In-Reply-To: <20251204160639.364936-1-fujita.tomonori@gmail.com>

(Cc: stable@vger.kernel.org)

On Thu Dec 4, 2025 at 5:06 PM CET, FUJITA Tomonori wrote:
> Add dma_set_mask(), dma_set_coherent_mask(), dma_map_sgtable(), and
> dma_max_mapping_size() helpers to fix a build error when
> CONFIG_HAS_DMA is not enabled.
>
> Note that when CONFIG_HAS_DMA is enabled, they are included in both
> bindings_generated.rs and bindings_helpers_generated.rs. The former
> takes precedence so behavior remains unchanged in that case.
>
> This fixes the following build error on UML:
>
> error[E0425]: cannot find function `dma_set_mask` in crate `bindings`
>      --> /linux/rust/kernel/dma.rs:46:38
>       |
>    46 |         to_result(unsafe { bindings::dma_set_mask(self.as_ref().a=
s_raw(), mask.value()) })
>       |                                      ^^^^^^^^^^^^ help: a functio=
n with a similar name exists: `xa_set_mark`
>       |
>      ::: /build/um/rust/bindings/bindings_generated.rs:24690:5
>       |
> 24690 |     pub fn xa_set_mark(arg1: *mut xarray, index: ffi::c_ulong, ar=
g2: xa_mark_t);
>       |     -------------------------------------------------------------=
--------------- similarly named function `xa_set_mark` defined here
>
> error[E0425]: cannot find function `dma_set_coherent_mask` in crate `bind=
ings`
>      --> /linux/rust/kernel/dma.rs:63:38
>       |
>    63 |         to_result(unsafe { bindings::dma_set_coherent_mask(self.a=
s_ref().as_raw(), mask.value()) })
>       |                                      ^^^^^^^^^^^^^^^^^^^^^ help: =
a function with a similar name exists: `dma_coherent_ok`
>       |
>      ::: /build/um/rust/bindings/bindings_generated.rs:52745:5
>       |
> 52745 |     pub fn dma_coherent_ok(dev: *mut device, phys: phys_addr_t, s=
ize: usize) -> bool_;
>       |     -------------------------------------------------------------=
--------------------- similarly named function `dma_coherent_ok` defined he=
re
>
> error[E0425]: cannot find function `dma_map_sgtable` in crate `bindings`
>     --> /linux/rust/kernel/scatterlist.rs:212:23
>      |
>  212 |               bindings::dma_map_sgtable(dev.as_raw(), sgt.as_ptr()=
, dir.into(), 0)
>      |                         ^^^^^^^^^^^^^^^ help: a function with a si=
milar name exists: `dma_unmap_sgtable`
>      |
>     ::: /build/um/rust/bindings/bindings_helpers_generated.rs:1351:5
>      |
> 1351 | /     pub fn dma_unmap_sgtable(
> 1352 | |         dev: *mut device,
> 1353 | |         sgt: *mut sg_table,
> 1354 | |         dir: dma_data_direction,
> 1355 | |         attrs: ffi::c_ulong,
> 1356 | |     );
>      | |______- similarly named function `dma_unmap_sgtable` defined here
>
> error[E0425]: cannot find function `dma_max_mapping_size` in crate `bindi=
ngs`
>    --> /linux/rust/kernel/scatterlist.rs:356:52
>     |
> 356 |         let max_segment =3D match unsafe { bindings::dma_max_mappin=
g_size(dev.as_raw()) } {
>     |                                                    ^^^^^^^^^^^^^^^^=
^^^^ not found in `bindings`
>
> error: aborting due to 4 previous errors
>
> Fixes: 101d66828a4ee ("rust: dma: add DMA addressing capabilities")
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Applied to driver-core-linus, thanks!

    [ Use relative paths in the error splat; add 'dma' prefix. - Danilo ]

