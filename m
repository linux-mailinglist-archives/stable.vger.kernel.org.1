Return-Path: <stable+bounces-52173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2859087A2
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7101C21251
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0F18757D;
	Fri, 14 Jun 2024 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnrIBH4Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D356A186282;
	Fri, 14 Jun 2024 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357816; cv=none; b=tsx6lzdR6yw+lw+jtdAVSVsTjB7XMVYEUIppuqrWuDEm4xJojHGFdBqdsLApAWgczjxYpGFSy4jtJ8o7ukuuQeQMJorSmoSe+wDo8kJD2BcJe5Yc1dcv9TL7FOR8/zsEyybn0y+KLW+GXM7oilTlCWOE3tNykv9zld5X9z5TdwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357816; c=relaxed/simple;
	bh=rm5AVC8tE0clXXvcUm+tJMPWlqDx/DlRU0dqbjejEBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9qMX/fgpeD5NPalipLGmMXUTyt5BXFB9ufU4CpZeOOW716Ez2UMtz6+BQs6+X9OM2BACvQaUvxCeOnJlrFxeEcA5Dk2rZs+SnEkL+4OeNe2Viw7q2AGztSKUe48y0X406gsVCmwo3FyCDiyEMA2lSZyxJr6XHAAgMStM8I6Oys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnrIBH4Y; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so20966581fa.2;
        Fri, 14 Jun 2024 02:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718357813; x=1718962613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUsTXLHqULhXlNokLnYidcv/h/2pMwfX66ciJcJII+k=;
        b=hnrIBH4YXmyJWXEqSjNezyhired5R7OjzvDYuN1g4IX2U6WqXOIxkRKEYhx3DmGxno
         XzU5xDxt+sYWrA5/mY2/zc7tPSi3wGq9SGSXq6Rk/dYAAJoaTgsLmrlEjzW7LSy9S8fn
         ifuS49GSCPwvQb475dGsASHYDOCdKQzv1Ss70LVgKvCqnrcq+mIZshep2T+ARtZuxdqd
         5oD4CCy5Uf1lbjK3XXhrzpqBVue/0r3+TGBr8BWzI18L14ZtvQEF9pPl6/Gd77E8PFtV
         q15IWHEDv5TY5k1Q1tJspjlbum1R9Q3BZ7tu7HV55McxmZsm/5vrKvYCa8Y8fFm8CdHr
         rkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718357813; x=1718962613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUsTXLHqULhXlNokLnYidcv/h/2pMwfX66ciJcJII+k=;
        b=g3VBoKktSi92jbjt40NpyhlWvqn6dbE20QYD5IYy/rBSp0qgagnrsqK7b0a1f2gbQv
         bl0m1mB5ivj6gIlgHCYNk6rjR7hvStPKiY9VdPSZYvIweucRUGOuIfGZmMv/gSBeNpB4
         K7iRB8YK9pYAcmN4dwCPORTbwYglrsTQ4LnJy6CgnrHYdW/pRqHHpq30/MJzEFVba5p5
         Ffc4TQT/V1hRIipxGhpuUGOsqK66ONX/8D+/5ksxQ4p4V/0mzTfr2OO+zTPGUQ8bZoAe
         9+2kuOGwqEMOjVgGMA1A8jhtRiF76S/OfZ4jEGhaGMgx54ugIOw/49wvQb5p6+fueGdY
         /DuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0tMvTsfDTL8NVQ5Bcm4EJRu5RKV2Z/iV6x+p5otPoCMcEETRzHQd82y47zMFOqI5HgVscQVnr7QoS+PxSeRfpYowT9J69HCAi902k9y0P28kNCob5TtG7mG6ww4DLs6zx7ma
X-Gm-Message-State: AOJu0YzkwMj+RDb27N/Pj+4XyjgNdeCUE8YvWGGtqD3TLaxEo9mNQgBI
	QnqgZkvnZZLRVwZI8dauVfMHJqiigS7E14OZVKkTBmtHjMr4yljVZLZhH1ZvBltrdTZ4qAwTwTm
	SGhrjy8LV3j/aSFyb2zvb6Au2LEE=
X-Google-Smtp-Source: AGHT+IFNei/zgel8iT950goVTjeeVbkj4EnwLZtUp721PDa6gefpcWXhXrHiY4nCk34QMhYUWMyD6wNsTci/1G3vVf8=
X-Received: by 2002:ac2:58c8:0:b0:52c:8b1a:5513 with SMTP id
 2adb3069b0e04-52ca6e90857mr1358869e87.47.1718357812749; Fri, 14 Jun 2024
 02:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113223.281378087@linuxfoundation.org> <CA+G9fYtEkcPasc62FH170nPyJTS83jfdAtHUfgwG+QDuQP060g@mail.gmail.com>
 <CA+G9fYvwJxJdsSeTGsKjKonkiJnDC13t1+mpjHhyCvc_2r3=-w@mail.gmail.com>
In-Reply-To: <CA+G9fYvwJxJdsSeTGsKjKonkiJnDC13t1+mpjHhyCvc_2r3=-w@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 14 Jun 2024 11:36:41 +0200
Message-ID: <CANk7y0i5919ih8UML+YtTr6MomemiJVu+4rpsU95TPBWv7bmeA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/137] 6.6.34-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, 
	Puranjay Mohan <puranjay@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg and Naresh,

On Fri, Jun 14, 2024 at 11:15=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Thu, 13 Jun 2024 at 20:15, Naresh Kamboju <naresh.kamboju@linaro.org> =
wrote:
> >
> > On Thu, 13 Jun 2024 at 17:35, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.6.34 release.
> > > There are 137 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/pa=
tch-6.6.34-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-6.6.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > The powerpc defconfig builds failed on stable-rc 6.6 branch due to belo=
w
> > build errors with gcc-13, gcc-8 and clang.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Build log:
> > ----
> > arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_build_body':
> > arch/powerpc/net/bpf_jit_comp64.c:1010:73: error: 'fimage' undeclared
> > (first use in this function); did you mean 'image'?
> >  1010 |                                 ret =3D
> > bpf_jit_emit_func_call_hlp(image, fimage, ctx, func_addr);
> >       |
> >          ^~~~~~
> >       |
> >          image
> > arch/powerpc/net/bpf_jit_comp64.c:1010:73: note: each undeclared
> > identifier is reported only once for each function it appears in
>
> Anders bisected this and found following patch,
>  first bad commit:
>  [2298022fd5c6c428872f5741592526b8f4aadcf8]
>   powerpc/64/bpf: fix tail calls for PCREL addressing

^ this patch can't be backported directly as it is using 'fimage' that
was introduced by:
90d862f370b6 ("powerpc/bpf: use bpf_jit_binary_pack_[alloc|finalize|free]")

We need to manually rework this patch for the backport.

Thanks,
Puranjay

