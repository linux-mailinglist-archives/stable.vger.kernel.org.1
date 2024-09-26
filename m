Return-Path: <stable+bounces-77806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFC898775B
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 18:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B14BB23E64
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 16:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD38158559;
	Thu, 26 Sep 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUYHjp1Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C79113B5B4;
	Thu, 26 Sep 2024 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367093; cv=none; b=V5CV91PRY+6z1dgeaDzjwmHdRFf/7JLaQ+5aye5mpmM80/1Q0hhCZGGWaefPXmtxYrVWaa0wc8VfsDFaD1Q/yTLtKwS0wjegrv+uU6MDrTsJlI5hzeDLEg8WmG/vgWOvFdT2mJWSaARPh0xZ2yzCtfJ7nqw/QgUEg1HRURodTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367093; c=relaxed/simple;
	bh=shJSHXjlK547ydVvMCQRSZN4pxzvR+ilNKJfQM11QHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAkVyAUaBI3Myk9KItRww+c6qAc0otJFNtyELkoy2byJCuF0mXzUwsTahvLfHjh+onjSudoLF4PDzYShHu0sa5eBX4Z+ybYjVHyv1Qtf0oygY5zeVIZRQo0VFXRpQ3nfKNeWBBULFIXL0eLqXLp+kfgb9KHhxJBN8lGcaeEP874=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUYHjp1Y; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e09a36f54eso64680a91.1;
        Thu, 26 Sep 2024 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727367090; x=1727971890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shJSHXjlK547ydVvMCQRSZN4pxzvR+ilNKJfQM11QHE=;
        b=DUYHjp1Yn3hI6HqL2aIF3/eP+HMhRcDEJq0XtwBGOnGmQBGq2THiYbS6DNHch4qj9n
         JZLNHH5FL8TdE4yxOnEtCpdUVanl82YkHgSj48CDSZlR04cAjnI/cmFpOaNGIkKx5YmG
         lO9AtZF4hzl83gpbyop9cXKWKlh+Y2FtQnsHRqJMZdlUuN75Km/e5dc+OVKyDJYcDJaA
         vG1Q7Pb3ZFlJ7S7qrsTVDTy/IMHBgy0C8yc0pWfODBpNNVmaOUz9Lryfuom6L8VG3lkO
         F5E5Rek1IzWl3LzJrO+4NXWSz2qs9BgLEBilukyB1Ngdk4jhbiV+ZZxs0G94CY16fL+1
         XGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727367090; x=1727971890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=shJSHXjlK547ydVvMCQRSZN4pxzvR+ilNKJfQM11QHE=;
        b=WSkcEuAfHs1mGHkxxh+idwrh/U+CvQAEhqLMT1rhb+L58UzW31pceZEH1fV+jFGPVu
         ybDOZ9TcVahbCvGZPDL/nh24mnPfuA0VttQfpWjY4LytYQlPjFEi0ZCR7avwOm8PolI4
         iYnYr/A5HkhHHhLx3iIAENQFlAHVAnAyvgNd861B0+pCQt8xxQGZ5Bgs7J4Ig1ERBwgw
         fQfS8tTiYlGRABcyURWPikRSXdQarEzGiahWI5aO7z8JKimfCtHoQKnRJ//+o4NSIl24
         uMiqk60PQxC2wPcgVfL7gO2/BcTGFTFGe/mQIeg91srK9l12lXKxsOxogo3ebRblUh0j
         ca5w==
X-Forwarded-Encrypted: i=1; AJvYcCVF7W52mFUh6DF9kPQMBk1Bxvh9vuA4ISvERsWOvmExYYPH7jZL7dgttIfT63dbbgJVx8sPeWgT2ErLpbs=@vger.kernel.org, AJvYcCWuk1uPWCcytoTflLm55tdmmdyOdbv4ep943Hl31GPQsnDeK0G3vxvIxAvt/3IP1vjjd2BEODlL@vger.kernel.org, AJvYcCXOuLgxMPwElXiq8BCaCfsMA/lm7eo+PxCZkjD8WK+Db7iqvAc41PGBcBzSFIikxKcCSX6RFbfEIRqqBAy0KAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLbv0m1XD1I1P9T+bFImruLOF4a9G1sVKi2YoyXTgW8RIAwGeN
	gdS2rihpYWnFIHeJsMFLZJv2pKDtW/6t7p4rs/6w0kdZcMw5jPG4WiM7Dm6X2z0AQUKtItKrjM6
	c2VfyGiMSt0VVf9NmEFSZqc8vXAQ=
X-Google-Smtp-Source: AGHT+IHOPDH1wb+stuy0EfXx5p0HnQnqPFmeGMm37xP4Tf5VJjlZHx1w8z7puUade36nUeULNJZImKA1mSHvAcplnsI=
X-Received: by 2002:a17:90a:a78a:b0:2e0:876c:8cbe with SMTP id
 98e67ed59e1d1-2e0b8ee52a2mr104368a91.7.1727367090120; Thu, 26 Sep 2024
 09:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917000848.720765-1-jmontleo@redhat.com> <20240917000848.720765-2-jmontleo@redhat.com>
 <334EBB3A-6ABF-4FBF-89D2-DF3A6DCCCEA2@kernel.org> <20240917142950.48d800ac@eugeo>
 <31885EDD-EF6D-4EF1-94CA-276BA7A340B7@kernel.org> <CANiq72=KdF2zrcHJEH+YGv9Mn6szsHrZpEWb_y2QkFzButm3Ag@mail.gmail.com>
 <20240926-plated-guts-e84b822c40cc@spud>
In-Reply-To: <20240926-plated-guts-e84b822c40cc@spud>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Sep 2024 18:11:17 +0200
Message-ID: <CANiq72=ShT8O0GcN8G-YRE1CB8Z9Ztr-ZNcQ6cphHYvDGanTKg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix building rust when using GCC toolchain
To: Conor Dooley <conor@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Jason Montleon <jmontleo@redhat.com>, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	nathan@kernel.org, ndesaulniers@google.com, morbo@google.com, 
	justinstitt@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 5:56=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Mixed builds are allowed on the c side, since we can figure out what the

I am not sure what you mean by allowed on the C side. For out-of-tree
modules you mean?

> versions of each tool are. If there's a way to detect the version of
> libclang in use by the rust side, then I would be okay with mixed gcc +
> rustc builds.

If you mean the libclang used by bindgen, yes, we have such a check
(warning) in scripts/rust_is_available.sh. We can also have it as a
Kconfig symbol if needed.

Regarding rustc's LLVM version, I wanted to have a similar check in
scripts/rust_is_available.sh (also a warning), but it would have been
quite noisy, and if LTO is not enabled it should generally be OK. So
we are adding instead a Kconfig symbol for that, which will be used
for a couple things. Gary has a WIP patch for this one.

> Yes, I would rather this was not applied at all. My plan was to send a
> patch making HAVE_RUST depend on CC_IS_CLANG, but just ain't got around
> to it yet, partly cos I was kinda hoping to mention this to you guys at
> LPC last week, but I never got the chance to talk to any rust people (or
> go to any rust talks either!).

To be clear, that `depends on` would need to be only for RISC-V, i.e.
other architectures are "OK" with those. It is really, really
experimental, as we have always warned, but some people is using it
successfully, apparently.

> Sure, I can add a comment there.

Thanks!

> In sorta related news, is there a plan for config "options" that will
> allow us to detect gcc-rs or the gcc rust backend?

gccrs is way too early to even think about that. rustc_codegen_gcc,
yeah, if needed, we can add a symbol for that when we start supporting
the backend.

Cheers,
Miguel

