Return-Path: <stable+bounces-108154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52518A0818A
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 21:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A13D169440
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 20:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC971AB6C8;
	Thu,  9 Jan 2025 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GsQVXt5M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15A1FAC4E
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455496; cv=none; b=YF9HKHvegnd65qtG35Km7iLTSsvmlzyXaUbdJEsyoocmvK32CgOuDGj/dmYKskvBsu/2n6D9EQaEHGcpe9LXb25g+uzWJOEPck/+mUTKxggIMgKtqcf2yI2FlOSOkKeIUjDS/dazJ2VAg9k1b6x461yLU78RUyKUXHZpWmBKBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455496; c=relaxed/simple;
	bh=AlRB6GfwaGyq6rK14nL1W5hFUWrwYyTuo8YTIqAZWhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbFzsAp6lwSxq6giJFfaQCj80THq1pXL3MSiEXH1gGMUg/gEXoxY6TW+nO5zjpVtwNuyRSWM7b4L5gzd0XLDrOTZGhajhZdo/ciJF0lLpiaM5PW6CjEDAqB1IPmb9zUa9X7whemtbqj6uTcozZKX4ZdZRArZ9axOSEdXYJ4/0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GsQVXt5M; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-219f8263ae0so22765635ad.0
        for <stable@vger.kernel.org>; Thu, 09 Jan 2025 12:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736455494; x=1737060294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahDuKardNqhYr55KFBv/RB6jvPta03a89PwG7tSKRMk=;
        b=GsQVXt5M1E9TmMMaw+65uRN+nDObO24iGy0UjAAWQ/vtUGqrOzhXKbzCS5QuMnXpRo
         i3UXkDmjROhpJPtEkHTJONXXmXw0VfVtlqhRnVS1lK8NIFOvn0O1MKbXynMpotKddSYA
         RffZ2NzfrxH+VU6rjcqBfYtLdVv7bGIAAP30r0ZZgEx2MWvWHnfLkpvcoH3AaZPs3isU
         EvNQNbd3ne6ud7JbEb9UTJi+luaORdMn5fiOkZya+pAbcnFpjFaMiq4YnhW+d+kMkTQP
         bcr4QzY6vvYp7c+dnWWdgPIse5EMe1Ih7AM5suklvBja4SgMTLTDtLFfV5Qtyxern0mr
         I3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736455494; x=1737060294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahDuKardNqhYr55KFBv/RB6jvPta03a89PwG7tSKRMk=;
        b=N7Uo+Uqi1yG8lAM84Efu90R59q/eorGGKbIz3qquC1rIsJ6HWPXUc46Rb8tfgPAB6r
         A+nGCSQ1wfOyaA9urJivFrhx6Yxe+2m3sVSAZr53Ls5ZG1a4Y1FiZyxz/Jd5f91Nz1Vl
         wJR8SSe5VqHDqCDPUMDTy4OIk6FZ9M6StdUSNUCXMmkpaRH2jTn7j9KZ2nuzJeZzo0Be
         B36p8auAi0BmoW7NdxLN95Au3KuHJd2vUU+6fmptns+Xwm7IJm/ShiUigdFMszJA888J
         4+NN4fsqxEsqH7MVCpPMY0qqaerht0oGm9f/ofUtPm+9pwRigD4m4U6xRz7+KoyWS/Vh
         rH9w==
X-Forwarded-Encrypted: i=1; AJvYcCW9DXKidslxI2/cWqnJGQy2p/4+ei6bbhSc7bpuX4zwtpzJUcXQc5f6qwsEX3ws7f4fdXSC0KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOM/TC1d9JseMUO5Q6bn4EOSobM1M93uQGorD1k0vxp1KiR1ez
	Ae+RbLXzlF2nZLbsJqUq4hK30qwLO+NwtJQhw3mm7r1ZQ2qgDxIu4oG1NH9TC6FFUF01YSPFwou
	u9vb+vv510j6v85nwlmCOvgmR/sLlD4a4mp73qQ==
X-Gm-Gg: ASbGncul73ZVba3C2wTnGMD4xn4OP+tnLBTXIPQuW0c9hjrqX6pM7yc8WkLtCt3Bny2
	R4dO6x0h5ATISRVI6B7Y20se0SH6Srk5i4EJyQIDfKG2cJoL+a2ZyQN7H
X-Google-Smtp-Source: AGHT+IHqEioSHkNL1QwCoj1k4S6AIOOZsZNefbwDOM2EBkfs99GFRbuIr6UtwlzDW8FB/CGWz0fT1OsoIsbLZUS7JlM=
X-Received: by 2002:a17:902:e843:b0:216:2e5e:971d with SMTP id
 d9443c01a7336-21a83fd9648mr118906185ad.51.1736455494138; Thu, 09 Jan 2025
 12:44:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106151150.585603565@linuxfoundation.org> <20250106151153.592449889@linuxfoundation.org>
 <3DB3A6D3-0D3A-4682-B4FA-407B2D3263B2@cloudflare.com> <2025010953-squeak-garlic-08de@gregkh>
 <CALrw=nHC27RRxG7aPzzGNaknaHiDzXKSL7o+MLCY=kjNFzWX3g@mail.gmail.com>
In-Reply-To: <CALrw=nHC27RRxG7aPzzGNaknaHiDzXKSL7o+MLCY=kjNFzWX3g@mail.gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Thu, 9 Jan 2025 20:44:43 +0000
X-Gm-Features: AbW1kvYLVO-L7A46WopjdwtP3JEd5FzxIeMx9vTMMz3FZNGugIv997wxNF9MKk8
Message-ID: <CALrw=nG+_KyvPiKBnZOVin4XL4fbwiKWj6=o2x0rMELQBpP9iQ@mail.gmail.com>
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

On Thu, Jan 9, 2025 at 6:08=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.co=
m> wrote:
>
> On Thu, Jan 9, 2025 at 6:07=E2=80=AFPM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jan 09, 2025 at 05:39:04PM +0000, Ignat Korchagin wrote:
> > > Hi,
> > >
> > > > On 6 Jan 2025, at 15:14, Greg Kroah-Hartman <gregkh@linuxfoundation=
.org> wrote:
> > > >
> > > > 6.6-stable review patch.  If anyone has any objections, please let =
me know.
> > >
> > > I think this back port breaks 6.6 build (namely vmlinux.o link stage)=
:
> > >   LD [M]  net/netfilter/xt_nat.ko
> > >   LD [M]  net/netfilter/xt_addrtype.ko
> > >   LD [M]  net/ipv4/netfilter/iptable_nat.ko
> > >   UPD     include/generated/utsversion.h
> > >   CC      init/version-timestamp.o
> > >   LD      .tmp_vmlinux.kallsyms1
> > > ld: vmlinux.o: in function `__crash_kexec':
> > > (.text+0x15a93a): undefined reference to `machine_crash_shutdown'
> > > ld: vmlinux.o: in function `__do_sys_kexec_file_load':
> > > kexec_file.c:(.text+0x15cef1): undefined reference to `arch_kexec_pro=
tect_crashkres'
> > > ld: kexec_file.c:(.text+0x15cf28): undefined reference to `arch_kexec=
_unprotect_crashkres'
> > > make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
> > > make[1]: *** [/home/ignat/git/test/mainline/linux-6.6.70/Makefile:116=
4: vmlinux] Error 2
> > > make: *** [Makefile:234: __sub-make] Error 2
> > >
> > > The KEXEC config setup, which triggers above:
> > >
> > > # Kexec and crash features
> > > #
> > > CONFIG_CRASH_CORE=3Dy
> > > CONFIG_KEXEC_CORE=3Dy
> > > # CONFIG_KEXEC is not set
> > > CONFIG_KEXEC_FILE=3Dy
> > > # CONFIG_KEXEC_SIG is not set
> > > # CONFIG_CRASH_DUMP is not set
> > > # end of Kexec and crash features
> > > # end of General setup
> >
> > Odd, why has no one see this on mainline?  Are we missing a change
> > somewhere or should this just be reverted for now?
>
> I actually tested the mainline with this config and it works, so I
> think we're missing a change
>
> Ignat

From the looks of it it is missing 02aff8480533 ("crash: split crash
dumping code out from kexec_core.c")

Ignat

> > thanks,
> >
> > greg k-h

