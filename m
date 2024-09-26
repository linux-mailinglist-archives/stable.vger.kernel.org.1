Return-Path: <stable+bounces-77799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34119876A8
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451951F26D34
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 15:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA521514DC;
	Thu, 26 Sep 2024 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPJ0Ggc7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10765145B2E;
	Thu, 26 Sep 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365234; cv=none; b=dagFvGqrFOHc0HO7QLHZb9wKjVAopy6L/mcZJXVFVj2ta9nETx6d/2zcHlR7lg4FF4lVckPOX+DbpZIBJ/PbxmjSscpcuc+7Trg8uIET/QkQucknkGSH6ZUcxBlqmECp14/kQugJyHA+IOJfcGOObPb72cnAalyFAnoLevG7QkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365234; c=relaxed/simple;
	bh=eBWvVfsKE4lYCkR9jWhTHTt0x1qkASzl46mhvR//R7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLmEMsnfp+8y8YpS6DJwSyAunoylZtqtVpyDLsiA/93g87B61uKG+gs3kl6qb3tQgz/fksk95kjHrMTL7utE1wPzs3W0DRwhhIwuOLUkaBNKzuM2b55Kx4ZRX7p5UCTW/O/iaYbvc10BfJaaOV3ICP23nDmZ2SfuHkh42jkw6zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPJ0Ggc7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c3d415f85eso79958a12.0;
        Thu, 26 Sep 2024 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727365232; x=1727970032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBWvVfsKE4lYCkR9jWhTHTt0x1qkASzl46mhvR//R7U=;
        b=VPJ0Ggc7+EjzItIjoFx9C0Am305nY8vagkZYwGfXZwTMIvTX/eGHwyONAf6KSbd4+T
         yrqOXLPlm1rURrO27B5tIOjAw9wX+Jup1zs7tXYFFqcsTPmujUg4M18AtwAgrKRzMHR+
         806hQtPjJWL3DGwrPdRzPaFCOeF0tE9eLT8owRa5xPkrpq0HBc6RxKFkxOWbm9+yWBOK
         NfiJFfpCfZurlQLKnsUPSGhaUFFK+9tv2l+Wek2l3gGNxGebKuqwD1397IMqt8iWxjWv
         TXImJCgfPfCRHaom12GD2SGayHfcmLh7W9+iaJSa2RDBmvHxQEySk8hiFmipd5PHvBmJ
         AMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365232; x=1727970032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBWvVfsKE4lYCkR9jWhTHTt0x1qkASzl46mhvR//R7U=;
        b=U9wWkObAlfqGHN01oiuVBZlrBx7y9cJjknNV9hx9nKItCLo8GmIFcOPT8264RoBSLS
         6vVRuTRT/sWQjPsJDzU8W+7+NgLKAZXo3L08aj8pPrDkMMXTF1Qfc53ROYE68JzXzHQB
         iAY9AoXfM9XOJey7c5CWQvK2Uxk5linESSkN/DwCYwUAlsvqzBo8UueS9otH7CTEcvkb
         3NdfF/+2RWz3vX/B07T9KT+VJG/8HbkH1syUpwSMccMOrb8XJLz3oi7zvugUAx1qYDxd
         IVCk7/uBGhk7dDknqR8YoELRB/Qtyk0+LFxetIWHkRDYWAB1GHsNBBaJOlhoZk/Itcsu
         OcEg==
X-Forwarded-Encrypted: i=1; AJvYcCVDmxjUVGxUJJbhYq+YRPIKNOiu1zTYAKVs9T+3EkkJp/Rq3/Q0gsbR7cRssA2vJCjHk4eR1GRqUexbsUU=@vger.kernel.org, AJvYcCWnv/Qitb1J9CQXh1Kz4594Qu5jqifRhHR9oQvyS/8PZedMsSMANqPgpqIkLwVXHhitWgBEe0VBRKu8L+2z4ao=@vger.kernel.org, AJvYcCXZb8qmFRhKHie2IIibg9zrgmYiot/E3FK1fqvFkIx+hrHhVaHdG+BCjTo+Bs2Qd5I5Brjea2vj@vger.kernel.org
X-Gm-Message-State: AOJu0YzsclbfKVA8demyp/sy+3L11LILBRjjq3E/H/Ool7A0aFrWWK2z
	RT8AgZfDdiYGNb+SSfQ96sjoixUcYen4MM1HnBybW0GaMx6Vum9t/semENe2Tx5la5vYT95XE28
	uHYy1V9f255TNwwPy6VxAmPGkQt4T7ft33BQINA==
X-Google-Smtp-Source: AGHT+IG0/1g5eMwIe2YWirZf4Ac8fdSnvrNHQArrRR/tnb9tehSWeiCfeqtWgbf9mBS9CWxs1mPUyKjyQDvqh0yUQKk=
X-Received: by 2002:a05:6a00:891:b0:70b:705f:dda7 with SMTP id
 d2e1a72fcca58-71b26059671mr157176b3a.4.1727365232203; Thu, 26 Sep 2024
 08:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917000848.720765-1-jmontleo@redhat.com> <20240917000848.720765-2-jmontleo@redhat.com>
 <334EBB3A-6ABF-4FBF-89D2-DF3A6DCCCEA2@kernel.org> <20240917142950.48d800ac@eugeo>
 <31885EDD-EF6D-4EF1-94CA-276BA7A340B7@kernel.org>
In-Reply-To: <31885EDD-EF6D-4EF1-94CA-276BA7A340B7@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Sep 2024 17:40:19 +0200
Message-ID: <CANiq72=KdF2zrcHJEH+YGv9Mn6szsHrZpEWb_y2QkFzButm3Ag@mail.gmail.com>
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

On Tue, Sep 17, 2024 at 5:26=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Yes, but unfortunately I already knew how it worked. It's not flags I am =
worried about, it is extensions.
> Even using a libclang that doesn't match clang could be a problem, but we=
 can at least declare that unsupported.
> Not digging it out on an airport bus, but we discussed the lack of GCC su=
pport on the original patch adding riscv, and decided against it.

Do you mean you would prefer to avoid supporting the mixed GCC-Clang
builds? If so, do you mean you would prefer to not pick the patch,
i.e. avoid supporting this at all? (If so, then perhaps it would be a
good idea to add a comment there and perhaps a note to
https://docs.kernel.org/rust/arch-support.html).

Otherwise, please let me know if I am misunderstanding -- thanks!

Cheers,
Miguel

