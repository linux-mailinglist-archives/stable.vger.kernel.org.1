Return-Path: <stable+bounces-43024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302558BB17E
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 19:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A491F21D4E
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 17:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D22157A70;
	Fri,  3 May 2024 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eu/6FVf2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B83678276;
	Fri,  3 May 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756314; cv=none; b=ty/XTN6vzbsumYDM9axPRISKhKZYUCbgEJELBSHH9Zu7tCPjN9QBk6+L/kpb1jZR4SKq/HmLVJoC1t56kPsErgUaBmgnsqxCW935Vm6gDCt0WlSvmCBLcPFSFvUaZoa2sZS0iYw8JX1eg9BZM0qPiCbzFguJqUImg5j7owd18L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756314; c=relaxed/simple;
	bh=qc0LWvz87yKr844m6J/WZNe7ZieL5RbpTrSvkIbfIho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2vB+WTBmdfMU0HsUgWFCE+kSg9h9fgR/yHMnMdHimprH1EDV6zRYqRUx8kjisCbK2YOGfBZREMXBfVqRdkuui0KNoBP2ahxCK3PB4gLami6k0/Bnba0JcJtVacrXVuGHl4CgJdxnVBzUU9HjuZpaDhksT9RALC9s5RmgDQZBF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eu/6FVf2; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce2aada130so6562744a12.1;
        Fri, 03 May 2024 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714756313; x=1715361113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFAvPxAEH3lX5q+vynueNN1MFGFzRRG2oXkgEREB2X8=;
        b=Eu/6FVf2xmJzMmrH5qoU6ZYPtbhIqSkA5/rxo1j4zaU9iKCJCNmKE83gh/jShKr8cp
         mTsnNACMHc6mlmRiGE78nZNnkGX4FvpzxF32Z0B5X0xrWa704bUlBybCesDUnwXy9SZC
         eODn9Clo4e4/hej9if/uzSJWZkUGIKdgYhX0oYcw8U/rUe/UeIwsMZGrmWiacLN5+et6
         NtsJQqJBp7MiGEPJikMdPN/xZlzxmdnRdo9WHhm52pD7VaqaOJdXoqIuaiip+DeQXh3x
         o+UZUyFK/DuREm0K1e1MAav1trtwXlMFYtNJ2u4ry/qCveqdUUsoQNjTUGDwSdWCU2Nf
         i58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714756313; x=1715361113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFAvPxAEH3lX5q+vynueNN1MFGFzRRG2oXkgEREB2X8=;
        b=mpNU+9MpKI4Kq2mBMxOEpBhGYbRl520Ksy2rOuP+54MIWJd0DHictYGSWWvwGfI3r4
         QgFv+1wghSiBrywfI6IhoN1ZmyTYd8u4bnK7ADjUU+xuLsDgsnPMhEFVJpR+APAsv1Cy
         aP3SfLICVlc2Gn3EiLdavXiu75XnYQaAFTE8BiAB1+bMMwWmqez/UM+fS3iFe7FCxOAU
         GpAu5ugnmruc8hV+44yKV5McqE8isNDf/0+/1XYKzL8Bj41DoG6qns2CSN4tElMzJLO2
         DaezBd4govBFpF/9ZJ6Ejg7wRP/LnI1FTuICKtZuzwo0j06cDp4NKjh8RdtESlP793OW
         //SQ==
X-Gm-Message-State: AOJu0Yzpl1pj2XftKDVNes548mLnCwUPtoWGjW5wkyyR7NC6cpccLiZg
	Rp1BXCAFSI6NxGoqZP+T/uQNBpSd+oDDvXbwdAu3X/gnDu3OCz27RodR9COvt296PQZTdcGGelg
	tBAGa4Z62Bn3T0d//36Z4n0YUwqecf9tL
X-Google-Smtp-Source: AGHT+IElOkiUfQx/0mlGiQ9kGncms1yhCk+1WunzFvhDuMivpoc3PQs0xX9z8Y5+gtsvGI/oqcZvQWQBw+JmJ3acaHQ=
X-Received: by 2002:a17:90a:898b:b0:2b1:74ad:e243 with SMTP id
 v11-20020a17090a898b00b002b174ade243mr2867649pjn.24.1714756312847; Fri, 03
 May 2024 10:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503164220.9073-1-sashal@kernel.org>
In-Reply-To: <20240503164220.9073-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 May 2024 19:10:35 +0200
Message-ID: <CANiq72=V1=D-X5ncqN1pyfE4L1bz5zFRdBot6HpkCYie-EQnPA@mail.gmail.com>
Subject: Re: Patch "kbuild: rust: force `alloc` extern to allow "empty" Rust
 files" has been added to the 6.1-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, ojeda@kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 6:42=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I don't think it should be added since it requires upgrading the
compiler to Rust 1.71 (from 1.62) at least, given:

>     be fairly confusing for kernel developers [1], thus use the unstable
>     `force` option of `--extern` [2] (added in Rust 1.71 [3]) to force th=
e
>     compiler to resolve `alloc`.

Now, we have upgraded the compiler in the past (in 6.6 LTS), so it
could be done, but the issue here was small enough (it should only
really affect kernel developers if they happen to create a new file or
similar) that it felt too minor to warrant it (especially since it
would a bigger compiler jump this time, with more changes required
too), so I asked for doing it only in 6.6 and 6.8 since those were
straightforward:

    https://lore.kernel.org/stable/2024042909-whimsical-drapery-40d1@gregkh=
/

If someone is actually doing development in 6.1 LTS with Rust enabled,
we may create bigger problems for them (even if it is just time used)
by upgrading the compiler than what this fix fixes here (which is an
issue they may not even care about or ever notice).

Cheers,
Miguel

