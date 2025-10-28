Return-Path: <stable+bounces-191522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE36C16117
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 18:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F003E4E1AC3
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27411296BCC;
	Tue, 28 Oct 2025 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2pDM5Aq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359B734678A
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671526; cv=none; b=Wzr/ftO++3fsX9FPrt2h/qaNKOop25+hPzlanXWTEMnLRFFJl0sPHz9sT1M7vnztbvv4dC6HnjTx8dAC6YHMngy6YZXrOFQCgTc9Em2fgTtbosfYSXEYewMAgz5GqaBFIZ4oeDSU2fwQPBxoUSmfILWX3n3mVqJfXiPTAzJHi0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671526; c=relaxed/simple;
	bh=uRk8EwEwcOWT3u2NM1bPYXtYi7WeFHtlYV5DrUELKj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIAMbsxfsbEtps+ZKzRS4Fc9pJhLxArEvVAr1LPCzN8Y8LrWYaBJH0qi+Yegyq+4s2ORK/udwmaU5Hfwj4WXbqK7jBUqj/+qXQX2QHK8pqEjYeoS2Hij6kINCVdJCRXLLIP9gFr0EFa2B19FiNEEx92sIwP6P6Td8GzdABK+DMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2pDM5Aq; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso132136e87.1
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761671523; x=1762276323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3Pj3kvcN6aBQ6j/0SMZsas3fPFyjC2TU5uVuC6Co/U=;
        b=c2pDM5AqZHFsKfkYmLLw5UuryD3LRgp7av7ErMnEYUk2Ct6b2uxR0nhomol9QHFsDJ
         avThxUfWEzlz29LWRE2eQRwKFL58N5hPFdKvODpu8WxlqKL6YRK7LchLyr8+ewWL5JnK
         NXrpgYRnHHXlwoJo7voZh9LDjgpnY5okgFQCH5guJ5gqrykdIFEjezPMYvcuzGOtryBC
         3AdfrMnWKu+1v/CJhfeb4yUJ8ovT9j/9t0fIoiQF7qOkbxfq6+q184f/h6XB7bMjg78o
         ps+q+uVPTnT92ewFAi1qQBelbns3bbnJkMF2i2PJxTQY9VEEYCl6gqLa5H+Y2ax8UMRt
         taIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671523; x=1762276323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3Pj3kvcN6aBQ6j/0SMZsas3fPFyjC2TU5uVuC6Co/U=;
        b=jJoIpxa0z0OHvkUX4qsXcp8ShX0ONvOBqdLwf1XU5fuyFtgqQEs2EJviWojoJwN3Sy
         kZ7XS6S8xYG4dZ3GJnmNUSCWX2SIlZD95/qIRECf7I2ozKtu7rAFJE5rZ8i365ZAfC80
         RWO0RB89haLBWsECDPVgZX1hbCeSMR80Pd4sWTBwffFaABi+IwbMTSQI0idB2lmxpACs
         es1eRtu2H9t1QsOs7HYUWGKp7aVfEQOyq4CXmfkhPWKV7CQbzAJGI9TByJXm+P/jE+e4
         lHEna/4j4Vcz6mBNOTYQJg9Eka3fxyUA+1pF02QaHCM7PtAEKzlE11MBPLOYpwjF4nhH
         OT2g==
X-Gm-Message-State: AOJu0YxvxSL6kj0CPBRjczzZ98ucz8XtQ8h+QheULt01gERCXWTfI8fI
	p/tqN4vtmcPs0PIbappmjAAEGwDuUF8CXtOF1PVRawYw1j+xupMo/K0MHxvxVgGeY+oBlpNjlpg
	dVqhQezN6O8YCVUUDW38DoV9EpRM2Rwk=
X-Gm-Gg: ASbGnct+xf8wH+QDpxYf3Zs+HF2ScD/a2nQe4AoNhcBjTv4FFMUpA2Q2aqsKQHthbou
	fWjWz1eIJkpV+WKDNHpu5iXzfmzWN/S3ICO/jYZ7r9RhOGL185389RkLJBlRFWDHvNpnSxvxTzj
	Drw/xd1foHtiVAnpkxcRcuvdaJyUslC/E+slEmzeX6d3+fC8yPLQ8DkYuldEkpN3Hbp4w8a92tC
	KaVznz9zwNoNwvaP7rHKaxrO2fvl2rwZ/BWmp6bX8MsvjVuPGXHAiH/8FDGOD+nCq68aycJ9+Bu
	BQBBrBc1QLR8zoDdNA==
X-Google-Smtp-Source: AGHT+IFiHrUMwVmkTCLb9w5Mom04LhEQB7TPo2rlpYqTBqyrPAneD8NpZPc6wf+wC2DY8YSbv1v4z9OiFrCUDrWhegI=
X-Received: by 2002:a05:6512:2312:b0:55f:3f57:a64 with SMTP id
 2adb3069b0e04-5930edf7cf6mr1431299e87.18.1761671521998; Tue, 28 Oct 2025
 10:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183453.919157109@linuxfoundation.org>
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Tue, 28 Oct 2025 22:41:49 +0530
X-Gm-Features: AWmQ_blC5Fm1cvehLp8Fe4c8zA-3g-SfayVM4q9tWXtt4kuTKi3hE7u8Q4HxCIM
Message-ID: <CAC-m1ro02LHYLz4-J_9_+XUOBs9YXRO9sAr+Otd4ddj6gxndog@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/117] 6.12.56-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hii Greg..

On Tue, Oct 28, 2025 at 1:21=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.56 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.56-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and Boot Report for 6.12.56-rc1

The kernel version 6.12.56-rc1 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.

Build Details :
Kernel Version: 6.12.56-rc1
Source: linux-stable-rc.git
Commit: 426f7f601ca06d40c899834021f62b7cf90894ca

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

