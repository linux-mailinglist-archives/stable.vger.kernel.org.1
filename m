Return-Path: <stable+bounces-64804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BAD94372F
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 22:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B886F2839B1
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 20:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3641607B6;
	Wed, 31 Jul 2024 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4xxJCbA"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB493B1BC;
	Wed, 31 Jul 2024 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458335; cv=none; b=IutwnsJanqW73FXUNgLeWko3beEe1u0j9i2sqQXKTq+yT4y51rOI+W3FkL4Cs/SsaB0tyThiEzBE5FOwdRylqbwaMhjtJ4OxdPLsCo98oWkIIyXcDcGNsFpAeP3S5+dYl3ponRYc8Ig6NhSnwdwaOSa2HYe8R8NevkzQd9+CiKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458335; c=relaxed/simple;
	bh=QEDj+lYmdYwZjGej/erR7EUZaaRmzLc1Ns+v4v5sZQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjzgYVdbyigsYp3cJTHwcHKaw+5ozWSC6LDPMBLGH2c+BJYyhchJYz6OwaRUy5+gUxKoYAoNKQhpJjmoiDgTEZxALggjLWLaHLWIaEEm1vjOD5D33ZDW+H1yKsd6ghDX2t9kVG4OZ7rXXZTDHmX2oExv8Rh0XKm+oHK/Ra5SmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4xxJCbA; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4f2c8e99c0fso2108547e0c.1;
        Wed, 31 Jul 2024 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722458332; x=1723063132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F5NFLGE5phJ2Liv5ktsunuY0p6FQr//tugyI0Kha3qE=;
        b=C4xxJCbAiwar7A/U4GxoBcn8/VgF73ybNLbD5rymu/iPa+hdCR+L3TNL08qEAj4r7y
         0XYdyRhauEb4FgdgNPoPbZiTDAkiGDn+QI5TO1jFSAvPrUZPR8Wz0AvjcUCfE+X1yUs+
         lXNRMtDfugRtbjY/p9YKJEKAoTwY7kWl3PpVrWr1h+P7DrAIA2xJUYF+TWtRvfplWqOx
         6Pa7AcpZSDEvTYHTpTW72CDhIv8ztI9m+aP11aBy81rhR6JeSH0LUECRvi9iiNSXUMdn
         wEeGSVNWzvxeGBz8jz7bMggcykIY6khkVKi7hqXXoxc/c8e+E2ZP4dYBd1CMxOLb1mSz
         YUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458332; x=1723063132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5NFLGE5phJ2Liv5ktsunuY0p6FQr//tugyI0Kha3qE=;
        b=Htn2PRC2f4R2EaPNaGfHWAnqAxMfSeuXxYMmtoo7UVt5CvhLgRBpZtld3/6D/qHQa9
         BNNVFz1DimWllyhdgmP0zHhSa4HQuvBxuy8aSO8RXY9e6pADimJM/y1j3rvv/bvDSvOv
         RDeh8o3u6grd1K+XQkN3zppkkPejfnnR5rk/caMqZk7HAMd8mZmcniOcRkoe9Mmc97TS
         EQnGqEsZcgBVV79LaXl0O5VA9TOqY52cTF92laZ1DcKSwCUEVSJKxy5Jc86vL1BY9D2d
         SmAG4l73tHjriIUKFLJmxf7H5C57TrG5/pZOO8gOYfjhaby5TyJIoLBNFvSSoITUnsru
         QuTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8lAdzjKptmqaRhB/MSNDrV1LnTxmONz7wQMsu6yRWrVE0OGJ5HI+/hWJ91LRWgSGD+PrmvSgtWO7ZPWnXetcVoHOCcREvO9EyGeSM
X-Gm-Message-State: AOJu0Yz3t+QRgNRpJzzoYQcPTTciUoniVbdH0wTYniWgsXZlD4wuCKpV
	9inDQ4CPUxg0EXmJVpf8i6d6IY9iHVC/Pe1AtX/WtMsGTTyfU/M32mg7cxEanJvPT1WmRqgafl5
	L/qAQnXmpZ4gNd3JkVEsffy/tj8nvQdEi
X-Google-Smtp-Source: AGHT+IGgZSRkGNf2/g2W4xP0fPTsJ1SSYgUFU1liK/NEoXAyyFyRcjq7ugG5iHnPf32al3X9PQJ+gEYtWcwDPgKfHCI=
X-Received: by 2002:a05:6102:3a14:b0:492:9b6b:f844 with SMTP id
 ada2fe7eead31-494509d0130mr496280137.26.1722458331878; Wed, 31 Jul 2024
 13:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731100057.990016666@linuxfoundation.org>
In-Reply-To: <20240731100057.990016666@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 31 Jul 2024 13:38:40 -0700
Message-ID: <CAOMdWS+OnhEzLK1PyPKJWXAVauPwK8CA8jKvOs1j4D_G8n+Cfw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.103 release.
> There are 440 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Aug 2024 09:59:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.103-rc3.gz
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

