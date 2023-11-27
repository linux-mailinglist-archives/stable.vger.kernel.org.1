Return-Path: <stable+bounces-2784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B548C7FA7F9
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 18:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD12281718
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D2A381AF;
	Mon, 27 Nov 2023 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xgi7usSD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AA085
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 09:32:24 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-285949d46d0so2016111a91.0
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 09:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701106343; x=1701711143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts3VyCUe4cBea8IwRsP0b6P6Avs/GjtfVnV06MWxKQQ=;
        b=Xgi7usSDHLWs0scoNjZdVXFCTKEpBnIRZBqugTaUViX+H6lh8s2EkGi1o/MVjjSDkq
         m3g7JPmavK9J4sooPg3uDhXSQWYdPOflsr6alDo3r5RAaNx6RgwybPI8k+oUoqWfo+/8
         u0k12RCMK7Dm4uQLSr0D0pcPFClp39vXBIpeLqqwfm+QuYbQmbmLF5eplnmfFD6yW7Oa
         PcKaouEHu0kIfMMfmIxPBc5OTMaEYZ23RVpNYVqymihWJOMxP6OGDw7b93vKk8PS+Bt9
         rGb/4VJSrGKOIIAeha9Ypnvm3fEgWIq7PCKDfASIOQ97Ri+Nhc5xZEJea3U/LUctH2sT
         R56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701106343; x=1701711143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ts3VyCUe4cBea8IwRsP0b6P6Avs/GjtfVnV06MWxKQQ=;
        b=cblpg0qiwcP8KlG4YakMcFU/ku4U4Je1QK8F7qWes8Tcd8s3SyWXfm+9kuYjXt2unW
         uG3gQBVTH6DXt93SRJX1tTngjvO45qF/q/tZ+lp5ajNU6riyIGRSyqWk03SD4vP5quH7
         vT1EKLkU+/huRkr2wGoR22glcnQkB7YgUQVRD2lzxgfBCkR1Ab5XuQd+U0logaRfA/DR
         fgQXvBjcMbAPHFnBESJso8BJwH1jlJkM6u69gFUPkXS+ospKv79SfQi2j1HEkM4zuP1a
         WDTi18iz2HWuJMw0bTc42BAOd7KOnLa0R3UdS6nvNSH7vfrVpHG3WUxCrqebeLRxAROi
         0nsQ==
X-Gm-Message-State: AOJu0YwYon+Y5htGLhCYQ/6U2QNaqZDWmEUP0IiqQzMepBVsflrhDygA
	rwrr93axWcd8XQQecMkkvF+SWWIjyIb4PZmmk5O9hg==
X-Google-Smtp-Source: AGHT+IFQ9zX3MumdTgfhvMAgaY7F9eqnRsilyyirYn4Z4DQcWwjkd+7Kv6KPcwAvs+qloWCPAyY87E+KudOL414aKTs=
X-Received: by 2002:a17:90b:1894:b0:280:23e4:4326 with SMTP id
 mn20-20020a17090b189400b0028023e44326mr20599735pjb.14.1701106343555; Mon, 27
 Nov 2023 09:32:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124172000.087816911@linuxfoundation.org> <81a11ebe-ea47-4e21-b5eb-536b1a723168@linaro.org>
 <20231127155557.xv5ljrdxcfcigjfa@quack3>
In-Reply-To: <20231127155557.xv5ljrdxcfcigjfa@quack3>
From: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date: Mon, 27 Nov 2023 11:32:12 -0600
Message-ID: <CAEUSe7_PUdRgJpY36jZxy84CbNX5TTnynqU8derf0ZBSDtUOqw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/297] 5.15.140-rc1 review
To: Jan Kara <jack@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, chrubis@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

On Mon, 27 Nov 2023 at 09:56, Jan Kara <jack@suse.cz> wrote:
> Hello!
>
> On Fri 24-11-23 23:45:09, Daniel D=C3=ADaz wrote:
> > On 24/11/23 11:50 a. m., Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.15.140 release=
.
> > > There are 297 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.140-rc1.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > We are noticing a regression with ltp-syscalls' preadv03:
>
> Thanks for report!
>
> > -----8<-----
> >   preadv03 preadv03
> >   preadv03_64 preadv03_64
> >   preadv03.c:102: TINFO: Using block size 512
> >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully wi=
th content 'a' expectedly
> >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully wi=
th content 'a' expectedly
> >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully wi=
th content 'b' expectedly
> >   preadv03.c:102: TINFO: Using block size 512
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
> >   preadv03.c:102: TINFO: Using block size 512
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
> >   preadv03.c:102: TINFO: Using block size 512
> >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully wi=
th content 'a' expectedly
> >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully wi=
th content 'a' expectedly
> >   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully wi=
th content 'b' expectedly
> >   preadv03.c:102: TINFO: Using block size 512
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
> >   preadv03.c:102: TINFO: Using block size 512
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
> >   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
> > ----->8-----
> >
> > This is seen in the following environments:
> > * dragonboard-845c
> > * juno-64k_page_size
> > * qemu-arm64
> > * qemu-armv7
> > * qemu-i386
> > * qemu-x86_64
> > * x86_64-clang
> >
> > and on the following RC's:
> > * v5.10.202-rc1
> > * v5.15.140-rc1
> > * v6.1.64-rc1
>
> Hum, even in 6.1? That's odd. Can you please test whether current upstrea=
m
> vanilla kernel works for you with this test? Thanks!

Yes, this is working for us on mainline and next:
  https://qa-reports.linaro.org/lkft/linux-mainline-master/tests/ltp-syscal=
ls/preadv03
  https://qa-reports.linaro.org/lkft/linux-next-master/tests/ltp-syscalls/p=
readv03
c.fr. 6.1:
  https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/tests/ltp-=
syscalls/preadv03

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

