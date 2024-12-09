Return-Path: <stable+bounces-100274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CD99EA337
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 00:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624892827B8
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 23:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26077224884;
	Mon,  9 Dec 2024 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK0y7uxZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477719D092;
	Mon,  9 Dec 2024 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788673; cv=none; b=nZi448QeKkp3G81ep7qnU2SEQ1cXYvUSDJTYdsUgNTbAeB5wDcf7KXVYYz6L/xAvQaTg1baIbDXu1fAoWfIB4jWrUh6wOD0PiTbpg62qNjTjRl7pYDfGpf++acIgCQ2/fVStKzW2Dq03Qt0zbBX34LObXjLpRffOs8boIVqiwAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788673; c=relaxed/simple;
	bh=hpjEp/oF11sseU/xRny9xwf0vbjS/bPeeP7YWy3KZTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzeIot76pSoq8/dWc177QMroAHFpKZ6PbAVemIugDs7XNwLq/TwHm/ayQ/kfHR3ykxkg/wNQOhgg9h/vR/aXQRyEOFYBdtI+vk+cc53hmZsaMiweXI55+brhYlRQfuzcdnf1XplCgpzxjzqO4dvQfQCWC9es6hSrpw0cnuqIKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK0y7uxZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee8ecb721dso868182a91.3;
        Mon, 09 Dec 2024 15:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733788672; x=1734393472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHPxJ7hPLFpQidTl4ZL+eTNzMYzt1IS2TVSHXzTpC5c=;
        b=fK0y7uxZ80QpR/+SJPmLvsyGJXHoiFihwNQYhO234bkT3rygZuTIHT0V7dzbk1FdFC
         jczqEXj92HPOBovJdBKcfWEWER+HL3SLJfSNjMojuuTYW63dX1zDLwT1CAjmPFfnnZaC
         S8/fxOWE3Xs5To3S2hPYzLDPo1b1mTCHEwL4STqBzLmlVvLTBU0TPMBjl+wqrTe4oc2n
         ntC2IBeiU0KNRCfBkVrJo0G2sjTpvdLAoRuUBLNeWtYbde64rU8wR0UVKep5fXRmlABw
         VEdk6bi8/D3x9qhbibUVRz5tB2ccvryPN0929jVO1d65twUxW86uEUXfVL0CxThOVYi5
         1IUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733788672; x=1734393472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHPxJ7hPLFpQidTl4ZL+eTNzMYzt1IS2TVSHXzTpC5c=;
        b=f656TT2WQUEYfS6bBae1LZklQKxjAl/4cAMkh5liKNpW6dcaCOTjf9FZbcZaiLecNW
         n8S2kOvWyQZ/fbtF08MtLnGMEK/oP4TK6FfXh5dpHXf/XLW7gJ6sE/MlmbH3i7OXc5i2
         To3C7UMbk6VAywLTmSHJflyN/9NPO7L0fUDKLgKwtTduqL9nC81lxmtMn8UnGvSNVRgg
         dU8iXs7ur204Ly8BEQbQ+UbJN2hUubuJ5miZ+wYkJb8o3m09cNsfXduvzMI3fTgiviLN
         IQvgtVvohldqrgrqTHTy3jR+Wm3/l0Om5OZlYUOW5mtexYbl0S70/1JAPulq3F5sZtp/
         Fxdw==
X-Forwarded-Encrypted: i=1; AJvYcCVwOcXQmIVWgVAxYQMOkn9fMIjDGcPfsee47aWctyUnk7U1Fj43KQ7O6AFmxidnnMxmC6rrCw5nx2WKY4Y=@vger.kernel.org, AJvYcCW/Z79iSjl9MlBTgzALzqk78kQmCJtP9xuadBe5XNL8nJBpQ7noT3PESFreqdb4i3OJIRCqzA3c@vger.kernel.org, AJvYcCWLWfDZO6Fx4lXaacP1FC7t3c1jyiJEry8RdCdXS0dJlPDMh3q6ITzhxUXvzqctRfPdzf2FpDIdtT4YHu6F604=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZeK9Lh/RrUQXTRhctD0g+lj04GA4eqoDEaWXgzZ3w35mT08T
	+QgBWqK7LLIIhytKOrlpnH3YVONoqp9QPzIAs7GAm/LFPgpxRGI4s1f1xNRn4SF2j+0iZBuK6y4
	Dm/eXt616il+fuW5xtcXYELoAyf8=
X-Gm-Gg: ASbGncu2JOWLnKUEXbwmFrNbB0fPEZ10kGlptUkW1NuWMdEzeiK+VkfR0n6qNHe4l9a
	z/6B4mIVLWfNuj2iOoZ009ePQbIEZ5ycyUr8=
X-Google-Smtp-Source: AGHT+IFA3lV2vvANGAr/q1J0rO42UgmCv9jlCFJWKSe4+sKE0L6emUcGAjynzPESeucKuAY0Wly56Rz8xKK+eETDnTw=
X-Received: by 2002:a17:90b:1a88:b0:2ee:b665:12c2 with SMTP id
 98e67ed59e1d1-2efd472eba2mr848875a91.2.1733788671803; Mon, 09 Dec 2024
 15:57:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125233332.697497-1-ojeda@kernel.org>
In-Reply-To: <20241125233332.697497-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Dec 2024 00:57:39 +0100
Message-ID: <CANiq72=gRDr658wi=PbEcwTM7oEdmBU2Fr=wKw9eq2kEbrjWHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panic: remove spurious empty line to clean warning
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 12:33=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Clippy in the upcoming Rust 1.83.0 spots a spurious empty line since the
> `clippy::empty_line_after_doc_comments` warning is now enabled by default
> given it is part of the `suspicious` group [1]:
>
>     error: empty line after doc comment
>        --> drivers/gpu/drm/drm_panic_qr.rs:931:1
>         |
>     931 | / /// They must remain valid for the duration of the function c=
all.
>     932 | |
>         | |_
>     933 |   #[no_mangle]
>     934 | / pub unsafe extern "C" fn drm_panic_qr_generate(
>     935 | |     url: *const i8,
>     936 | |     data: *mut u8,
>     937 | |     data_len: usize,
>     ...   |
>     940 | |     tmp_size: usize,
>     941 | | ) -> u8 {
>         | |_______- the comment documents this function
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#empty_line_after_doc_comments
>         =3D note: `-D clippy::empty-line-after-doc-comments` implied by `=
-D warnings`
>         =3D help: to override `-D warnings` add `#[allow(clippy::empty_li=
ne_after_doc_comments)]`
>         =3D help: if the empty line is unintentional remove it
>
> Thus remove the empty line.
>
> Cc: stable@vger.kernel.org
> Fixes: cb5164ac43d0 ("drm/panic: Add a QR code panic screen")
> Link: https://github.com/rust-lang/rust-clippy/pull/13091 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks!

Cheers,
Miguel

