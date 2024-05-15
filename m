Return-Path: <stable+bounces-45162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4568C660F
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 14:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0913F281598
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 12:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994CC6F533;
	Wed, 15 May 2024 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="HXt9wlOf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF45A788
	for <stable@vger.kernel.org>; Wed, 15 May 2024 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715774595; cv=none; b=Br0WByjE+YcZAULrDEDBka6KRZgSidM+uis88gT9NkBydpF9bO1y1O1Ier0IAdECnXiUrAHQa71xvMSw8Lz1qicQQU3YIpusEZu8noVzRimGgwb22mW7ozZldxE+UTgmidAylJ62y6JCig1beJOTK4g1GPPHMX3y/IGln5ZjCCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715774595; c=relaxed/simple;
	bh=cZULlQnzOZ2Pej2Sv06sBDw4hjTWF4t0tcOP2mtKUnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvmKlpwmD7Xu0BMSnQovBTB0BNL2lNatu3uo2nas4P67yDi8E5v94JuofMas68IC/TEDAnoV8YhJG1zGHQ+1Zqh/3zxR2iweQ7qEi0WMMYaDWDANs3EBVS4YbloE802kTtwwklDq0xWMtyok3s8vCCjc52MHGGoEqfiHujiBDHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=HXt9wlOf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ee954e0aa6so54229995ad.3
        for <stable@vger.kernel.org>; Wed, 15 May 2024 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1715774593; x=1716379393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DcB2okqnAgkynFg9jcCuDayVN3zRAZHBcQStj5iFBs=;
        b=HXt9wlOfvs2sIRCSWTFaAjblrRrOvJuDvO2b0jj921ZVX171pJfznv4gg1GbM2ChQ3
         1Eli4ccfayEr4h5692lDV4dw3qJlzO6Ge+ZEFiFKmGMwSSz2XcSO2sNuESJtg9M+ygYn
         LMSfq/+xtllH4zUx+YX+P1+tgRCCbWQSYve8vCYIId7vooCR5DcGplIsevzo1OubgYez
         36Xv5TscXEy+rXBBYwuyOvTN5nWkzZxSrqZ6Gi6B2a7ik4YIqg9pe9Mwp38BmjaNl2MY
         U8iamyKj3xZs8Pvh+VcuWZVNtjdnu2cxDCfuf2fHNwjvuEADflbf3Zxxj8wcaeMT85Yq
         4qOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715774593; x=1716379393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DcB2okqnAgkynFg9jcCuDayVN3zRAZHBcQStj5iFBs=;
        b=WhqL6tDW6aMwhrhcMtvQQ8ECwlhxYMKEkMw/2YcW1Em3LJmIda8UxXZu9Zc67MFgYu
         fvfCox06fP0kK6ieoAz8GZiVH2u8b/NNEWw2Jw0cX/sKQnsfyvknIKJqe5WhClXXFxoV
         fwBekp/N8r6wpzifFi0Xv4nU9QgK4fSuzqYytVGsa77K5+Fei2ZWMU/Y51coqZRWwZ0+
         WN4p1IwR0Ke6d8HnzIg0hPsGDh7d9rzh3WZ9ERUSYH6PuC0V0d8kHKorq9omzG/B9xcQ
         JJrTIJiB4rOed4KLSO9JCVnxjru3FHNa7LnSWHBvsQlW/Zf6tdDfW5TLXbg5zQ7jT+mI
         jHGg==
X-Gm-Message-State: AOJu0Yx/ku49Z6o3kXY2w/pGuhjehOKP06VRgvx4Hl8EtZl2k1Wmme+o
	TGVLP7CwrGRS8lDXG+9ZmEDv0T6hDjM1sTFMr3CWMCdSpkHDHb9Gipo28oIrUE26uCkQhuN/dCt
	fO9hIbvjBSMDYyQmlgS8A0WnhTAdIpsjo1ye3JQ==
X-Google-Smtp-Source: AGHT+IFy3gmVgZkNpyZFzjDzx0VAz+u8/kXHpLODxZzc9kj++XjUCO678HSP+AFx1+KEX/6z3WmoITL5ipamNpy1768=
X-Received: by 2002:a17:902:7d95:b0:1ee:b2ff:c93a with SMTP id
 d9443c01a7336-1ef43f3e4admr144321025ad.40.1715774593154; Wed, 15 May 2024
 05:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515082510.431870507@linuxfoundation.org>
In-Reply-To: <20240515082510.431870507@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 15 May 2024 21:03:01 +0900
Message-ID: <CAKL4bV5YkLqnZJsLB6t-n0ZeSSZAHYsaE0c6=-=ohK8PBG8AvQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/309] 6.6.31-rc2 review
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

On Wed, May 15, 2024 at 5:27=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.31 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.31-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.31-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.31-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.1.1 20240507, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Wed May 15 20:35:08 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

