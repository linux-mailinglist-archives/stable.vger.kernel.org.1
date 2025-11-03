Return-Path: <stable+bounces-192247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5960DC2D890
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 18:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FA43BF117
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F9F27B4F5;
	Mon,  3 Nov 2025 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="cJWdBVyN"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E61F2BAD
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192106; cv=none; b=h/8YmufcQ8CsaGVlR8a5Qn1A2WdbePpy0yJLl76lNN8jOO/3iXb1mFr3oZBi3a4D07CGQBF3esUGi2aGGaxi3gGFmKJnRKMrlRQ2OWJGz75JgusO2ZNqqKSYBawITAiVGMgD5dKn9JJ1Y9HWtExNtsl3mHtrMentiHNcpdSCQyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192106; c=relaxed/simple;
	bh=DZohdGmwhvfS7Y62yh/IEXkOppV7V3lqoMgTejWulFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6MjDUUme9oruhf+IzjXVg90BIp/c/aQq1Smd1Rnn2x4Os/995KtztddRi2L53N+43+eVEIxpeEZCrpSmoRsNW4ivAtO4XUXe83ElEPVArgXxJkRj0Is2X2sEmvUui5319GIghs+FAUvp5dba8c9jM5zoVAiorYj+cQVGtgCk1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxtx.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=cJWdBVyN; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linuxtx.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-433217b58d9so8383215ab.1
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 09:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1762192102; x=1762796902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWkOe5YDiqYERha5LD7zMqeSoJ/N7fJr/JJ2cnjXNyg=;
        b=cJWdBVyNjyE3Aw9dE+j0LOcjW5FSF9EToC1B/Qw3CMZ9GBRHHQKgsalbLZ210NbiCO
         uX4tUtmZuoMLvAcYmv3ylMjRSckVoqGXPobGXyutbnY0IyD+PiC8i0XbXm5ohL0oe2GP
         yTGvsVzqXiEJWTPL1pe26AytPqwza9Ho7dpO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762192102; x=1762796902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWkOe5YDiqYERha5LD7zMqeSoJ/N7fJr/JJ2cnjXNyg=;
        b=KRpnmKpcgvcg/+zGi/Fx3ihuzNBHr33THHrJdk7JxQTWUo9olMfZPNKiiRxEHInf5W
         zqAZt6qZqgPMRW6E3o/F+am9fvj00M6B14lcEx/2dObccHNcoDGsI0jgrtQ3LhI/UIEY
         N6oVGzkuQNkXAsPVGZSGJbREeQ5nsSTYzTBkMXlmi/eQUto/tNdt70TrX+V4BsomzkiB
         zzirwwY4vggCSUvZrKkB81WL4q9mX5KKsRsbSaDDK5YQXFgIHuIAdci248zfGdnR0EYu
         Ao2dc6dmCpjP2u+XnEoIkGTdllpke5cXvZmMR2jsUUrIIE2blGHyxi5kbyhZjRSiXjuv
         MXnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/UiNepF7scUmH99tnOyIx1qKZjiWdd8HTQ/AqjLSVAnCII9j8BcQHpulsC7JzXq+h7t5drWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPX+QdLBUC9TXPmNH3ivm+v+RNbE2GLIwXPZHFFf2tgJ6vKko8
	ibz6mHvAWTu0QHTJKGVQ3BU6CY8MuSy0RrtccVLLkAORtGCVKXKVuH4fJJ934U5qv+yLuAJokVz
	LpeP9tx4E+ImmFU5TA4z7sv4W2tXytTV6TdURHdVQ
X-Gm-Gg: ASbGncudgne0ebDlQHEIJ6jR4FcZVeMA1sYqVbnZatIdec/QNzudFzmUCGBwyV2/TBy
	l98+T2MLcQGpbPSlMC1pfzAZWkCyElbOioXwKhJ/+KLjlooGg2gDHWTuCVhY1h236gc1fmXUjGr
	RNVPbOxnnIVJ1D1bSrDOU8USHC1M+n+rtFzIVOUdYrV+4QSXFApZIvYULTLXHoxFeBA9VY+MeoI
	kfJMUAOc7bXyXzlE3PqiV9OmaQPRfsgtHGv99a6YxakIDK+whEB+wqlomCOnA==
X-Google-Smtp-Source: AGHT+IF9g9cwwuNwEQElfAQDhH0pHEpQX+9ymSaDZSx7wt1xXs7tDoLgwlfGaAsR869GJ5w28gauCBpymwrx1MG7HaA=
X-Received: by 2002:a05:6e02:470e:b0:433:22fc:bb9a with SMTP id
 e9e14a558f8ab-43322fcc5d4mr112236115ab.13.1762192102332; Mon, 03 Nov 2025
 09:48:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251102212853.1505384-1-ojeda@kernel.org> <20251102212853.1505384-2-ojeda@kernel.org>
 <aQiDdZvRNrBkrB-U@google.com>
In-Reply-To: <aQiDdZvRNrBkrB-U@google.com>
From: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 3 Nov 2025 10:48:11 -0700
X-Gm-Features: AWmQ_blfBw9zTFrICe8pc1ZBkE8gZV528mb4K6Tu6zlEDetF0EtgCfFYO7hVTdg
Message-ID: <CAFxkdArACiepmcjk7GFH313db4cpXDcWouVy4a6zQTMR1aDmPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: kbuild: workaround `rustdoc` doctests modifier bug
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 3:28=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Sun, Nov 02, 2025 at 10:28:53PM +0100, Miguel Ojeda wrote:
> > The `rustdoc` modifiers bug [1] was fixed in Rust 1.90.0 [2], for which
> > we added a workaround in commit abbf9a449441 ("rust: workaround `rustdo=
c`
> > target modifiers bug").
> >
> > However, `rustdoc`'s doctest generation still has a similar issue [3],
> > being fixed at [4], which does not affect us because we apply the
> > workaround to both, and now, starting with Rust 1.91.0 (released
> > 2025-10-30), `-Zsanitizer` is a target modifier too [5], which means we
> > fail with:
> >
> >       RUSTDOC TK rust/kernel/lib.rs
> >     error: mixing `-Zsanitizer` will cause an ABI mismatch in crate `ke=
rnel`
> >      --> rust/kernel/lib.rs:3:1
> >       |
> >     3 | //! The `kernel` crate.
> >       | ^
> >       |
> >       =3D help: the `-Zsanitizer` flag modifies the ABI so Rust crates =
compiled with different values of this flag cannot be used together safely
> >       =3D note: unset `-Zsanitizer` in this crate is incompatible with =
`-Zsanitizer=3Dkernel-address` in dependency `core`
> >       =3D help: set `-Zsanitizer=3Dkernel-address` in this crate or uns=
et `-Zsanitizer` in `core`
> >       =3D help: if you are sure this will not cause problems, you may u=
se `-Cunsafe-allow-abi-mismatch=3Dsanitizer` to silence this error
> >
> > A simple way around is to add the sanitizer to the list in the existing
> > workaround (especially if we had not started to pass the sanitizer
> > flags in the previous commit, since in that case that would not be
> > necessary). However, that still applies the workaround in more cases
> > than necessary.
> >
> > Instead, only modify the doctests flags to ignore the check for
> > sanitizers, so that it is more local (and thus the compiler keeps check=
ing
> > it for us in the normal `rustdoc` calls). Since the previous commit
> > already treated the `rustdoc` calls as kernel objects, this should allo=
w
> > us in the future to easily remove this workaround when the time comes.
> >
> > By the way, the `-Cunsafe-allow-abi-mismatch` flag overwrites previous
> > ones rather than appending, so it needs to be all done in the same flag=
.
> > Moreover, unknown modifiers are rejected, and thus we have to gate base=
d
> > on the version too.
>
> Ah .. we may want to file a bug for that.
>
> > Finally, `-Zsanitizer-cfi-normalize-integers` is not affected, so it is
> > not needed in the workaround.
> >
> > Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned=
 in older LTSs).
> > Link: https://github.com/rust-lang/rust/issues/144521 [1]
> > Link: https://github.com/rust-lang/rust/pull/144523 [2]
> > Link: https://github.com/rust-lang/rust/issues/146465 [3]
> > Link: https://github.com/rust-lang/rust/pull/148068 [4]
> > Link: https://github.com/rust-lang/rust/pull/138736 [5]
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

I can verify that this fixes kernel builds with rust 1.91 in Fedora.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

