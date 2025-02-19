Return-Path: <stable+bounces-118295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22CAA3C363
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 16:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A6B3B870E
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 15:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBD11F3B82;
	Wed, 19 Feb 2025 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+HrCPnr"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F419D074
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978150; cv=none; b=C8ZQQpQeJe35iqrYwUy836cdDHvzpkNqFJngbsNFSMJUp05X/xhry/dXDmZprsK3NyZPkxNX7Fq6u2Geg9UJezYSYwkOrO0NnY6gxOBHQYbyLkKicshwgKEWoK2PJZAvkJQxawiSodgRT5kOtf75TOsgf4veFKA774OlH8b43wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978150; c=relaxed/simple;
	bh=Iv6t7FRn2B5grw2+MtJh7t4h4IagAcD/o0AdA80NfQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWqOfg/cNOLDAMgnUzEMt9M1rb0eYTpB8WnE+G9H4z92f1VbFq2B5titJBy/+ZoBru5M2+aUOh3W6ciJTK8BEH39iMrBblxbJ6guh0l/5uVxlrdWCBt39P3pCnVQIAME5ql5tMc/4zyg9OSMzeXjGvEeAmZvagFMDGNwNCKBhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i+HrCPnr; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e66b4607d2so26905976d6.3
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 07:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739978147; x=1740582947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i4BufmELc/H5oLk6Se7bfRixYeydt1UGAVr8rJzEKPM=;
        b=i+HrCPnr7hj8spFtYLMmbJN4GrwJ4dfHSMUILPd3nugBjV6Pnep62sVeUZiv4uLgPh
         T5XfHCpv0+RcshyV3tbuhiiWfnT2ld6d1s3K5xQdkNuz8mkTHXtYcR0ice9zLOF65Fw1
         ubEkNcCK8a3lh8bd8Ah5syIhn5dN4swl3Ut1rbLkYuaXN7hFqruJ4qtoWtOc/1b+FlFK
         ID9D2uAu2/J8lYsiNKaKaN4vKCZoTW0QTfXgK/LFcVaKetL5+vvGWn8YNipDnGOKGlq4
         osbUvYG3abppm0KL0QsL1qi4AbwA5jcnintQewvvdc8dhBb9guGgDedOfqhdp1+IJ3tV
         9mHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739978147; x=1740582947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4BufmELc/H5oLk6Se7bfRixYeydt1UGAVr8rJzEKPM=;
        b=Rdpt7H0wqccvN+ByORbBwTmgmUthctBR70h1+6zAA4hwgKYP8RCFTZQStAtYAuPin8
         FM6ZLKTSrHVdKlhUPJBeF5/LhKEqaAGpILNMvVr9UI/wP1xqQ9+LdCjkpl5WInIsRl9L
         69MUkgyjqr389spKsBVtIS2dBH6Xdbrs96Okw68x00nWYn+Vt2MfVUoaCrFWIzUiuiax
         InZcr2tf0bnftzM+2og/Ychk5xskCXauKsoZPQ2uoh9QKBBGmjWZpZJf+Ovdfmiq7Qly
         dWEDCF8h+rwlTo686jKGpcij2VMWue6CHjulRDqtfaepy699xZHhkTJ3kYvyqpaw1YfB
         pH+w==
X-Gm-Message-State: AOJu0YwQNyz1eGAUEbkxLPrk9iTRHE7BHSn0bCxJty4QQPN3Gnl99FYZ
	z1yjaZgJ11KyuDe0W0L1nxVIw/nCL9Iz+3O/g/tVW6sl8uQ7VXhUhZE2YvFyhPTxRPVwazCPm9F
	IZlH1VwUFon28ojOTLfN9+IaDosnQLLoSVDvHxQ==
X-Gm-Gg: ASbGncsMC12wDMw5FgGo/fsL4PjSAyKXrrtfPN6SKFvc2GqCq9swaCSgJITZFpMofQ5
	GJI1Ho1YMECeY3bIBwreEwg3v9vZvTVI0BMPQVrmp052gJZJEP7NEZFVMJ9LAktzQfRRG3MpuqE
	I=
X-Google-Smtp-Source: AGHT+IFOL53hLpR9huwVKcdEp9S5ol3K22XXCd3/mcd/L2bQqRKMnRbCt0AScL5oNtTya9R/VDI/ycGal6VHuQEUFVs=
X-Received: by 2002:a05:6214:1d2c:b0:6e6:5d61:4f01 with SMTP id
 6a1803df08f44-6e6974fc658mr68832166d6.8.1739978146707; Wed, 19 Feb 2025
 07:15:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250215075701.840225877@linuxfoundation.org> <CA+G9fYsBu8DOLEDQoGrdZmjwZKvz72tMmrVPnQSJLNMbefYymw@mail.gmail.com>
In-Reply-To: <CA+G9fYsBu8DOLEDQoGrdZmjwZKvz72tMmrVPnQSJLNMbefYymw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 19 Feb 2025 20:45:34 +0530
X-Gm-Features: AWEUYZmBriKaF0g7ZN6AKPL4WUNipNS0LvWaItl7Uel4aGCuiaCeYdtgGR_kvUY
Message-ID: <CA+G9fYugvbR5jJrOUHd==_h2MXKDfVjivRnaXxvwWL_dzBXdGw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/418] 6.12.14-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 13:08, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Sat, 15 Feb 2025 at 13:29, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.12.14 release.
> > There are 418 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Mon, 17 Feb 2025 07:52:41 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.14-rc3.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Regression on qemu-arm64, qemu-armv7 and qemu-x86-64 on 6.12.14-rc3
> We will investigate this and get back to you.
>
> Test regression: arm64, arm, x86 selftests: memfd: run_fuse_test.sh
>
> * fvp-aemva, kselftest-memfd
>   - memfd_run_fuse_test_sh
> * qemu-armv7, kselftest-memfd
>   - memfd_run_fuse_test_sh
> * qemu-arm64, kselftest-memfd
>   - memfd_run_fuse_test_sh
> * qemu-x86_64, kselftest-memfd
>   - memfd_run_fuse_test_sh
>
> # Test log
> selftests: memfd: run_fuse_test.sh
> ./fuse_mnt: error while loading shared libraries: libfuse.so.2: cannot
> open shared object file: No such file or directory
> not ok 2 selftests: memfd: run_fuse_test.sh  exit=127

We are installing libfuse2 in our rootfs to fix this at our end.

- Naresh

