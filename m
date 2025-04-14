Return-Path: <stable+bounces-132439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341FDA87EE9
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAE3188E537
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA0228151F;
	Mon, 14 Apr 2025 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2HKJHlj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D44269882
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629746; cv=none; b=A4DFDfm+sNd82T4qQd4R+BB/B6AqtU7q90l4h988orol9tq7O4C5J0oVNfNuB+zXMAmsJXVZJQm+gjQv7UYBFnCE0y9yhHgJiQobksl50LCs5itlTD5/06wjwXzmcWPNjBe8tHqf7gQQF54j95ogO7k9N2msfkRELNY+lE4N73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629746; c=relaxed/simple;
	bh=5Fvjkjfat+nJk7Vy80tDWnDp5NpzHStADTmDQuN5aCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rm/spGjGL65dPF36wtmxrCyNYfJmbMZQ9olDpMWXUojr/Xho9iCTbRQmlmp++1bXOtbPQLwHBlDCqx+ZLrskeWeXOybwI6uIMBgM+3fmTW6CaeeiefEnnWYTzvgb6AlqjfUq4gI4IHU1S34w+XM7hYz4CzlCcwHG4nPafZlA0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2HKJHlj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso31332075e9.2
        for <stable@vger.kernel.org>; Mon, 14 Apr 2025 04:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744629743; x=1745234543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rft3EAUTLyhnp7+tWC0d5mWYcohYnVvJHm8W23d6BUU=;
        b=Y2HKJHljzyuuReTwKUy2YuPklO26NnXFOTtF9/+RRuF97SdY6XPya+/i57cfiMk5bu
         +O3d203lG9935JLqdiDpLarbsbUPK5VCk+wTXmCu6XinJY68OaAPkn/0Xb8OdSGzbuwi
         seE6p0hsuampbw/LRr2aTeiZ3ecG4M2lfxlW6ojWtU/ZBVvcPBVH5SrlRVqDHG0s3Z9K
         MxS87kQLv5O+LqEI+SeRoRvk6yhNp/FamMuONeqTdAs6Y8FjVsUr2GeMmvLPfB9OmYXn
         8qUwi6giR72ciKOWdnl2KqFCSuPow5oZ94Yma74GJwNcnslz57b71O70M03/uvQs6VMh
         FE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744629743; x=1745234543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rft3EAUTLyhnp7+tWC0d5mWYcohYnVvJHm8W23d6BUU=;
        b=rFWBZG6JDWgNYMZoMWp6cqKKujzot2KghBZrMn9mmJbVya5qwoTW3uQfZh6pBlZ60z
         m35vBPakCLpKh+uv7gWl5XRwTRoVg9uhxegA3+O/xyfTBeaLIXGlTYPd/jIebHnx/P2Q
         0eZ4nQ20KqcB8US7FleRwKJoB55AB50Zbdjyj2NKUncdlzf9G7zDyvZlPlcbsNsuSfwK
         NVNIVUo9sFD+wS5s/cD1JayRQ+z5iwTBSJz/1kZDsehXskOnz+A9RRntcw0EA8zfvmob
         t6FFIYKIO893P4AAB31BUXUb/dtY3nNHYpUIvFiHarUXRi/9e9HEDKaVfFlwrI3BA1Jf
         i+fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV73byosvB55C4qtHPTkrSfUXa4bdeTMiSj5Ak79zlnxj1blgArmMlB6a7jZKDetpt02ySuKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwaK+l8iIQqeOuV+MO4P1zK1Nio4Aca9nB4XsHS3/c9pg2gCoA
	fuVH+NbyEwlSI66Xw/HAxyH41mWWTk0ul671sAlbTVVbw7UzggsLLCFhs3fo679SzwKzpX72svA
	c9CbmvnIyyPZ/TP6G3uNTKDzeoKQ0yfrZNkCB
X-Gm-Gg: ASbGnctGGlSs9wioOP152bRWZ94fRv9fVzMznSEOquew25Yp702xwKHBgeTn2rRM8gj
	96dEjqWlHmjKqFCZmdYOSdnleiOzUPiN5PRozrEjAXA/CvB+5ZxIuVCpgRDle1hpge4ahiDiLhm
	FSl0axgjozSycx95D70DVrmqrfWNJVOdcB/0G32jual0b0ySrKCag=
X-Google-Smtp-Source: AGHT+IEZZBt3UNC3+TSE5+/gmDD+2unhz/9dXO7/xHNdpPGb0TNqsh6CfuUuMhd+ZdyeJAI6BZseyvWSCutQpwcC5zk=
X-Received: by 2002:a05:6000:2405:b0:39c:1257:feb9 with SMTP id
 ffacd0b85a97d-39eaaed586amr8788733f8f.57.1744629742684; Mon, 14 Apr 2025
 04:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408220311.1033475-1-ojeda@kernel.org>
In-Reply-To: <20250408220311.1033475-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 14 Apr 2025 13:22:10 +0200
X-Gm-Features: ATxdqUF9via54VPG5nlOhtSrUPwWIS_mfTXT8g_wST2xwdZg_Zg47Lq68Zxptiw
Message-ID: <CAH5fLgjb3Wxbkzvvy9H6QUYVpxXvkse1rnDmmR3nVHjp6zEx9A@mail.gmail.com>
Subject: Re: [PATCH] rust: kasan/kbuild: fix missing flags on first build
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev@googlegroups.com, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Matthew Maurer <mmaurer@google.com>, Sami Tolvanen <samitolvanen@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 12:03=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> If KASAN is enabled, and one runs in a clean repository e.g.:
>
>     make LLVM=3D1 prepare
>     make LLVM=3D1 prepare
>
> Then the Rust code gets rebuilt, which should not happen.
>
> The reason is some of the LLVM KASAN `rustc` flags are added in the
> second run:
>
>     -Cllvm-args=3D-asan-instrumentation-with-call-threshold=3D10000
>     -Cllvm-args=3D-asan-stack=3D0
>     -Cllvm-args=3D-asan-globals=3D1
>     -Cllvm-args=3D-asan-kernel-mem-intrinsic-prefix=3D1
>
> Further runs do not rebuild Rust because the flags do not change anymore.
>
> Rebuilding like that in the second run is bad, even if this just happens
> with KASAN enabled, but missing flags in the first one is even worse.
>
> The root issue is that we pass, for some architectures and for the moment=
,
> a generated `target.json` file. That file is not ready by the time `rustc=
`
> gets called for the flag test, and thus the flag test fails just because
> the file is not available, e.g.:
>
>     $ ... --target=3D./scripts/target.json ... -Cllvm-args=3D...
>     error: target file "./scripts/target.json" does not exist
>
> There are a few approaches we could take here to solve this. For instance=
,
> we could ensure that every time that the config is rebuilt, we regenerate
> the file and recompute the flags. Or we could use the LLVM version to
> check for these flags, instead of testing the flag (which may have other
> advantages, such as allowing us to detect renames on the LLVM side).
>
> However, it may be easier than that: `rustc` is aware of the `-Cllvm-args=
`
> regardless of the `--target` (e.g. I checked that the list printed
> is the same, plus that I can check for these flags even if I pass
> a completely unrelated target), and thus we can just eliminate the
> dependency completely.
>
> Thus filter out the target.
>
> This does mean that `rustc-option` cannot be used to test a flag that
> requires the right target, but we don't have other users yet, it is a
> minimal change and we want to get rid of custom targets in the future.
>
> We could only filter in the case `target.json` is used, to make it work
> in more cases, but then it would be harder to notice that it may not
> work in a couple architectures.
>
> Cc: Matthew Maurer <mmaurer@google.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: stable@vger.kernel.org
> Fixes: e3117404b411 ("kbuild: rust: Enable KASAN support")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

I've boot-tested Android's KASAN configuration with this patch, and it
continues to work. It also passes Android CI [1].

Tested-by: Alice Ryhl <aliceryhl@google.com>

Alice

[1]: http://r.android.com/3584874

