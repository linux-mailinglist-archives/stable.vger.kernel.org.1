Return-Path: <stable+bounces-35980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8160589917F
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 00:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44C71C234E1
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 22:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1CB6FE19;
	Thu,  4 Apr 2024 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3SVQEvFL"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E84753362
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270476; cv=none; b=V2OwKZGLXtXUQ1aAeRsdIGewCZyijQ1gMBk9dweO/UlQCVyuVOqhUAQgK5cDW8StKX6CvhxLs0CR6+DR37uII2Q2klC18LpKlDKEfOfTYRfRwXHNE9UNTfGzSRezXQ9b6v7G4WiQ7WOHNYPJIr/3RbP9HK6RbYJkAh5SLL1ZRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270476; c=relaxed/simple;
	bh=8A5tKiFBa0lbUbCLGluriwofV6tCs9WRKtzaqV10d5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4MXG8yfZAImTnvnCFam0SvtpDubiERfxW9j1Gfp5KTOkDjjt/qbLJbUsjghIEQFFrwQbaY/k1b+t6OEdMmQiGK3NwUwQKXwG/bXSbGKkA+kMBcqjt9H3fzhodd4DZGBA48cukqMm9XX13u9W81DYQDKlFb+gS93EZxB13QiSM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3SVQEvFL; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4da702e48e0so649782e0c.0
        for <stable@vger.kernel.org>; Thu, 04 Apr 2024 15:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712270473; x=1712875273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8A5tKiFBa0lbUbCLGluriwofV6tCs9WRKtzaqV10d5w=;
        b=3SVQEvFLH5hC8C+pSGkZZOrGdYOXWU+uy6P1oO6NXphX+DIuoAD1HcgsF7Ybj4L+hn
         PgMJwUkNWSsK3X159h6sgPIjoRXOpaw2PKdQTbPs2GzNA1GFIORCW6j3Eo5Q9LQVg3ey
         tKHzxPWjf0Rc3f4+KpNdArHsnZ06QvXIIUgBbDw6/e4/j7Gh10WHfhfFsPZwENn3qMik
         OXGcI3MK4td73qHmiJcuE9H8b8/QffXDvBcKBKS7iPgM9skUNk4bYdrNu/hsrtzyWD89
         3Mrandzr92ryjSTXiANP4mDjMDUk0yy38jwgisdDpHpRnMKfdi6dCkrHLk2IwZuy1JF4
         bHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712270473; x=1712875273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8A5tKiFBa0lbUbCLGluriwofV6tCs9WRKtzaqV10d5w=;
        b=Uvg5d5fil+oEscIpsfPgBn33sq9gpD0MF7cLFLTBhuimmQ5xcu5inZSVF+T1oQ+YU7
         NIAb/FycPHHrGgaKw5D+5fOkSm7N+ZhK3BN7AaOrD49AR5mQAUO9oo02MXnyPdkYziXE
         OfjXW+HQZ430aFYPw62Q3laeCxPesbySx4l5eJimTLAXyar/Bt08agymGN4+Cwhf23AV
         v+pr97XZh2mx9vEmRMx9YLp3ly6Mls4NHq/I7jRltorSiI+TFifZqrxgTXV6gWd49G7b
         +aCc7Bn68huozQfjQ60GpzX0Se37OV7J/OtXFwmOMlJewWzNbmlhuCnLZd5+3D2162jK
         4W+w==
X-Forwarded-Encrypted: i=1; AJvYcCWgU69MoM4DEgkZSXYDhcI2EN0iccAWjTUbmn34imt5junH8fBkpP5EVYAvZTFTx0suEqzVMK4GClPXnOpNGwp3jyoyUG/U
X-Gm-Message-State: AOJu0YzAmj5v2wwc+oYeO/q5fOeFTTZwZSin5p+KoujRh3Ipsbq+yZZ4
	qb0ySiBYeZ1g5Ep4otfnAv9GW/FkPULGC3PJJ06gI1IR5eumD7gmzmw04mLTGmpB5jW88yNWOyA
	+ZM2bZlwLhGsHUfSNeHS7S6EZYn3DoO9Cj5ys
X-Google-Smtp-Source: AGHT+IFZOijUz7nc+slBJ8zOHyZ8cj9MgnjzviT3lXApOXO2vYVNI4DlpN571/pk/cWTagxBQ7uu8R14TkT0NKKSOs4=
X-Received: by 2002:ac5:cdf3:0:b0:4d3:3a0f:77ce with SMTP id
 v19-20020ac5cdf3000000b004d33a0f77cemr3746386vkn.13.1712270473349; Thu, 04
 Apr 2024 15:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-providing-emporium-e652e359c711@spud>
 <20240404153258.GA852748@dev-arch.thelio-3990X> <CANiq72kSfC2j07mAaV591i4kDwejWRYcFTvASgQmNnHVe5ZwCw@mail.gmail.com>
In-Reply-To: <CANiq72kSfC2j07mAaV591i4kDwejWRYcFTvASgQmNnHVe5ZwCw@mail.gmail.com>
From: Ramon de C Valle <rcvalle@google.com>
Date: Fri, 5 Apr 2024 00:41:02 +0200
Message-ID: <CAOcBZOS2kPyH0Dm7Fuh4GC3=v7nZhyzBj_-dKu3PfAnrHZvaxg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: make mutually exclusive with CFI_CLANG
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

>
> We track the unstable feature(s) at
> https://github.com/Rust-for-Linux/linux/issues/2 (I just moved this
> one there since it is close to ready, but it was in #355 previously,
> and cleaned things up a bit).

Sorry about that, I should've done this already. In addition to the
link you added above, here's a tracking issue for KCFI support for
Rust:
https://github.com/rust-lang/rust/issues/123479

There are still a few unresolved questions that I'd like to hear from
you as you experiment with it, which the tl,dr. is: KCFI support for
Rust shares most of its implementation with the CFI support, with some
key differences:

KCFI performs type tests differently and are implemented as different
LLVM passes than CFI to not require LTO.
KCFI has the limitation that a function or method may have one type id
assigned only.

Because of limitation listed above (2), the current KCFI
implementation (not CFI) does reifying of types (i.e., adds
shims/trampolines for indirect calls in these cases) for:

Supporting casting between function items, closures, and Fn trait objects.
Supporting methods being cast as function pointers.

There may be possible costs of these added levels of indirections for
KCFI for cache coherence/locality and performance, possible
introduction of gadgets or KCFI bypasses, and increased
artifact/binary sizes, which haven't been looked at yet, and I'm
honestly not super happy about it (but it's better than the original
proposal of adding shims/trampolines to every virtual call in the Rust
compiler), so I'd be interested in any performance results or
regressions you may have while experimenting with it, more
specifically:

Linux Kernel without KCFI vs Linux Kernel with KCFI vs Linux Kernel
with Rust and KCFI, possibly isolated to the code of a driver that has
an implementation in C vs an alternative implementation in Rust.

