Return-Path: <stable+bounces-60459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBD9340DB
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 18:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DCC1C2140A
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 16:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0C11DA3D;
	Wed, 17 Jul 2024 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hzc6fVK8"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A217F39B;
	Wed, 17 Jul 2024 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235431; cv=none; b=iOwnzOjZekXDO7syp1J9BrIaIfxRGkyZdVQhF50ZX5wsLLKPgosvUNx8zB8zMLPHfRPcFv9B84qPD5qaLkM4n38mcR4Edoi1NtJx5sN6slKjNlY5Ku/jydvVruKfPt6msTAp5ISQkxW2syiHFtL5GRTRhOHXAVMd86z/9RP2phU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235431; c=relaxed/simple;
	bh=WQoupIds/WAgDwHlqyBKda1KmQUZ6GZLIpDvamuo/EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0U5pomkSdsTXF2e1S21nq+K5R60d7oIE/nPkrMPR4km3jNWh0TTNCbmJ+FqA/p1qIP7QPloA/wRXQGIxw9pcWBeuAgEPddIJ2oF9PqU8lWwNdFrSY0IobO77ytOM2n/5LGg2E2dyib4kIPn/y3ITQOV/K9vraeAsItZYqgW1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hzc6fVK8; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-48fec155a0bso412935137.1;
        Wed, 17 Jul 2024 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721235428; x=1721840228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mOOdvHJILnLqKxW0K5N5eQ51awOco8Au7VrX8zS/IhM=;
        b=Hzc6fVK8kr8zhyflpkC/7CcOQTo5qNqoEqnSmhtqPTfyjU0Nwdc8rSyMFyN7gV7zRS
         Of7Bm7NwoWMawHtQ/8C84oXIcV3/bTSFaxtu09FVmXwlfH17NV9X6xWGNVebWzvv2Yfe
         3Rez1qXLdg7WtMGOuzxiJ4godt/ncnxkgRLnt+2nX0suOSxsPVm24FjdpiLhVO45nIs3
         gCEp0PFNLpST/2rg0i2P0R9YeHSltTmcS/IlWrxOegXVXX6Pu9WIyzvsZG1+4JIyCSn0
         kGdbJAlPjZSplfPB1da+JTbnXtaNwLjwaAeLmUrslccRQOmPw4UZcBTj9Q59k0GH/fja
         nnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721235428; x=1721840228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOOdvHJILnLqKxW0K5N5eQ51awOco8Au7VrX8zS/IhM=;
        b=BRrebDBN0P5HoGcY/yrMz8Izv7Rt8HqNob/DcYhymWu9GjDKgSQb8ImTxCndAVwv6o
         qGQ97zz3TdrODxqllhkW/vL13X919stZ4nWWm58+R4jhQyuEutd+2KjvB04IcGPCoL6U
         AWlpuUxisFoA65bOGJdXeWaku3k52D+kHWlbWhhBadIGWkIhNTYRkYJDY6uKa3ODcBZ6
         3AxNP2V/XIuonLpViLRuECOnqwVP+hL90W1tHM2XXSStybxyauxSXiHUKQsw6PNynFZw
         h1zk++g6ThR06h2SJIOBqtMfEOrQ/8Ix3IS1vN22gMtBw7ipYMVTljWroLTL8Ra5xPFI
         Z1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVviG1VzLb13X5kUV5yb9bh8k7IipTpcyFtOPsAJrrBSUvr2zqKoArtxK4Ns/UruhqrM3ul7uv1+I3RP8p+eAawBpxhD7o0qQTpv9Gm
X-Gm-Message-State: AOJu0YzIep+jngXVdUUw8dn87U1fbCf2jAawdopmcWy/FyU4T+MVpCzy
	N73FEtHn6Rjyv+VyByRpcTIjgRF7vXO/Ie3L5JYSdZJWDzjihxNcyXTWK89wPsLTlZy6UnmQov8
	jAmjZQUyKZcMQHG4RNNX9Q73oMSg=
X-Google-Smtp-Source: AGHT+IEZL6tvedU0NKmu8UAgB1HnO4jxYBM4LHwmkTyVVnItZrjDVOUl6cM9k4vRqtb8aLxZA0f0LakU/5KW540q+74=
X-Received: by 2002:a05:6102:3348:b0:48f:39df:2d8e with SMTP id
 ada2fe7eead31-491599acbe9mr2869265137.19.1721235428516; Wed, 17 Jul 2024
 09:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152752.524497140@linuxfoundation.org>
In-Reply-To: <20240716152752.524497140@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 17 Jul 2024 09:56:57 -0700
Message-ID: <CAOMdWSLkJrm2cOx-Ugk9QUCXWB3r+N4tw7Y1ZjLsfTm_ND_juw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/144] 5.15.163-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 5.15.163 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.163-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

