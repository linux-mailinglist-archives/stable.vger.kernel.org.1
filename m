Return-Path: <stable+bounces-105146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1EB9F65AF
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D09A162098
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 12:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F6819A288;
	Wed, 18 Dec 2024 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="mkt5o9Ma"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F31534EC
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524197; cv=none; b=qedhNUYaj/eYCCflYD+BpeKUGrYntbDEW5g+/jKTaOl5i5xLZL6/0AwlQfSE58veAtnngff7twAJlsQYi97ZsdFHzO8cQ0tf2ZAQGE4528mF6MNROz2+boPxYNvPEHDFzdTZ1KxhP/fo9ZZ0MCl+8H4T+RMAkAg+QS/Aj8PAA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524197; c=relaxed/simple;
	bh=twiqzmfa0k6rVvwKb4kVKF0U5mkPuRFri4eXv8g/B18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1ACLIQAUlSd/J+jXRbYkFCsAUCF1pHIu0AHrRW2vO+vk4MPIL9vxxG324uchunTdYhdgh7VP+l6qOFt6CsWGt0CFxQ+KoE6QTmOfP9Fu8oQIxYqOAg9R8mPy0rqS6+D2THqm3YaqqE7wCpppjmW0XXgVzdKd26zcHQpwv8We8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=mkt5o9Ma; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee51c5f000so4485132a91.0
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 04:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1734524195; x=1735128995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMgJ1n37qBMrXii59hNg/ts/KUZiMWLlRfTJDT3i1i0=;
        b=mkt5o9MaWqT0/55MOXl5ygajDst5t7/KlqnOrsYJXxZFDeDugWZgNNFvpp3/3p22pv
         BMc+vQpoyIAZ1dPO/hxDwNkv0E0hlLXCTeJb1w4CLM/buVR7b7tysCrcnbA9jvmg1CiY
         rQUf+1L4vMZ2Er88jf5vJPdBiEJXR8pVKaIU+gU1Y5weX+s+wAkcRrsXvmYWdGS7XU4w
         wGC4gYPrLCrbZ0+VBW4r6TzH7dx18mbYI0Z0LyoSnjYzRqUGaQvZhM6gioN+GNuvbSsk
         vhzOaExxinD8qWoZYhN/EKOKiPCbgwYFrEeaWf80RY3TtWiFr8nUuJUKt9NfDK9x+NMB
         33Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734524195; x=1735128995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMgJ1n37qBMrXii59hNg/ts/KUZiMWLlRfTJDT3i1i0=;
        b=KWsLc8fRN9c3ofebzmsh76LGwcSfwrb4quGOXOx48KTXxvBngS2C4eXfc0OV2RuUIp
         OEtGaOX43t+qXbdwjIzg4uoRbUSZ0NuuH562mx6xJ9Yw//H5GDHT6ERxyj3Q5YBD6PMa
         ITk2VNQ1yjpXI7v3P/Pgks4BiipQZh/Yne7rXODvML77U1uMzADYgc16VuxsXcpG+PAW
         WHJ7eyxYjBEtQ7y3obouDI3adRwa8mBLTiYdmPdjKxsH5p789FNCrl4lbPFeJiPjS3Fy
         431HumvSRyytL+MrmXIyFkRzwJDRRtSwVe6I6tpd/Rj/hLEmDFwFdxjwU0UggY5MwbZh
         +isw==
X-Gm-Message-State: AOJu0Yw6YPp8cAtx0i6wdXen9UIH4L3Vjg+iTlpa1Cjv+OYNHT24YmY4
	v7DOmEjqd/ubdkyxoIx3SeYfGuifPDW3BR6ckdKNiZ2PE73VrBFrHuMAbEWPng7M0RKebBz66OK
	JnG9tB1r0OT9t+ptVzR3nSmIqfs/LUioGR4msUA==
X-Gm-Gg: ASbGnctk5txbCtT/t2TeJVkiZYTgfei+39oGcFx4Y2N1fpilAiZwDR9Obbw3JlS9oZ8
	kH1ELHjLJOvoTN1VODJlHq86cqLaa0weTT/Gtlw==
X-Google-Smtp-Source: AGHT+IEBr6Q2C61/Cq2TVUTgG/Vgl3/i/ZI+3fCMzOgertDix5jNgYZxiglfunJ639kL2OTiIFRgnaJThJHfZbgwMLA=
X-Received: by 2002:a17:90b:2d44:b0:2ee:8008:b583 with SMTP id
 98e67ed59e1d1-2f2e91dd1cbmr4300861a91.16.1734524194844; Wed, 18 Dec 2024
 04:16:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217170546.209657098@linuxfoundation.org>
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 18 Dec 2024 21:16:23 +0900
Message-ID: <CAKL4bV7TKtmtu-2omRa9U8u9x7rdNKN7dZcoJHe7=iv5yjC=vw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/172] 6.12.6-rc1 review
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

On Wed, Dec 18, 2024 at 2:28=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.6 release.
> There are 172 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.12.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.6-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20240910, GNU ld (GNU
Binutils) 2.43.0) #1 SMP PREEMPT_DYNAMIC Wed Dec 18 20:05:26 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

