Return-Path: <stable+bounces-60570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538E49350F9
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 18:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849F11C21B89
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 16:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E60145332;
	Thu, 18 Jul 2024 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0OtqhnX"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F17144D01;
	Thu, 18 Jul 2024 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721321811; cv=none; b=rP6CRR08OYWS06QTAzvWql5zDCJY/vUtqWpwMFWA4eMRfoW5icQffSQffMOkLNEbZ0c3yBsj9yEMXfixlp6JcPv29RcCdWhFjX0OxWGFJR9xAsiDcK3p4QDivB0D0awBVe/rJCXw+dhp7JSSrQu7H6qD8tE5UFgIw0dfIuetJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721321811; c=relaxed/simple;
	bh=vNycuE6S7BuQIAvXu3VmSLPTI+xFJmtdQWvVxVWu2Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RieT1M8axG5eOG6cxqV9SK08HVZFyaSCxAAjA8J8A01NBBlo3LHGfaQjfVGBVZCrkNXcyVaLTLHBTGpHpeJ5gCi1tsDgdslu7WxHxinAmSCGOCzfUHSMA8hXhitxWNmfMRHKMMCfClqffZwlzIWee4Vg0fzp5HptJhoVz0YMYSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0OtqhnX; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-48ff19d7074so434045137.1;
        Thu, 18 Jul 2024 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721321809; x=1721926609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N6aEJS3ZPzDIEoyWlBsShm3zWqq8TNQ9J6QXNez4EB8=;
        b=H0OtqhnXCMoq4ggDGWWYoNJijliGkub56FM9DCdGA9VSF/YOzzvmwPUfKiL7NX1hxM
         5TE32zZhy6Ep2kQAz6yOJH7vsTNFCQPlJVi+bdB0Bkqqb6ADRpbZZiM4FlQDDCKHKjey
         3Kpz+BiQ7U4nRo7pzjWG1gqyQdeCruUMd6sUwWeztKyQYGE5PSZLgfYg8iLntrWW9/Ik
         Vid6fh1nlJK9ZtTeLlxQNx6GBrxEhz5JW+EbsO5j68MUzvN9wtCAu1A4dpGhuduP2Qvo
         76LtHtdmmFLYgin+G72yp2bCtbGslbswDHLmFJmi9tY87X3k2PEJfxyUbwZTau9YPH4S
         a1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721321809; x=1721926609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6aEJS3ZPzDIEoyWlBsShm3zWqq8TNQ9J6QXNez4EB8=;
        b=r9/n+HYdOJybw4Z1WSUqDZiQpLng8WAQq9HwGK+QPjLVLHnvavZj1VxGzqTPZb9a9I
         c7/PEuN1ZyW0BR8gs9woL2yL2QhNFJc7AjQJM55TrZW2jZ43TZz0sw+QoLSKWNrilEUF
         Xh8EhH5C8thXW2639hIvYqTVMxniGCaDs5GN5oHvgvOoBDzDivVY4s/hIhoGy0yjFA/S
         5aG8qtfhYUO/58+akUROZ1yo52R4OEVz8pFZIA4N+dmO7wU2MvC+hf6Ql6AxaK2RJ7qC
         QySOTsd0bzFjpb63Y25dFxYSeauoLJwXy7JALrqCHJDDgtDvIuwlSPtj48J1ENgAlE9R
         L+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJjTHksKGEK+yjGvpe//3oNf1VnKu1zMBLsyPI3bNC6nmDxDBS3MHTlqXzQ1/agpcrHUeBdeYdmueABvI8KhLTA8ldutihfuQBQEi5
X-Gm-Message-State: AOJu0YyDhN3jydC4EshSxFD3Txs31D4Zuwg+DP04xw1gzAn3luaT5txU
	gh1KzQ4dm/ynskMfqKtdm/vnjvj6vtB5Z61tI2QCur9xXggagKmdprwwFmGbPjaYMmetj1LTkA/
	rpaR+z8SLAaD2Vfa/zfukAWXgsO8=
X-Google-Smtp-Source: AGHT+IH58sUM9LXnjs0x7sBz5rke0fe2dE4msxSSDtym413q2u9R+/rI8KIso2MhGpih3P3gSU8uXTXLmfdk2Du4pFk=
X-Received: by 2002:a05:6102:1517:b0:48f:41ec:b0bc with SMTP id
 ada2fe7eead31-4925c1f2030mr3820256137.4.1721321808974; Thu, 18 Jul 2024
 09:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717063802.663310305@linuxfoundation.org>
In-Reply-To: <20240717063802.663310305@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 18 Jul 2024 09:56:37 -0700
Message-ID: <CAOMdWS+V=Z=8dfYd7bF+=yirzKtg1g5GqzYZ=bSZKKCT9SAomg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/122] 6.6.41-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.41 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.41-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

-- 
       - Allen

