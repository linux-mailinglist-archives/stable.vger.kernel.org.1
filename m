Return-Path: <stable+bounces-139501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF1CAA769C
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 18:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507294A2AF7
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23D825C811;
	Fri,  2 May 2025 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGlgGK09"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC94925CC4E;
	Fri,  2 May 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746201763; cv=none; b=OrtMo+8KTkzM60eXnN94zZClWhT9S+fpIVmOJnjOXGIZV4nCbFYd1KMx1OBCXMQZNAIIWfSHKFqAvMINelIErGrOENA+9Pve75RV87OP61TRdXT7zo8yzyjV/u2SaNKvus/caX9IU5a2jMSqP0HASuXDkLI8xmj+mTLiBSY2OQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746201763; c=relaxed/simple;
	bh=UJ6WwhmFuVCqUdif14DkJqSkQxNVnMZG/jRa4NZF7Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8f8NCjpyJYxngUgJxIkPbSCH2YweWNwHq5yHJftOePgpSfs6EnyDGbY3rn8B0up/pvkqiDup+JNYqgoVC9Pt/PoPWEjYDRjQNL4i5kEXWUe1ypArdmJf9OBf5p5e7j7tinUzYrbBXV69D1H+1sPZHF7o5TplbrjpQQ4CfclQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGlgGK09; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54ea69e9352so2481415e87.2;
        Fri, 02 May 2025 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746201760; x=1746806560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWXi6ouIHtCt+/SVmgFqOORSK5kSta3bTlozmNEeTOw=;
        b=aGlgGK09m0o1NTDeLTsKXKByFw3aS6xVU+tQFt9M15LN0ecPn3SIFO/rrVYwyinM91
         /2k7jcq2kRlliVDSQ8iyxVgM7VOI9npbzuK3HMthX4FkDqnEdj6tQaeogOg29rJch41D
         PsmDl+WRNmqgj6y+pHDoKusWF0tDfly7//0SfqJB+TkDhuRqqIcRMrRTO3zxyM+eEG6C
         /SX8XKdp+8I1nPUG6odLg9DBCuAtXcYnzoH+mjA5PXoPqEGNsf7aWLzDZMCn2hVOL+1X
         6bJAZy+PRsW05Pyc72jjFi3godT989y1Rh2gnQ3yFpVd69a6neLrv++sfR6aRQBypAjz
         vg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746201760; x=1746806560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWXi6ouIHtCt+/SVmgFqOORSK5kSta3bTlozmNEeTOw=;
        b=F7GEN1ZuGtKw8lRAhojjTlF41WgjOAV0TfSs4p7l4IxMNCIPrna1/vtLd99Pn0OjzM
         ajogo3Ffs1aTU7hj+9Oyv5JKvW+Ftog6A+5hsJGKVTXt8QRhZCuLlpY9MPMUtuVKmRsx
         S5GDOXOpadk8HlUrQjOi0Yd4U4XGoYrqmVwfXeu9bgrPaNwv9ldWosN6gUTaqlD5QbvL
         XNjbpywfBi9nRzJ5NpwvVrMa/rMhUsUOJOGobWSPqsFtGZrc/xb00AlQjwRmuMr5rXAg
         IxHE4aC3NCD3wqpJBYsbt8MzS5quvoA3tLgpNU5bzV5CLCFGIT7BNS5gzn4VTMGKBfJq
         acNA==
X-Forwarded-Encrypted: i=1; AJvYcCV3RlZ3uods9nc0U2KKP1f7lOvbUagy5po3kkb9+YnhFgg3/i7HZuSzaJ7iNn4w0ixy+ZKBhHZYvqrG7w/O2w4=@vger.kernel.org, AJvYcCWEs8ozpHP01NG0dnEit/x/8NaNNXwlBEA+m4TiaD15HcqiB55sm/OJXDn9WNZK9xCzkrrC1Y4v@vger.kernel.org, AJvYcCWgMDArRQsCT0vc4JgOaldE4T03tvpH4MXt2gpivWtCnjnjix5Qm76hfXnl9MOS10Ott0RUsfE6ZsrlVIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp+lAZd5iTYsqYS6HMWmkOKjP5cpUoou6KY0G5g9vCzgp7Jv1i
	NLBuGvFsldzmhzYOA4D++NspRhDDuZUR7Bvkwa3/i9DNHOMxdYyFEIR9zSEmGNNWe+tNVbpt8QW
	KR/qQsi7wlU/kFjWoVpizkVdXzHY=
X-Gm-Gg: ASbGnctmPvKJPfcsKqPkmu+tLXYlHpFnuCIAzOgnSl09P+BdAZPMPn/i212jVx9RwXy
	/H9KyAmoDppk26V4KQblcRDb8lgFkEXz4vN1BMHW075F2cfYTeZ2C6nR5F+SrLfxpcmrd/5/mIS
	+wtETirYcAx9Cv701XZWpVd329p/uAp4eZlr4gQQ==
X-Google-Smtp-Source: AGHT+IFQVJp0oLfBErJDYrcvWauZBR16iubXjM5Ov20E4hDu+u4f8dcYnUxZFRb2GWq/A5s6LAVkaHyvKfsIiT02qF0=
X-Received: by 2002:a05:6512:3b0b:b0:545:a2f:22ba with SMTP id
 2adb3069b0e04-54eac242c91mr923495e87.37.1746201756548; Fri, 02 May 2025
 09:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502140237.1659624-1-ojeda@kernel.org> <20250502140237.1659624-6-ojeda@kernel.org>
In-Reply-To: <20250502140237.1659624-6-ojeda@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 2 May 2025 09:01:59 -0700
X-Gm-Features: ATxdqUEluk2jv-DmfiRVYlxsy5N_uo2h5vdZh8glM634BlTDAbUSZr2VxhwzSKA
Message-ID: <CAJ-ks9=XJ_cX8=vCtAr8Qr+4iaX9fyc8+djiBmg8=FxJTggS9w@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: clean Rust 1.88.0's `clippy::uninlined_format_args`
 lint
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 7:04=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Starting with Rust 1.88.0 (expected 2025-06-26) [1], `rustc` may move
> back the `uninlined_format_args` to `style` from `pedantic` (it was
> there waiting for rust-analyzer suppotr), and thus we will start to see

Typo: s/suppotr/support/

> lints like:
>
>     warning: variables can be used directly in the `format!` string
>        --> rust/macros/kunit.rs:105:37
>         |
>     105 |         let kunit_wrapper_fn_name =3D format!("kunit_rust_wrapp=
er_{}", test);
>         |                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#uninlined_format_args
>     help: change this to
>         |
>     105 -         let kunit_wrapper_fn_name =3D format!("kunit_rust_wrapp=
er_{}", test);
>     105 +         let kunit_wrapper_fn_name =3D format!("kunit_rust_wrapp=
er_{test}");
>
> There is even a case that is a pure removal:
>
>     warning: variables can be used directly in the `format!` string
>       --> rust/macros/module.rs:51:13
>        |
>     51 |             format!("{field}=3D{content}\0", field =3D field, co=
ntent =3D content)
>        |             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^
>        |
>        =3D help: for further information visit https://rust-lang.github.i=
o/rust-clippy/master/index.html#uninlined_format_args
>     help: change this to
>        |
>     51 -             format!("{field}=3D{content}\0", field =3D field, co=
ntent =3D content)
>     51 +             format!("{field}=3D{content}\0")
>
> The lints all seem like nice cleanups, thus just apply them.
>
> We may want to disable `allow-mixed-uninlined-format-args` in the future.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Cc: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/rust-lang/rust-clippy/pull/14160 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  drivers/gpu/nova-core/gpu.rs              |  2 +-
>  rust/kernel/str.rs                        | 46 +++++++++++------------
>  rust/macros/kunit.rs                      | 13 ++-----
>  rust/macros/module.rs                     | 19 +++-------
>  rust/macros/paste.rs                      |  2 +-
>  rust/pin-init/internal/src/pinned_drop.rs |  3 +-
>  6 files changed, 35 insertions(+), 50 deletions(-)

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

