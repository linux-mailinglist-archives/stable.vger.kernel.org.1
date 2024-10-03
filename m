Return-Path: <stable+bounces-80688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C57A98F893
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 23:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C772835FE
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 21:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B43B1C9B71;
	Thu,  3 Oct 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm+cBKxb"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADF41B85E0;
	Thu,  3 Oct 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989610; cv=none; b=ujRw5bwklCZ4k1uYQiseFisIPQBjlOk8ufhasNXsH0+enqKIPMe18rXo19spkTYqzZPsNgI9phqHWyN6RTn0Y37s+eiGIx0wWPgITTegQEDJZ/KZyqwi4HLHiKolFpWVTIfzoiZqpFU9YpvZTJeLfCk825q2zMFVtFFvuvrwx3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989610; c=relaxed/simple;
	bh=ol/+aWm3RXmSOdAyVG0PXsSoMwIO2p63dptKg4Sh6J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXw6AQeJIX2LICrWoqXh6I+86Mf4xmvpphdc1r6BEod1lMJEXlWMXCr0fNevq4iGSHe6791cMC+EnpCB1+GamDndo3ufE5YY/iszmMjsLxTH8QnNqS+XT11ZRP5W0jOe6/ZLU018/TILFtnxMFMoO8MIRKsFZPrn/BM6qCWM9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm+cBKxb; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5df9433ac0cso677603eaf.3;
        Thu, 03 Oct 2024 14:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989606; x=1728594406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q8968dxVOOGrCaJH4A89jcshoXoU0BkvZ+8XBq1T7h8=;
        b=jm+cBKxbcIF0qNXOefsHnDP8z5GEhXQsaUkc8kvKVzOC0zjymuQ32CSOZrc3XNGBve
         /o3uqxJzM9I/5e09eJ6wo4Dp0cX3onVyqE8PUZh/6EtHSrpxNQ9K4TytZT43Max0rFQO
         sSZrhNv8vlgrXK0p5Tw4oIk0id8gLECSLbkC2cawN3EnDnhLTvcpBlrFmpTrsmKjD8iA
         PPPTj6TZT3nrT1fYBGV5O1jiODfGuSJSNBojMh5fRlKDHfqg9M6PlEiIlsvYCynhboDh
         S9uYtAXoxBbdv75/Ftw19mIgQYqjCWENy36jZM8gGKL4921Lhc/0+lgl98f/lC4k+Mr5
         uV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989606; x=1728594406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8968dxVOOGrCaJH4A89jcshoXoU0BkvZ+8XBq1T7h8=;
        b=gvFDwu5OFO3WMKDsFbdCscdJmF+c12Mx0TVUw0TY4BhnBia1E8G4AQi3r19Ay4tr7R
         zSvQzrBxepKlNH8eiOh9cJPjMV7d8m9lk6zzzr7inGaHXr+9YzgESB/FtgmhYsVd2y19
         sX37O4bnpBxbm41T155uOvGfC+TMCTXFh19ylKsQyTjR6OPRPSTTEXPBKKk5/vijXyPs
         BxAvyIogG0JYQgniduRVtxLVpCgAEel3BzxuFAf3rGEwWSmvF/LGPEwwVLuFsqXYNrs9
         m0qR4iUraii8X2yoIU1rCk6fNmLJL6wuBkJqfD5EpbT9d+bj5DJht69bhTPkPVO8GiHe
         Zd9w==
X-Forwarded-Encrypted: i=1; AJvYcCUFzAWblpAI/KFsg3qE56lhehpWps1GENPBHKg4b/EDlat7MzfPXuqP5i8sqMrJ7CiT2pnQHsnjz7kttsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkxq/UtVIKh0uuvyFvRDoYRrZSal1I5G7hactP9EilAgz1u7NB
	gGINjilpXLrfnUCpMpjW3U4QSlyaPq2yGr282bHl1VhID2RcVMbs3edyoD4PmxsQV2RzLSHqmFQ
	35IH2zu1upylyBCp7gnVNcCpZg57citG2
X-Google-Smtp-Source: AGHT+IF5sxcLBv45je3SkotpU5f9m7oZxQlxAwDwlb12VyV361hYsxVRbYWq3YL1qFjNZEqy6L4DLZFmSo04X7eUlHw=
X-Received: by 2002:a05:6871:813:b0:287:34a7:af9a with SMTP id
 586e51a60fabf-287c1daa2c5mr674457fac.12.1727989606522; Thu, 03 Oct 2024
 14:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002125822.467776898@linuxfoundation.org>
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 3 Oct 2024 14:06:35 -0700
Message-ID: <CAOMdWSJ0io4Nsgf5GTARYcbJpEAxTq+VEggiQBG7iwCT+rCb0w@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/695] 6.11.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.11.2 release.
> There are 695 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 04 Oct 2024 12:56:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems.
No errors or regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

