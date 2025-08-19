Return-Path: <stable+bounces-171852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C41B2CFAB
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 01:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407EB626CC9
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 23:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965372797B1;
	Tue, 19 Aug 2025 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="GNW1ZPTh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86416274B31
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645233; cv=none; b=Xe7vOgjskWfIEKxRDp+XEUf2+2bxFB+w50A9a603jj/fCS1YMAxXZdCvBQ4ows4RJ/c66IUkme/dyQ10+fxDwljfzAhEElMc7AE2SZepCrbpHg4NgxPhKJt1zyKG8PlS5vnrEgmqbEwGNPy+Ig9plDU2HsSHI4J2fdCeJ7gaWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645233; c=relaxed/simple;
	bh=xAe4svIGBTEkv+groVjH8FKVpdlrcojWAhm1WDZ7nJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJbpAmVMF/7D3Zu7t2vrV4Bc9bL7FplsvYXq5YV4WGDn5druMZZ0aUyPI+/mudOCgxdaLbF5nczIszLfySUwfE99HMbvfFi2a6Da8P+q8Zr9tq9zmxMbpsx1ZfrbyJypb3TKejo/qG/i98f6cYmxlbzJZ06nijNqkJl/CQgxBAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=GNW1ZPTh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24458317464so66221005ad.3
        for <stable@vger.kernel.org>; Tue, 19 Aug 2025 16:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1755645230; x=1756250030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RymNDBodT5MUud6sKSaHadH0Ax0mvSOm7rKts0yhCjY=;
        b=GNW1ZPThNaB4Zr7pTklyF7RQ9muwzDlz1ZFCJcx7WOutikDfcD7mcQbwE5mx6L4Z4q
         vYFpqcufnc1HklL9wJR3wZCi6dG3Fi5E4g8AyLceDmB2/pUzJUz92YEVx37YB/IuTh5y
         +HXKBgPmp+AgPPdEdI1QQ0TteO+X+8+5HZp/2tEVqbUi9BLt2ZJZ/CphDf1QUOa/j5SR
         4JLL+AHsMhGEvt9WBagePzyFieJ3KAUzN1riOmsIVCplh9Nzi61nwwlgt8IMCo5l3pNm
         L2GfKrtclg3Bm568XJMBeOLajzlttcfpI5UWv+Q5BJNzmIthsOI9DfK4TtTdlkzcOx09
         kt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645230; x=1756250030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RymNDBodT5MUud6sKSaHadH0Ax0mvSOm7rKts0yhCjY=;
        b=cY2GGGtC1oezO1InbN/wqB5adSzpX2JeHyhvEmoBcqPNvY/rjLwtI1LMgrktO5JR48
         JFyKi2OXC5idSP8Vpys3I/1cRr4tvTNaH6Ovu4/85Qgk0ztuVkWkTnCQjKnoFUZL/5O/
         tTPbeImJU+pN4vgnBZXy8s4rBODxjtUPlFi4EQbkKsVc4FkVQZAkr/h9hz28me7luLOI
         CHWh4d+Je0TTfgqgTOp9ykDQAt5gNzQX28siuFYbZ/uiE3M5WoDoSdA7RIPz2xUSJNqC
         Ev9wRhgdZFKayszNheAAJwSXz3TtcmY/IJC9SC33JndcQc/u4G5BtFi1a+lEzK1UCLWi
         3t3g==
X-Gm-Message-State: AOJu0YwOZNqWK2YTLWElI5gOL74FwhLL15/To4hNBFdhbShqLrOCp++v
	zfSd9zrIXmfgK+IFx7rdV+lidVKr7Ufsa4UsffhCxZJmgZryo0W4SRYNXDLJEvFuTTqE8fEqxBU
	He+lULJjBWHQriNlEIE5ny7wcSeNnKsTRQgTspASCsg==
X-Gm-Gg: ASbGncv5cXFQpJjMNCOIkxNMZ3UCYUtgSJRn8NzGRLZ8+nR684VR/9fCDqxnk6pr5Kh
	2x4JtfyeCXQAG6K5poWyRgeaag2DEFE20n1mwLRzIOwhuHRPuFAozqGb0GWBkpVMH8zyk4E+MW3
	w4S8sdiCjwdQme+fVCUdFSJ5i9H86mzusF8IYDVXDsQ0S7s3M3bfvZ2jT6UWYpzm8QnIlcP4mav
	nG/0NI=
X-Google-Smtp-Source: AGHT+IFaZF/ws/2o+IVsHz9PC52v3WyioUyPmwUMSCJO2aOKx5RBikHgg3DVCfdX521mViGqwYkoA21PN/BpPcwTrHI=
X-Received: by 2002:a17:903:2ce:b0:240:84b:a11a with SMTP id
 d9443c01a7336-245ef124770mr8124485ad.17.1755645229801; Tue, 19 Aug 2025
 16:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819122844.483737955@linuxfoundation.org>
In-Reply-To: <20250819122844.483737955@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 20 Aug 2025 08:13:32 +0900
X-Gm-Features: Ac12FXxH2I6qrc5dZhBRts0fiH57_1LDeKBa6_to3NcZTtdevZEnOqUrhz1C2LQ
Message-ID: <CAKL4bV69Q670+9Y0FaLJL83cO0SM0TKsjsvYuNSk-yFtsE6JHg@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/564] 6.16.2-rc2 review
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

On Tue, Aug 19, 2025 at 9:36=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.2 release.
> There are 564 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 21 Aug 2025 12:27:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.2-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.16.2-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.2-rc2rv-gb81166f7d590
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Wed Aug 20 07:32:44 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

