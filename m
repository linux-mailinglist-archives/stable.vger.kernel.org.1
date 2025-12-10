Return-Path: <stable+bounces-200719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F22CB2DE9
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 13:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95FDB303B2FC
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 12:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B406C322B73;
	Wed, 10 Dec 2025 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="UTWhx6d6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A61E9906
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 12:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765369041; cv=none; b=QASwF0qo62QImC77QlaQEZ6xJhV1rj7wuF3BEPV/xewOtPxSb+VeIedBwhCny5m5y0AEtWZ3uCGM2dRJAjfIeCcATDP38ew8QKEczOrc+iUmkAjwiXAYP2B0oQT+X70rmZpE0xHhsUXyN2XuN9UdpmtOxqcQijvHvFdyHCUv/E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765369041; c=relaxed/simple;
	bh=CqddzwXfg+iqUA6B+bgarDhsZ2CwkeqjbcD6pMA7Ges=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhR/sUPayO7wb178E4yCSLqo7H8pDtbW8jO1t4o8QYUfdgNlh1+bpJEiBkeBHHVkN2zVLQgIQePP4EUbSRYJ3GVK9fgBSVx+airFA/HySiraiSmbgZB5OxHWdvwRPnUnqD+phIxt05yOoT8VPIa7tHvjHEsUq/+expIVn0appYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=UTWhx6d6; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso3968591a12.2
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 04:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1765369039; x=1765973839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1xwdwbZyc6XmBBbHWBkpSZmTvfwzWj9ylDCyZwxUU0=;
        b=UTWhx6d6Bu0hQVXvNFWDL602RXzKoJzq8a4MoLwNbrf+lKuKhlk/YO7ZLvJWfsk5Az
         eqFXXBjmUFOLHW1I/ku+Y+dqzmdT2Jz7w2MLqAKvG2LpCCJm/joVgevmK0wLhY4hmtQi
         CJFnk9txZCXcZXSOvTgFf6A3IzEy98JMB3utw8W6WZvXK3FgjYHssbEkZpBAVKV7osco
         zWLsfZOvp/AP0nUFt1rVgXI7iH9DS9632y864ceDwwdtrqYWk9M4dKV/jtxEAxi7XtMC
         BVU6ciN5CpiLl+wHH35vIPeiSWYwKF3N8Nzv2vGCcg2lPCDu1qMwh+nI5rfu2EuJPbdP
         dz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765369039; x=1765973839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1xwdwbZyc6XmBBbHWBkpSZmTvfwzWj9ylDCyZwxUU0=;
        b=fMNrJOnDeww+DekKtCWPmEWXSoI6hrO9fAZLCmK2A7WUGhphoxlQLCo0q1zs7oaX0V
         f/eEf0HDkvsQBrxzdwFDyFo2Lesz9EgcOZdH7jo6TeEFHi+39SaTETSVh3lFiSAtcZ+r
         8zPU1/e5IXp+8JoSBWrLzcS6W3ZQgyH77I2Gc+S8xtvqSD1B1PdRmv7vrla1OkaBRaQb
         OUFWaKztms5eVIdkUnGQzreesxibywDnZAFLpYUMLYr2l7Zvty1V5t20GbUB6T3Cwy9+
         7boOIX8OlJqFPkoHYsAqx6f/P5a6edgQgjX0LVtLQI983zabTsIYbhArTt+BvyPnPHeE
         Ingg==
X-Gm-Message-State: AOJu0YyrAs4NR/wgqhokUQmCBo5pZTE6CqzEdI2WX5DDH+wrD52ll/Hm
	CgmOuUgV+UYnBEztSlnOoDM0pDJjrSjwbpSTJs0NZU3FFygtNEAM3iAhib2w5NTZJ8hiiQavgxC
	s6q3W4jd58lXhSmELFnQd/fv6ktY1B5lOfNOrBqjztQ==
X-Gm-Gg: ASbGncsf/3NiwuvVOuWbVcL+GUkA2JZ8fCJuiZl6QRX7F/qZx9MbcrU9COf0CrBfPx9
	0QGll6uP6+FkFMuaug9exXdKTMOvoeFo9TNMdLb/bxdZP78HpZ7t2aUySJHsKgdGfLQPXi1RVnC
	Pey42NkAifVH1hDx1svnt1edWfUhvwJzSX12PQKC3sHV0lwvIHTJ+LWtCDDOpiDZAiiiRY188ZG
	E6TqaDOR99YiN/OkS0OthpObrCBnNgO9SNV65WW4VUmyQ37YsmYNkuPVyFqZ21OM8CClAWNEQ==
X-Google-Smtp-Source: AGHT+IHBgz+FmtVPvJu3SCy7tALN1FAmhPzb18VCi3/4ZrVRGY+kOcv5Fz+irwsD+vLtWKOs0MzTStN2UBe7MMegzfo=
X-Received: by 2002:a05:7022:4381:b0:11b:9386:825b with SMTP id
 a92af1059eb24-11f296c4100mr1746123c88.48.1765369039130; Wed, 10 Dec 2025
 04:17:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072944.363788552@linuxfoundation.org>
In-Reply-To: <20251210072944.363788552@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 10 Dec 2025 21:17:03 +0900
X-Gm-Features: AQt7F2pTA2Cii6t8rtYmLN11BKTetwmg6gtStkBaVhUsG8qqSyx6V4L8IpnnnJY
Message-ID: <CAKL4bV6LnoRjoyqss+5DBOC+SCa+bKbyyS4wCA6tTRaDpqUgWA@mail.gmail.com>
Subject: Re: [PATCH 6.18 00/29] 6.18.1-rc1 review
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

Hi Greg

On Wed, Dec 10, 2025 at 4:36=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.1 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 12 Dec 2025 07:29:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.18.1-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.18.1-rc1rv-g7d4c06f4000f
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20251112, GNU ld (GNU
Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Wed Dec 10 20:19:12 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

