Return-Path: <stable+bounces-146312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2320AC36F0
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 23:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4AA8171515
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 21:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9767B1A9B24;
	Sun, 25 May 2025 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krZuRBt4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3BC7263F;
	Sun, 25 May 2025 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748208249; cv=none; b=PgAsdpyFVzAQzbvl7keF/AmHRJswCuB8UeSKRg/Zp+20f9jcK+MkJBcN6ZWLxsUWkfJasmcB4TWWKOhC+ZLZ5t54qZD1Q4FvhQjHPWAJpSE1XQEiBDC2Yj/0nhridwmIhcTqsabtOs0OVdbhhpXcRVKfQKHXu69mhon4h5J10nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748208249; c=relaxed/simple;
	bh=csjIbxkjXvsJic8Gju3XgtEF8puPjSWDZKkqI4fhte0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y56cq1UWOQdeys5S8CclrmecSseT5vmkYSikz61AE0HXLJqqVdQzP12kElQ8t+PpgwNwwRothnOgXWZ9Kh6v7y8Hv0llh1nJ5XpAGch/rzNIq4kQADojJBLzWe3dz71pIbGEotOiSgD1BlwExIKwki/q9RbPQXR1FzDo1BnHmZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krZuRBt4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30e85955bebso353842a91.0;
        Sun, 25 May 2025 14:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748208247; x=1748813047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdKkx0UX2sT9LmyAkFFCfAeiqt4ITwNiesIM4/v6r/Y=;
        b=krZuRBt4Id5f3Bt9IsRvFqXDNuylgmJwXiQQheAZdvQZ2Sl3CqqrGXerg4ugI5bBvV
         qxNy+UuYG2KfI+SKjQJy5CifsSA1v9IZMlIhF+5Ytpj9o0+EiRcfDak+TPUBKwri/n5h
         acHjU5ieSQJ86pw1PENifXP7dxcMCpXzO+FhMdklYvOpEuUaQxEZvJJGjeKEY++uGUHl
         lCZrEscgrtyKUH0ezb+xyCDeuYWhlNb68U3tgC/8ITOja0u18dZo8hV21SI4hyfmHgb5
         +Fj9srCZCi4DEYMkROL4iN8jZcjKSIYQBirRjXnSvOooa0PJMsWE9lqRLdCzW75TgnJI
         48Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748208247; x=1748813047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdKkx0UX2sT9LmyAkFFCfAeiqt4ITwNiesIM4/v6r/Y=;
        b=Vq5onN4oXkhA0J6NdLqFurPfSz4OGnFFtJicXUTgLRN23Fysb2iEypgTZrBJ7qeZrH
         /jMtH+9n6NuoBpfsKsd42TxpYcbKDURwhiDs0F69UIIgOFTVPLE5StIE740FtqNY9Ahl
         ptuLtdUKdEVxIcGJOEvpLr8GXGOAIR6trYZPaLRE1ZutWoz5uQpeWrYx+hwTXicchEs7
         tZo3T/7Q4JJB7xrVoCzPXAEIk182TCgz1MTQ6fTCpC/vhtsA8GlX5wMzbR546pA7eGIx
         fXO5EUrli/oUlClMNbE918a6FODR5xUnjmTARsgkFN3tJi57Jfqj67XBorsrPJPamfJx
         O5tg==
X-Forwarded-Encrypted: i=1; AJvYcCUf4ktBUpefOLdfqiLrRLofkUZ3XZDRXfLfUWbmIkawbmrSIckTovIHyEXudxT9lsnlAEfrnOBWvRyOHHyf8D4=@vger.kernel.org, AJvYcCX+BHMEwUKMcRapRyqb+Y14C+aeORSKaJcHdGgmqOI8mx8ON6rU23wVRGGG4zS1jHOUxicLx1V/@vger.kernel.org, AJvYcCXaRFKMoK5YRZxlrYD0BaGAdHu2wpmf1QNhbs9psfSQ3pMavWtG7vANS3SZkBsqAPJfhRTwDCTp5Ym3pig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+MJcCFYY+mMFre04l+u62f3CY3+48kPIBmw322jGnUAG/GjdU
	FjrxDKHpuMjRigH9wtTYXKxvXUIUiG95nqwUDAkatznbAZNndBoxKb+OkNJ5B+l/En98M0gE/rH
	jfdsFuX7Y9TPHssvMdOzmWiSKoksHOAk=
X-Gm-Gg: ASbGncvHVKRkCrSIYMBoDxBdVLJBO7kIOrbTIOO8LzxgpW1wLnB6NlGg7nSURQs6pOz
	ux3v+ebw5fgYLRVW1iHMStfXvu3mKAJR63qByAmajPY5gtC4G+91eEid0FbJQyLNxHJhGuMBc/M
	/SrGE154hofAD0dsLFGWx80PTbJtAOeIzYxwO5eAaLpWE=
X-Google-Smtp-Source: AGHT+IHcuLaRbjXl0Aj4/4BR+A9R+bCebtg21XIgPASl/2RuX+lhDfXK6IbAOQCX4iv6575aG0IK7wrMVgKjrfOIDaE=
X-Received: by 2002:a17:90b:1d12:b0:2fe:b879:b68c with SMTP id
 98e67ed59e1d1-311104b93demr3933873a91.6.1748208247196; Sun, 25 May 2025
 14:24:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517085600.2857460-1-gary@garyguo.net>
In-Reply-To: <20250517085600.2857460-1-gary@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 25 May 2025 23:23:54 +0200
X-Gm-Features: AX0GCFu8WuLVBP8Vfcvlzqr7jzVCub9uuBZWJyDHsB9FiEQK29CL4RZwEw0BNls
Message-ID: <CANiq72neLdtGORQ=GMsJ-mVgWscrAw4CB+_2cfbR4gtju4+azw@mail.gmail.com>
Subject: Re: [PATCH] rust: compile libcore with edition 2024 for 1.87+
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, est31@protonmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 17, 2025 at 10:56=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> Rust 1.87 (released on 2025-05-15) compiles core library with edition
> 2024 instead of 2021 [1]. Ensure that the edition matches libcore's
> expectation to avoid potential breakage.
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://github.com/rust-lang/rust/pull/138162 [1]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1163
> Signed-off-by: Gary Guo <gary@garyguo.net>

Applied to `rust-next` -- thanks everyone!

(I actually applied a couple days ago in advance of Monday's -next,
which explains the following report)

    [ J3m3 reported in Zulip [2] that the `rust-analyzer` target was
      broken after this patch -- indeed, we need to avoid `core-cfgs`
      since those are passed to the `rust-analyzer` target.

      So, instead, I tweaked the patch to create a new `core-edition`
      variable and explicitly mention the `--edition` flag instead of
      reusing `core-cfg`s.

      In addition, pass a new argument using this new variable to
      `generate_rust_analyzer.py` so that we set the right edition there.

      By the way, for future reference: the `filter-out` change is needed
      for Rust < 1.87, since otherwise we would skip the `--edition=3D2021`
      we just added, ending up with no edition flag, and thus the compiler
      would default to the 2015 one.

      [2] https://rust-for-linux.zulipchat.com/#narrow/channel/291565/topic=
/x/near/520206547

        - Miguel ]

I also added:

    Reported-by: est31 <est31@protonmail.com>

since est31 told Gary in RustWeek, and we discussed the patch there.

@Gary: I hope the changes are OK with you (I can put the
`generate_rust_analyzer` ones in a different commit if you prefer).
Thanks!

Cheers,
Miguel

