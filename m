Return-Path: <stable+bounces-114902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F719A3099B
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 12:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A499B7A471F
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B991FAC5E;
	Tue, 11 Feb 2025 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="I47V+x4+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772721F891F
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272253; cv=none; b=ukSqlYv3eRF+hsHksCAZ1WRJxzzgyoT76uouTaiwnOb0aY4f/EAbTMcVaJFAUV/nhLXgPjZ95SqSch3Erq7epnlsdgtjRfnE7DQorR+7B+Z4nXbG3XA1e5qOa1QIA+7F/tiHqLj7tleycZh4eM02bouTVvS7U0TBR9A3AcxOZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272253; c=relaxed/simple;
	bh=WPb2ORZc/9ZZ6+gHNdJlvp8bilbLUMvl7JnfNtvGfEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8wVLGTxJUFV2t63vYXyH8BSPbGcDNr/LFIBxMB98uUsgwEIQgMVUS5yLvKb45yhVph+lWS5QDDO9wwt78MUHNo4G8hAJYvqT1d6z0YDMM/2m54eJ/Dstg6H4Jq74Kk+8js08l7fOMhuIS+k9O0DfFhZU+DKgOeaYvqIeh4vpo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=I47V+x4+; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5b4d615267so2969072276.1
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 03:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1739272249; x=1739877049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPNCIgpBAFQQZU10UukFXE6nijs336odSMhelfSJ0j4=;
        b=I47V+x4+oJekKAnoV39TFWOLke41Iij7hbPNnF6m1ImZmHZQpjfTfTdUiKccLXdO4r
         HKBTmy/gKEJdXY8PmjMFvMIh3hUANv16jj3PeEPiLek2mYRBlwVoVet9w7AKXPANGdT0
         1HqFt52fDYGoKvr1Ne7FqMQ0e/YhWOaYiVZu/40T9iQHkdJXhQduxY0ZcPbSdRxDxt2h
         T1IEairzYZDfLzFvIpOktsrYM0vMxp5B6Uzl5qh71InvAcbeCfC0/uPnMta2aDZ2ikDN
         6sh/fgPieq50tIF0pbslmOJ8fEfIZe9QuqXA/FmkVf712Wk9g7C6xQnwOApsKGtIOCnw
         Qhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272249; x=1739877049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPNCIgpBAFQQZU10UukFXE6nijs336odSMhelfSJ0j4=;
        b=Hcn0H1xsx21HP4QHMVsXuMtjQF3qfBY0j6gUqUiCtqocOG1zUw0oyJILcYW2aSUlPs
         Y2QwpQVJ8h/jBkfBlj3AyxdW8CB+91wDeteeX9TF1LxbeHAAdEm5c3GFHa85gv0luyrG
         KLcxQT96XzsJACXft7AEcJY+nitXeuOlrwS39Ieesihcnihqd1KnQNZKIbYje1pIzva1
         4jbdjUE5TcE/LOz0NgoIXezVEbKNhivv6WndnC9qpHpCGxmQyjY8Q5easw60Ff7MOjUk
         fM9jF0JtGjo1RKAJJpuMFl/GF4fxe6f48DjUrs4hn6UvT2K/c3DHgYfZMD8hrW3d5aBN
         myuw==
X-Forwarded-Encrypted: i=1; AJvYcCVuLbVzeya4YuKSNdaEM0H6BLm3dZr46ILbeCSNF687A94FURs/8mfgZA547Y7e6iWSF/gH7hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD4qy4segdrhGLkrBmI37V6OSsUURafTxqpRrAb3jkG8WVzzM8
	VH0rsvtUoJnMFv7JImKvE9bu9KXywwYD2wOzVYBhiY2J5SXwsDYVthJWknG8vsbIOUW/Kw1FS4H
	2a0A0LYovD1PWAjj+zxP1bmWW1/x8U41Om+7MlQ==
X-Gm-Gg: ASbGncuPUyZqt4nd1w/lpyH6S6RqIJQ1AXB/Z6tKTAEzCC5HkwpVKDWsW0MAsKP2Zwk
	ejtdLSpYZK3mf9tswtzOibaW0MTdagyv5MhTFO0Zx0BKIMVjeH9th2INiIAd9nNvXS/ugv4iG
X-Google-Smtp-Source: AGHT+IGwcyBsYc46RWArEeADU77H8bXfVzk3irEgxqL38ZDIwj53ttNaZ+UD3iPTNd+DjLbLMEDFzT6kErsvcr/dhMw=
X-Received: by 2002:a05:6902:27c8:b0:e58:7aa:7de4 with SMTP id
 3f1490d57ef6-e5b462c2b38mr14587566276.45.1739272249457; Tue, 11 Feb 2025
 03:10:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210163732.281786-1-ojeda@kernel.org>
In-Reply-To: <20250210163732.281786-1-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Tue, 11 Feb 2025 05:10:38 -0600
X-Gm-Features: AWEUYZn351_k4v10MDh5azMViiAdx98NkshCWwsinZSeHh9hCB6x5oVItn12a_Q
Message-ID: <CALNs47uBcyTmBdTBAPXiBcAkE0-4tih9j=VAv1rRcTcf_c2yTg@mail.gmail.com>
Subject: Re: [PATCH] arm64: rust: clean Rust 1.85.0 warning using softfloat target
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, 
	moderated for non-subscribers <linux-arm-kernel@lists.infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>, Ralf Jung <post@ralfj.de>, 
	Jubilee Young <workingjubilee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:38=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Starting with Rust 1.85.0 (to be released 2025-02-20), `rustc` warns
> [1] about disabling neon in the aarch64 hardfloat target:
>
>     warning: target feature `neon` cannot be toggled with
>              `-Ctarget-feature`: unsound on hard-float targets
>              because it changes float ABI
>       |
>       =3D note: this was previously accepted by the compiler but
>               is being phased out; it will become a hard error
>               in a future release!
>       =3D note: for more information, see issue #116344
>               <https://github.com/rust-lang/rust/issues/116344>
>
> Thus, instead, use the softfloat target instead.
>
> While trying it out, I found that the kernel sanitizers were not enabled
> for that built-in target [2]. Upstream Rust agreed to backport
> the enablement for the current beta so that it is ready for
> the 1.85.0 release [3] -- thanks!
>
> However, that still means that before Rust 1.85.0, we cannot switch
> since sanitizers could be in use. Thus conditionally do so.
>
> Cc: <stable@vger.kernel.org> # Needed in 6.12.y and 6.13.y only (Rust is =
pinned in older LTSs).
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Matthew Maurer <mmaurer@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Ralf Jung <post@ralfj.de>
> Cc: Jubilee Young <workingjubilee@gmail.com>
> Link: https://github.com/rust-lang/rust/pull/133417 [1]
> Link: https://rust-lang.zulipchat.com/#narrow/channel/131828-t-compiler/t=
opic/arm64.20neon.20.60-Ctarget-feature.60.20warning/near/495358442 [2]
> Link: https://github.com/rust-lang/rust/pull/135905 [3]
> Link: https://github.com/rust-lang/rust/issues/116344
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

This is consistent with what has been discussed for a while on the Rust sid=
e.

Reviewed-by: Trevor Gross <tmgross@umich.edu>

