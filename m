Return-Path: <stable+bounces-158384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B9DAE63F3
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 13:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C3F173BC2
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 11:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3FF28E576;
	Tue, 24 Jun 2025 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="MhDBnMaZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65632868B2
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750766244; cv=none; b=p/bzLZs7LypV0U0+i4IZ6UBV3p0pS2Gyyshxnc1k4MHE9r9BVgeMwaMPrYdaxROmY6SlpsC4dhIc/z5oukuqSdhy75P4luzYsndLe6IMc5AeTtnuXz6ppUmfE2UM8Av6PhWxJlc4uHSCmV5tWPluKPPlKkwARssYZZR8OGBf0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750766244; c=relaxed/simple;
	bh=tRy1eXVSAZ56E3F4ovZPdbmpPSsxWjWS0y1a7XOGytg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aM4gYDhanUmRPPGspLLAhflUKYI2WXVa3Uom9Qrgm7y6ef5fCulpgk8ZmqWjNMerKedLfLRXw+hJaNO4omplolej9FGKcbaYJ1yXNZ9SNcJmo5F4GhSSYdFlvMsPHoE8Lw2zSRtdAVd4W+fSxzCaMeLGHhOqStXxfnXXO/xqLdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=MhDBnMaZ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b31c6c9959cso5665002a12.1
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 04:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1750766242; x=1751371042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q86PY0wC/gj3dz8RRxO/iauAyWxBGEaS/86SENs7hZg=;
        b=MhDBnMaZ73ioL1i/bOywA8euLyIP+6OIXW9V0udYBCo9Z3jY39WQva7uJT+uL29FTk
         cfcA5l8b+STdXdklCQN5D/5UrKhsHYAZeV1r73H7h8NITyn2dO7mB+4OBkgA1MRVDQ9z
         PuJLMm9mkBmO1pNrp2/2AYroBhKWvkn5/NwEyFBBMGOtIOtmRjUq/UrW/wxCE10tDI6b
         0VaFDxf9EmeTEcS4q7/1cLSGG0lSI/o3U+YNfD1kpxYmCimM5vLPIB3Ll3yvmECcOxch
         hqMNfxWXzKucJOs5UwohT/aX5fBtKdO3I1hZtQx5QHCgNGinU3gmYbt+soy8bubKzaYn
         zfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750766242; x=1751371042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q86PY0wC/gj3dz8RRxO/iauAyWxBGEaS/86SENs7hZg=;
        b=DgJmNQ0nxBCW05+o4zAB7jyJ+ktWkMVPUm/8Eiyn1TK77l+t+NCpLDvJ05AW3bzWeX
         k7pARrvKjTogME90aVUn6Rq9Kc13gbiq5L6bWlIkQD7KECq+8tPpJYzKXJ4Io9DIAhD/
         4PezoS6P5zxk1K5fuF8pnaKJJfb7mFP7z4twXMZ7rNc1RZLpZuf/pqiLq8nuYAmh5uz/
         zdYrnB2c56j306M8iHXKSeyKEvZm/LdRjn7m5Td19qqegp+y8fqGX7e5y9nIENKBkOuW
         gRA604NBiYLCIItuScT/noVmnaK6Ma/X94B3EN5HqhQuzLWNuaDO52/I4G/n919JbkdR
         g1mw==
X-Gm-Message-State: AOJu0YzaH63wSOFPreo2ELWxZM9kMUXi5pJ37RVSMRf4Yg90lTxsK+hp
	0QRxD63sbEdD+qf0rGhK3hwZ2QuoNfVr7A5bkSuoXfKiMJFdDjxgvIPBB7xEu1stDz1a/mtdlHt
	KbDp1QGPMQr1/mEOYLYdl03d0zdIGukrbZx278mr5MQ==
X-Gm-Gg: ASbGnctvHvcVLLa0ePNWott2ToH5Kq540+8podyoPtSb2ySL8iEbsOCpTZPoib3ZbPn
	QO3uGYnU0YHYTEl7LNsv8V8oIq4Xvf1ZWcg0FqwoHMkDLWtQChjMhdY0nPlQxi1DL2aGDdlocdp
	hNwYdYjyro/t8fmhF3IKKvo245/I0I7c6GHYxlkiWlo94=
X-Google-Smtp-Source: AGHT+IExtPp2I2mFB0A9OeofBQzId6Ui2rK6a6yZnOAvbn0MCJF3aNmFF52R/DaW0iRmuQwDOo3jMJSYi3yRrmIXxCw=
X-Received: by 2002:a17:90b:5690:b0:312:1ac5:c7c7 with SMTP id
 98e67ed59e1d1-3159d6257b4mr24312771a91.2.1750766241983; Tue, 24 Jun 2025
 04:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623130700.210182694@linuxfoundation.org>
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 24 Jun 2025 20:57:05 +0900
X-Gm-Features: AX0GCFuTEjbibu-8Tjw0fKQGwh7s3i7RYXmZdiawgw2iqWdvIFiSW0TkstL5ynU
Message-ID: <CAKL4bV7Ce1J2xVQNbsgWwNm0ekUiny6TxtSvaXa8dQ=-tT-mCA@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/592] 6.15.4-rc1 review
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

On Mon, Jun 23, 2025 at 10:09=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.4 release.
> There are 592 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Jun 2025 13:05:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.15.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.15.4-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.15.4-rc1rv-gde19bfa00d6f
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.1.1 20250425, GNU ld (GNU
Binutils) 2.44.0) #1 SMP PREEMPT_DYNAMIC Tue Jun 24 20:14:32 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

