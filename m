Return-Path: <stable+bounces-183338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B90BB85E2
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 00:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F9B3BFAF6
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 22:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE47275AF2;
	Fri,  3 Oct 2025 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuZrqr3V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED05203710;
	Fri,  3 Oct 2025 22:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759532248; cv=none; b=eveGzYCrQjpABLss6lxJ6HCroYAUbT7F6uh+SOKfNN5smlKoITXKje1Zqcajr33Bj9UrDs5RXUVZAh1drrO+sWScthN0yAYZy9JZBgb8yf11sTSkOarKNhSlM/9za9W6wEDNE5XHq0/euoNTNSWsga+BpaFcmhqa+K8NZm7pBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759532248; c=relaxed/simple;
	bh=QlnUffNjLbcmqEw64x2x55MGPaaNVTMhAgdaSwOtFU0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=daD+0YUR6J3tRjuiFKO5dJoDP/3xPFcXdCEDzwplCSBccm5kIwsf93u6egL3eMD3F+3ocomOZ4tqy8d+jJHDOvcY6UoVydpMrPnOOcz9S395HUUEqEd2VBElttdnxWtfiEMifHSQvg5U58n0PZpwvYxba27xxUh8Ont/K3QNyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuZrqr3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E65C4CEF5;
	Fri,  3 Oct 2025 22:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759532248;
	bh=QlnUffNjLbcmqEw64x2x55MGPaaNVTMhAgdaSwOtFU0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=kuZrqr3VFx4YNSicaWCcRbCoY4HQnuUCtSr5ZdtRryFOCgSRlD1pM9GIlqBBr3FC3
	 e8AK5mzhO6yQnWpl2MztppA8v2dJJVTTsT8gH52beE+NpPn2lvaabZrPYv2Av689kc
	 rXyAxReuEnl+IB9s+mi5dDyg5TvQ4ZbEH5s2Od6+Q/FaI/h9zgG2y66xva3MV8Ezoy
	 xfwIWuT7GVmV93a7fc2ZvHYu6zq/aLZT/CRf0KbpFmSV9P3RO6fTs9MkQ6t+2bUWVE
	 lKci0+LSh75RjoffLWeJXPaiK9yo3Vgk+jrvNIVqTy+wPCuwH/yKp9DgopUJRBiuSD
	 KQVza0Yw4zRyg==
Date: Fri, 3 Oct 2025 16:57:22 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Conor Dooley <conor@kernel.org>
cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
    linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
    stable@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
    Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
    Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
    =?ISO-8859-15?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
    Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
    Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
    Danilo Krummrich <dakr@kernel.org>, Kees Cook <kees@kernel.org>, 
    Sami Tolvanen <samitolvanen@google.com>, 
    Matthew Maurer <mmaurer@google.com>, 
    "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
    linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v1] rust: cfi: only 64-bit arm and x86 support
 CFI_CLANG
In-Reply-To: <20251003-viewing-residency-d4f849c6fbe6@spud>
Message-ID: <71b9ca7a-3847-72d9-b9d1-c748f301450f@kernel.org>
References: <20250908-distill-lint-1ae78bcf777c@spud> <CANiq72mw36RzCtNVax650fJ=+cYjuGNF722_Mn2Oy1FAvxWc8Q@mail.gmail.com> <20251003-viewing-residency-d4f849c6fbe6@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-567175886-1759532248=:870847"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-567175886-1759532248=:870847
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 3 Oct 2025, Conor Dooley wrote:

> On Mon, Sep 08, 2025 at 04:36:09PM +0200, Miguel Ojeda wrote:
> > On Mon, Sep 8, 2025 at 3:13 PM Conor Dooley <conor@kernel.org> wrote:
> > >
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > The kernel uses the standard rustc targets for non-x86 targets, and out
> > > of those only 64-bit arm's target has kcfi support enabled. For x86, the
> > > custom 64-bit target enables kcfi.
> 
> Hopefully someone can take it! I was hoping it'd be 6.18 material, can
> someone grab it for fixes please?

Will pick it up for early v6.18-rc fixes, thanks.


- Paul
--8323329-567175886-1759532248=:870847--

