Return-Path: <stable+bounces-114185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67703A2B676
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 00:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E973A81A1
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 23:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A06236A75;
	Thu,  6 Feb 2025 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI2Mi3bX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B52376FE;
	Thu,  6 Feb 2025 23:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883547; cv=none; b=Iy6KnntzxvX844OIgm9CYdWOrvT2vZfSgcTA8BYYb9aNcewNhmqWpvoLhlaJvLATgalGZrI6G8uJ9IIVIkAF3g7jSyFvE1g4jFCFoXpkmx5031G/VH4NJ2mYBbTFOAcOx6eGM6hFMlf3+cvkuLD/K2tQPuVIGWP2yFgkBtUZdfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883547; c=relaxed/simple;
	bh=s41qX6Yk4nXFhcCL2GbVjCi0CoJKcL0Dv0LKGqTWoa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/ddWaRGAayB0ahrfJcoJZ57N8Z3ptmlza8jWDgMzUfqIjQ49+UvLxGOAtYgryFfrH5kHjcIR2rMHCao6SQG77XH6YAl9yLbHu+lVzPk6zon3Jg88WijctvUKEuIZitrSMDTa6GFYob4ZlyA+mqWrV2WNYWrI1gh7+aWih1h7pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI2Mi3bX; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa227edb68so64171a91.0;
        Thu, 06 Feb 2025 15:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738883545; x=1739488345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyErsUMqJGY+6wGgFKeF+TSNY1GZRRrnpHGcKU+4aXo=;
        b=GI2Mi3bXndo/c+itaq4i6l5POj6Uz+S2518bmQ0oB6Us5xP+X6imHXKlDKA1L7Zd2t
         CGXTOicSKZmPKMKdHchykwQ/1k30AHsuppn4mtjsNOG2l6nMf+z281ebBiCSfVp6jdkP
         eUxQCRBxAFbEQIjLtYS/6snUD74iZzr13F566Nw1yu+nuDfbAg4eTnczhrbDYjMN05Fe
         C+6Rxu6scoJQHhapsjY+LGivBYqForM56XaN2LlYSCD8EJhrTrlFAhcMX1gW5jhoxk7S
         m9dwkuKPqE4V/C9+u9zonoiCoI2ErGT8iybMwZOGeMmIF36OfzTNWIdl6AEtdRxNI5X8
         DsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738883545; x=1739488345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyErsUMqJGY+6wGgFKeF+TSNY1GZRRrnpHGcKU+4aXo=;
        b=GdIgPmPdqec4cZh3xT1iEyqQ94qEHJIl+BzKKCHbQz5QnwlP+JxaeAJet6YmoFqoyu
         BLFs1C4xY15J5ESsNeWCeYjFktWEFvCXUqbM1LJF7vUPjqXEk7kJBWQe9//bQHxfHSdf
         IaGfF3iwHh/61h2ivyPwwh43JIvD74QwpggnDFcyqV5iw23LEIclP+DQcAvYyKJ3+WVY
         qLhpBpDoKDSe78bRzyxHGGzJ/FcQzmms6BFqRvXs6eoSA9B0+eCWJIAN+4SAv4qpuWG0
         irhasOMTmRzPOKRlF6bNG8j+pzbvg007ukBnuICF3LySVG2HxnVh8JeEAltjkYwEKeJA
         X65Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/3khjLa9u9MgNbqISiG+tMvBEMvuYQV47GPROCbEPZ/3AJbdAL1/k04ZWyHgNuGKYcLw49gSQLNpBn/7w6lw=@vger.kernel.org, AJvYcCU4jytNHShj6dnBVm4vvtQudHLuMowP9I71dOabd5C10HEBhvJk/boMv8k27h1ZrWYejuN90Kus@vger.kernel.org, AJvYcCUjnU3R8s7oXGWzba+P6N9SqGRgJzbfnT/l10FcRl0IJk0h1KDwwSZSLLdBuoSo6mhLrumqeJ9FvsqLuyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzEN78h3cn5oPCBHFfhKvO+WDZel4cxNk/S4GMUSuiLY4VbRyz
	MPmXUUluPKwoT5E/nlwc5HAPp1Z5UogUCRwNW/MGACraQlgi72MsfT5HtnBBuAp5zjGcMv+3d5k
	G7nXZJ9hTkcaEMlCQfdtFPVaDip4=
X-Gm-Gg: ASbGncu8Vwj/etVIV49F7LUsxrSjyWL7dISPWJoKwBeuwLCkKD8mJm6rVa5a/H7JR2w
	9aONHPAr/Vn8ktDtK14tD48NT2MYyRs/tJRBLtBu1iEzv+rXMnFMmzRVWHTFc7xa+sEoGY9Vo
X-Google-Smtp-Source: AGHT+IFabtG21X7NKUhGacZTQpIuZrXOWACb9e0BMyyfkrF06jXQFwkCCC4oCslp8Y9ghomKpxd/CJgaMkrH7G/brOQ=
X-Received: by 2002:a17:90b:3a83:b0:2f4:465d:5c91 with SMTP id
 98e67ed59e1d1-2fa2452d339mr529092a91.8.1738883544912; Thu, 06 Feb 2025
 15:12:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-rustc-1-86-x86-softfloat-v1-1-220a72a5003e@google.com>
In-Reply-To: <20250203-rustc-1-86-x86-softfloat-v1-1-220a72a5003e@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Feb 2025 00:12:09 +0100
X-Gm-Features: AWEUYZlpw7jvFfytJyU-YvSj6TSBA8CfMhG2Wuxzy9iTLvJXn0cPjfdmm8ipjxY
Message-ID: <CANiq72m-BbHdt3krPCZ9RDELhSnDPisG32h_uKzQPGwQ8H2ykQ@mail.gmail.com>
Subject: Re: [PATCH] x86: rust: set rustc-abi=x86-softfloat on rustc>=1.86.0
To: Alice Ryhl <aliceryhl@google.com>
Cc: x86@kernel.org, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 9:41=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> When using Rust on the x86 architecture, we are currently using the
> unstable target.json feature to specify the compilation target. Rustc is
> going to change how softfloat is specified in the target.json file on
> x86, thus update generate_rust_target.rs to specify softfloat using the
> new option.
>
> Note that if you enable this parameter with a compiler that does not
> recognize it, then that triggers a warning but it does not break the
> build.
>
> Cc: stable@vger.kernel.org # for 6.12.y
> Link: https://github.com/rust-lang/rust/pull/136146
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-fixes` -- thanks everyone!

    [ For future reference, this solves the following error:

            RUSTC L rust/core.o
          error: Error loading target specification: target feature
          `soft-float` is incompatible with the ABI but gets enabled in
          target spec. Run `rustc --print target-list` for a list of
          built-in targets

      - Miguel ]

    [ Added 6.13.y too to Cc: stable tag and added reasoning to avoid
      over-backporting. - Miguel ]

Cheers,
Miguel

