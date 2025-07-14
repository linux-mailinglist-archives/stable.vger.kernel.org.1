Return-Path: <stable+bounces-161814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EC5B03A18
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 10:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B85E1793D1
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D935518D;
	Mon, 14 Jul 2025 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+pZGC1e"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB0D23497B
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483319; cv=none; b=JPuAJrxwQTHmDd4YqXF3bkYu/YVpZEQMAmKnjO2zUC3K3AbVViixoTp83NERfsgUlsPUTkNi29rILPs90L3wpzillLH07QyMkcGH13ztuhlCEUMe3UnT/kkVBwItVkkeFXMgntc/Oe0BgZF+fGxZy+TjdVW7kdL+K5Til6qCtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483319; c=relaxed/simple;
	bh=dZxAbZ8ulWv334/QiHn19XkVOBuijNqEiiRbXClfk4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgaGBn8vfvsYeuWpYR3gRBb2LPYGDZ93DceRZEDrwtIJ8PCqqZbv7pVdWRrTnqo9PvBH8eEC2bNv5RTnZc7SiX2IzqgPSfLms7Bmz83IJJ9bbcR3k3sWAWVU1rYMXIMjKElGo5vviU68HP9NRErZNEbPZ8OjvvGMzqEUluCkWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+pZGC1e; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45617887276so6697365e9.2
        for <stable@vger.kernel.org>; Mon, 14 Jul 2025 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752483316; x=1753088116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gj+niLV6OALorn2kYpyE8/uWxGl7XxWeivxdBGPq6ow=;
        b=u+pZGC1eH2rAt6aQASXzBXuGeE9/05Y1VaneWtGHeBeJCpWisjmsCZ5nq7inhhJeNS
         BbccsTVFfQ8sZuJFaCW4FS3LTKZJS7hPURFo95Sh48Vw+AojQxSR7OVjUGPE9iz2K7Nq
         ldBlWX6NT6lcdpPyuEomW398zcit1MwEsebcOW7ESEYT7PQPK4weaHBEGg3+w85HSDpC
         Zr3VhEVzUbtEzS5v2gZ6CJZCaK7HwsFNlpSNCVrmzhStYRaK6csVB8s4CjvbQhObfJ9U
         dO7lhDkRIMJJUjRL3cVUwrdj3ucQjD0XPKEYp4YeuERXpKODP48mVo+x+SlYKoxrWzKf
         Xu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752483316; x=1753088116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gj+niLV6OALorn2kYpyE8/uWxGl7XxWeivxdBGPq6ow=;
        b=b+UbTJo6gWQH+3heVraYpFpxG36i8978A2TayuEumfSN9FFIHBSmPVdwUlAmPtQs41
         Rcylf6eSStfUycizcPSFsMBS7GkttIkiQYZ8QfWeC6ir5n48BC2tiUle47EPNiAEorKF
         0H303MvWq4lELVFbWTS4DjqoiFWU3rtKahI6AxhKljznL+E0K5wXaetfVCg3vmHuh+pf
         PlguNG3ca88TF2ZU11JN8UJ1uU2fSwh1vi7DimEjR716MXzVVzfMzuxEwZaPGmz6Qwx7
         i5pr8mPrUIJCKD7tA1i+b72WCRmb1uAMGufpIwFvr6eexAsqm9ECjL7B001XNMqajyeL
         KGjw==
X-Forwarded-Encrypted: i=1; AJvYcCXngQLVdd4HjgdUYRl/ZhfsWsnNWUrvU3V4oIT+iGGwA5EqOG3rSWt7GIiqIZwCHbk/ZsQP1XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeChpxqUIHwRBKfK3Z/pZP69DvPCHrHTsVGR9CXsPX5JQ/gpVK
	yv7JhJUcjBWLvYW3x5d9Ic5bXZRbgqqPB1y2uL3+IoLikJXKeLZ6orrNAlYe1XCOxO8U/pZtWoE
	AyRt34k2t+k/pg3oPNSjcd9UfUJ8szyGLdvsel1XE
X-Gm-Gg: ASbGnctu3abx3FD/pjJeaIpDS9X5Xoo/aAiwO4SwcRDYeVJotUjiFuexfTsIuBSEBgH
	FcHwApqk8fiNHBtcvrPwggaq32PMGMhWop39rz8WzVKVJqd073x9lJOM1LpqEnukOFdy2d6zNxA
	4NqyeiXRyXJKfXW3kAWlK5RQk64ytFoJIeqxb+Jbsc8sZ6RGjwqOmb52U18sglC4ScF1yF9crGF
	zxJRwLEgyKqibli+ataKKhQp/KSqX1eQGehXw==
X-Google-Smtp-Source: AGHT+IGsQeQEfcu02S30Jll96c0wDwxxBcoxIYEXCRnd0CfJMcytsTVZIf/b8uy6EvvrTgZ3nUg/bsWlB2lNPIlFVmI=
X-Received: by 2002:a05:600c:46d1:b0:456:e98:9d17 with SMTP id
 5b1f17b1804b1-4560e98a5ccmr52570005e9.5.1752483316042; Mon, 14 Jul 2025
 01:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712160103.1244945-1-ojeda@kernel.org> <20250712160103.1244945-3-ojeda@kernel.org>
In-Reply-To: <20250712160103.1244945-3-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 14 Jul 2025 10:55:03 +0200
X-Gm-Features: Ac12FXymYzZFPEmEJ79-ojPY2RmA0JBZ1Q8D2S9b-wAnvsipbXwRr9MT_ii7c3E
Message-ID: <CAH5fLgiZsdW+98-_kMmGcdujQzusDcLMdGJzPk-6VG7pkC2bcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: use `#[used(compiler)]` to fix build and
 `modpost` with Rust >= 1.89.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	David Wood <david@davidtw.co>, Wesley Wiser <wwiser@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 6:02=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.89.0 (expected 2025-08-07), the Rust compiler fails
> to build the `rusttest` target due to undefined references such as:
>
>     kernel...-cgu.0:(.text....+0x116): undefined reference to
>     `rust_helper_kunit_get_current_test'
>
> Moreover, tooling like `modpost` gets confused:
>
>     WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/nov=
a/nova.o
>     ERROR: modpost: missing MODULE_LICENSE() in drivers/gpu/nova-core/nov=
a_core.o
>
> The reason behind both issues is that the Rust compiler will now [1]
> treat `#[used]` as `#[used(linker)]` instead of `#[used(compiler)]`
> for our targets. This means that the retain section flag (`R`,
> `SHF_GNU_RETAIN`) will be used and that they will be marked as `unique`
> too, with different IDs. In turn, that means we end up with undefined
> references that did not get discarded in `rusttest` and that multiple
> `.modinfo` sections are generated, which confuse tooling like `modpost`
> because they only expect one.
>
> Thus start using `#[used(compiler)]` to keep the previous behavior
> and to be explicit about what we want. Sadly, it is an unstable feature
> (`used_with_arg`) [2] -- we will talk to upstream Rust about it. The good
> news is that it has been available for a long time (Rust >=3D 1.60) [3].
>
> The changes should also be fine for previous Rust versions, since they
> behave the same way as before [4].
>
> Alternatively, we could use `#[no_mangle]` or `#[export_name =3D ...]`
> since those still behave like `#[used(compiler)]`, but of course it is
> not really what we want to express, and it requires other changes to
> avoid symbol conflicts.
>
> Cc: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Cc: David Wood <david@davidtw.co>
> Cc: Wesley Wiser <wwiser@gmail.com>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://github.com/rust-lang/rust/pull/140872 [1]
> Link: https://github.com/rust-lang/rust/issues/93798 [2]
> Link: https://github.com/rust-lang/rust/pull/91504 [3]
> Link: https://godbolt.org/z/sxzWTMfzW [4]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

