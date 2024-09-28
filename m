Return-Path: <stable+bounces-78177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DF6988FD2
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 17:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755971F21F33
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462FC1EF01;
	Sat, 28 Sep 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOev6hCX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0790117999;
	Sat, 28 Sep 2024 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536002; cv=none; b=DVh5MenkdUCIRE4Nbdyq9XDEf4A5OEdxUfY56XdeQTkFKpv29T4J67W/mbKAugrhi7Ou3EmB6k2Wt2VumU+zGpldhvUDwq4OK6QIiIXfxF6rcF9ggnvqv97jlJj0LhMMdO+9FyICACEhb07JJrRczwjDYNtjNWWL60ZB1eVZ/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536002; c=relaxed/simple;
	bh=X7PdJX4K9/BBDN8TWCr9zBTBGVYJeM+Oicw1FAwRG7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpTlwadaNnXOoWs04CGe0hJpw15eXpudwD+qx5DRGgnYU0osw7sKMu9HtbUIoepxrwjOo4P9txNB8zXZrp4HmPvFRdn2DzREY2zeYBkEvkKxvrenbqIBKidn1iqL0u/ih768uxES0x1jwX8y1C+FlFlc1EndxFMhBM9d2v4UXBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOev6hCX; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84e8028c47eso975399241.0;
        Sat, 28 Sep 2024 08:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727535999; x=1728140799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5/+JOHh40L6mwhVe3jkLJF3MLF+SyUORnDZxN+djnuA=;
        b=aOev6hCX6VZNcKOagjRKuYUUsUIaBPRA5NBPEjLe0+5oDWtzMzV3AzKwqpuPRi8njh
         mc3WSpntuZ8m4EM1+u54HRF6CdYbg46Xrcm3qMDcsrtbSp3lvPPXaeAAcI2A0w7SEyBP
         2X+zxA73oEmwpwYEKI3CV4ZT5uJgMWrkesoGQ2kVR/BvwOnwMssWbW1BYqC4SYIvRj2U
         vsuPP4HfhltNlMj5l+gIfR2qhT5XziIkPeQiKOQrcxndRIttwtN4iuph4KvGq4uoCCEv
         0MwhD4TqscPxBse7Yr3/7NsoQ61JukanthQ5y7sqFSE9F8fiIHXg3XeN4K7q79Q2pS4x
         V/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727535999; x=1728140799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/+JOHh40L6mwhVe3jkLJF3MLF+SyUORnDZxN+djnuA=;
        b=oUQeBa2N9+np+dvGetVEQVByAUuIM6TFWOTAedQk1fFA6GCaRK5JuOnpCf74MuCGlC
         FMq7yV6ExVraTd0S/1bjnpGKIwkPNEfXlKxXIm2ClWu9Hj/0M+KgllWiBvjRXLmOGq8/
         bxCcLIw+28JN3tTjI1YxSOgXBPAS1AX5Pv26vY8T0lwi6urTU/pdpAPTOMkiaK9RVNgl
         wFKS3NVhl7NuCK5S9ZjhUCcdTrV12gAGmsfk017QqJgBMnSH6MGTRH7jVPiqsAA37xRJ
         iNmUv1KOFJm/QJONkzO4giWYFKaS0VVvcl2SG2ODeU7YrdEmoEWzTCxMT0bpWxl6wq4L
         2wZg==
X-Forwarded-Encrypted: i=1; AJvYcCWWX8aGB4DXc4XEAUAOylRleIOsuwvWxz1dehx8rEoSpTG5/xzCAUa/smt9Ase4ljWlZLgvbv4VBrvaR10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzrR2u3k0ke1D1tvZH9zYqFCZGLj0eIE0tSbht3Z9XSVU2BGat
	P3iNOk/+DRy1M5ZNqE7fvTUgOVQDu219X9LHNMEn/ok2LppbcLFtDBBCZG1CHwe+m6m4AzPS45H
	RgfYPqF1+kfiYiAN0S3QSxUi6Wjw=
X-Google-Smtp-Source: AGHT+IFfb21udVadVrbmwymV6FPQ4mDbiMTYap6Nno/n7Y+0HI9+sf8i1iBohwFWyGux5tc4HiyFIj5OnmKIzKP/bps=
X-Received: by 2002:a05:6122:4597:b0:4f5:c90:2556 with SMTP id
 71dfb90a1353d-507816e69edmr5229848e0c.4.1727535998813; Sat, 28 Sep 2024
 08:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927121715.213013166@linuxfoundation.org>
In-Reply-To: <20240927121715.213013166@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Sat, 28 Sep 2024 08:06:27 -0700
Message-ID: <CAOMdWSKcdV_SviFS6GVU6Q5CPWe-2AiG4FsmYh1c7qEm__T_9A@mail.gmail.com>
Subject: Re: [PATCH 6.11 00/12] 6.11.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.11.1 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.1-rc1.gz
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

