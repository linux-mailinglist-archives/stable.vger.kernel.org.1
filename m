Return-Path: <stable+bounces-116490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6278A36D81
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 11:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42ECC7A5135
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FA11A5B8B;
	Sat, 15 Feb 2025 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="CLzEjP+9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5338F1A265E
	for <stable@vger.kernel.org>; Sat, 15 Feb 2025 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617131; cv=none; b=usG3CcKkT2IObP6AgaWl1yP6+cp8qhcK4lapGRUrmX8B3/Vb6h+bq1C7uQSQwgH8rELEaYlMmxpSVH/qTrp7Xm9ei44Sar1mQpPsG9C9UnCTkqf+PcqkHdQQJolqKM8jK4GZXjyXgq88c4lCfxsb4yDVj6Duwx+BAZy2m9f6avU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617131; c=relaxed/simple;
	bh=WypY/zniCX/xErM/Fd3718ZwTFWc3QmqpFaCeoPBLIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkShNZg/SwaSWX0Cg8NXFeZHtfE4M73kcyjohBgWs2o2nfsCWbpzTuMCpAlCRxyBy1j/H/rOYE5Pa4dr8AdgqkodpfJdXoGWUqjxF30GOf8h2d8vIPbJOrfYBVz6ElCxY5/AWMFsAdHLngg4UuVT9EAHt4c5ajCaOewQ23QZY5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=CLzEjP+9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fc1843495eso3566457a91.1
        for <stable@vger.kernel.org>; Sat, 15 Feb 2025 02:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1739617128; x=1740221928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXfy0pOqgURw0sBNhPyNsYPIbvhDPU5LYX/WlO2f4Gk=;
        b=CLzEjP+9Lh+vJviHoib9AVi8+JhqoMmtMfX8ebUJ0WAxbmztMKCrg+SDzEBdGjzJHo
         lsHBMKQxUjOaOlHQ6PSv7t/UB0zvHDlLk7PVRiRxcOVlW7XhFeLakhJAJC/PMJYEHboH
         KfzkR9GRTRtk60e+QykC/4MWw/TSByRdv4lIyM7CU2QiRyeMEC4p0Q7GQ052Wr33LDX1
         vl+JNPUGRcvO3yTcCxq9ICtUssOMQsqrfZqWvASoNVmJF9y9/Dh6qslmremwCFHgi/FI
         gUFQK5dhn7A7m2PQ47yWFCyMV65FMBRFnK9aibA0FocRzyuK/5TlkN9X1eAAIRSt6eM+
         6KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739617128; x=1740221928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXfy0pOqgURw0sBNhPyNsYPIbvhDPU5LYX/WlO2f4Gk=;
        b=hzjjQ9pafyM7FhZzK0uP7BUzAeLEcRFHeKyHt4uBG0gRehKawLbgpOLGdFHssqw1qF
         obGATQ+EXSv9gV1uTfJPIHNtUeg91SGFdKZw+ZteXmsQI3pFyK6DurzI41kMwVE4OMIp
         QjmdRFM3ri6fbDUVBJPxL4Aq4CJgZrJMuFbVDZmXwFoCxjHOAVbUNhRV/vX7RP38McC0
         q2ZB7ejDekTOK7cwKXZrKjlb2uU3NOmkC1GFEAzxrXNrPebP7PmFP5c5xvDzdrGbRL6i
         KYiKSz40LQZTlCel4+iLLi5SoNDGAFVGejsnk5KWEcscfKJmq46i0Mbm2seY3YEnVmB1
         QnOw==
X-Gm-Message-State: AOJu0YwS6LKgWVfSFHW02UO9fZfiMquI00+QuN3ixnmGd1Cb5H6/zJtx
	s75WME+WOqNGnGNamYgxjP9FgYMb9FgLjovB08nd+HtxGDjZWs5Lb+Ujq32rM4VMD4Y4SSgEVfl
	UL6a7qQkCVrOgeBiCRSBN5ZEfAHsYVXI+UKfViA==
X-Gm-Gg: ASbGncuH7gisfPcYcjdnICk2ejbwISU0XILn1L9a0qMQ/6WSmi49HmKOI8Kk0SyuASb
	Y0cmpUHCH6f5LceISE3GwT6dqkvsf+oaM+OxHGAH27wvr/nCcXIZ+D5x84NZI3M3wfcxcjIA=
X-Google-Smtp-Source: AGHT+IGcm3YamL+djIkvINYQT1aOevF5/DZ5KAC3xRAWBFUGwATEBGcQ+6Hum4fw7ATKOI8oyHGs5dLlknn8TxpJt7c=
X-Received: by 2002:a17:90a:d44c:b0:2ee:f687:6ad5 with SMTP id
 98e67ed59e1d1-2fc40d131a6mr3847992a91.2.1739617128566; Sat, 15 Feb 2025
 02:58:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215075925.888236411@linuxfoundation.org>
In-Reply-To: <20250215075925.888236411@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 15 Feb 2025 19:58:37 +0900
X-Gm-Features: AWEUYZnkoOlW1hyrGRrx9kFeBwSnP1ZO4zRWH6Z6cw3cQhiue6RMn3nyo77fQHU
Message-ID: <CAKL4bV6ibyowUOZfrfndLH+XawFRPObBNR6cJXTvoJ8RQK8SxA@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/442] 6.13.3-rc3 review
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

On Sat, Feb 15, 2025 at 5:00=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 442 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 17 Feb 2025 07:57:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.3-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.13.3-rc3 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.3-rc3rv-gf10c3f62c5fd
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Sat Feb 15 19:21:18 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

