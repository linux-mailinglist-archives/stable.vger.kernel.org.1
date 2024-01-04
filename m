Return-Path: <stable+bounces-9627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E89F823A99
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 03:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEAE2811D1
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 02:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7919F1C33;
	Thu,  4 Jan 2024 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="d0w4vMVG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CD5223
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 02:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28b82dc11e6so23986a91.1
        for <stable@vger.kernel.org>; Wed, 03 Jan 2024 18:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1704335083; x=1704939883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB51INjXiZAvQxQW5xjKyr7zrTy19sHnvauwLTdnqrA=;
        b=d0w4vMVG08p1dV98jqDXPZUiqsyaQ8XfdwuS2/pKJR6lntQMOAlLOFIsanJDf8dXSd
         xodzRrwWJhqMuJUMgeSZaPylfcH/HVDDxCLY/tJtyRxNdi9g8/3cg8YhizoHeBaiaGE8
         OTLGhn1zct7aXb/d5BSsyVVZhmaeERhu+LRC7shEiCV+sdd0LWIhG3fgfEwkLZqVQr1w
         g21TBQdt0oHePuumDO+y+rKBZ8KsPaS2EniSmCCspZdyzWHOBPjbMf1mBtJQHYxAJAbL
         cC+Rdu7nTazIRkbD8GCTvs6JRsfIKiBNhbShl+9R/nFwPGV99sDqysuM6wwIdAovcGaK
         uSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704335083; x=1704939883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VB51INjXiZAvQxQW5xjKyr7zrTy19sHnvauwLTdnqrA=;
        b=MPU1HjYRyfH6toOZF0rSMYgsh4DpOunV45CZlT4hi4uQNAvaKL2zjN71/+7K6zx1o2
         qXxgrV3r0Rls2NpGsOSnWIv2VKHb16tlXwfS0IJ6ky5FuVWQtpzb+AlzwtVsKmbmGfpG
         D8cjmgwEu9rf6iwiBjTKqTXYOkNsR29mb4DBgf+dJVedYHKwHGKi40dqMn9Kqti+aRpj
         gZf2OMQr0f0GCyhsJZsVrnuaJhcp2na1HJYW4HQV9Z+KbgclPXdsHxNq8ZNqOC+73UZ6
         FDwL/uMDd8T83mlJxhj1pUB7cLvt2G+M0iq7UXlre32xZSOeADRynrnuvX9QO186v36K
         GStw==
X-Gm-Message-State: AOJu0Yy9ekqkA4U1rOI1j5MNM+on5XyIZ7zSr5b9y6V7F/0fJkorkRT3
	sW43YO+zAiYEXyz7xnYOs3iTFdqr/ign8MCQuWWdXeTwgG1YkA==
X-Google-Smtp-Source: AGHT+IHwcnvw7WqGDCzzJmUK7XaNnwQlpCfti485n1GWpO3JJeg96VGxHxoTNad+Uelm7salPKt03E1s/Ox2oTQfsl4=
X-Received: by 2002:a17:90a:ad08:b0:28c:2614:2caa with SMTP id
 r8-20020a17090aad0800b0028c26142caamr12231pjq.17.1704335083230; Wed, 03 Jan
 2024 18:24:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103164834.970234661@linuxfoundation.org>
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 4 Jan 2024 11:24:32 +0900
Message-ID: <CAKL4bV7uOrnCVjKQp7rZ-KBtpV7sxpxHMc_6B0b3QiiHcrM+YA@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
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

On Thu, Jan 4, 2024 at 2:13=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.10 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.10-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.10-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Thu Jan  4 11:03:04 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

