Return-Path: <stable+bounces-118446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA378A3DC4D
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 15:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D66189C70F
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 14:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F7D1FAC4A;
	Thu, 20 Feb 2025 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="MufIqekY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BBF1FAC46
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060965; cv=none; b=Mxb9oH/4dU/AbjP9AXlsDjfuMUotJyc2E5WaqZpJZKY2e2+A3+iUGqyAlwIk7fFkHgck1WhPVC1HD4NUogjc2IKX+6ZCoLZg2Bt5C4FZZnu90CnCdtlWN9OuV380fSN1oMIKVemDJbIH9vDN19qtLH++49rlcNe/bWQkf5Cv5DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060965; c=relaxed/simple;
	bh=FnUDn3kteGNiPrF+F00ntwEnWg8uVOcU+mbj1dX1PPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=re3atSQQgw0EK1QW5QE38ljPsWCHKoBavaprcojF57ucMiWRbolsSbSkiSTQrK4DxTryiaGt4Bw7M9doGuZha/1SQVi4NI9CCnF4yPD1io/OSj2NpVWdfGeM8iQJ5mw3bMpmdopqmrnjIWg9Aymtjk4zaNddGVCIIylsBgEZhpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=MufIqekY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fa5af6d743so1568704a91.3
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 06:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1740060963; x=1740665763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFcRRgZ/OI8HueiYaAyTUjysgPa3NhOt5Zbu8dcMaH4=;
        b=MufIqekYgaPCtrDlYaYgHGAUiHa2oNFQDjsmWJ0UOdGEX6npQKDvwrYVarcVGt3B/V
         kWIadCJVAkIo2dFaIwrfsPne74Qw4YJHkpLvBpDkm4ssaKSnAWaeWYnU+MznzJkCaWyl
         K3bEU0WlHhCvhPuUWb+8p7Lb04GncQ3OlVnv+0JAvKJcSSxpD/oDLRO+FBPNQc7S7oEA
         JIxWbbns1dRy7Or9KW7W1VFFC8/lmwwRPcoD5RW4emWV2utr218fTpQCaitfS70QPfM5
         7dZs3aIxPDo1yXvDOjJWWBLd4vV+72p0DfuqzEjxIT8vif2R3ioUzAi5sR1ET5Htghsv
         3HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740060963; x=1740665763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFcRRgZ/OI8HueiYaAyTUjysgPa3NhOt5Zbu8dcMaH4=;
        b=O+DUbFWOEok4Ga34eMfp4pCd9La21g4Pujx9gEZQWENB14ltFGRs8bPpYTIHdR0IlB
         ZdeG1phgvnXmzFGQ7tmCUoDERXxTe1S2JJKo39a6iLD1QRSq5UahQ/IGI9aBRPUQfFfT
         hdF3hzmnpZAN5D0/mZsR6Qpn7tmIgYcNS2gphGoEPc0RXv818ABHiSOVr3m0AW/vCQsV
         h2HgSo4SLkSIDyxJdM3MKxF4VhemP7x1AmrKvG6TfCTGrk4X4PepPqeBK8eGt2pvkK4o
         7IOja5r5NHesVhRbscq7TWTjvMfBSNI0lyc4K+irZg2IH5ulhQQWCqkDRtGoS+49ujp9
         sy3A==
X-Gm-Message-State: AOJu0YzxsOE+tA3pdoQnJQ40qF32gvwsFOZBDwAg9a7hiWqbV/UgjKdS
	zk2kKtDP+WyGO/LhvcVvYRJFzqtx037TDOg0D1aUkNdZTCtKE26sT6aHmOZmtNll5P89cIjSgyC
	iIrTBp6aKKH51qoztLOA9W8eIK85MKi+oOdeGSV2q1pZQ5CnH/LU=
X-Gm-Gg: ASbGncsaLiFz+tvMtuwharHgRPLthpAZKySIFmYVRf6ENHC6SWdkaSROlDrNa78lUlh
	l+ZQJmLt00BvWBJgLMvo3eyo+Y1/MOwXJWBMBIZxUxhmeXoiKrKILgQprqnxiFcX8SCbs1/d2
X-Google-Smtp-Source: AGHT+IEbWS89Bl3M1hawkEALiF7cs/fWjH88qNg94FJjoiQcjQaQjWu5RV+u+rnxMy7eGDtdRYuM2xTyBdXRPvgUL3Q=
X-Received: by 2002:a17:90b:1a87:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-2fc40f10271mr32024795a91.8.1740060963496; Thu, 20 Feb 2025
 06:16:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104500.178420129@linuxfoundation.org>
In-Reply-To: <20250220104500.178420129@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 20 Feb 2025 23:15:27 +0900
X-Gm-Features: AWEUYZnRaDnwS57qTXFvSLbWRSRROWyGCamNNyT6sk5HbujlvZO28fPyNcOuvaA
Message-ID: <CAKL4bV4NumjHYoKgCqnuqzQGHTM-wLnohFAPKRj5K6n+qWpbhg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/258] 6.13.4-rc2 review
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

On Thu, Feb 20, 2025 at 7:58=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.4 release.
> There are 258 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Feb 2025 10:44:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.4-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>

6.13.4-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.13.4-rc2rv-g191ccd3d65d1
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250207, GNU ld (GNU
Binutils) 2.44) #1 SMP PREEMPT_DYNAMIC Thu Feb 20 22:48:41 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

