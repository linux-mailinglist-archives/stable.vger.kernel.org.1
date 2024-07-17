Return-Path: <stable+bounces-60460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE899340DE
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 18:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA051C21401
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 16:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00258F6D;
	Wed, 17 Jul 2024 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2SdjkrD"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC91DA3D;
	Wed, 17 Jul 2024 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235487; cv=none; b=HpTwJAg2wedIpoap1rrJTmyKq9OpcotfGDNBpIdEQjIQzUIrGvWZwMRS/yq9YP9diOSu0zaKa0xgQpZt+jG6tuZHrjV+bgWVLQcWfMWVFoQcQbDL7OB5+WwelDBZrqZDWdm5hOHq3yBYwoos7ICgGmLq/3aDwU95Y3oqhrQtkFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235487; c=relaxed/simple;
	bh=wj5L7vEg8raWB4kya6dpvBDuV4WIo/wvnhvYLz9sXZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2ziuWJMG66+bhBMLSgSIUus2dGljbH5s9FRqJ9YZRaw5W1GUHjbdE+weHBb3nF3Qmbr0Tbme8qypGYqCpGlvyfYlSSobnY6WJbvpd4dVQ5dG51iXrTqCFvaKs5y8+s2p+RD3S4dqnry9zOMH07FMxjulyd6puWmYLrO493/Zos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2SdjkrD; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4f481c2bc80so593031e0c.0;
        Wed, 17 Jul 2024 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721235485; x=1721840285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9zx4ikMct7TQBtb7G5Qz3bBwEzbNm2mRb2UdvLZK4wE=;
        b=a2SdjkrDmtVyI3678Yo7DfNWTECT6iPYtIlRFDouQ/4a4YhgHfTlVdmGQPZdtw+Y3K
         B6ir2pyHW9JNsNRiInbRPjvOp+HCr6iZeR5X3RKKyydKP7yhO6jHBvQLe61WP3c6Lymk
         HJm1skVaOteRkLaQcgVDHcLu1S/tQKTSGdLQuce5BDDfmEjpj1JQ8+ynxouOF2ZTn/Gr
         qKqs5s5aI5LvcZtuUZPb4qEHGqeVgZaiu42iRJkx+UToXPpvU0XvN1UVZSgeCBqKvnEN
         zB5pgTT3+i6diXS3rzCPiKtnql5kkAaKYPv/PZUINVRbBmG7lgCOb7KBcAxdVJHv9i8O
         teHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721235485; x=1721840285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zx4ikMct7TQBtb7G5Qz3bBwEzbNm2mRb2UdvLZK4wE=;
        b=ZevX+4w7O0s6AxeGl9CyN60rzQAr/5zzkJoAet4Y9qdUQ0/GcA9EHd8wR6jOfP/+fw
         aOSyWjzdw8khppoJr8I3SeyDgu82lnanz8fk27LANChzmItfUtbUyoBnZ4spuw2NdFHm
         U6qXrnyjjqbiLCfR2V//5cqHSAeXOpiE31xLt19//QG8ZuaQG5FGdJ9O5u+kCmt5L5ar
         flFCeLZk1pM0pTRMLjqp5NN/GesxhXWd48+bJmt4/FNCmZrk9V37SMPgkufX6hwWSLTb
         20j6imI4Ao4hBwgIQb5jMEfjafrwl1YS8t+RxZVjbLMQIj6xydBErTqWnNKndkUeY+0k
         uUPA==
X-Forwarded-Encrypted: i=1; AJvYcCX7tC460p89yut/tc5oC3X5DL2oGRCmgaIB1vxfgbxQ5Q2otm3K6SFui6YKF0p+ySANRT1xzbAv1DWXs9alfZAqvAjb4PsiTy3+SHCZ
X-Gm-Message-State: AOJu0YwQf2iOSz8+GkEv5hHyznid2DsB8/BE+qOw1tLgJpLogpjtDSHZ
	dUBcY9uRSzTlfzttPR5xySo6lPpdIVO/2GUbO/MXQgEZ6hyxqBq2rFP559sHqb1xTbIo6tXgK2O
	pk6oFSDJkSuO7rIjWxnrlJd8ulvI=
X-Google-Smtp-Source: AGHT+IE27HJaUmz9pDPNvRfvXyzRAD6RTrQO6vYcolvCZjt/pJdDQFz0naoLXnmwn/iRhqPv7nAXdgx5zYZZ1zJhKsw=
X-Received: by 2002:a05:6122:3bcd:b0:4d3:cff6:79f0 with SMTP id
 71dfb90a1353d-4f4df687dbcmr3157507e0c.4.1721235485093; Wed, 17 Jul 2024
 09:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152746.516194097@linuxfoundation.org>
In-Reply-To: <20240716152746.516194097@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 17 Jul 2024 09:57:54 -0700
Message-ID: <CAOMdWS+aAOeQqTceZwkpM2zCDGZAWvq6KnVCWKdguzQEJLmAsw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/96] 6.1.100-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> This is the start of the stable review cycle for the 6.1.100 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.100-rc1.gz
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

