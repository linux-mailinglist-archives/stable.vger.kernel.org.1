Return-Path: <stable+bounces-108181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1387FA08D56
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 11:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8F2167DD3
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 10:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F6020ADC1;
	Fri, 10 Jan 2025 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="X0sLddhg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5230209F53
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736503559; cv=none; b=TlIh78/p/kFlWtIQLFA/xXiKcPtxtEJxfn2mbuYeR3Ksz6DhC3wobhWwoTaw6fUIvrgrTp1zq8yCgZYfQgiru2jVADMVHFgD4+V/UCLL+ZOa7meifIeaNWRSCqnetwuL3dTviYe+7hdidF0+/KKyFzcoy4CCESnhQmlJIFI+WPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736503559; c=relaxed/simple;
	bh=zqWR6uUUhRzE5apPpzst4i3UCWD2C2Dw81UIiybH4k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZaWmGc99T9C1nob4in9PW8zQ42gV1dlFOvgJ48/s1PlHgnvZT0n3/b1vrzeiegAa4OfZCWdOH9o6wuaxgFj6w7sgxK5Vw9GfAVFskq2RmjnQ4IOyNMLuu2CXvPq0YbK7JXyLPmwVHJbVlJHszLoYJkLiMvw6lKBPc3xMRHJDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=X0sLddhg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso2567427a91.3
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 02:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736503557; x=1737108357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6/OtJufzLaqyKcYD/pgKEeBnjxZ49eDu4/BDU+oB74=;
        b=X0sLddhg1AVOgm9U+GBMjVKr973fZWJM9J6olbUHq+fQ0F6YciOu/UCUUF9W7gkHA1
         fxQQMC/BcdFOrAZjbjxoUPvBFfGS5A4ftDihApSdORof5VtcjvFgBIsph4p6DZIyOXCc
         lE2SbJkTrEDkdfBE9Nv+i9vYf8I+lTgj1uXE3zpLkwCdm4dFeFG5bYjz1iAHAD/VNRIR
         ibdXaRAzQ2nwCbKPR4kbbuFdGFvQXHzg/UIJ5NqtVm9m0lXez6r7fCgBejpwRKqEbhmj
         LyFEqFBqu/HG+zOR9IWFTc6Sf9j1tutlPQr4nk6i8FFu1g3LDYeYbQdbdpzVjWILcpod
         NkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736503557; x=1737108357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6/OtJufzLaqyKcYD/pgKEeBnjxZ49eDu4/BDU+oB74=;
        b=GADNP7wqq4od5ikLJ9AziBJ4HKsreDNX1lXyqrETT8tktmg7GI35Tecpcwu3x94pa+
         Kp2eVD2eAcx8s81Xl64de+HmNoYOkC92GKUGPfLG9S3PboOm+18sxFOrQRceiNRw0At/
         HNlcwNnZpnMdXq9hluUXZHhtEIvti/b5VlYCL7g374WASi3YeK8dCyuRciaz7yppVDbL
         3Ul4jB1v0+LPmuMQgNUIvWao0Rd1ssngcecASgZ44I/E+QavqVESCVvimfamqgcQBCpv
         vKYAbHqsPzNjOMPsNWZ9yEzScyLhwB6HfsEUsK8f7HG6SspwmGcUP0IwsvPROnHdZ8un
         PvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiQ1p5Bgzzq1pwaYxIpNB1o/oGkB2rQJ7V29jeSGlg+iBvkhfomx7VCqXBH783QJAiryaE7DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzySRYLvLToFeayL0O7kcvuac9rNgPIs0X430k32h/+VcQOU5uE
	jUjUMz3PJzt0qcbfwIwnhtoY1tEPlNEHTzsn1vfo/SLOU9Fe3KcdPyfS0tIry+Fg3Mwcgo7/1S6
	NsZMskKHt0eeDwEd/b4bqeytsm2QRY7XurGLmSg==
X-Gm-Gg: ASbGncvkl2zTzm27lYoieCCZlxq/cADvCnmfGn7I1KApLFIAyAP/H0JslGnTY80W0D6
	6e6jud3IawXQXDQv1zYTSdk0diOynqNpJO48rUW3248ih4R/CxImyOA==
X-Google-Smtp-Source: AGHT+IE9wZ2CoJEw9/XLgi3IcaR7qp0BfvyjD0qLw7ghplmpAZyxf7VjUplqDtECXqeNM7nT7jYGlL3Orq+vuGYeXt8=
X-Received: by 2002:a17:90b:224a:b0:2ee:49c4:4a7c with SMTP id
 98e67ed59e1d1-2f548ec8a4emr15689661a91.18.1736503557095; Fri, 10 Jan 2025
 02:05:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106151150.585603565@linuxfoundation.org> <20250106151153.592449889@linuxfoundation.org>
 <3DB3A6D3-0D3A-4682-B4FA-407B2D3263B2@cloudflare.com> <2025010953-squeak-garlic-08de@gregkh>
 <CALrw=nHC27RRxG7aPzzGNaknaHiDzXKSL7o+MLCY=kjNFzWX3g@mail.gmail.com>
 <CALrw=nG+_KyvPiKBnZOVin4XL4fbwiKWj6=o2x0rMELQBpP9iQ@mail.gmail.com> <2025011043-tiny-debit-4507@gregkh>
In-Reply-To: <2025011043-tiny-debit-4507@gregkh>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Fri, 10 Jan 2025 10:05:45 +0000
X-Gm-Features: AbW1kvZ7WkVF351a-eB2b9dFvPyEnzanKaQ75tdCkxSKBn1KX90cHAQAhdWU3Kc
Message-ID: <CALrw=nERvgZSsSrex9c11k8ejbq36sYQsjw9MTA8pjC7h0hZ+Q@mail.gmail.com>
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

On Fri, Jan 10, 2025 at 9:58=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 09, 2025 at 08:44:43PM +0000, Ignat Korchagin wrote:
> > On Thu, Jan 9, 2025 at 6:08=E2=80=AFPM Ignat Korchagin <ignat@cloudflar=
e.com> wrote:
> > >
> > > On Thu, Jan 9, 2025 at 6:07=E2=80=AFPM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Jan 09, 2025 at 05:39:04PM +0000, Ignat Korchagin wrote:
> > > > > Hi,
> > > > >
> > > > > > On 6 Jan 2025, at 15:14, Greg Kroah-Hartman <gregkh@linuxfounda=
tion.org> wrote:
> > > > > >
> > > > > > 6.6-stable review patch.  If anyone has any objections, please =
let me know.
> > > > >
> > > > > I think this back port breaks 6.6 build (namely vmlinux.o link st=
age):
> > > > >   LD [M]  net/netfilter/xt_nat.ko
> > > > >   LD [M]  net/netfilter/xt_addrtype.ko
> > > > >   LD [M]  net/ipv4/netfilter/iptable_nat.ko
> > > > >   UPD     include/generated/utsversion.h
> > > > >   CC      init/version-timestamp.o
> > > > >   LD      .tmp_vmlinux.kallsyms1
> > > > > ld: vmlinux.o: in function `__crash_kexec':
> > > > > (.text+0x15a93a): undefined reference to `machine_crash_shutdown'
> > > > > ld: vmlinux.o: in function `__do_sys_kexec_file_load':
> > > > > kexec_file.c:(.text+0x15cef1): undefined reference to `arch_kexec=
_protect_crashkres'
> > > > > ld: kexec_file.c:(.text+0x15cf28): undefined reference to `arch_k=
exec_unprotect_crashkres'
> > > > > make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
> > > > > make[1]: *** [/home/ignat/git/test/mainline/linux-6.6.70/Makefile=
:1164: vmlinux] Error 2
> > > > > make: *** [Makefile:234: __sub-make] Error 2
> > > > >
> > > > > The KEXEC config setup, which triggers above:
> > > > >
> > > > > # Kexec and crash features
> > > > > #
> > > > > CONFIG_CRASH_CORE=3Dy
> > > > > CONFIG_KEXEC_CORE=3Dy
> > > > > # CONFIG_KEXEC is not set
> > > > > CONFIG_KEXEC_FILE=3Dy
> > > > > # CONFIG_KEXEC_SIG is not set
> > > > > # CONFIG_CRASH_DUMP is not set
> > > > > # end of Kexec and crash features
> > > > > # end of General setup
> > > >
> > > > Odd, why has no one see this on mainline?  Are we missing a change
> > > > somewhere or should this just be reverted for now?
> > >
> > > I actually tested the mainline with this config and it works, so I
> > > think we're missing a change
> > >
> > > Ignat
> >
> > >From the looks of it it is missing 02aff8480533 ("crash: split crash
> > dumping code out from kexec_core.c")
>
> Ok, I can duplicate this here now, but wow, backporting that commit is
> not going to work.  Let me see if I can just revert a few things
> instead...

Yeah, I tried that yesterday, but saw it is not that trivial. Thank you!

> thanks for the .config section, that helped out a lot!
>
> greg k-h

