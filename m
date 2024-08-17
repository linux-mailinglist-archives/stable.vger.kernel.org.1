Return-Path: <stable+bounces-69393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A9D9558E3
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 18:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534CCB214DA
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 16:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374EF154444;
	Sat, 17 Aug 2024 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxTC3C4L"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D264C97;
	Sat, 17 Aug 2024 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723911813; cv=none; b=Vyt4x8LVlSHTlFAPgtWhoonh9sW47z7+6PLXONlrsRkKcVyP0zhIQHE/5WSCQpzjkX4vkZbPBYZOhBkLfYYZKSLSf5dIhjTSVdMliAq7VY3wO87mR1mASLOWI5MVvABx+Cj4Jd4Ao+8YhW/aThpHvVCT2M4bF8+6JaHxURJDU1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723911813; c=relaxed/simple;
	bh=3mSY7NA4/PUj/9LLz2fLy7yTUnk+qaTQ3gAEF1ahkyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZxSw4i5CzmaN/OOlNksyAIiBj9kuHGlOTT3NqyWuMzc45f4bnwRhSG0irOA09AHBZ0rGzwFZfab9L/uL6iFAenIvM+10sO89WHGQDHgT+SW3P9fMFvnq90FOYZTubZb3p3VfeUIMN2dU3a9kZd5EDt5RsSwU9GKipdxuCKSWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxTC3C4L; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8430557e436so703506241.2;
        Sat, 17 Aug 2024 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723911810; x=1724516610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7xyaYPCiE8ubv3Fg2jG1lMbnf5Wxv9+LvazrJSM5u9s=;
        b=FxTC3C4LxaKB6N4p0ONmHIC+KkFZEMH9RH8whH8FKBRKrewon4a5lXF/qHla1MImYf
         0ZZAmjdIBrK/cE4H5+w/wwaBJqJEczp4Y4gHF9fazBl8eUoeYhJih2SQRwP99lhwFYgY
         y8JTyWkUeZmwUJ4E22BqANbv9PsVu7kdryhjwfEf+VfNjKPNKkr/0HOX7Tj03yxFRcMG
         K3dxO8D7mba6+XhSWYlG+MA8zyYwUqkvjvfb5KRqPAzWGSnEH4ey3fwG3lA5DFsku8D7
         aoWRt6sFnuQzZLriZl6jr4NmEdCGDeq5fKfYgCpiwcuOFRWHY9J81hPzGO2lrhklbT/y
         yLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723911810; x=1724516610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xyaYPCiE8ubv3Fg2jG1lMbnf5Wxv9+LvazrJSM5u9s=;
        b=BszGDJow+z92Pnqhgv0I4l8ecYZkoPLM1woiLXokleAjzPhv04zUSCj7btVXNRX2FE
         cC2n2yhxgLQApOC/wB0rmhsRuwY3EfmE4tiP5no/2na/LiuMXlavPaO5LZhN7StGb+Rp
         0FJv9yw85GkN8895PYLGf2UGCi7qYWeZUKo6PyxLn7Pv1dnCEcSR73bpamSMpVTPlnPM
         YJP11rsJJ3Bn07gpJmpoIsKhB/LKx/QUn5qoP7yGn18qPIkOE/f7IhjkyviWmrPrbnrR
         SqMMsve2qMln7yvGWBjRMILDnCEcO894YKyMoWKG2l7uRtlEzWst7vWilOYYv/urrM7I
         8xhg==
X-Forwarded-Encrypted: i=1; AJvYcCWALKYAIZ6S+IZZWCLqntMeSeXa74NELkD623mLOuTnIn7v3cFMf0l++mtfS1NdjQp9WxZmHlG69RDvjI1Hy2vBC6BWUB4L8F9cRNFU
X-Gm-Message-State: AOJu0YweG6hFcHELMsIhHKHzl8348amSZaXgNw+wmEUs8acDgg4/Rjo6
	J4AguTZcfoykS0jbDLAFPkU39Y3CsqrDyCw4w4M164wYctjCe20iXNx8Jztztmx5J5l65F25i9A
	E9rG9jHBnOS3qbC7bxpJ6OVG7eqc=
X-Google-Smtp-Source: AGHT+IEJIMGHi094EmzjbYpNVP7impLgba/aIK8W3VVjhE5Y96IHkNPKFgucWQwk6qFrDgFgFzrf/lC54fMRwNmXcsc=
X-Received: by 2002:a05:6102:6cd:b0:494:10af:2bc8 with SMTP id
 ada2fe7eead31-497799e6397mr8734377137.24.1723911810306; Sat, 17 Aug 2024
 09:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813061957.925312455@linuxfoundation.org>
In-Reply-To: <20240813061957.925312455@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Sat, 17 Aug 2024 09:23:19 -0700
Message-ID: <CAOMdWSJqAqTk0+RxzGrPvSAR492U9KdWpq8NGYB56BbS=2dWKQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/149] 6.1.105-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.105 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 15 Aug 2024 06:19:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.105-rc2.gz
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

