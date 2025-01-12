Return-Path: <stable+bounces-108335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886F1A0AA30
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 15:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E51BA7A2B85
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBBB1B86CC;
	Sun, 12 Jan 2025 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIvqGTRZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9B11B21B5;
	Sun, 12 Jan 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736693238; cv=none; b=f+MfJ7Ei31C90kfj1JZfD3Q1kSPHBxoZbXvv8KXj+XdShJxjibZ7aY4PPeP2hBk68azidHDdEaq7KxPLFg/+Rl/psam5VlOInO6xNpdQPKyjgrBonmpSe69jfE3KGdAJlPvPwDvZoqA6n2f0+SJvbjlwX+vfUWrP54N5sAoiYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736693238; c=relaxed/simple;
	bh=sYm+b6a271AERSbamgy9m3KH0LP8SVZIjMoiBZbQjuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyOI9XcLf6kY4ulSfdcSUKx3rft/9yIH3GHW4scwMJecJ+wKdEpVDcTuKyMOUbz/Pzf2C/djsZBWdbK1D0suQcRTAv18mqzu9O712HBncJhjDHz3WHUUJWr+hSwEyZRp4f6uRP3L5WlWwJIX3wXAR1SC3wNpb1nQbWz/gjBppkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIvqGTRZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f440e152fdso824530a91.0;
        Sun, 12 Jan 2025 06:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736693236; x=1737298036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tE4fq4FFdl3mipmmIEQXBMJ+EXT6JLW50zf6NtrgmJg=;
        b=eIvqGTRZLbIlkukAkqIdKJmxRbu5vxDG2bvC47IQ9jtCIPIiL53mjATiq6GPXNTane
         5iITLs1Dh89cKkiY6Tlngy1pbgh28wjmzi5lsuH5BMmXhk3uBrJTvD3kWdD/4buD4nkx
         ZJqYPDkhIZkwDM89jf4F4uaN0S4I/6wHe4g87OGQT1WxmREbPe1XaJlGAN+Le2cArRXv
         tSFMMbwHbR6T097/u/WnEe9GfC7Vr9OcpFyuaujQu4+QjxFi1t/zmTEdI+69abwihrKY
         iDw6BS3cZ5+9dyplJNhuPfAJKU1zE4AAx/swcYbQOBdey/jvvLYYC1qBli3k3JJQRJ6k
         i2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736693236; x=1737298036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tE4fq4FFdl3mipmmIEQXBMJ+EXT6JLW50zf6NtrgmJg=;
        b=pgPPo45gMGcxKOfs/cD4W/gMibcPPta4dJM3esqCCKlGG1/AZcDDReT0bFThoaqF2b
         A15LN4Edy4Dq65Pm6bsnAMo9KVJg+V4tHjFgU8dTBzrrezJz9mhDERw4a+wqyIxFnzJM
         HR0UqLiGyI65Hyrjly35J2ontFwI6A/o4hxC5JKOpxzUXYnNNf4Uo8RxY0QL4AIZvmpl
         mjDG9pFg1FhM6Joe1DLXeXbdJAqSFWCBauCqpD72l2FydNpO+O1qBhmRLbv7hG/qlNE6
         phIFB1nI0qkCkD2an7UwgpY+GNA99pqoE7vj45ODgziQ/VOk6F04PdLFGW8fbJS9Awsm
         1mQg==
X-Forwarded-Encrypted: i=1; AJvYcCV0G+H8KL+ATUatqwq3oUgs4sc3BXyqCQS20WS0lvscpGVeVsuTY8Aq4azm4OFTAJpMnfYQu8wtf934KnU=@vger.kernel.org, AJvYcCWLbkfe1n6+B9oPjhiOgkjtmSMlep8xJp89mynlSw/m2UeOvc7zUcnY3SteNpHvvOL6E9huoY81@vger.kernel.org, AJvYcCWTv6YCYpBRFpkCEfuMjC+BKaZjMIrw7bb8IkeEUdn3U24La8HTBDECY9qTLQuKVYSceHLwIzpzxR9L/f3VWSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+ASAUbcHC7TztJGul3E5nphZ+VjC5zGCnTvQSBWinhmvWWiu
	hzoE3m6ho0T8HNVdn9l6cfv8zTgHpuGsQLNqzIBqc2S8gYLTcPASprai1n0dgI6dXK8R8fvjgVq
	Nv0wL5lw5Ya15tsXCkKFz6On0YjjKAIkizNc=
X-Gm-Gg: ASbGncviEhzdnszEhaqqZqGYr6jX+T+qALXUbwJCEF4ZxnQ4BVa0U4l/zVcPWZ7fKIm
	ztkT0dSw8f/AXc3oAblzBOIqXeMbSlhzcO78RhA==
X-Google-Smtp-Source: AGHT+IEuRenyy2o5QaqN4nyEdk23ezwMIoLC8nom6dD09a6ALhzLdfeY6rB4+NUxuJMQ9fOJvDAxJPuyDUEO3F9KwNE=
X-Received: by 2002:a17:902:ec90:b0:216:30f9:93db with SMTP id
 d9443c01a7336-21a83da3f36mr97531635ad.0.1736693235892; Sun, 12 Jan 2025
 06:47:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112143951.751139-1-ojeda@kernel.org>
In-Reply-To: <20250112143951.751139-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 12 Jan 2025 15:47:03 +0100
X-Gm-Features: AbW1kvbzYm7hp8g_4DWQtGhIwWcoM5284oJgC7S23IarUKB-GcORr_DyMpUCpfA
Message-ID: <CANiq72m=O6LHrj03nTLEtn6wqxe-4ra3UNxV6eUXOQOAW58Rsg@mail.gmail.com>
Subject: Re: [PATCH] objtool/rust: add one more `noreturn` Rust function
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 3:40=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
> for more details.
>
> Cc: <stable@vger.kernel.org> # Needed in 6.12.y only (Rust is pinned in o=
lder LTSs).

Greg/Sasha: I didn't add a Fixes since it is not really a "fix" for
that commit, but if you want it for automation please feel free to add
it:

    Fixes: 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")

> +              strstr(func->name, "_4core9panicking13assert_failed")     =
                               ||
>                strstr(func->name, "_4core9panicking11panic_const24panic_c=
onst_")                        ||

Nit: I should have probably put it after this one to keep it sorted.

objtool: happy to take this through the Rust tree or not, as you
prefer -- it is not urgent.

Thanks!

Cheers,
Miguel

