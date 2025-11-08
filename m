Return-Path: <stable+bounces-192767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0943FC42525
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 03:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EEA189345D
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 02:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4203F28643C;
	Sat,  8 Nov 2025 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAchsO6a"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6328D82A
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762570215; cv=none; b=TjOvb7YSNb0D8qJQ1qLVcP7KqJXdRioUax+JwhOLsu3h3+TKq6nEwf/Mj7XQmNcZFFqKOospT1hHpcyBV05tuLLYRtHU3Yd1xW2+E6TK6gwUnGZdpIBHk6sVuNTbKuY0oGguVeeQ7onc1xyV9xvt3cryEZZyLcavNjWzbcOLx50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762570215; c=relaxed/simple;
	bh=OAMQkM8H202HpZ9SyALa6Zflvi3TrT+59q9nVOpCnkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWx4v4SMOT/qqoebLtSQatVSFGYEF8DKEbhWo+aTWc5BsjKPuBuqZlN5bzwt+XC8jgdAHqlqgUjYWCDOpVBnbpRKpvfFISLZbbBNBa2BVH/jLIJU3AWlANOmFpS7m12wHkwTQ4mZZg+gz1omPI2cEOIMXoYlA0imb9IF4Xb09uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VAchsO6a; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-294f3105435so48375ad.1
        for <stable@vger.kernel.org>; Fri, 07 Nov 2025 18:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762570213; x=1763175013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz9KbiB3pKiQMMUPj1p32orHVehzjrikuGFe9xgdEQk=;
        b=VAchsO6alXNukU6gX/pvJYwQCDSkZMHVh4dVm5JfY1oGfbAmpLxIYCzpZtKbeACb5R
         9sFUxtSIP4BSiAq9li9cHIgUHph9mZvWSTXO/T79k3bo0MUqC18QTeEytObcv5guW7PX
         RIOMgMkQdealGumFovKyXvrSk+QXhr92rzy44TokOfWiRrjxS+x6igOdcw0y6Ax7dhRz
         QPq9dkVUXaY7tjGC4wHgccyx5nv/nHP12pzmntBfGPDPuD61cbBRUMYB19mKOFXGeMiA
         kMjEWQmn//kTGO2mW6VgLFV8byEqB4R7Mzz0ZdgGWj/1YuqOZ6BEsHcuqNhuSjHK4zsf
         j1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762570213; x=1763175013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xz9KbiB3pKiQMMUPj1p32orHVehzjrikuGFe9xgdEQk=;
        b=WT/oWPR58tqCuHWdxgj3BjGiKaLiupgvdhlk48ciZFkla8H093OXRaXkVa48X9LRhq
         Z9KY7hhWWUFCJjEIggW1Glk5CBJjOhV8dZzPRPeDATA4YTbGnD490dYVQnHsNtID+otf
         sx805LMsziIuZ8HV4MSUFOko4EFwoguReRgm7NPkac3YeilSXKWESleSkoGHPHkGaEXR
         21cJFuKPbgzyklwu5a+RQL3sK3FXZKNSFy2OBAkMXV2tAjvp+XPTTY21QDxn2MpFDWAw
         YPANLaIvm5Ti9A0La5HCRUVsqyzueRA0Q1eFV/ybMPR3dcVbWxOcMTuw0SBw2tiwwmBT
         zxHA==
X-Forwarded-Encrypted: i=1; AJvYcCVqHprdonfaVs65c5zCfBXUtsV3mOAkaUHP8sU2R4G8VhHlN6CRgueoVAgecRs6ZZezSf+dXLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+bxeCSxu97gck2pMmYTt2WjmVaG5A+A5Tcenv3J1xRB/Tl2wp
	PxKWyPEZIxXf5p55+Qwlx8lu5jYYLQ0lugtqeF50HIst+o+RX9Sswx81F8lM1pW7e+e0jP5yfoN
	yWCxvlNtuU2rswKuLyXUo4zl7zGvOm5lgXMSSE/vJ
X-Gm-Gg: ASbGnctEOSViCiIPhxnd52YTPx9eGHR0fgc+KPmMKrNZbZdyXjefmdjShmARHGEzwzC
	1++EvIoZMcbjPZS+GCm8XW9ytLj6lEcnO9Y5hcsiEBr7o4zmdxxF5dujvMSyoywWydkA4brK/G9
	icVozvRk+b3wrQBcPyYiAJAXOKZsFemDY2Er5S9q11Pcp48o/cvDvgIjXFge9sB1UD+jMDxuTDc
	qEkEZp+XnCIS2HPj4pc6ocUwRj8jzTJca0ztNSPDvSzFSzbXczCFoI8y85LDB3655RI
X-Google-Smtp-Source: AGHT+IEDYpJKL+hIOzjq2gpmJ4iFLKF/Y9OWuaaO1G7yVaYPMHtubhDweRGu3Pd8BduK0hfGnF3VI4ZMdg1XmQs5Cik=
X-Received: by 2002:a17:902:d4cd:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-297e51be5b3mr2383685ad.4.1762570212326; Fri, 07 Nov 2025
 18:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108014246.689509-1-ojeda@kernel.org> <CANiq72nKC5r24VHAp9oUPR1HVPqT+=0ab9N0w6GqTF-kJOeiSw@mail.gmail.com>
In-Reply-To: <CANiq72nKC5r24VHAp9oUPR1HVPqT+=0ab9N0w6GqTF-kJOeiSw@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Fri, 7 Nov 2025 18:49:35 -0800
X-Gm-Features: AWmQ_bn2xE_C004xbiOPfj6vuNrWvyE4Ho8Vxi_L-U3qXSI0Ruu8KQu5_TFbvtY
Message-ID: <CABCJKucCJLWfHz6o=wWWx95keLC6na+uO3a0WVLTPEz02gENPw@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: skip gendwarfksyms in `bindings.o` for Rust
 >= 1.91.0
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 6:31=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Nov 8, 2025 at 2:44=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
> >
> > note that `CLIPPY=3D1` does not reproduce it
>
> And obviously this means we have to special case this one too...
>
>     $(obj)/bindings.o: private skip_gendwarfksyms :=3D $(if $(call
> rustc-min-version,109100),$(if $(KBUILD_CLIPPY),,1))
>
> There may be other cases that disable the optimization or similar,
> plus we may have other small crates in the future that could also
> suffer from this, so it may be best to simply force to generate the
> DWARF with a dummy symbol from that crate for the time being as the
> fix:
>
>     #[expect(unused)]
>     static DUMMY_SYMBOL_FOR_DWARF_DEBUGINFO_GENERATION_FOR_GENDWARFKSYMS:
> () =3D ();

This looks reasonable to me, and indeed seems to fix the problem.

> And then later do something in the `cmd` command itself or teaching
> `genkallksyms` to auto-skip in cases like this.
>
> What do you think?

Like I mentioned in the other thread, we ideally wouldn't silently
skip symbol versioning because the exported symbols won't be usable in
this case.

Sami

