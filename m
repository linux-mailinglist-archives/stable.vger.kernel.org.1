Return-Path: <stable+bounces-57971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3114926772
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 19:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F021F216A1
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 17:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6121C1850AE;
	Wed,  3 Jul 2024 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vsssUqfH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95517F511
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720029121; cv=none; b=Xakoz9+2yVhg0chWM4Ax0vdt+JtyvTLx4MLETcd+ePd+uQ14zn5O2g8groyj3RfV9yFzL1P5E/FCpnJ/r9UqvBGzyNn1D07YwFmqUHtfl3ZWSzA9dKE/gADZ87h2yIrIoI+BVxKqCmzXBYCORD1Kb6Wqms6Z9qKWwt37jOnqdHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720029121; c=relaxed/simple;
	bh=I/SyeQYOGfLQAUSaryB4epiEujHxOBhpHqyBsKYQnmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKpAJklI/AmONk2Qs8kUs0vJ1w9tp41s0Y09C0Kt07ce1JmYG1/NT30SxCw4oNluhOmtvrXqpHrzEAeL1/LzPMEecK1TNSssi2wAhX4pwkCA7AOU2qRcM5/GvzpcoaNweyYF+CQzOX9qxxYsHccKJGfoNXHj+G5e0547xuvyvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vsssUqfH; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-8101c661979so276023241.0
        for <stable@vger.kernel.org>; Wed, 03 Jul 2024 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720029118; x=1720633918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i8jcvDGwHGDOUPj1r3ad1ZdHqvoFYLPPd5l4l3bI77w=;
        b=vsssUqfH9ffgsx3yjTvNTWTN5YxgiyP0EO0n6BcdTHelomytRQavfMYdDosTo+DkIg
         slq2uc+0JAAvN082Z4Uet6rzEeE/7W0/bQ+lE7ix4rwI4PugwtabNJcc3BPIKSQqH93u
         J9+72jM3ECC96zFkTkqHb4bUhP5yM9xhoBk+N7kKVzZY+PDE2oiwgDLjZzSCWEjdtBxO
         z1hVkJvDaAyNX9CCZnyfueChL+HHpX81M9G1+/7vfdA25Vw0SzB1/TBdzOONKPgVFZl3
         xqSQJQGxe0i/PBMwZv60j8bxaFymgSJhWAAjpBsdikcgfNxWqBOlUxzaLE9K19WR+0rF
         mX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720029118; x=1720633918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8jcvDGwHGDOUPj1r3ad1ZdHqvoFYLPPd5l4l3bI77w=;
        b=Gcwa82H7iBJYfF2JJx3mgpsvbiDfZbEv40RbkhXgsJrlbnHrAhCuVFhmmH3TCYkDtC
         tTO6Vi/TXJKly9AgA4AiwS493qF6c5DOvZk0k8GiJv+4uIksxTq9+lh2dq+Lh/5VfwUN
         vK0yO47BFSw2A+tYE1xx5WX5Rz2QUzMHbYBs7dUgJt6mMVmAaeJ+ZbECckr76XFi8jSa
         c23TeONrEVtv9hEgzi3/S+0r5WmGCFsDw+etiU6nBWMQc/IYA8jGf/DfgJZ/NNmEOA7J
         XcaCo99tg6mYKQDPoVy9jA6wSMiMTfJt5A8Mp8MugAPm2SfXMgtSHUS2nEMgyhd5b0K5
         AUXg==
X-Forwarded-Encrypted: i=1; AJvYcCVVspgrMGbyvIH7kCtOgf0qW2Qa5BU/vIyaZnoztQ0owpQsQYt8wUz5s1ms2ODmdKvAtGoQuVUz6mvH2qbvtwLpIR2aBngh
X-Gm-Message-State: AOJu0Yw+m74/NjMZVn8HMhnqnQggRlR4CIQPqFSqFPzTGvSKhjpFayvv
	/FABu7hzQXEIf0nQSRl0HImFAYH5sxWKcHh3In+611rk6WejpUPNLrRRQyVLybXl5SXApuNJ1Yv
	9Xn0D1x+0dOTq2WPwzhYdFbGOENnBP8HrTDfzmg==
X-Google-Smtp-Source: AGHT+IHhubxatrzSaA5HKwryk/uHLQRo61FC6EY73fx40maWnrKKGtHLfWp7my6T+SlQSv0KB+ZvBb6CauO9auPbwxg=
X-Received: by 2002:a05:6102:e14:b0:48f:9751:198b with SMTP id
 ada2fe7eead31-48faf12de8cmr14916609137.23.1720029118386; Wed, 03 Jul 2024
 10:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702170243.963426416@linuxfoundation.org> <CA+G9fYuK+dFrz3dcuUkxbP3R-5NUiSVNJ3tAcRc=Wn=Hs0C5ng@mail.gmail.com>
 <c440be12-3c22-4bb6-9a10-e3fd03b87974@app.fastmail.com>
In-Reply-To: <c440be12-3c22-4bb6-9a10-e3fd03b87974@app.fastmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Jul 2024 23:21:47 +0530
Message-ID: <CA+G9fYtuiiV0FDFoSZOaKQbKiQYw+SphhWZDjK8R-bH7dBfs5w@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/222] 6.9.8-rc1 review
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, shuah <shuah@kernel.org>, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>, 
	Jon Hunter <jonathanh@nvidia.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>, srw@sladewatkins.net, rwarsow@gmx.de, 
	Conor Dooley <conor@kernel.org>, Allen <allen.lkml@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-block <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Can Guo <quic_cang@quicinc.com>, Ziqi Chen <quic_ziqichen@quicinc.com>, 
	Bart Van Assche <bvanassche@acm.org>, "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 14:55, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jul 3, 2024, at 11:08, Naresh Kamboju wrote:
> > On Tue, 2 Jul 2024 at 22:36, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> This is the start of the stable review cycle for the 6.9.8 release.
> >> There are 222 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> >>
> >> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.8-rc1.gz
> >> or in the git tree and branch at:
> >>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> >> and the diffstat can be found below.
> >>
> >> thanks,
> >>
> >> greg k-h
> >>
> >
> > The following kernel warning was noticed on arm64 Qualcomm db845c device while
> > booting stable-rc 6.9.8-rc1.
> >
> > This is not always a reproducible warning.
>
> I see that commit 77691af484e2 ("scsi: ufs: core: Quiesce request
> queues before checking pending cmds") got backported, and
> this adds direct calls to the function that warns, so this
> is my first suspicion without having done a detailed analysis.
>
> Adding everyone from that commit to Cc.
>
> Naresh, could you try reverting that commit?

I have reverted the above patch and boot tested and it works.
Since the reported problem is not easy to reproduce It is hard
to  confirm that the issue has been fixed.

However, I have submitted jobs with and without the patch and
running tests in a loop.

>
>       Arnd

- Naresh

