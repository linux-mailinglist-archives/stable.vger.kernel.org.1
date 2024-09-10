Return-Path: <stable+bounces-75153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8149733CE
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4FCB2D3B7
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAE4196C86;
	Tue, 10 Sep 2024 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G6lXH3/F"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E543E1922F6
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963903; cv=none; b=KI/0VaQsyUR+5EFXHW1UO+LEY6Me57BgW4gePakURbf7s6243ptfd9Zc/H6utj949TqJXY1mY1GlTo1FIKDCIRRSZYlxKkmPyWVMLmPrcE9V0uVDzzsqhHpZzeuNnXpvPUk/hicEj/avSRQiBl9mDBhGL+vEO2HQDDLFR41pFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963903; c=relaxed/simple;
	bh=oO0euwLlbAwqUe9osbySCpSY/KLWU9E6/QQ8kCU2eKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSRxgy7hD5dU2kYGPjhPf5zUqT4v4QJRMdHbqWDzgjmPwH7GAjTWcqhL9A8xN8FWLnWZ9oqfAsk9Rv5MU01iAnQIesvr6nITSi2yEe9MW7lU+GAxuz2xepIuQCF0snNqjAylvpiKXOHX+vdaWp7Xjc0g1BeYtrAEY0+4b5NHHVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G6lXH3/F; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374b5f27cf2so3134275f8f.1
        for <stable@vger.kernel.org>; Tue, 10 Sep 2024 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725963900; x=1726568700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LItVPrRgPRXz93pKfnwrtSMcwlhD9zKRya1Te/J8aUM=;
        b=G6lXH3/FYx/i9Zqv86M/TAsX0s9ZZucGUTfjEi612W8vUGOKdB0mrty/CFZZOjJYz8
         77CbwKIjK9u2zOmkOcMMf0lauC6BsURbZhu8e5Ml6He8/8nZEPum0ZT79JRDuFq7k27j
         cx+U7VpWb4ywCOiNKsQKBL8fvRpZG1Qsj9VluLOk5+RRRezMqnnrpf+rg6KWANBMF5kt
         8ac3f2YRZL9gBTZ14IIDap9G/vmuHd7Y2Nue5u8fYtq47ewLKm48uzbbvcD2kvnl7ANt
         cl+H1ubB93yIb2zCiGqbeJ3+miHxlM1c7/Kj6abdeQhhGEBZ9fuY29S6kv3m7Jat6+i+
         QK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725963900; x=1726568700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LItVPrRgPRXz93pKfnwrtSMcwlhD9zKRya1Te/J8aUM=;
        b=okCUuazkeNstfy+kMeXIiv1zB8agGmOsiqKx2E3I+QbN7jiiqxh6dDeHIUze/0NiKu
         Rzsi/Z5kSGWV2/Fga4qg6a4bK2ZzuVmSODpNT6tExKsDl1nh3lXkpPOh5gy9RrZKUR+6
         9oR9IknsO9AWDHSto+n+4nhfxo5chTcmXwHzdxIzyMExoFD6eXQiWsLtU4hwk4hk3zTM
         90zEwOmjaX58VdVJNvi3L3ImcLulEN+quLLlCvVXIeQEXpbjUcDZM+x7dHW/ryldfwCq
         n+7siqaImpE2Ixo4Q5JGyzEvfjDS+14f9cyYiRpiUE9r0Uqk+EEBhhp3WTDXg64/I7Zm
         gMtg==
X-Gm-Message-State: AOJu0YzU02YeyCLLFoJ0MOHCd8JZl01UOGu0SRykXq+RihmS7bVkn6Fq
	SXsrVi0rMcNYk+R7OTjigaPXFOrVnzN/4aLXPQg4VjQ8QS0if2eVB17ONS4v8ESPcSyZohnbEqW
	q5rfFRrYNhlPBEo8BQEeB+cPLbvJMwB8seVNE
X-Google-Smtp-Source: AGHT+IFE+aeaOIu3mHHqd9rU8fMjNrnXlDx31+3SUTswLoHNnWIdHXKc2Ye99D86WGP6iwo1+QjiSLM9Js5qXzIwyYk=
X-Received: by 2002:adf:fc91:0:b0:374:c432:4971 with SMTP id
 ffacd0b85a97d-3789268e9a0mr6557616f8f.16.1725963899859; Tue, 10 Sep 2024
 03:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910092557.876094467@linuxfoundation.org> <20240910092604.257546283@linuxfoundation.org>
In-Reply-To: <20240910092604.257546283@linuxfoundation.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 10 Sep 2024 12:24:48 +0200
Message-ID: <CAH5fLgi7_=3W3WdPR2KcUW73Ma=SXo-dX20z0xx+AK4S_N3SwQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 153/192] rust: macros: provide correct provenance when
 constructing THIS_MODULE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Boqun Feng <boqun.feng@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Benno Lossin <benno.lossin@proton.me>, Gary Guo <gary@garyguo.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 12:12=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.1-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Boqun Feng <boqun.feng@gmail.com>
>
> [ Upstream commit a5a3c952e82c1ada12bf8c55b73af26f1a454bd2 ]
>
> Currently while defining `THIS_MODULE` symbol in `module!()`, the
> pointer used to construct `ThisModule` is derived from an immutable
> reference of `__this_module`, which means the pointer doesn't have
> the provenance for writing, and that means any write to that pointer
> is UB regardless of data races or not. However, the usage of
> `THIS_MODULE` includes passing this pointer to functions that may write
> to it (probably in unsafe code), and this will create soundness issues.
>
> One way to fix this is using `addr_of_mut!()` but that requires the
> unstable feature "const_mut_refs". So instead of `addr_of_mut()!`,
> an extern static `Opaque` is used here: since `Opaque<T>` is transparent
> to `T`, an extern static `Opaque` will just wrap the C symbol (defined
> in a C compile unit) in an `Opaque`, which provides a pointer with
> writable provenance via `Opaque::get()`. This fix the potential UBs
> because of pointer provenance unmatched.
>
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/x/topic/x/nea=
r/465412664
> Fixes: 1fbde52bde73 ("rust: add `macros` crate")
> Cc: stable@vger.kernel.org # 6.6.x: be2ca1e03965: ("rust: types: Make Opa=
que::get const")
> Link: https://lore.kernel.org/r/20240828180129.4046355-1-boqun.feng@gmail=
.com
> [ Fixed two typos, reworded title. - Miguel ]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

The opaque type doesn't exist yet on 6.1, so this needs to be changed
for the 6.1 backport. It won't compile as-is.

> ---
>  rust/macros/module.rs | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 031028b3dc41..071b96639a2e 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -183,7 +183,11 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream=
 {
>              // freed until the module is unloaded.
>              #[cfg(MODULE)]
>              static THIS_MODULE: kernel::ThisModule =3D unsafe {{
> -                kernel::ThisModule::from_ptr(&kernel::bindings::__this_m=
odule as *const _ as *mut _)
> +                extern \"C\" {{
> +                    static __this_module: kernel::types::Opaque<kernel::=
bindings::module>;
> +                }}
> +
> +                kernel::ThisModule::from_ptr(__this_module.get())
>              }};
>              #[cfg(not(MODULE))]
>              static THIS_MODULE: kernel::ThisModule =3D unsafe {{
> --
> 2.43.0
>
>
>

