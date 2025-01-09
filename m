Return-Path: <stable+bounces-108146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A2A07F91
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 19:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15943A19C7
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 18:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD36194A6C;
	Thu,  9 Jan 2025 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WmzYEeHz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E40192D8E
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736446143; cv=none; b=TFycoIWbGxtKWpUED/u+MKG6kw/1Wgzj1ho3syqyc8MTUUQpsDbAESKhAKwqlRuJMlrQ7Ep3ihxbCd6V3tCImu0SjmStFJVTvNsxlPrVfb7C+zrkUBXHa3B82i1ZaxGY/F1zxjxwKBmkt5YD2PZk8Uc7IUJQYENlT1OT17g6k4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736446143; c=relaxed/simple;
	bh=LOWvfSAeFJX0TkK1ditU3Y3kWM44ZqKnQUa5HEDo+FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOER3/JY7xFAJYiLiBRf177UGy/5J0I5e3TYjKt68W3McSePSUvvm04TsDC8EltVrLQbrKCgTGjAw6XwPTgG7SEB4YUzh3J/7NlwYQzvVatS9ugEuWZPsW1GhDPDBP5OjuSmxk9TW8iORH6UfTBWnJgKhpJ5NxDwhnih0ly+NnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WmzYEeHz; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso1803873a91.1
        for <stable@vger.kernel.org>; Thu, 09 Jan 2025 10:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736446141; x=1737050941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIBaW7JwdgjUdrWSxiA2g79nkPYvUF3i5zeAkytJz5k=;
        b=WmzYEeHzfmWdC48LLKpYCqQLBkREtVCCB0HVbBMupeH9rJrIhhEFmhZ3Oqb6BIIuOE
         +ROzR73ZcR/DYLjn/ohouT8U9Kk8b47m/511kEx+jNcN/LUu1d6rC0hzhS5zM4u8lTjB
         oD0i7OfPkRn8EiYvprqIjxJn/5ZxeUTKHfklikE7rjkrTCfa/BwsDk+GouLUp1e+M8BB
         OlHa1iea4kY7UGoavOViPvxJGjQ7uLZThw+XR3vJEpR6aZLCMKAI5XCWPBQwtsw6tkWQ
         TYvBMw+46rBZnNU/hUs0DU95craJlvpk2Lp6YqhC/J1KOUJxhjVy7gQVJIubwV58kPmU
         XHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736446141; x=1737050941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIBaW7JwdgjUdrWSxiA2g79nkPYvUF3i5zeAkytJz5k=;
        b=fKyFH44qSDQh9z1cakp5y5FNXNpo6Gqi9IYt2rPNAReQf6ebsX7lKxtTn891OZYzWX
         +USeqqnovXcwUAlavhrGNVU+nAmwUs63fPf0/h2isf8Ri/Imex7ufGjPnJ1vUI6vAWRo
         WkI8CVXSCBb+g4S+3p/MLEtgp8vKUIkmybdKkPqQ0GfUzG0FuyeMMOCYOpXXsTbWkaZa
         siuLJ5cSiQPhAeK79ourTXjTd5wpTWFYbXABsQwrBSpM5KYw5Q+VJ56Mjdfmt2shGcE0
         EMFZXSZAC1OoLH2owC+cKfQVJNwVxa1Tx6qPi3ElA16irnfehWeCbKg7jkPZjsoyCs9g
         9SNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZPsxkFE4HOcsYa2Z4PDaAdF8SdiWHbZ+VMn/sjMmMmZUIBn4yr5CV7exrD9wKeVzJhEKYjg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJSO2+wn2PiOKjvfS2SW4b5TcxGqqOt/56MgiH0U/aAGR3xHuZ
	cC7rAU/HkaK4uG/5Agb3r2bqysAkmJZkTr+LpYQUBqwa5zfwvO2sgVckjJBDVfonSMjQAHS5BtQ
	46ERjrCwln/HXP55TkcpUKJANoNGO3zy6WX8oow==
X-Gm-Gg: ASbGncuL7+HG08OvA1S1KBhlCuEpiyRfNiu+VvXFEKKT5pav4GqsCbr29wgreizXqIG
	tNhpeoPD9j+VIDkyaoQhpdlHxB8W8/pXsS8CU4EA=
X-Google-Smtp-Source: AGHT+IHGpZR26QegtJklr6eG/rvlcOSo3+gLEc+Ikyd9eF8cCninJpw3xD8uUVa4OVXN8ZVb/HbA5cEZc6Zxr8rGAm4=
X-Received: by 2002:a17:90b:4d05:b0:2ee:f80c:6884 with SMTP id
 98e67ed59e1d1-2f548f426ccmr11426719a91.33.1736446140970; Thu, 09 Jan 2025
 10:09:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106151150.585603565@linuxfoundation.org> <20250106151153.592449889@linuxfoundation.org>
 <3DB3A6D3-0D3A-4682-B4FA-407B2D3263B2@cloudflare.com> <2025010953-squeak-garlic-08de@gregkh>
In-Reply-To: <2025010953-squeak-garlic-08de@gregkh>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Thu, 9 Jan 2025 18:08:49 +0000
X-Gm-Features: AbW1kvYGPiZrbCwxQJQjhFIE2fo2ZXjftiSnUMFMG14at11sQreZWwrN_NTG8sc
Message-ID: <CALrw=nHC27RRxG7aPzzGNaknaHiDzXKSL7o+MLCY=kjNFzWX3g@mail.gmail.com>
Subject: Re: [PATCH 6.6 079/222] x86, crash: wrap crash dumping code into
 crash related ifdefs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Baoquan He <bhe@redhat.com>, stable@vger.kernel.org, patches@lists.linux.dev, 
	Al Viro <viro@zeniv.linux.org.uk>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, Pingfan Liu <piliu@redhat.com>, 
	Klara Modin <klarasmodin@gmail.com>, Michael Kelley <mhklinux@outlook.com>, 
	Nathan Chancellor <nathan@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Yang Li <yang.lee@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sasha Levin <sashal@kernel.org>, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 6:07=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 09, 2025 at 05:39:04PM +0000, Ignat Korchagin wrote:
> > Hi,
> >
> > > On 6 Jan 2025, at 15:14, Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg> wrote:
> > >
> > > 6.6-stable review patch.  If anyone has any objections, please let me=
 know.
> >
> > I think this back port breaks 6.6 build (namely vmlinux.o link stage):
> >   LD [M]  net/netfilter/xt_nat.ko
> >   LD [M]  net/netfilter/xt_addrtype.ko
> >   LD [M]  net/ipv4/netfilter/iptable_nat.ko
> >   UPD     include/generated/utsversion.h
> >   CC      init/version-timestamp.o
> >   LD      .tmp_vmlinux.kallsyms1
> > ld: vmlinux.o: in function `__crash_kexec':
> > (.text+0x15a93a): undefined reference to `machine_crash_shutdown'
> > ld: vmlinux.o: in function `__do_sys_kexec_file_load':
> > kexec_file.c:(.text+0x15cef1): undefined reference to `arch_kexec_prote=
ct_crashkres'
> > ld: kexec_file.c:(.text+0x15cf28): undefined reference to `arch_kexec_u=
nprotect_crashkres'
> > make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
> > make[1]: *** [/home/ignat/git/test/mainline/linux-6.6.70/Makefile:1164:=
 vmlinux] Error 2
> > make: *** [Makefile:234: __sub-make] Error 2
> >
> > The KEXEC config setup, which triggers above:
> >
> > # Kexec and crash features
> > #
> > CONFIG_CRASH_CORE=3Dy
> > CONFIG_KEXEC_CORE=3Dy
> > # CONFIG_KEXEC is not set
> > CONFIG_KEXEC_FILE=3Dy
> > # CONFIG_KEXEC_SIG is not set
> > # CONFIG_CRASH_DUMP is not set
> > # end of Kexec and crash features
> > # end of General setup
>
> Odd, why has no one see this on mainline?  Are we missing a change
> somewhere or should this just be reverted for now?

I actually tested the mainline with this config and it works, so I
think we're missing a change

Ignat

> thanks,
>
> greg k-h

