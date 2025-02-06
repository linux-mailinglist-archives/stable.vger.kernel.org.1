Return-Path: <stable+bounces-114177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5F8A2B4CB
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 23:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0463A2703
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 22:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3A222FF59;
	Thu,  6 Feb 2025 22:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="WS9x6mvv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C422FF57
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879768; cv=none; b=i8xk4vLXUKhsDRoauMm6b6dHVRgwbGeVtUwAGi9mNTvlvnJiP7dLh4DUB6Vf6im51jO+pilG8FuNaiEfjFOS2yC54ON2plZy0/2Q0/tRioRqgMy9euKTtb46Pw8la31oJRj49hDgUuUPfr4BM3EatgCDRF9nYRT0wYsnSkHS+nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879768; c=relaxed/simple;
	bh=v8Cb/I97cbYSHojVbzWOcSDJMzlNFCCIVvXaYBcMZxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJWY47tzyEc94rSIBGBiWFjMthXfdFzB16xHi8ImBFOJ55kzNM+5nhhlsC00U6eX922FGDCs8bNdos6kago+zVKCMZCwYrOKCnsm+SG/Gg0FD2/JMR6pHjty1RiNTIZJKTVkRGtYKifulyG0cYygMUki40bAYKmkU2fo81wmXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=WS9x6mvv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f3328f72aso16588065ad.3
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 14:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1738879764; x=1739484564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YowFV95RzqYpXXncaW4VNnhPzNA0mgUHkVJDlV/Z4no=;
        b=WS9x6mvvw1xRtAvcpMCfBQJHjKlMf8A/0GANFGWK3D4TvvqRrOLf+witlUNi4HOqPv
         v7zIcMgdW+8qfMbJaBNu/b1CsNcDchgfKL5IYdn9uWukS0LoIY++PlFrj3XSvSqtcR74
         Cqy++AHBfbINO0NsAqXOeNcWC0C3e4xlbibUnme0wQabxssoYLzQD8jPiftyBB8qbmVo
         OVCX4vjMqGspB1WukFpXCzgTXFBIB0/isr1hvavOOww347EMyP26Zuni5PUwE24WdgHH
         YE5ToAchpAI/hhgjRMObZ359n2X7cKao3Q9P4Y4t0ako7U3IT45+A1Uhh/7/CFw7L0pF
         Xfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738879764; x=1739484564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YowFV95RzqYpXXncaW4VNnhPzNA0mgUHkVJDlV/Z4no=;
        b=m4AN0gfKnIDyxD0KZJ0z17PR623BPF5bH1W855CiWuOC9R+4ZYvh64WknC7PmACRIY
         u+/Fu2hVO/91TPT3ZCR6MwbRfrry8sudYmjJQ7n95GaPSzlvU2AngQWAJ+qEopyxFFZs
         MvD8LiTU2YOxiZKq7hl3ukTwrsEKw+vwb8PFuTHIgmVKjy1vp7LR1FoVnd1hqQ63PEB/
         2X0l+HD16G4bOqpXam5T1wmarmorUvjbZnQZJSupHyGa9PY85BwAmjh2kKCLni6D6Oag
         hoc2TlAPcvpapNOXYtIzpXkea26m5MErsdyWpBr2BGiVQAlMnoNr9PxeLdMy7E/6q/UY
         NOFg==
X-Gm-Message-State: AOJu0YwhntiRlIJkwNmWfrgDGweE+P2FflVnMqIXaQTs6S8o/8FuzJ4w
	ArooamCvR/NzPaV5+EsSWijTJH+RjJIJZpD0kdUForD0WWy07QSs3wkkmgP9VqL1QqrxOyXA8aM
	ytDw+NhRvc5QvfxF4TmnqMor9qe7wgtkQ7vrZTQ==
X-Gm-Gg: ASbGncuksTulU5jrRpsHSwZ9HX7al5jsXjFUgu5zdCUSwkm8qsXINIuWzPo2rrJl0YV
	9toAsqq7CbGh5MN2hPM/DtCk8yPIicu8J7+AfSqhiD20mWng5uyM8vZ/PUFDgqJsnkIYnyA==
X-Google-Smtp-Source: AGHT+IHVA3aLLUHBjvM7tBiT/JAeRIG715XqkMU23ZlOgaA1/IPqLSTPkVNA5hE3GgpS2Sq6STuEQ8GQr00qCN1MoNE=
X-Received: by 2002:a17:903:2a86:b0:212:6187:6a76 with SMTP id
 d9443c01a7336-21f4e6afbccmr15332045ad.14.1738879764518; Thu, 06 Feb 2025
 14:09:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206160711.563887287@linuxfoundation.org>
In-Reply-To: <20250206160711.563887287@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 7 Feb 2025 07:09:13 +0900
X-Gm-Features: AWEUYZkqc_QFPDa0cmxptap1fL55qjlShAz2QJJR1zciPi5pSP-77julnD_XuYc
Message-ID: <CAKL4bV5Ks9OCh8SrgkoF=UrK3KW+POAXOD77L1kD0P9fOiNC4w@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/583] 6.12.13-rc2 review
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

On Fri, Feb 7, 2025 at 1:11=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.13 release.
> There are 583 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Feb 2025 16:05:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.13-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.12.13-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.12.13-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 14.2.1 20250128, GNU ld (GNU
Binutils) 2.43.1) #1 SMP PREEMPT_DYNAMIC Fri Feb  7 06:24:00 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

