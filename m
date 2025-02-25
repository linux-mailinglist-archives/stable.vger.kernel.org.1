Return-Path: <stable+bounces-119482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55435A43D65
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 12:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB97E3AE7F8
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 11:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99E32638AE;
	Tue, 25 Feb 2025 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="h2zTm26M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB311FCFD9
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482214; cv=none; b=tJVjz0wz1A2XZYBkkAltEmZQ9fIB2eu3/Dn3pFts9o1h8vSqYT9sQRnFF698NayOhKnjU1YuMtTudiqpZgW7Z6GFxl6HN676ML2TK9QVTVCZG3Jzvdsx+dmJlRJmB7EBizLP8DrXlYAw/laGVsgr1xQ6gbm8Tjs+XDMp/0+qv0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482214; c=relaxed/simple;
	bh=nq0EPGLmAEGxwapDdA7JGX7A1kQwUZXc+8FAGQqLWgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjpKkGqwtO0V2yMvRfg/0lnz1dofvE9pg0DBtIief0+xgmIivODfqu5uNORofmxQh+nhGtOuNx5nVDx0cnol4Jkym91eTTXpXNW8HxDlx1jdzwpvL5hF/eAk9nJMqEKhaBoWfKDNC3gSwR24Ca1+6gmArYQwyxvWjvPWsCPVuI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=h2zTm26M; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso9303607a91.0
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 03:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1740482212; x=1741087012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BidLeBZkJUtIcxcRlqcE1G4NM4e2prFwhePG6wNNgOU=;
        b=h2zTm26MfBnP0qdlVQiKrSWub/s8lNXSjEED8ZyGgauXYOPSIqmmxPfdsliXGPK6OK
         s/isxuM0AN6tEv3lWJayOETrXuksoneVL2/Iqz/UtgYpHRDMQUcXv41NYiRootQJjI7x
         1twFrsXkLZQg/zCoPGTPmeSTDlk2J6bxW99AfTT8nnSsDX4IBoFQ4t51Jlbb6qlV8xml
         yUaYGbm36CaAR7iDe5X4PdHpw90Yg7AyViewUaRUkyITOdm3hIaPhkWEiaifxmBCzsjy
         kKqMPqIgYzgE/nIhD3YGML062KzPaS6iM0mFPeK5N5TaevDXXIzqDhyAxnXqOKKYa3YV
         o+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740482212; x=1741087012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BidLeBZkJUtIcxcRlqcE1G4NM4e2prFwhePG6wNNgOU=;
        b=OnZDzGPUMscFWjZ6gtqxnxrVKATJ6b0P0GSxy7xRE0xhaGqq0kX5bW3xM3ap3ndypo
         6ZT5c/9tHwlC0n69FoIP6TT8siEncwozJZEsnk1UJ2+av/qIYieGUj2xqQXdtkktbyiV
         BbjOC4mZvhL4lJDZYOpld/jDU0fNY122jcXfsUL5FELN94UGz96jWvdWoq1hiR6BzTfQ
         jfnYW62BvTjoke6TZ7teC31NejhwYx6jXVUt2yOaGQdpAzEzxgjemcNzT9f937oBHidU
         Eccoywn/n9U3jcmgDq6aIexqakRv+2lrQXcg4VfIR9cFfjXj5YJ3KEeXqUsUJt+vIzTD
         nmOw==
X-Gm-Message-State: AOJu0YyOmSM6tD2wH7LjzfkAxGMWvl+8sd1q2owGIKlWDgL++k7ke2Cy
	ySuPVOtqx79eTegocRMfvv/Jsd2QlwMYYHslfkWb4pKyRoCawk7AtswuQX2hluj05UierncOKN2
	FJZDWDbkG6VOLQSEKAqTFi/+WK2syECwYA4nN8A==
X-Gm-Gg: ASbGnctFCaKN8KozT0YZFyLJniFFjdcUJfJ+5aH2ntuH92wFtkE2S0hJBpiDzmP9/F/
	l+iOLuuyOCTNmXjtO/anDUwTMGBgM/696hTc0zpmqnLJkV6fGt6u3aB8zcPBL7Hoja5Y4mv2MHN
	u/ySauLkQ=
X-Google-Smtp-Source: AGHT+IE4zNCtApjgCW7IVrMKgxaqKv83HSY9BzzaaRBtqgzD3CudAd5vQ1VyBcJ2Xih314sYh+MeRB44yJsTo17Xs3M=
X-Received: by 2002:a17:90b:3e4e:b0:2f9:d0cd:3403 with SMTP id
 98e67ed59e1d1-2fce7b738ecmr27861132a91.16.1740482211795; Tue, 25 Feb 2025
 03:16:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225064750.953124108@linuxfoundation.org>
In-Reply-To: <20250225064750.953124108@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 25 Feb 2025 20:16:35 +0900
X-Gm-Features: AWEUYZlymfn4SR6NJFuWVJLjUbbiu8b-EdVKox624pmhyRoWSWfGeNS-etq0fYI
Message-ID: <CAKL4bV4VvXMJgrtWGdBNOWzfn09S6NAaokR0PO=JO_u4E5mtmg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/137] 6.13.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Feb 25, 2025 at 3:55=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Feb 2025 06:47:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.5-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.13.5-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.5-rc2rv-g1a0f764e17e3
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Tue Feb 25 19:28:03 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

