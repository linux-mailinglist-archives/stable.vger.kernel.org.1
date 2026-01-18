Return-Path: <stable+bounces-210241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EED84D3998E
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 20:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76FEF30021F9
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 19:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F46291864;
	Sun, 18 Jan 2026 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyVFMji/"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E72C3277
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768765398; cv=pass; b=Q67XQiMQXVIuKHTAvaY2x4C0uGNhx3UNWTR0g4w09zA+MFZFkTVklMjt7Ui/nEgPafuCSOjvCt4ZqQFI96QPj4BMa1yiVFVY5850u0Y7NDdyF7OmV1AdV23BPgKC8T+L7WAKtMQNyJBqNfoim6gz6rnJCGC0sSeuJGDERKjnPk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768765398; c=relaxed/simple;
	bh=YcWX4KpE5LzyFkGNlp0UmN6AScfsx8INQHNsRSOVao8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d75EI9Bl2WFJ9rpQsvx2ObaQvcIV/QJ3UvLf2GcZkOXO35Y9osfVIJ73XjQtweLDjc0hDsRyao2RvG6NjgvuckkwDYVJVxQ3qHxw4docUPzloScscdvFk/4MDD7TUGNZJFCefyt3TZyjdesR4RlS0ax1vYgeufGFK8CXJBQcQHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyVFMji/; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b6ce77a2cbso50005eec.1
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 11:43:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768765396; cv=none;
        d=google.com; s=arc-20240605;
        b=Ngb2ksL7hDavUB3jxbhohRpW0WuT0yKsIwWt+ajLDkh6yTrvhFs6izcZzryAFr2dh5
         SjKnn8zcEJfnwBVoTdtUYCSoWReW8noRQage30341C28kUaN7dRx5Gseh4Sr+H+6NC6/
         dkFlXhMBT9nvf00CnEBEonZFShU+NVRENb/QchXURw5wpHpGQEYt8gMLx119Tpw1eHz0
         z4t6mtXNoLTg0U85Z0ww5G+1Vyg96nBoRES41/3/9Nvcqe7P+RMot+kUknZPOg3tta06
         JOrjAgljo7GNzIPtfWJhfMldtBO3sgqRlrnM6ei2wrjyrh8hfGRSAUzeWXD5dO5FJhIc
         ab8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3WkwnRacVzZnF9+VHDBdh2NvGD/q/Isu1ZQKlvNDN0I=;
        fh=zBgGoH6611pVKbDWTwQgnibDv0oCebu0/schIaAYg6g=;
        b=KSUZB13XaOXJnT+hdneI3yIVs7xA/N3W3JcITa5rMjx143zpzofRmYB7YRGgn683+U
         tKJ0lWZszF4c9mwDdX1DUXUB7069KddlvR3xVkvzP/Iuz7BrvTnDutygV2bES2bBx35L
         5W82quJct05ViyuajiowlHmpCRRJ23vcFm1pmrKHHIeHitRNkAIB6qWg8FL9Xif7oJLD
         6HBJwpx7wfbBDIVfjPTme1M38IeqPaiexshfaxY/xBqNCszb4UV39BywLONgbS9BqQcx
         S5xen1shnWZxz47SXaNLaTbSDRJfuWkkfyvvXcrF7keVuI2XpeTl5magovOJ7grM0ORx
         R0ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768765396; x=1769370196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WkwnRacVzZnF9+VHDBdh2NvGD/q/Isu1ZQKlvNDN0I=;
        b=JyVFMji/c1eBg4LJmOVPcjNlcOenkPq7z/Ysjq3Hehh3n2JscrHBsQqoX0KD9dIj/B
         CgGK4f6ikRvaXkaNakJpb9IqeqXcI3liEZr9ApuIuJ7hhwPV5z1v06CjEzlOiDIsqC5r
         f9DM+zzkFTg170yiNciTf9IZoMPVzY6JrDPmytalgfSnVJga+bl9uIrIjSt70kwxPhWZ
         lgNubit1H/r/xahYemoLlOJ9rrd8PPy4jnmXsNubOrK45nhpSEI1syOxwxUadEJ+7HSj
         0CfCLjMTsvLkyG0lZgj8v3eDZq4Zn4N+/Kiy19W/8WQllIrTJ9Cbf7nkaUtuiES+e3iP
         de3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768765396; x=1769370196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WkwnRacVzZnF9+VHDBdh2NvGD/q/Isu1ZQKlvNDN0I=;
        b=g4bdReOrVCzCHy2QLheOWb7FJUlQQ4FS1n/69fwf7F4akCIjtpr0j/udBqEae6vi7U
         aLeO1OSmMkvZGQwegnUgRDLbLxWixwJsql8ip6UAKSE99dzfSK7hiCheDwRl7n2gCswn
         Ls+beQBscbeZB8qHOZ172x89dt0cCoBOecF3DHKsy9dN+RIXviprjd/io5mJI34WKnvI
         UPLLaXjV9+RWSVPgmsL+RWa5vqLDHc5pSuBbMm3OXYNBbBdUeQF3nkz0DIzGLdj0OzRV
         3X/BwvIolqYMlvBqPq5mzvX0gdLilGrj59Ng2NYGdjgf2amBLGcCPf0WLHiWqkkZoKMS
         pOMw==
X-Forwarded-Encrypted: i=1; AJvYcCXbd0rYWQIe0mh40rtqgZjvOCK7ComB8/G/7f/dGdOvslc0JgAzju/usk3VqkbVpj/CQdNP/+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YztSQzuE7ngejX4zdQinghI2k/JVF5DrQmIw20WlMFyzwByJ57D
	8KRdKcCTMCPqyC1cc+Ym0oNZrbqtITxvn60JIiHlxOydbsd8VKp0Gr+AqJ8tX/JwaM4kNkIvj3l
	RrPcPJjXQbVUoricJMCARnIjcL0tdVn4=
X-Gm-Gg: AY/fxX66zHyFCGlykbYoLGVBrktmpsnOc0qJ9wm0hZF4ri6W24QHXfEzQNZ+MnJLIFL
	mKQRPFA/oI0Qb2IlehwAVoMpMcrkKFoClHnjP9zt+dVYTbZ9ZifkmUJNdIovnOphRHHi/JIoNT7
	7/+ykJWv7VOzVXN8sSHA2tpLZ96juWjYFK60qPgMidm1KFc/C7ajU23gNYYBTKozl7szMJTaUu0
	mMlCM02p6FcmtPDaSagkj83xoTx7s+FRlEzhVdnCMku29oZfw4ClpxBxaUE1j0lE18QdiaRKjIN
	mSLt/bnH9p+RECBv3fSUXa+aW/HcjsjyKMUUwsM58U7JXwCwPpMAASqoLxpuhI9ATWw5uFRlfxo
	xdACxlWIBe1Ge
X-Received: by 2002:a05:7301:1f10:b0:2ae:5245:d50e with SMTP id
 5a478bee46e88-2b6b4114382mr3414544eec.8.1768765396119; Sun, 18 Jan 2026
 11:43:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115183832.46595-1-ojeda@kernel.org>
In-Reply-To: <20260115183832.46595-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Jan 2026 20:43:03 +0100
X-Gm-Features: AZwV_Qird-lwibLosQ8SVV1mDXaYy8TIK_gyKIQwJqqY-9VOd-kxYQI5T5v3RQE
Message-ID: <CANiq72mRB1Hhu=m26GsFHDTdiRTditNZGT4bRYWhWo_oBWsYXA@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: give `--config-path` to `rustfmt` in `.rsi` target
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 7:38=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> `rustfmt` is configured via the `.rustfmt.toml` file in the source tree,
> and we apply `rustfmt` to the macro expanded sources generated by the
> `.rsi` target.
>
> However, under an `O=3D` pointing to an external folder (i.e. not just
> a subdir), `rustfmt` will not find the file when checking the parent
> folders. Since the edition is configured in this file, this can lead to
> errors when it encounters newer syntax, e.g.
>
>     error: expected one of `!`, `.`, `::`, `;`, `?`, `where`, `{`, or an =
operator, found `"rust_minimal"`
>       --> samples/rust/rust_minimal.rsi:29:49
>        |
>     28 | impl ::kernel::ModuleMetadata for RustMinimal {
>        |                                               - while parsing th=
is item list starting here
>     29 |     const NAME: &'static ::kernel::str::CStr =3D c"rust_minimal"=
;
>        |                                                 ^^^^^^^^^^^^^^ e=
xpected one of 8 possible tokens
>     30 | }
>        | - the item list ends here
>        |
>        =3D note: you may be trying to write a c-string literal
>        =3D note: c-string literals require Rust 2021 or later
>        =3D help: pass `--edition 2024` to `rustc`
>        =3D note: for more on editions, read https://doc.rust-lang.org/edi=
tion-guide
>
> A workaround is to use `RUSTFMT=3Dn`, which is documented in the `Makefil=
e`
> help for cases where macro expanded source may happen to break `rustfmt`
> for other reasons, but this is not one of those cases.
>
> One solution would be to pass `--edition`, but we want `rustfmt` to
> use the entire configuration, even if currently we essentially use the
> default configuration.
>
> Thus explicitly give the path to the config file to `rustfmt` instead.
>
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel

