Return-Path: <stable+bounces-2556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939E17F8623
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 23:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1A528232C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 22:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BBD3C49E;
	Fri, 24 Nov 2023 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="wUlAz1XX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8849710E2
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:29:32 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cbe5b6ec62so1796619b3a.1
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1700864972; x=1701469772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtO7rC2KdoTCgc8G93D/JqXyAf1FXvlF8iNq8cF+6uk=;
        b=wUlAz1XXVOyo66hK6nzGENEESF5k6zkSHlmPgh+I1N46/esWvaetrdbNyP4J395dMQ
         4DowJ5cWY++8ArbZ7Y2feReBcmz3hC1zGzGoxQPXXblalJ4vBDrg+avTDVas7XMYN+u3
         1XxoQ5SszuQ9Ijg111gviCSnhX69kfGTogBstW3EKcYQkhnSIbp4qKUq1GwYjzf+uw57
         MKTDLkn516DF5786ziytnThTJINUmn5ptsI4Sk6nLCjDqazFZlRL4KjKLfvvxVAsDeeQ
         BN+cQfVnX0R10WxUynkHObNbd69OOr5cWLGlEMh7J7qVtBl0uKG/whBQRaU++Shoz8JV
         KEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700864972; x=1701469772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtO7rC2KdoTCgc8G93D/JqXyAf1FXvlF8iNq8cF+6uk=;
        b=Xzq/shpqqvLO9B+fQkRrx7Ho88zkqj5eq2TX1ptc9kS8ZVs9isoybtPpx50G2ZfoYV
         90HfhOwcWiuVHp25Eddxh5YBaUG6Xs1NzIZ1zPdP2lyBmrmWOzTWGb54uIRB/WbzuyAN
         PcZKLBu5GrboJJnK8qhbi/VWNvraE32ApJUu/Z+5alBNgJGVqhqyXMHfSqO8CWOHbThZ
         b9w2CNlb79zOUc3Ikk36qlyRbvcppiEZ1TIHsiooMct2S7VzAkRtRv58dqga3SY02/Cn
         6iepqfi1KCQS3QrburXCGycdHGzUGr+ceznCacS6QqLLbzqvCSHfto7VfjsgQUtN70Uc
         MBjw==
X-Gm-Message-State: AOJu0YyT7kLhkOtg414wZr4xvRrWur3tiPJN48o6L8NoRbaGdQXfCvEn
	KM6zLhxpPxQyW0J9Ja/vizsIVPwfQ1UlmkCkwh5SjQ==
X-Google-Smtp-Source: AGHT+IH5NbPttjWJkpecrastRq53qLAAtUK4Oazr2S/MEe65+eKyE/40H+jjaEPBL+i3tRuz7vCgnz3jR8yu91mspg0=
X-Received: by 2002:a05:6a21:3998:b0:18a:fbd1:8e1b with SMTP id
 ad24-20020a056a21399800b0018afbd18e1bmr5700264pzc.26.1700864971900; Fri, 24
 Nov 2023 14:29:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124172028.107505484@linuxfoundation.org>
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 25 Nov 2023 07:29:20 +0900
Message-ID: <CAKL4bV4T4ncGqfZB-qJO8TE3eoeSGsb+f9AXKsX1aUZOj=tPHQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/530] 6.6.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Sat, Nov 25, 2023 at 3:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 530 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.3-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

