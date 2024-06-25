Return-Path: <stable+bounces-55775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 763CF916ADB
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 16:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB831F266D5
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 14:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2518156883;
	Tue, 25 Jun 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RXh/0eir"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99D3A8CB
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326618; cv=none; b=ZWiOr0i82tLuXYcV/vTFEkIWkqC465uKKM6l29P/Ahnbz5jIEe6HCAJuTH1CWo0brLjNMJa/xqfY5XnDVlqsDFWMPPVag1oRNHFKQKyi5nFeWNfI+VwjYfGo6TYYI6ZIP5KQT7swByl2lfWmWw2xAQTXmgog4pUmZz86w6J8Iqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326618; c=relaxed/simple;
	bh=L/dydMq7C251MlD3tTdRlp4r0XkouiX4vTWqD0ow9mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3uighqk29lbxa3pqwT6PrnthEhc5fonj2M+WWHNJWqTxzoYCT8pH1aJdZrQrvhX0mCT61vvN5SWYcXVSNwEb6pDt1SU0vjSbuGkq9b8FwlJLv+HVd3KUsFfE62HM6OfWNElb/GvLedyEDXzKXuJ+XcZkZl9o7Oh/jCMgcP/EqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RXh/0eir; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-48f37e28bdaso1479192137.0
        for <stable@vger.kernel.org>; Tue, 25 Jun 2024 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719326616; x=1719931416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MaaT7rnWKnSYEKZvA5IKNh7dQiln4aBFeYHJwuSSqCc=;
        b=RXh/0eir+tFX9rk5z3ONB+LHNP61TwX/b2gaV1x1fn91s+cE2uh3/UkbbVprJLZReO
         HCfqvubX34llW7cf8l3tKREsVpeyfgBwI5yc/uImb84Hji8GYKPztBKRSWCTzDysjrOp
         DQyrPeFzwdwtRqsQrf3efO43m7EpmWeIFP5C/8WuVKmjdFkd1qly9oqoGmqjiRalrJ2p
         2+6rIOaw96XEIlBsKj3CiAvi/dYxN3QViLA4NNgo+fYyu24GoBLhf37QLHG+1gPoSc8S
         kzSdopAouFvoZ6gl/hvQMBlkJqnukmjeNL02NAvEThEgp9znBFiN7NHWtJwMgUAX7608
         wnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326616; x=1719931416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaaT7rnWKnSYEKZvA5IKNh7dQiln4aBFeYHJwuSSqCc=;
        b=fKsX9kNOc37OhamKLvQ+w2toYnH8xEZ7DHczEL4KLGzpadxL+ivaJI+uQeGLTAuMyz
         q54YzaozH9y4Fq86RU1MvoWGLXwjIllNPW6YPo7HuWrq1ZABEpl6/VhgNmQh5jJtO8YN
         +uaj/RMncW+sndrFUEj1JloVOXoRcWxAJhPtT0IgjPSvwKf3hPBtYa3/pEdM2E2Venef
         QSkuUWnACVghFNEUDxvlO2fFPZDUehR7KowpJcuQTyQSBmSxI7qfK1LkcgVWgHD1OCNz
         ZXPbYMKBHDws0KCF0fW93moyjrn2LXThFloas0eMsENeDa1yaC/Fo8eSzhXplQy3IIFH
         BQbw==
X-Gm-Message-State: AOJu0YzrDrT2/DjN3gJIXWYtCc3bimmsz+HAKJ9jGWr4j5qgk/eQG4Mq
	kwKyr1vTnDJ8duzw+rn+2W3Rx/S42z9oRjxKv5Jnxc2JufKnM3iEOk1d5vp/ELQ4WlYdircBorL
	6w61SA1RnbG5fdVVHTkGmyAbqNh9ibDrsIGReIg==
X-Google-Smtp-Source: AGHT+IESjp1uZJE1cuEpSbu1klElS0IBkMZLTW2oJluu4P14tweiIz4ytmLniFUqAZDnE/jDE6DXfw9wVZibU3S6UMM=
X-Received: by 2002:a05:6102:301:b0:48c:3db1:94dd with SMTP id
 ada2fe7eead31-48f52be77cbmr7263726137.30.1719326615883; Tue, 25 Jun 2024
 07:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625085537.150087723@linuxfoundation.org> <CA+G9fYuWjzLJmBy+ty8uOCkJSdGEziXs-UYuEQSC-XFb5n938g@mail.gmail.com>
In-Reply-To: <CA+G9fYuWjzLJmBy+ty8uOCkJSdGEziXs-UYuEQSC-XFb5n938g@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Jun 2024 20:13:23 +0530
Message-ID: <CA+G9fYsn8r7V=6K1_a-mYAM4icHKt-amiisFMwBbfPeSPyqz-g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/192] 6.6.36-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 16:39, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 25 Jun 2024 at 15:18, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.6.36 release.
> > There are 192 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.36-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> The arm builds are failing on stable-rc 6.6 branch due to following errors.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build log:
> --------
> arm-linux-gnueabihf-ld: drivers/firmware/efi/efi-init.o: in function
> `.LANCHOR1':
> efi-init.c:(.data+0x0): multiple definition of `screen_info';
> arch/arm/kernel/setup.o:setup.c:(.data+0x12c): first defined here
> make[3]: *** [scripts/Makefile.vmlinux_o:62: vmlinux.o] Error 1

git bisect is pointing to this commit,
[13cfc04b25c30b9fea2c953b7ed1c61de4c56c1f] efi: move screen_info into
efi init code


> metadata:
> git_repo:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git_sha:
> 580e509ea1348fc97897cf4052be03c248be6ab6
> git_short_log:
> 580e509ea134 ("Linux 6.6.36-rc1")
>
> Links:
>   - https://storage.tuxsuite.com/public/linaro/lkft/builds/2iMq0CHppQGxkVSsEPFtnw08bc6/
>   - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.35-193-g580e509ea134/testrun/24441308/suite/build/test/gcc-13-lkftconfig-debug/log
>   - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.35-193-g580e509ea134/testrun/24441308/suite/build/test/gcc-13-lkftconfig-debug/details/
>
> --
> Linaro LKFT
> https://lkft.linaro.org

- Naresh

