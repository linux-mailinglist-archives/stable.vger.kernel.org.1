Return-Path: <stable+bounces-9679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6328241F2
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 13:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C083A1C21853
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 12:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65355200A4;
	Thu,  4 Jan 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z03cvwJf"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D640219FC
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-466eb8576e0so111696137.2
        for <stable@vger.kernel.org>; Thu, 04 Jan 2024 04:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704372005; x=1704976805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJVxiZQHIN91U6hoH3sFs+qS8wBRAeVdMoW+bqKjLsI=;
        b=z03cvwJfmlDcq/XlxlyG1xGfmKfXcF61ztOCzckc9cwlvsbPABIMwZ3G6q2+PUMDHr
         pSGdKHjOx/PYdPsTFBTMXtak5GUlUTLFfbOW+vNWVfC3RudwIpDJMXEFYH8OPuJgCa5C
         zAaIgxWmHqwnzPk66MNzvHyjbohq5eD6p7u8Zp1rTcZgu54BCSxq4ORrcVZVu6WJRXyH
         OfwUOWckJ1wUbI9GlXxmmgLZvWbAS9dm0uiu50nl441qMpzwu4I5VyVBfPURNO7OKn6G
         1AlOb4zaocRuZnBzsZui1p/9aCaEkQSWJ5SJbgvsmPuBbpnfuat6ZmWWabu020GeZ8FO
         jMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704372005; x=1704976805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJVxiZQHIN91U6hoH3sFs+qS8wBRAeVdMoW+bqKjLsI=;
        b=h2ikajCkJad3EZCLP67UtogkJMHrJxUOA3Mue/VFhnthoB3X08HMwvosNPCo3JIw3P
         YwzhXJpm95QvXTFR18u+xKyBY0s1mBNHI9OfML98gvnFD1E+jnsPWXRAimRUrMsLTrDP
         XMmOU3UaJabcFq6WYLvVQbvR3OFhFTlBrcBiSnM19PXRpRvYBPCZhD7O5lCW/Th/TJcf
         3Rn2/uPXcbPNOSP3tqLr+rf5L/UJPDDZYIpeHN5Nq0TcJYKw4m5DgaNZqJH6kL0yuf4o
         wRo62fiazjwQWaqeSL3FRRZwKdCH/JS6SW0+6HGeyWwCs3Y5/ipPMGi/h8EE3SHE5nlS
         5YQQ==
X-Gm-Message-State: AOJu0Yy143vhcVZzsVBDg3XXn71IT0emEVBDOP87Ces90Zm+s4/eLiqJ
	NdLJ/jRw3GQOZ322atJfnXuKlscmS27GvJla3pcQyU+CX28VhA==
X-Google-Smtp-Source: AGHT+IFXZQnw4BjI/Ojqt4U9SS96DChsIyTcnDo26dSAdPNqc2H5P2Rn4C5dOz+iO2Tpq0LVLHcbkoI/wbivsFDI6HM=
X-Received: by 2002:a05:6102:358c:b0:467:ae65:b4e with SMTP id
 h12-20020a056102358c00b00467ae650b4emr73008vsu.4.1704372005415; Thu, 04 Jan
 2024 04:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103164834.970234661@linuxfoundation.org> <99fe3993-51b5-4284-8a22-869764f393d8@linaro.org>
 <32ebe3f1-49b7-4ad3-9ea5-ed2adbbd78da@linaro.org> <2024010427-kisser-canopy-763c@gregkh>
In-Reply-To: <2024010427-kisser-canopy-763c@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 4 Jan 2024 18:09:53 +0530
Message-ID: <CA+G9fYvMRQ5QTkbGETUHDzVAyOXKEMvMdL0Ghr8cVzXOaUHifg@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>, 
	stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, leo@leolam.fr, 
	johannes.berg@intel.com, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jan 2024 at 13:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 04, 2024 at 01:15:45AM -0600, Daniel D=C3=ADaz wrote:
> > Hello!
> >
> > On 03/01/24 10:10 p. m., Daniel D=C3=ADaz wrote:
> > > Hello!
> > >
> > > On 03/01/24 10:55 a. m., Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.6.10 release=
.
> > > > There are 49 patches in this series, all will be posted as a respon=
se
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > > >
> > > > Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patc=
h-6.6.10-rc1.gz
> > > > or in the git tree and branch at:
> > > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-6.6.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > We're seeing a build regression with x86/GCC-8 and allmodconfig:
> > >
> > > -----8<-----
> > >    In file included from /builds/linux/include/linux/string.h:294,
> > >                     from /builds/linux/include/linux/bitmap.h:11,
> > >                     from /builds/linux/include/linux/cpumask.h:12,
> > >                     from /builds/linux/arch/x86/include/asm/paravirt.=
h:17,
> > >                     from /builds/linux/arch/x86/include/asm/cpuid.h:6=
2,
> > >                     from /builds/linux/arch/x86/include/asm/processor=
.h:19,
> > >                     from /builds/linux/arch/x86/include/asm/cpufeatur=
e.h:5,
> > >                     from /builds/linux/arch/x86/include/asm/thread_in=
fo.h:53,
> > >                     from /builds/linux/include/linux/thread_info.h:60=
,
> > >                     from /builds/linux/include/linux/uio.h:9,
> > >                     from /builds/linux/include/linux/socket.h:8,
> > >                     from /builds/linux/include/uapi/linux/if.h:25,
> > >                     from /builds/linux/net/wireless/nl80211.c:11:
> > >    In function 'nl80211_set_cqm_rssi.isra.44',
> > >        inlined from 'nl80211_set_cqm' at /builds/linux/net/wireless/n=
l80211.c:13000:10:
> > >    /builds/linux/include/linux/fortify-string.h:57:29: error: '__buil=
tin_memcpy' pointer overflow between offset 36 and size [-1, 92233720368547=
75807] [-Werror=3Darray-bounds]
> > >     #define __underlying_memcpy __builtin_memcpy
> > >                                 ^
> > >    /builds/linux/include/linux/fortify-string.h:648:2: note: in expan=
sion of macro '__underlying_memcpy'
> > >      __underlying_##op(p, q, __fortify_size);   \
> > >      ^~~~~~~~~~~~~
> > >    /builds/linux/include/linux/fortify-string.h:693:26: note: in expa=
nsion of macro '__fortify_memcpy_chk'
> > >     #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,   \
> > >                              ^~~~~~~~~~~~~~~~~~~~
> > >    /builds/linux/net/wireless/nl80211.c:12939:3: note: in expansion o=
f macro 'memcpy'
> > >       memcpy(cqm_config->rssi_thresholds, thresholds,
> > >       ^~~~~~
> > >    cc1: all warnings being treated as errors
> > >    make[5]: *** [/builds/linux/scripts/Makefile.build:243: net/wirele=
ss/nl80211.o] Error 1
> > > ----->8-----
> > >
> > > This is currently being bisected, so there is more to follow.
> >
> > Bisection pointed to:
> >
> >   commit 92045aab1bd9bfd73d816e907ea07739c4550b41
> >   Author: Johannes Berg <johannes.berg@intel.com>
> >   Date:   Sat Dec 16 05:47:15 2023 +0000
> >
> >       wifi: cfg80211: fix CQM for non-range use
> >       commit 7e7efdda6adb385fbdfd6f819d76bc68c923c394 upstream.
> >
> > Reverting that was not possible, so I reverted 47f3694a4259 first ("wif=
i: nl80211: fix deadlock in nl80211_set_cqm_rssi (6.6.x)"), but that was no=
t enough. After reverting both 47f3694a4259 and 92045aab1bd9, the build pas=
sed again.
> >
> > Reproducer:
> >
> >   tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-8 --kco=
nfig allmodconfig
>
> Very odd, 6.1 works fine with this same compiler?

It works on 6.1 with the same compiler.

> These changes were in
> the 6.1.70 release (and the 6.1.66 release) before.
>
> It was also in 6.6.5, before being reverted in 6.6.6, so why is this
> causing a problem now?

It was also noticed on 6.6.5-rc1
git_describe: v6.6.4-135-gb0b05ccdd77d

I have already reported this on a stable mailing list [1] on 6.6.5-rc1.

Please find more details and comments from Arnd [2] and Kees [3].

[1] https://lore.kernel.org/stable/CA+G9fYuL_-Q67t+Y7ST5taYv1XkkoJegH2zBvw_=
ZUOhF9QRiOg@mail.gmail.com/
[2] https://lore.kernel.org/stable/ce99918f-eb6a-4ad7-aa44-9d27c27b6b00@app=
.fastmail.com/
[3] https://lore.kernel.org/all/202311301016.84D0010@keescook/

Test results comparison,
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.9=
-50-g5fd1c89851c4/testrun/21921607/suite/build/test/gcc-8-allmodconfig/hist=
ory/

- Naresh

