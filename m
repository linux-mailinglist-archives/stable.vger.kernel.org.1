Return-Path: <stable+bounces-77809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1B098778D
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 18:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821D328619F
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 16:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C454158DC3;
	Thu, 26 Sep 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP2LS+zS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2D15820C;
	Thu, 26 Sep 2024 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368184; cv=none; b=X8jC0zWsuo8b/hYXZFeJjHEP7N04osI7GzWP+0YIdlWgy1M7PxHiSW2uMFdrjxOTo/YoBS512rlPppBYUoc7OP9AtiDNOmwpEeOFqyXJT4Cq2o+tNyUpXuMz6BKqal+Z2ZLBknE+9eelsxLAo8f+3Z0HLKRsvbqtfTsauG3iAKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368184; c=relaxed/simple;
	bh=enYKeiYzEZuiXlgCfHWUHkKt206E3RtoQkmTSzufcAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfg+gobqWIf+bkQYR5GjRyxsWaidg8WL68r9Kb24ki+h+EDtHclazH+EJN0heiElU9PlUZ2pHOIAQM8j2JkfXrue6K2K7PYEHzVpxTPso4zbkvexlaWIohTF+wPpJuV5ezRBF7RWgP/WTj6bGdCMmHJC/FtYW6mBOdue/3imNX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dP2LS+zS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-206b9ab5717so914625ad.2;
        Thu, 26 Sep 2024 09:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727368182; x=1727972982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enYKeiYzEZuiXlgCfHWUHkKt206E3RtoQkmTSzufcAk=;
        b=dP2LS+zS0aj/rkQdn3btRS998U6BQv9jYK5xqCOmscU0zwMqJtrXTnLVnt2SKPZ/zF
         rGXPIw+e7iy+R7mIiZ/AkkVMSTMXEgQw1l9Kcc04XV8sZlOXCLLWBiM8AcCyDyOoRntr
         H2vO7uCvSeBjVh0bDwbrPAxl/zs91u2keIWxw6noLJZ3p4A2QrfCFDqA6wFP4F1eAie7
         Sog7IGjdrDOu1d3+IUUCqgsTqHL9LR20/88tsRJ+r6SkGDXVgaKAsdsVaBF6bBFi83HC
         mlhYpfyKoiDb9RIgVSAKm66IMwE3duN4Vf0u24BQ2V+RB+r2hS9RnRDt7eNBCC7lvpVS
         Mwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727368182; x=1727972982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enYKeiYzEZuiXlgCfHWUHkKt206E3RtoQkmTSzufcAk=;
        b=s75ladhbpyx3XFSIXokxG2HSGSdDe3zFiH2RYtrHRFsFx/FXDmmElf850Oh1wvoIeS
         5kfMXgI94DHft3PMZwM+xt+sSoIjMpwO23+i6k4Wrs9RExH+glPSarTLwcWsCJUPlzX7
         DtRp9CpRE6x7WZFuIPhbeZE6s8Ephd1LJS8/LIHYYiMMSa1OzdEE2pBMd5o8c0Qzh9Lc
         jH2MPcl+H99vUYmk7GQtYdgVwIGtliMVmwYjTzms1Qnu4SsP6Crc3iPPyj4WRsqdOOAf
         xZyF2gzS8yKMhFOJyV24SDfDncIxZlZUMET88gUa4w1S0l+mZHprVVmYXk+vaM8Erp/g
         jDcw==
X-Forwarded-Encrypted: i=1; AJvYcCV1l7U6c2Exi+mzXuQ0x4FGml+dsRgk5gxL9u91Eq5vspY5SsisF3ZYgMVeIFauuvEutRHkCdTNOYdoDhQ0q2E=@vger.kernel.org, AJvYcCWFMWLiEtc0I34ScLkaY6yia40yh1S/q1FvdPKCHTR9KJoB2b+50xm9ba9hwLzcIahMfVTiVzJ1BwEO4Uk=@vger.kernel.org, AJvYcCXqz6BGdR11Y8YZOunydyQPPhy0iIP33F8jjpeZjmoF3R2q8xP3BwVYTt6PX50Uv2O+AQU+O5Qd@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdK0EiKNZ28r1FsurqJxgP9pnoP50JIf2IqqE4QYyNz4PpQY7
	tL2VULf9YW3VrBBixWSv0cvJ1iyhF4F2kKTgIVT3e+Ykex0golDE4iWKer9FC6o5yTw3YOtlrxz
	Ehp8cNHddWbj3Az1YYeyEJB3uf98=
X-Google-Smtp-Source: AGHT+IFWnPCIvNcird/b9jtNo2ic1qoJxCG4l3sNzelSgtW5Pt3GkMD1EioV4GRyG3deDzQmsovWpn69wT7w++8wlz0=
X-Received: by 2002:a17:903:191:b0:20b:9aa:efca with SMTP id
 d9443c01a7336-20b36adbadamr1866825ad.9.1727368181789; Thu, 26 Sep 2024
 09:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917000848.720765-1-jmontleo@redhat.com> <20240917000848.720765-2-jmontleo@redhat.com>
 <334EBB3A-6ABF-4FBF-89D2-DF3A6DCCCEA2@kernel.org> <20240917142950.48d800ac@eugeo>
 <31885EDD-EF6D-4EF1-94CA-276BA7A340B7@kernel.org> <CANiq72=KdF2zrcHJEH+YGv9Mn6szsHrZpEWb_y2QkFzButm3Ag@mail.gmail.com>
 <20240926-plated-guts-e84b822c40cc@spud> <CANiq72=ShT8O0GcN8G-YRE1CB8Z9Ztr-ZNcQ6cphHYvDGanTKg@mail.gmail.com>
 <20240926-battering-revolt-6c6a7827413e@spud>
In-Reply-To: <20240926-battering-revolt-6c6a7827413e@spud>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Sep 2024 18:29:28 +0200
Message-ID: <CANiq72=JNS8eaQXJYCTNw8vNymD-0A-g4FmagyLkaH7L1DqhwA@mail.gmail.com>
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

On Thu, Sep 26, 2024 at 6:21=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> No. Things like clang + ld & gas.
> I don't care about out of tree modules ;)

Ah, other tools, not just the C compiler, I see -- that is why I
mentioned out-of-tree modules, because otherwise I was not sure how
you would get mix the C compiler itself, i.e. GCC and Clang.

> Yes, just for riscv. The logic in our Kconfig menu is currently something
> like
> select HAVE_RUST if RUSTC_SUPPORTS_RISCV
> so that would just become
> select HAVE_RUST if RUSTC_SUPPORTS_RISCV && CC_IS_CLANG

If that is what you think it is best for RISC-V, then sure, up to you -- th=
anks!

Cheers,
Miguel

