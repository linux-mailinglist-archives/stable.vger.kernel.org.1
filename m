Return-Path: <stable+bounces-131921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 806D6A822CF
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 12:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9761E4C120B
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 10:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0926225DAF3;
	Wed,  9 Apr 2025 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="t8lnxbbY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC825D8FD
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195973; cv=none; b=fVlRwPyuEAll4Iyl8wh/KmaWy9ZLfleHRzZrDWJ8G9VIKOci/SpVXFeZun/aaPA+wB2LTidqRx4JAJihFPxTbKbQpXA/UVgCk+ZUtWIBIMydLMQHQb8JWOMhsCbBUk7g/FpUMPv9GwAP4La/SvpR9p0RDwiCPRtGyqV6BICzcNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195973; c=relaxed/simple;
	bh=j+uEOn94WeDJ8rRSksBy522NBpryi2/Dt/AiLrHWerw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFz/ILJGDlxDLo6wQWSTrHoJoMbZt8uZ+ozdY38aO1ezn0ebO/166WF+0dt6lv4ufAZBVsBqe7PrDAdXdPN+1ZEKpy/8vMQqTpmKUv/sE+ZiuaUxeLemjMDYCOH/uwR3r94IG7KOwoB7xmlA6dBvnT9IBV62Xm/0fNCBFxHmLKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=t8lnxbbY; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso4886021a91.1
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1744195971; x=1744800771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP3mLYDJdiYs49Wy/ACTrdIEYtJ1MffPrsed0RZQMck=;
        b=t8lnxbbY8efZ89A+0sbiouO2Rn0Y/wm6UDmMaYVkAVcCFIgPqn2yOBfgAnFTmrkFWF
         8BD8SvxSqL0pT6xbt/fbnSbN2NKs1pyAudGF+kFp+h/WfIXjX3EzkTuxwEYoUzqf4Yst
         K2sxdpV9t2dpMLh2CYLlxdXTIgFJAKg8slx5W8GE8GDmAfPMhpm6g+a5UgpyxyARAd6T
         m1igdCXomQIjGEu0rYW7cPBbo82onDnZiOB2JOYGa2yfESwrgNf0av8/WTLrtOzx4OOF
         bwHi/53PX8Ayen9vdAVN9ofUKhw49VPnXQ77SiNUY4drhbCF095Q870xCfHvYYrFzVst
         QEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744195971; x=1744800771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP3mLYDJdiYs49Wy/ACTrdIEYtJ1MffPrsed0RZQMck=;
        b=qJL4jxZekRBngWWeShm19JLz45HC8CZiFZibq23ceKdQ2xDyBr/jLpa6PoFowjR2W9
         b+I6enZ77n6q0VT1yC2SrbyO2fc6R66WXaN9HRkANvVzWCHGSlHKtY3DQgGC651qwwq6
         wcs68u91AaxDjzZcRI+UWkrUaEbWru5eIX1EdUzws3CgukdD6D3dIwZKvD4Mg/MnhFwy
         +SxjFDtgYQqxJ4ZCRKR0OCk8kCMsZGq2MoZgU+06UCaBENoHTh+KrKXXfCjHy6yPFgTj
         eNUGghHwcC6W5WW9+y1gxUjLKRqu6bM8hV8vQRt9DuXpx9z5fQq3OyaTwHXtqTEu3ddm
         Lk0w==
X-Gm-Message-State: AOJu0YxmbhlcUx7KHzb2R85F8IcPzD6bQVS9vKAHj8mt8fuW8Ji2jIQ3
	9S/OEYXAcFZ1eLqk8YaustbZ4v0Bib9S4O0bjbKdvxTQQvSXmYan7onEDMbLvjfWkKhqO4euWvs
	UlWHaUHiYGibzkJyJCjxWBLq+gdXZhOTEmIqpVg==
X-Gm-Gg: ASbGncuRfjT/wpri7b2zI38fVZ2GSxANiDGWTVtICDIX4UxxZd3xqWXZYwBQJ3JJ02E
	hzq9W0OkME/aPuQ4u/wqTQwlhAB7Mf9ItiZ9t8f7RPiU/iU1HZ7w3hNLGXvuYmGxZSGjCQrz3YC
	tgZ6ikTLgSm8GYphsMBL87Lw==
X-Google-Smtp-Source: AGHT+IE8q2Fp7m5nIPPywP2omnIJkj+8unBb4Xhy4pc3ScTFmwB7HP+RqNqLS0Q/9/FH/M13aISBQjE/oCpdYRuqHDI=
X-Received: by 2002:a17:90b:520a:b0:2ff:58a4:9db3 with SMTP id
 98e67ed59e1d1-306dd56b573mr2623679a91.35.1744195971569; Wed, 09 Apr 2025
 03:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408195232.204375459@linuxfoundation.org>
In-Reply-To: <20250408195232.204375459@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 9 Apr 2025 19:52:35 +0900
X-Gm-Features: ATxdqUECQ863JszPw4BKDGauaEHrGOh4MUsIOWrVopMSy7rYKfjkRIj4B0RxQn0
Message-ID: <CAKL4bV7inHa+o4mka+16qqdxxQvpKFj+gJ6mfi1uzHrXZp27TA@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/728] 6.14.2-rc3 review
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

On Wed, Apr 9, 2025 at 4:57=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.2 release.
> There are 728 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Apr 2025 19:51:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.2-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.14.2-rc3 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.14.2-rc3rv-g5bf098994f3a
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Wed Apr  9 18:59:40 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

