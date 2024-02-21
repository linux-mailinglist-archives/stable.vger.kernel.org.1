Return-Path: <stable+bounces-21820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105B985D624
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 11:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415371C2143C
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 10:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30D83F8E4;
	Wed, 21 Feb 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="ZyhSP4wI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D053C067
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513053; cv=none; b=X4n1uBxDnLb+bOjfGWhuBK05jM0o6Nzt9/yqjZpKK7xshXlyhe41LBbEaDcchcB86kkzYIDklpOECTjdo9SWtMvXdD1uM8axztEAoQj4XzfRkwRipTjwUwc9yA7j0R8sCUt/KEJu/WMGCtkEL/bsbYQvNkHZgT5l77PRo3As3Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513053; c=relaxed/simple;
	bh=12eHUbAjggF8yM7NgbCREXkzqk9dNvGWjPUhot5ICm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8vwsMcFBsYqztAMMAH51KrEMjW4/OVKYa8ed6ceIjVxKLtwqLsNg328uPI9RHtTKhdfZWCwt8ocBUyj3lBR8/779HQzrdmJVKor7Uaapw83edG6kZkkvwTKXNA83VuO0xj5/8wwdyis37/Je3imuINrnS6NHHmEZyVh4xlnmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=ZyhSP4wI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41275971886so3571815e9.3
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 02:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1708513049; x=1709117849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXS0v4k2QIM4BKra2esPdMnm5lJf7ZlcPGjCl+7IYY0=;
        b=ZyhSP4wIo7LeuhjYcKwJjGvr73PIDJ8G+lbylUYm4vfJl7dXmpxhXiZTTJdEOs5jg7
         qSbp29H6gG6HX0xbQQYGiNCkB2KktNeLadLNO6OGkJlb8ha/yjnUhp2MbOQM0JrP9+0Y
         LcZVUP8KceW5WtPG78Hhw1rpC6f3/Gb7CNcXQNDKtvwldEF5XrthQLm8ktIhLRq7lgya
         wxvVx85UtMLDZIp29DYfOTjuqhYJaH0gTRsRh17P3z3JSph7aHWEqVq2nnkrqMnx99Hf
         g7Q2p+vIiI+IbZWDi650UUU4QGKc+Xgq6rdEeRfsErnsxKYzcJJc9KbRxekQXpmLIOTL
         hdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513049; x=1709117849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXS0v4k2QIM4BKra2esPdMnm5lJf7ZlcPGjCl+7IYY0=;
        b=Qk+9370ZJJPEPWZcYgvScMF3L51cqBUAcS9GmwP/UMN9JEKX9wQj6fOzsChkimxHxO
         GCvxKE2qQW/JxBRKLLVO3F7CRkesJ0hEdb91Yz8uNoNpfOl9TIA+jZEEQbH+XsP8yBYP
         X/zmvrAu5OPW2g5F65wMU7rObngRY1i/ekv4xwRat5eq73I3vfnXa9a4MeqewJbw27Wt
         wiGJkkL3XmVKBAXOkbNaFbhF/no/delOQQUTB2sKiprC2gOeZ/ftCeQTfVNe2sLMA/kZ
         X1QFbHNXN5QBRoZ/8v+c0Y5dxqUFBs2YGX6qM7lAWdY44n+Pj9wIq27Qa2Ir5Ad3Assh
         2aPw==
X-Gm-Message-State: AOJu0Yz/fGsi+qMl9SSQUd1SaF4Ow9abvmK3bO37+JkUBBq7IPToYvTZ
	XP7S9YRpGqTjuEopSTr44029rVTqAUDYk5eyQ05aB+cU2juoWVIOs/tvAni4RXyux/zbVoBmH8r
	Ixzi2SULiPvrLAkUEIEeW2ZvST50kKUzMByQ4Eg==
X-Google-Smtp-Source: AGHT+IGuvBYOPybU+JlLxiW/kVCWLOvI2+PYz2s5jpQmusjJ3soy+dVF8/NFDj1SlG1DcCy9YtEo+OfpQSAULDF7mLk=
X-Received: by 2002:adf:f742:0:b0:33d:7ea3:5b90 with SMTP id
 z2-20020adff742000000b0033d7ea35b90mr829829wrp.65.1708513049204; Wed, 21 Feb
 2024 02:57:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220205637.572693592@linuxfoundation.org>
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 21 Feb 2024 19:57:18 +0900
Message-ID: <CAKL4bV6j90+tQVoAVUaxkFUuCT05sK8OrjuBZntesw=UyOVaAg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/331] 6.6.18-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Feb 21, 2024 at 6:09=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.18 release.
> There are 331 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 Feb 2024 20:55:45 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.18-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.18-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.18-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Feb 21 19:34:18 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

