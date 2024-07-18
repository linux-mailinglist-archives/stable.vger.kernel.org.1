Return-Path: <stable+bounces-60572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7509350FE
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 18:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9780E283715
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 16:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AC52F877;
	Thu, 18 Jul 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfr5ySYy"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312E144D01;
	Thu, 18 Jul 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721321929; cv=none; b=X3nrF0jgzBDxiECBbe9AOvsKKhAVIWN7R+o7mJ3bxlTATfPkH2YftBzEHLLbDSE+9MBVvQdAWmdTw+SbC3eGzGzKqzinS3+qDy+zO86EuYWcu6wygdtsP2af4S7UmCAK/G1/GCZhqBAZ3c74ayCQ+bs1goS8ueFJ5700kFsgVKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721321929; c=relaxed/simple;
	bh=sPrkjq4MxcMtTeBM9AOiDMAaXq4/Evz6Mnhyir3JBjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoB2YWRS6/mGYJtHDYiJP8YtBr3Kui1tRPvB4GIHKGUdRtvucd9kh5GIiyt/kqfnSkk9atN1oy2LcDxsrkrRc7J+/DZjIuv2+0CXznjGAKqqvD0roOVSGaSLeSWUeJZh5yC7zfkvslC2o2dIY6DVlFns3hNvcGvNjP0D4FoloG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfr5ySYy; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-48fe544ce8cso288450137.2;
        Thu, 18 Jul 2024 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721321927; x=1721926727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iatpE1s6t3358QopSVpoJVx3bTQcHGBKmfVMA9RyACc=;
        b=mfr5ySYyJwjLYMzJMeumFni+hKGyXNzUnAVww6s+QpYU3yvIan+MFtj7e2lo7H8ypK
         J/6LRB2UEW3zWXuJRte3AFQbPIixu9HEAW75ZNM1NkO14lM10kiYwgVb8u7ZzTWExmqi
         j2KhiI8LKRe/QAFrIvuSvtKne55R8YmxssMxaz1V6X5v3YTeMYTFqcWv9vt2mUZxF78l
         izoFYLCnyR/KMZMYZgV5+Wq59ww8bt/6a08bBf0glK3uAleyoCUOqGm7s8ri7MrGk3eh
         +LErDoYQlorOIjjUbcROmrYN1gTUzOBu7YwddkGwKsMEpmKR6PC6Pj3KOOahXMjih8/L
         PFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721321927; x=1721926727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iatpE1s6t3358QopSVpoJVx3bTQcHGBKmfVMA9RyACc=;
        b=IgID3dzyvl/u2haJSTujI392w9lbkCBTsx48TPJmZ19zGlHCbPT169kr+FEmycvCnt
         aHiuZ+AIZ53zcaY0obNcGnh4YQ9xLsM6TscgDvfgKnPaD2KZj26rxD2hGferObjpMWYy
         Qy4pkGakjPGVAlX4YgpRCCA8eUL1VV2t9+VqpWkA96v7IwdgeIHEMx+8yGK8kff97Ljk
         kacH1OPU1L9CVn/Ihg5Tt9FXqHi6sRDRsQ7feXUO4rPeH2K7zaaZvtM5xWjGI6/wvest
         q2qmJCD8i+DcBQFqOxvSK4wMsTMHEpHSWchz4Uo1DHez5JfP1MSCJc49MVobPR4YYGCe
         J3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+U+cWc7U/aQolQxpYZmjYDaZmhSNWMg+tleCVxV/UaXU2KuSPyeeLuh9Gi7FXeTq3i2Gzas+10ZJpMjp3GVJhLET5vyUcLfc/XRER
X-Gm-Message-State: AOJu0Yy7CR7m/YGDl758qyJnFzE/dVkYORYrZ7zHjpeODOQbb9t8hwcf
	JK6xmOhIuT76EvG9HFnVmXEx/cpJxBFbWnKAksGbIwB1Hot/XYj0kudeil0KXkqUuPbMyuE/r33
	j4dTo8BTVHTndajtLbo8UlTSicFw=
X-Google-Smtp-Source: AGHT+IHLI2TTdbav+PZksYfVFsQFkSooWRDxySwqWAUzlJDd0jgmIdJpOeEu2mjaW9YxU5SVvf/aLAol4aGLiUS24Rg=
X-Received: by 2002:a05:6102:15aa:b0:48f:79de:909e with SMTP id
 ada2fe7eead31-49159849e1cmr8036750137.18.1721321927351; Thu, 18 Jul 2024
 09:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717063758.086668888@linuxfoundation.org>
In-Reply-To: <20240717063758.086668888@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 18 Jul 2024 09:58:35 -0700
Message-ID: <CAOMdWSK8dur4dx1+TRFjqD_bFu73+-nFMAPcEZCCuv_xtEr_gw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/95] 6.1.100-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.100 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.100-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

