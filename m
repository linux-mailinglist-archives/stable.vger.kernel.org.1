Return-Path: <stable+bounces-205892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF444CFA0F2
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1265930809B2
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D58345CBE;
	Tue,  6 Jan 2026 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/v+mhsp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F7729D273
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722212; cv=pass; b=acFElMmngY0tQMzzJwl1GT+LmAbDozdM6zQP9P0+Sf01JpSQiPUNImrYyKtvlOKgeuVwVINcrnnCQ4VAoKQj8jyKlXXVF+FcwlsrkAn11gkDubYgkLpJCYZxDI2BxuqZjjJwFgztBk11U3qbeCElJMLQdK4IV+mL1xgVSCnPG3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722212; c=relaxed/simple;
	bh=b1EoNNjieLxcoSo0AfHltNs1toOanJO0lCrICvL08UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvgAYLJpd+zAcaIfLhzH56fc5R57WRQI1weD/nPj3bx08AkozqGV0TRwr2qsIGDx6OACZ4WPuGGdfMzTPGacQpyBodz5VR37KolqGJVbBaOMMXy9MnN/ax66Gm2PxAKmyGjUqnrE4J2EMYbHeolyV6bF7jZET/y82UvuGz+u1zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/v+mhsp; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6505d147ce4so432a12.0
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 09:56:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767722209; cv=none;
        d=google.com; s=arc-20240605;
        b=lMkajOU3Ki3LZMabjenAZsowy8PLCJvzZNlKTGP7bTmkteEkQsvOuwUOvCd7Yvy6iP
         a8HuyneQsU+XRD3urPNs0JY7s25S6Xy3HDYdKPsVrZMU6VyOrl8wQVY5drTQ4HSXtCwu
         eXLwtxAm64d+w6C5QTeWUj+pU/ry47+90TVTDKI01tKy0zROoIWRGy+Sfs9Mu+poNVFO
         jgpfnlecSac4xXEi3WbTg0XD1yEH6tciRGPrTNYFXKh56Co0Sze6/vu9SYgYxL25/QJ4
         fFY1TyLmfmmN2wOGkuoqZ8eX3IpLT9mx2LXebYuxhsu9lorhq+rI+oOk2QlkRkh+IRh0
         FR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QYxpL+XnUS5UB2Ui7qcrOxbu+fTcZjWEGOnFGGJMq0w=;
        fh=5wGKyRWEtusGpBe/f95CfpcwDByplDY5zitT5PPaKkU=;
        b=K/8nyDGC/17p/nuWjy5uZHl/xmv4tNPGoltDyhzj9ZyyraoBwScbquxLi36YHVNQjp
         r3TlNILILhov6L9sxTeBSUhs0YW88qgFboV7A1Q6EP2V4iQf2RTNTm3nXQzvuyTk14Jx
         uT2INj0B2v/eEihINLXjMLBZYibpkAm4onEq3D5ddgzVYe3WNpXiLOxcHWYZ7MB0hDYD
         hG7TYVaB3T5T1O9QCmv0WHF3mauY0XATLAijEyqkCW4M18dCFhnnX6hVXkoMLITagRjc
         5mX7mgfzk96HvxM4fzzM9MXsT7gtmElvmFjjWyTz29nFrsBWh/70IgzgytNi/8dH19rD
         T7BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767722208; x=1768327008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYxpL+XnUS5UB2Ui7qcrOxbu+fTcZjWEGOnFGGJMq0w=;
        b=i/v+mhspmYYRWZL5UHeqx7uEVuojyOIHnb1Lhm3+loxCqyD+4+AoYnJNNGu8CR9jo9
         TbTlbcfmSEpX/LebGAQWybe0laWU6RH1NeLhrJWotkfjnP31pKxUbpq4EEOT8HYiX4or
         eXqJevgssbTiOO1n5Pjq/Q7IbiRcMMdU944HG4OaIrSLsT/zZ0NfivhmE6RM3HYfsfSV
         HtDYK2HRr/CfmNT70+8KIKbaa5xWL7DiHflmvw/3opCFxtTAXzaLSJ56CIYpxNfjGzBf
         seIHyOyZxJWug6UKDHbDp+llbV6S8l8aGKpge88tkUu3ygYRiQLzv4eCEaEZzGaH4b+w
         dS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767722208; x=1768327008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QYxpL+XnUS5UB2Ui7qcrOxbu+fTcZjWEGOnFGGJMq0w=;
        b=lVFBrtU+/geHP6QGI1VLXvJmeKCxiWGHUHRjbeEMWtiBuyLQxDVb/6f/MZ9OK53U7S
         O7yvnG+eR1GAJ04BGUV8a1B7aJSxI+3ZzijjxuMVXMucEDAS5pDDKmXpAvqv8ax94vVQ
         nbcKlzsnvsuTbSqFCsZIHH0uzfiI36oivjZxLwuyY6O9Y70DDm2Xszys69Wh9ER0qRC2
         fCEMxce8UdQfdOrNboe2PyuvXD3NPE4UEHpwLhpXnGq0Px0uPhvyEMA7rdZwK42F5bdY
         jJcqpA0OGJOPWwKVcoqXcYD4av8a6z3WN37o0S8fAwNWb4sV/tIllyAoqc6Okdb+MBK4
         UcWw==
X-Forwarded-Encrypted: i=1; AJvYcCU8ahhrqzhmRMqBi2QR71ttq/hNKJZI/3rKAbLKC1NrLEv6aZ2vw7deafPPK7Rcbuy3TU7cfnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwHqBPrc1fjEe/cGxJmppq+kqd54U0GZbB/YJefF2StGz3sqFW
	kMBF7Y8MbT1O/PJbcpi68OnHt0YPdthAwvX3X104FwVNF0GJKQQ5vpj/e/zJVZ3rSSutvyoTPFc
	1xtrKtF2A5X7NzEvrER3TPNjVTjS6tz05KzB9I3/2
X-Gm-Gg: AY/fxX55kN+fVG3xeO+WJlCQLLWAxZoz8oliStkOzv5334Jl5/5BeiWYE6CWCzOkObV
	HlfBCq4IkggUYuUYUlAeqxbdpltXZCUD0D62aAXZWYmK3ltLDGLNtBZpc2Mdjjb3wy1o5mhgykp
	7hOybB7GmOCqhPve9uk/47iQx3CSLkiIH9j1LLyOgLi4SH4dGLCjW3js7CR5HETtm40Ciyj9l5L
	mEZgxQoUkHArrojgvCLKaQSGxq12530c66g+kTbVHKRHssNo+U9b9QFRjKm/vn/TCRJXPo=
X-Google-Smtp-Source: AGHT+IHKi5u0ZUoIiLDKZvTW1fieJbK4f2Ck1yEd4b1rskSfipnf8lmsJb/sxIxC/QxMT48vm6QhJurThfZqBdXk6DI=
X-Received: by 2002:a05:6402:1811:b0:643:6975:537f with SMTP id
 4fb4d7f45d1cf-65080907a25mr39042a12.13.1767722208281; Tue, 06 Jan 2026
 09:56:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101090516.316883-1-pbonzini@redhat.com> <20260101090516.316883-2-pbonzini@redhat.com>
 <CALMp9eSWwjZ83VQXRSD3ciwHmtaK5_i-941KdiAv9V9eU20B8g@mail.gmail.com> <aVxiowGbWNgY2cWD@google.com>
In-Reply-To: <aVxiowGbWNgY2cWD@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 6 Jan 2026 09:56:35 -0800
X-Gm-Features: AQt7F2ri3iKInZYTA5GeVwZP_koMuCHpRuMrgpaA7xmYZy37HUARMY0JidPig6w
Message-ID: <CALMp9eToT-af8kntKK2TiFHHUcUQgU25GaaNqq49RZZt2Buffg@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/fpu: Clear XSTATE_BV[i] in save state whenever XFD[i]=1
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 5:17=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Mon, Jan 05, 2026, Jim Mattson wrote:
> > On Thu, Jan 1, 2026 at 1:13=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> > >
> > > From: Sean Christopherson <seanjc@google.com>
> > > ...
> > > +       /*
> > > +        * KVM's guest ABI is that setting XFD[i]=3D1 *can* immediate=
ly revert
> > > +        * the save state to initialized.
> >
> > This comment suggests that an entry should be added to
> > Documentation/virt/kvm/x86/errata.rst.
>
> Hmm, I don't think it's necessary, the SDM (in a style more suited for th=
e APM,
> *sigh*), "recommends" that software not rely on state being maintained wh=
en disabled
> via XFD.
>
>   Before doing so, system software should first initialize AMX state (e.g=
., by
>   executing TILERELEASE); maintaining AMX state in a non-initialized stat=
e may
>   have negative power and performance implications and will prevent the e=
xecution
>   of In-Field Scan tests. In addition, software should not rely on the st=
ate of
>   the tile data after setting IA32_XFD[17] or IA32_XFD[18]; software shou=
ld always
>   reload or reinitialize the tile data after clearing IA32_XFD[17] and IA=
32_XFD[18].
>
>   System software should not use XFD to implement a =E2=80=9Clazy restore=
=E2=80=9D approach to
>   management of the TILEDATA state component. This approach will not oper=
ate correctly
>   for a variety of reasons. One is that the LDTILECFG and TILERELEASE ins=
tructions
>   initialize TILEDATA and do not cause an #NM exception. Another is that =
an execution
>   of XSAVE, XSAVEC, XSAVEOPT, or XSAVES by a user thread will save TILEDA=
TA as
>   initialized instead of the data expected by the user thread.
>
> I suppose that doesn't _quite_ say that the CPU is allowed to clobber sta=
te, but
> it's darn close.
>
> I'm definitely not opposed to officially documenting KVM's virtual CPU im=
plementation,
> but IMO calling it an erratum is a bit unfair.

Apologies. You're right. Though Intel is a bit coy, the only way to
interpret that section of the SDM is to conclude that the AMX state in
the CPU becomes undefined when XFD[18] is set.

