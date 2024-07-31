Return-Path: <stable+bounces-64775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A869431D8
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 16:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC2DB231CA
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 14:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A981D1AE875;
	Wed, 31 Jul 2024 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="cGSef8L/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074B1A7F73
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435548; cv=none; b=pncFkgkuuouErAT0EiCOihpsIIMia0TfjjLzBSaQBrcSE9ITMbeTI0wDXXRqjzsiyBjPcagwnwwldZnEZfK3RX2utrc1FWRyIbW/KuF+/9qn4Ii9EBJR3fyhdnsLPlALL2lWrs5N0JLJi+YtFOeRX1J+QJGXYqCeLx/m7jn/jKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435548; c=relaxed/simple;
	bh=tw0+TCU4/jS0AandgOrW7tGxrTSxEhF7HElw2lzzHf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnXZiOqJ9lmsJ5/1Ewf/7DB1oKQH2bt+g8QJHaMZn25bAksLo6sU7tDwkxkIuP7L7wFY3QNcigmAZy0Sd5tt10AdoWWjKpyEzpv2xN1iUqc3cbX9pove6m9bhsaKA0fVGIJCHDWbbzQ6uAc23ZEEmmVbv0wHLfI5mt+zepDMx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=cGSef8L/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-70b2421471aso3599041a12.0
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1722435545; x=1723040345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+olOBTdXwD+ptqnBW2bgMxBC/rcIDKTtdk5vVlb2vLI=;
        b=cGSef8L/s1Lz7tnsMq/Srg+DbX0JvQ85xZWg/quZewmByP3hc+13j3gA9Ge8vAizBG
         YJWkBbaMcSu0Efhz1XDd1fOMweqHNGOyAv1O2M7tAxoBTcjO4sAqhcTi1qzmnSLI6Rp5
         wCcJvbx6/FABBuuu+y3VfIAbehGQmTzuuLNou0qLzxCkqFh2BFHTsUo+EG5uqu05hInh
         aEjtsDAcywkn8W2YWLSXyhpd5xMZ0CMaHFJ7JQJOB4FiBiN54LlLkZwGXcktV7DILpUl
         cufSrdYujL39U00QfWTltWnMa4sVNyLiHhaQ51be9j1YDDDWRK2h2ykpuHGdN4kk/CvY
         yzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722435545; x=1723040345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+olOBTdXwD+ptqnBW2bgMxBC/rcIDKTtdk5vVlb2vLI=;
        b=Lx2jHUk7+5kYWLYB/M1q9cqGQW+sFv/p7PqXXrs5A5emqm1xtAyTxAFEgI9G8nc/Py
         Lml2TLq5ZNMHUXyRtepAwNsSGDmieigQL/TtIE98h1DDq1bqevwku/wfIqoEpPzsbDPl
         xk1D/i5WrJrD91gW2Cp64Qamcvdh+hPwpM6LCYEwMYcFix+hG5TSMWMjz+wq8/a5poHE
         tV8vs4KPDTjw380L79QoRUEBGvqkCuQVKvopYMV+Jz4xortzXwcLaBnyht0blYB7hLYf
         yRY1f3l/s0rumPQfb2ZdfyKQm/qVopxz3F9bb7zYXy8gxPT+Pq5RkBCBenBX9LeB8A+2
         3A0w==
X-Gm-Message-State: AOJu0YwFmT4a9txhw73Aw4gV4CMplxHgUy9dY24OliZrJrL52zQfKm+V
	BaBI/de4ARCAtxN3ZAFhXtEDTuTjfelKekHR+EjVmcklCxEzSWQ9ECVNL2KFGMro77p2spcIBnS
	yJAV9GWx4IooBHZ7zBcuckVcFPtfVC0P3CqkeTA==
X-Google-Smtp-Source: AGHT+IHaZW7cYzfTwRhs0thFGwdQ+qUnbaCYCKW3CFQH5AqF78fGOWlCFqSVRRM9coxyRFyVVFHB6SQjD+FOOJIzTAI=
X-Received: by 2002:a17:90b:1d12:b0:2c9:6f53:1f44 with SMTP id
 98e67ed59e1d1-2cf7e09752amr13328867a91.3.1722435544643; Wed, 31 Jul 2024
 07:19:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730151639.792277039@linuxfoundation.org>
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 31 Jul 2024 23:18:53 +0900
Message-ID: <CAKL4bV6aU9vqkUtOZtL282sUFEKLmo=TpttMRN-Tt79P904GJA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/568] 6.6.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Jul 31, 2024 at 12:52=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.44 release.
> There are 568 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 Aug 2024 15:14:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.44-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.44-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.44-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240720, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed Jul 31 22:50:43 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

