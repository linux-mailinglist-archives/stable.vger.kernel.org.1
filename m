Return-Path: <stable+bounces-180471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52929B82B5D
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 05:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AFBF1C22396
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 03:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA3D244687;
	Thu, 18 Sep 2025 03:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="V9Oj/Lag"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D9241665
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164882; cv=none; b=i4G6GbIN6B7djkWU1DJHhHD0H34acNrVglWiX2tBzQdV70CrqPf6HbikMlbtZkcXb+jbi1MtJtImeouWNR9An+GYs5WL3IHu+kiV4n3u6Bxd1JAAkusgvqvYC9IQnauPcclT+rQrQtgwSBl5hPGaT37TReYnkWNbICEVIA9b1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164882; c=relaxed/simple;
	bh=ucCRcxsuGDClfG5heo1r5qIU5kMebbEElSVKOAPitJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/UHPZZgnXSodcbOq7WZgf5gxzwIg4TtnC8xatdZNaYfJA4idV91OmtjBdIoM+r4K0pCpDfupDrHWwyeSj4ntK64BICZ5e3vrBygUwQ2KOdSaJELMhaB7t3Mh6lu1mwMJZoWBBF5QK8dl+zeKYplTrut9xUZ1Dn5dmCiJRxdNrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=V9Oj/Lag; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445824dc27so4588615ad.3
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 20:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1758164878; x=1758769678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOr262x4SNCixfw6D+h2DN6gV7zkR61R9C2FM+lF078=;
        b=V9Oj/LagAayBJWbzzAdIr+QLfFUypJLqCn0Q0otuGWv9ZLEa4CApHB8Oht7mBo2hV8
         tfsbDddh0ow3pzDtJbOyxCVCrwcxEDRALxkXUlg5cxwXtSxsy9DAD/OJQP1Fc5P7tcjt
         E65zpgnXmZ76x9ZeIykiXazJTL962d7zRByky+YCWQc7PG3WqRiqJv60gXswtiiLgwv3
         gJhzbiqQIy8dkLCgz+V9TeC3aTLPmmJVgyPJ7V8Rp0GiDeaWU7mu6CKhZpyuRHjVv+bc
         aXHlMWbVvePGIjFjlz90AICYWFTaCLm39Ah40bNvaGAtCGrx2XOhAFiqMG5rBNMdU6nb
         H1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758164878; x=1758769678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOr262x4SNCixfw6D+h2DN6gV7zkR61R9C2FM+lF078=;
        b=GnU3muXRk6P2OF3u6+LWavLNUWbPOH26ieQCw1z65l6YfPb7wvEa6qbZ192cCZ8CCr
         bILVWmHiFp6rQ3tRKXgWzLUhkftcjmjOhVeY2NLHjYrCEUYyce3Rz8QfbR+B6mrGEVFW
         fsiGH2WaPHfSUvHVGaRJ92gBQD+exTzAW09qSyd9co/OJM7XlCRItmEATZt6he50rr7U
         jopAATGf9YY/FUdyctGmko2Efhe8J3gqcSqsl54NuPhoewlOwBkPYDDsHxnzQd0JpEjN
         +NZOEXkN5/lASar50Ie/yH4IKfV5LcCBvbKoDOWHPaRfh9bLpR/SnAEEPAtDpZ2tbA3Q
         kRXA==
X-Gm-Message-State: AOJu0Yy8PSzC+oYJB6f2wB1ahpWdwNV80OZQQzfi9Q1vriHIkjm/CsE5
	uAGa41wcLGF8SVuQB0ntSaYJzfYdmpRnLfe0l2tuh48QUD4pnmsXiSsegv0xEwFcBO68F5ooZXp
	UBCeV1DV+Ls1D0BO4OQbPbdN2TWFNsyhxOsN+CHbS0w==
X-Gm-Gg: ASbGncslP0/3uVbcj9GoLmgkEYZRpYC1mdgNBAvqL1mUr0nzj20uHPHyoXT2akva77d
	/C4oZT4r4UQSLCzr6zzjcAe7IQm7nUgo7A+k50cY1i5v8uvrFcD53pKsmJrV+0ZHjfcsT66QNEx
	GZ4O5UYFeiBomXCau/u2tzRagezNlyEyHhcbDGi7L0afg4/f5LYku6mk8rw3weIQlmsa6pFX8W0
	Behw3SEgelKvRYqCjVUGYt/SJ4=
X-Google-Smtp-Source: AGHT+IESFnLmLGxL7zVRW9/AAJMJ3eUyMJy5//Ofo8Y4ShmsKybTu8OCYOtVcM347qhv52LF3IQYEflH+bF5I5G6ezM=
X-Received: by 2002:a17:902:d4cb:b0:24d:64bc:1495 with SMTP id
 d9443c01a7336-26813bf3d79mr48842325ad.41.1758164878562; Wed, 17 Sep 2025
 20:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917123351.839989757@linuxfoundation.org>
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 18 Sep 2025 12:07:42 +0900
X-Gm-Features: AS18NWAHWPq2LKZaxfOvpUL1LbKclh98pn2Km87I8UZDUptfVR4FgiZQQobBzMs
Message-ID: <CAKL4bV5MDKDWPKJvQke1Lah=HzeX3=hO0rfQYb3S_nXMcEYOvg@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Sep 17, 2025 at 9:36=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.8 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.16.8-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.8-rc1rv-gfb25a6be32b3
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Thu Sep 18 11:43:14 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

