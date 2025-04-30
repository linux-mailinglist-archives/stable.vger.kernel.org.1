Return-Path: <stable+bounces-139086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0588AA4106
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 04:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B2817A75F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257551C7005;
	Wed, 30 Apr 2025 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="GrLCfrbZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E26E34545
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745980826; cv=none; b=dxY7pFlg9U5PYN/GNnhHeC17lHzZTqlcIcX/0XVYnwfhKT91U2+1T+d72QbxBX8d1MvcKhVwtbhtmrG7lm+CymtbP8U3TnriEuZMXYEnZa4CjhhAPv37tsiDuTuRG8Owg2mG1KAQODbtP2I1z4MZ9hUZiWcUgO342AZ7MuYyNjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745980826; c=relaxed/simple;
	bh=mU7mJLta1RGfF4yRKijsEDRGNM67H19F80CUaYD9AHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=suhtzN277Q0mBSjd58ma+Fhd3BSdTLws6Ux3sB/ioLVcWDcHU8u94p84ZejmI1pg9KJ4O+aahnESROP0TF+E23HUMhhSuhqLnwhMCoOGGpzf0y0N90hFEyFT1QU3ySXDBRFXp79ztvunbWmumPWSTOVhLvANl1Qg9AM6W9C/r5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=GrLCfrbZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-309d2e8c20cso8267373a91.0
        for <stable@vger.kernel.org>; Tue, 29 Apr 2025 19:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1745980825; x=1746585625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE5kHfQorZNaYCIrdId91DC7N7tm0kAhCZ61321pEas=;
        b=GrLCfrbZUPX6psjmcPWiqVHL+Zqm8EZW8MaIa6n7iNMmVxz8CDmC0ZI6PT3zWUKLIU
         sMqN6pD01ChvcfhvWS2c01IxpbCoV6Xju04g9oOj07F2KGgJefskusGJUyK/EQ87BDpc
         zfk63RUj8TBPYMTpyywlcGxFCtR63ry+7ONrnfrdIIwk8trfBOjU8DAIBlriB5HOSPFE
         wc/j36JpS3NXSTbqZKbb60gsW9HhdcCsLO5sB2/rdHEitdK3sHnuADU3XZeDUS6CvOq4
         1FTFn7UbehzQd7T70RGlo7UKExyp+CUxo71aQ2glb5cVvGvyQO28JA+3m3u8aEEhuM2/
         40ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745980825; x=1746585625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KE5kHfQorZNaYCIrdId91DC7N7tm0kAhCZ61321pEas=;
        b=Z9mdQIpCiGprFz6JaZx9ZIyPZWfI1yZ34B3v7Ell8aUs5+yjKsAaWSaD8k215NOgM/
         HtjNxsZ35wriR6H8yzP40eu8bCjYH6KauEoGNzK60kkKSqmjZ3fe/iIh+S8/bwOSM+UD
         nxz0eBVpLZQCcLofuQSh/oTmeJj6i1K9Y4IhyF1eQdywtFbr/pobywO7yYeNu6mL8CTg
         f9VXR/FuilS4vtNGLaNYdJVnGKoKQa1ccnxMLK2kzVti/2L0QiXr+7nT24doLQyVXPSR
         5w1gLD4iFBtIHRTxQTjLa2ipbLmIhrV6Szgb/3QnQJfSOfACisyLPeHhbogXzc8nLEko
         Y5Qw==
X-Gm-Message-State: AOJu0YwzXsTMjX/jWPM3yppdtFNG66RLDcWrDvBoIDFilCxDjjZTRjS5
	UmrGY0EgycwrBdz5WEmcIsEWLnoSocqjy+NSu+0Bj75mD8IF6vrkX+JgLlrmTsAPipi+e+zGlwD
	Fqs4rXTllMY8BpRxY7zoSebNeFkYDfNahz2SFew==
X-Gm-Gg: ASbGncsHXmk9ERwSWEunWcXFYLWVa/x32tsx/0PAdVY4DjH34tbF1md2DAjMlVRkJVC
	m+ylw/iU7C+M6Z8tWgWQ4836s2xZrCj/PbhQB4H34C3uDd++UK7CGMGvbTyX9yd//ncrPhsnYzy
	7dBkPWWYMQUvRoYhKjXILsbw==
X-Google-Smtp-Source: AGHT+IHoE0eDvAqSf3SZxWvSFjBHfnIh0KE5oMgeDFXJL2YDQ9zk2a6IYWGwd91OMiJ1GIcoG4YuZjdrlL1l+W+2Oo8=
X-Received: by 2002:a17:90b:2d4b:b0:2fe:b735:87da with SMTP id
 98e67ed59e1d1-30a331d4e32mr2569324a91.0.1745980824704; Tue, 29 Apr 2025
 19:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429161121.011111832@linuxfoundation.org>
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 30 Apr 2025 11:40:07 +0900
X-Gm-Features: ATxdqUFGhSy1JnAQnnn0wNQBiX4TxdyonVv9lW6DvIqy86SE9Iy8dhorxCLC82k
Message-ID: <CAKL4bV4UVPgNTS2hS02A2BgLKBUyFjDKawHWK+oGQgNd9jXbXQ@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/311] 6.14.5-rc1 review
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

On Wed, Apr 30, 2025 at 1:55=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.14.5 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.14.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.14.5-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.14.5-rc1rv-g25b40e24731f
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Wed Apr 30 10:38:19 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

